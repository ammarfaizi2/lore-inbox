Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWFBX2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWFBX2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 19:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWFBX2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 19:28:42 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:17117 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751524AbWFBX2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 19:28:41 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 Jun 2006 16:28:25 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan Van de Ven <arjan@infradead.org>
Subject: [patch] epoll use unlocked wqueue operations ...
Message-ID: <Pine.LNX.4.64.0606021600001.5402@alien.or.mcafeemobile.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1795850513-1466854067-1149290905=:5402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1795850513-1466854067-1149290905=:5402
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


A few days ago Arjan signaled a lockdep red flag on epoll locks, and 
precisely between the epoll's device structure lock (->lock) and the wait 
queue head lock (->lock). Like I explained in another email, and directly 
to Arjan, this can't happen in reality because of the explicit check at 
eventpoll.c:592, that does not allow to drop an epoll fd inside the same 
epoll fd. Since lockdep is working on per-structure locks, it will never 
be able to know of policies enforced in other parts of the code. It was 
decided time ago of having the ability to drop epoll fds inside other 
epoll fds, that triggers a very trick wakeup operations (due to possibly 
reentrant callback-driven wakeups) handled by the ep_poll_safewake() function.
While looking again at the code though, I noticed that all the operations 
done on the epoll's main structure wait queue head (->wq) are already 
protected by the epoll lock (->lock), so that locked-style functions can 
be used to manipulate the ->wq member. This makes both a lock-acquire 
save, and lockdep happy.
Running totalmess on my dual opteron for a while did not reveal any 
problem so far:

http://www.xmailserver.org/totalmess.c



Signed-off-by: Davide Libenzi <davidel@xmailserver.org>



- Davide



diff -Nru linux-2.6.17-rc5.vanilla/fs/eventpoll.c linux-2.6.17-rc5.eplock/fs/eventpoll.c
--- linux-2.6.17-rc5.vanilla/fs/eventpoll.c	2006-06-02 11:04:58.000000000 -0700
+++ linux-2.6.17-rc5.eplock/fs/eventpoll.c	2006-06-02 11:22:43.000000000 -0700
@@ -1,6 +1,6 @@
  /*
   *  fs/eventpoll.c ( Efficent event polling implementation )
- *  Copyright (C) 2001,...,2003	 Davide Libenzi
+ *  Copyright (C) 2001,...,2006	 Davide Libenzi
   *
   *  This program is free software; you can redistribute it and/or modify
   *  it under the terms of the GNU General Public License as published by
@@ -1004,7 +1004,7 @@

  		/* Notify waiting tasks that events are available */
  		if (waitqueue_active(&ep->wq))
-			wake_up(&ep->wq);
+			__wake_up_locked(&ep->wq, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE);
  		if (waitqueue_active(&ep->poll_wait))
  			pwake++;
  	}
@@ -1083,7 +1083,8 @@

  				/* Notify waiting tasks that events are available */
  				if (waitqueue_active(&ep->wq))
-					wake_up(&ep->wq);
+					__wake_up_locked(&ep->wq, TASK_UNINTERRUPTIBLE |
+							 TASK_INTERRUPTIBLE);
  				if (waitqueue_active(&ep->poll_wait))
  					pwake++;
  			}
@@ -1260,7 +1261,8 @@
  	 * wait list.
  	 */
  	if (waitqueue_active(&ep->wq))
-		wake_up(&ep->wq);
+		__wake_up_locked(&ep->wq, TASK_UNINTERRUPTIBLE |
+				 TASK_INTERRUPTIBLE);
  	if (waitqueue_active(&ep->poll_wait))
  		pwake++;

@@ -1444,7 +1446,8 @@
  		 * wait list.
  		 */
  		if (waitqueue_active(&ep->wq))
-			wake_up(&ep->wq);
+			__wake_up_locked(&ep->wq, TASK_UNINTERRUPTIBLE |
+					 TASK_INTERRUPTIBLE);
  		if (waitqueue_active(&ep->poll_wait))
  			pwake++;
  	}
@@ -1516,7 +1519,7 @@
  		 * ep_poll_callback() when events will become available.
  		 */
  		init_waitqueue_entry(&wait, current);
