Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSKGWq6>; Thu, 7 Nov 2002 17:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbSKGWq6>; Thu, 7 Nov 2002 17:46:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1215 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266638AbSKGWq4>;
	Thu, 7 Nov 2002 17:46:56 -0500
From: "Jay Vosburgh" <fubar@us.ibm.com>
Importance: Normal
Sensitivity: 
To: davidel@xmailserver.org, Linus Torvalds <torvalds@transmeta.com>
Cc: "Janet Morgan" <janetinc@us.ibm.com>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF0E49851E.BBF9BCB0-ON88256C6A.007C9078@boulder.ibm.com>
Date: Thu, 7 Nov 2002 15:53:06 -0700
Subject: [PATCH] 2.5.46: epoll ep_insert doesn't wake waiters if events exist 
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 11/07/2002 03:53:23 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=07BBE6F9DFEF16E88f9e8a93df938690918c07BBE6F9DFEF16E8"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=07BBE6F9DFEF16E88f9e8a93df938690918c07BBE6F9DFEF16E8
Content-type: text/plain; charset=us-ascii


      The logic in fs/eventpoll.c:ep_insert()  checks to see if events are
already present when processing an EP_CTL_ADD operation, and, if any are,
adds them to the list.  It does not wake up any waiters, so, e.g., another
thread waiting in epoll_wait() will not be awakened for these events.  The
fix is to have ep_insert() do wakeups, just as ep_poll_callback() does when
it adds events.

      -J

diff -ur linux-2.5.46.orig/fs/eventpoll.c linux-2.5.46/fs/eventpoll.c
--- linux-2.5.46.orig/fs/eventpoll.c      Thu Nov  7 14:31:21 2002
+++ linux-2.5.46/fs/eventpoll.c     Thu Nov  7 14:32:16 2002
@@ -838,8 +838,13 @@
      list_add(&dpi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));

      /* If the file is already "ready" we drop it inside the ready list */
-     if ((revents & pfd->events) && !EP_IS_LINKED(&dpi->rdllink))
+     if ((revents & pfd->events) && !EP_IS_LINKED(&dpi->rdllink)) {
            list_add(&dpi->rdllink, &ep->rdllist);
+           if (waitqueue_active(&ep->wq))
+                 wake_up(&ep->wq);
+           if (waitqueue_active(&ep->poll_wait))
+                 wake_up(&ep->poll_wait);
+     }

      write_unlock_irqrestore(&ep->lock, flags);



(See attached file: epoll-2.5.46-insert.patch)

--0__=07BBE6F9DFEF16E88f9e8a93df938690918c07BBE6F9DFEF16E8
Content-type: application/octet-stream; 
	name="epoll-2.5.46-insert.patch"
Content-Disposition: attachment; filename="epoll-2.5.46-insert.patch"
Content-transfer-encoding: base64

ZGlmZiAtdXIgbGludXgtMi41LjQ2Lm9yaWcvZnMvZXZlbnRwb2xsLmMgbGludXgtMi41LjQ2L2Zz
L2V2ZW50cG9sbC5jCi0tLSBsaW51eC0yLjUuNDYub3JpZy9mcy9ldmVudHBvbGwuYwlUaHUgTm92
ICA3IDE0OjMxOjIxIDIwMDIKKysrIGxpbnV4LTIuNS40Ni9mcy9ldmVudHBvbGwuYwlUaHUgTm92
ICA3IDE0OjMyOjE2IDIwMDIKQEAgLTgzOCw4ICs4MzgsMTMgQEAKIAlsaXN0X2FkZCgmZHBpLT5s
bGluaywgZXBfaGFzaF9lbnRyeShlcCwgZXBfaGFzaF9pbmRleChlcCwgdGZpbGUpKSk7CiAKIAkv
KiBJZiB0aGUgZmlsZSBpcyBhbHJlYWR5ICJyZWFkeSIgd2UgZHJvcCBpdCBpbnNpZGUgdGhlIHJl
YWR5IGxpc3QgKi8KLQlpZiAoKHJldmVudHMgJiBwZmQtPmV2ZW50cykgJiYgIUVQX0lTX0xJTktF
RCgmZHBpLT5yZGxsaW5rKSkKKwlpZiAoKHJldmVudHMgJiBwZmQtPmV2ZW50cykgJiYgIUVQX0lT
X0xJTktFRCgmZHBpLT5yZGxsaW5rKSkgewogCQlsaXN0X2FkZCgmZHBpLT5yZGxsaW5rLCAmZXAt
PnJkbGxpc3QpOworCQlpZiAod2FpdHF1ZXVlX2FjdGl2ZSgmZXAtPndxKSkKKwkJCXdha2VfdXAo
JmVwLT53cSk7CisJCWlmICh3YWl0cXVldWVfYWN0aXZlKCZlcC0+cG9sbF93YWl0KSkKKwkJCXdh
a2VfdXAoJmVwLT5wb2xsX3dhaXQpOworCX0KIAogCXdyaXRlX3VubG9ja19pcnFyZXN0b3JlKCZl
cC0+bG9jaywgZmxhZ3MpOwogCg==

--0__=07BBE6F9DFEF16E88f9e8a93df938690918c07BBE6F9DFEF16E8--