-		add_wait_queue(&ep->wq, &wait);
+		__add_wait_queue(&ep->wq, &wait);

  		for (;;) {
  			/*
@@ -1536,7 +1539,7 @@
  			jtimeout = schedule_timeout(jtimeout);
  			write_lock_irqsave(&ep->lock, flags);
  		}
-		remove_wait_queue(&ep->wq, &wait);
+		__remove_wait_queue(&ep->wq, &wait);

  		set_current_state(TASK_RUNNING);
  	}
diff -Nru linux-2.6.17-rc5.vanilla/include/linux/eventpoll.h linux-2.6.17-rc5.eplock/include/linux/eventpoll.h
--- linux-2.6.17-rc5.vanilla/include/linux/eventpoll.h	2006-06-02 11:04:58.000000000 -0700
+++ linux-2.6.17-rc5.eplock/include/linux/eventpoll.h	2006-06-02 11:07:48.000000000 -0700
@@ -1,6 +1,6 @@
  /*
   *  include/linux/eventpoll.h ( Efficent event polling implementation )
- *  Copyright (C) 2001,...,2003	 Davide Libenzi
+ *  Copyright (C) 2001,...,2006	 Davide Libenzi
   *
   *  This program is free software; you can redistribute it and/or modify
   *  it under the terms of the GNU General Public License as published by
--1795850513-1466854067-1149290905=:5402
Content-Type: TEXT/plain; charset=US-ASCII; name=epoll-use-unlocked-wq-0.1.diff
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=epoll-use-unlocked-wq-0.1.diff

ZGlmZiAtTnJ1IGxpbnV4LTIuNi4xNy1yYzUudmFuaWxsYS9mcy9ldmVudHBv
bGwuYyBsaW51eC0yLjYuMTctcmM1LmVwbG9jay9mcy9ldmVudHBvbGwuYw0K
LS0tIGxpbnV4LTIuNi4xNy1yYzUudmFuaWxsYS9mcy9ldmVudHBvbGwuYwky
MDA2LTA2LTAyIDExOjA0OjU4LjAwMDAwMDAwMCAtMDcwMA0KKysrIGxpbnV4
LTIuNi4xNy1yYzUuZXBsb2NrL2ZzL2V2ZW50cG9sbC5jCTIwMDYtMDYtMDIg
MTE6MjI6NDMuMDAwMDAwMDAwIC0wNzAwDQpAQCAtMSw2ICsxLDYgQEANCiAv
Kg0KICAqICBmcy9ldmVudHBvbGwuYyAoIEVmZmljZW50IGV2ZW50IHBvbGxp
bmcgaW1wbGVtZW50YXRpb24gKQ0KLSAqICBDb3B5cmlnaHQgKEMpIDIwMDEs
Li4uLDIwMDMJIERhdmlkZSBMaWJlbnppDQorICogIENvcHlyaWdodCAoQykg
MjAwMSwuLi4sMjAwNgkgRGF2aWRlIExpYmVuemkNCiAgKg0KICAqICBUaGlz
IHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yIG1vZGlmeQ0KICAqICBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQ0KQEAgLTEwMDQsNyArMTAwNCw3IEBADQogDQogCQkvKiBOb3RpZnkg
d2FpdGluZyB0YXNrcyB0aGF0IGV2ZW50cyBhcmUgYXZhaWxhYmxlICovDQog
CQlpZiAod2FpdHF1ZXVlX2FjdGl2ZSgmZXAtPndxKSkNCi0JCQl3YWtlX3Vw
KCZlcC0+d3EpOw0KKwkJCV9fd2FrZV91cF9sb2NrZWQoJmVwLT53cSwgVEFT
S19VTklOVEVSUlVQVElCTEUgfCBUQVNLX0lOVEVSUlVQVElCTEUpOw0KIAkJ
aWYgKHdhaXRxdWV1ZV9hY3RpdmUoJmVwLT5wb2xsX3dhaXQpKQ0KIAkJCXB3
YWtlKys7DQogCX0NCkBAIC0xMDgzLDcgKzEwODMsOCBAQA0KIA0KIAkJCQkv
KiBOb3RpZnkgd2FpdGluZyB0YXNrcyB0aGF0IGV2ZW50cyBhcmUgYXZhaWxh
YmxlICovDQogCQkJCWlmICh3YWl0cXVldWVfYWN0aXZlKCZlcC0+d3EpKQ0K
LQkJCQkJd2FrZV91cCgmZXAtPndxKTsNCisJCQkJCV9fd2FrZV91cF9sb2Nr
ZWQoJmVwLT53cSwgVEFTS19VTklOVEVSUlVQVElCTEUgfA0KKwkJCQkJCQkg
VEFTS19JTlRFUlJVUFRJQkxFKTsNCiAJCQkJaWYgKHdhaXRxdWV1ZV9hY3Rp
dmUoJmVwLT5wb2xsX3dhaXQpKQ0KIAkJCQkJcHdha2UrKzsNCiAJCQl9DQpA
QCAtMTI2MCw3ICsxMjYxLDggQEANCiAJICogd2FpdCBsaXN0Lg0KIAkgKi8N
CiAJaWYgKHdhaXRxdWV1ZV9hY3RpdmUoJmVwLT53cSkpDQotCQl3YWtlX3Vw
KCZlcC0+d3EpOw0KKwkJX193YWtlX3VwX2xvY2tlZCgmZXAtPndxLCBUQVNL
X1VOSU5URVJSVVBUSUJMRSB8DQorCQkJCSBUQVNLX0lOVEVSUlVQVElCTEUp
Ow0KIAlpZiAod2FpdHF1ZXVlX2FjdGl2ZSgmZXAtPnBvbGxfd2FpdCkpDQog
CQlwd2FrZSsrOw0KIA0KQEAgLTE0NDQsNyArMTQ0Niw4IEBADQogCQkgKiB3
YWl0IGxpc3QuDQogCQkgKi8NCiAJCWlmICh3YWl0cXVldWVfYWN0aXZlKCZl
cC0+d3EpKQ0KLQkJCXdha2VfdXAoJmVwLT53cSk7DQorCQkJX193YWtlX3Vw
X2xvY2tlZCgmZXAtPndxLCBUQVNLX1VOSU5URVJSVVBUSUJMRSB8DQorCQkJ
CQkgVEFTS19JTlRFUlJVUFRJQkxFKTsNCiAJCWlmICh3YWl0cXVldWVfYWN0
aXZlKCZlcC0+cG9sbF93YWl0KSkNCiAJCQlwd2FrZSsrOw0KIAl9DQpAQCAt
MTUxNiw3ICsxNTE5LDcgQEANCiAJCSAqIGVwX3BvbGxfY2FsbGJhY2soKSB3
aGVuIGV2ZW50cyB3aWxsIGJlY29tZSBhdmFpbGFibGUuDQogCQkgKi8NCiAJ
CWluaXRfd2FpdHF1ZXVlX2VudHJ5KCZ3YWl0LCBjdXJyZW50KTsNCi0JCWFk
ZF93YWl0X3F1ZXVlKCZlcC0+d3EsICZ3YWl0KTsNCisJCV9fYWRkX3dhaXRf
cXVldWUoJmVwLT53cSwgJndhaXQpOw0KIA0KIAkJZm9yICg7Oykgew0KIAkJ
CS8qDQpAQCAtMTUzNiw3ICsxNTM5LDcgQEANCiAJCQlqdGltZW91dCA9IHNj
aGVkdWxlX3RpbWVvdXQoanRpbWVvdXQpOw0KIAkJCXdyaXRlX2xvY2tfaXJx
c2F2ZSgmZXAtPmxvY2ssIGZsYWdzKTsNCiAJCX0NCi0JCXJlbW92ZV93YWl0
X3F1ZXVlKCZlcC0+d3EsICZ3YWl0KTsNCisJCV9fcmVtb3ZlX3dhaXRfcXVl
dWUoJmVwLT53cSwgJndhaXQpOw0KIA0KIAkJc2V0X2N1cnJlbnRfc3RhdGUo
VEFTS19SVU5OSU5HKTsNCiAJfQ0KZGlmZiAtTnJ1IGxpbnV4LTIuNi4xNy1y
YzUudmFuaWxsYS9pbmNsdWRlL2xpbnV4L2V2ZW50cG9sbC5oIGxpbnV4LTIu
Ni4xNy1yYzUuZXBsb2NrL2luY2x1ZGUvbGludXgvZXZlbnRwb2xsLmgNCi0t
LSBsaW51eC0yLjYuMTctcmM1LnZhbmlsbGEvaW5jbHVkZS9saW51eC9ldmVu
dHBvbGwuaAkyMDA2LTA2LTAyIDExOjA0OjU4LjAwMDAwMDAwMCAtMDcwMA0K
KysrIGxpbnV4LTIuNi4xNy1yYzUuZXBsb2NrL2luY2x1ZGUvbGludXgvZXZl
bnRwb2xsLmgJMjAwNi0wNi0wMiAxMTowNzo0OC4wMDAwMDAwMDAgLTA3MDAN
CkBAIC0xLDYgKzEsNiBAQA0KIC8qDQogICogIGluY2x1ZGUvbGludXgvZXZl
bnRwb2xsLmggKCBFZmZpY2VudCBldmVudCBwb2xsaW5nIGltcGxlbWVudGF0
aW9uICkNCi0gKiAgQ29weXJpZ2h0IChDKSAyMDAxLC4uLiwyMDAzCSBEYXZp
ZGUgTGliZW56aQ0KKyAqICBDb3B5cmlnaHQgKEMpIDIwMDEsLi4uLDIwMDYJ
IERhdmlkZSBMaWJlbnppDQogICoNCiAgKiAgVGhpcyBwcm9ncmFtIGlzIGZy
ZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkNCiAgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkNCg==

--1795850513-1466854067-1149290905=:5402--
