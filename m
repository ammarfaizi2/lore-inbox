Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSDDKJz>; Thu, 4 Apr 2002 05:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313124AbSDDKJp>; Thu, 4 Apr 2002 05:09:45 -0500
Received: from [203.115.6.25] ([203.115.6.25]:1540 "EHLO shalmirane.net")
	by vger.kernel.org with ESMTP id <S313128AbSDDKJd>;
	Thu, 4 Apr 2002 05:09:33 -0500
Date: Thu, 4 Apr 2002 16:02:29 -0600 (GMT+6)
From: "Ishan O. Jayawardena" <ioshadij@hotmail.com>
To: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: [patch] kjournald locking fix
Message-ID: <Pine.LNX.4.21.0204041539260.572-200000@shalmirane.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811840-1230555238-1017957749=:572"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811840-1230555238-1017957749=:572
Content-Type: TEXT/PLAIN; charset=US-ASCII


Greetings,

	kjournald seems to be missing an unlock_kernel() for a matching
lock_kernel(). A posting by  Dennis Vadura to l-k mentions (among other
things) a kernel message that says kjournald exited with preempt_count ==
1. The attached patch (text/plain) adds the necessary
unlock_kernel(). [But I haven't been able to reproduce the hang that
Dennis experiences...]
	Tested only on UP. Patch is for 2.4.19-pre5 + prempt-kernel, _no_
lock-break. I hope the positioning of unlock_kernel() is correct... please
correct me if I'm wrong.

	Please CC me (ioshadij@hotmail.com). I can't subscribe to the list
with my own ISP because they aren't ECN-friendly, and subscribing via 

PS: Of course, the reparent_to_init() isn't part of the fix, but I've seen
kjournald become a zombie in an ugly episode with a deadlock in devfs many
moons ago.

---------------------------------------------------------------
--- linux-preempt/fs/jbd/journal.c.1	Wed Apr  3 08:05:08 2002
+++ linux-preempt/fs/jbd/journal.c	Thu Apr  4 15:09:29 2002
@@ -203,6 +203,7 @@ int kjournald(void *arg)
 	current_journal = journal;
 
 	lock_kernel();
+	reparent_to_init();
 	daemonize();
 	spin_lock_irq(&current->sigmask_lock);
 	sigfillset(&current->blocked);
@@ -267,6 +268,7 @@ int kjournald(void *arg)
 
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
+	unlock_kernel();
 	jbd_debug(1, "Journal thread exiting.\n");
 	return 0;
 }

---1463811840-1230555238-1017957749=:572
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kjournald.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0204041602290.572@shalmirane.net>
Content-Description: 
Content-Disposition: attachment; filename="kjournald.diff"

LS0tIGxpbnV4LXByZWVtcHQvZnMvamJkL2pvdXJuYWwuYy4xCVdlZCBBcHIg
IDMgMDg6MDU6MDggMjAwMg0KKysrIGxpbnV4LXByZWVtcHQvZnMvamJkL2pv
dXJuYWwuYwlUaHUgQXByICA0IDE1OjA5OjI5IDIwMDINCkBAIC0yMDMsNiAr
MjAzLDcgQEAgaW50IGtqb3VybmFsZCh2b2lkICphcmcpDQogCWN1cnJlbnRf
am91cm5hbCA9IGpvdXJuYWw7DQogDQogCWxvY2tfa2VybmVsKCk7DQorCXJl
cGFyZW50X3RvX2luaXQoKTsNCiAJZGFlbW9uaXplKCk7DQogCXNwaW5fbG9j
a19pcnEoJmN1cnJlbnQtPnNpZ21hc2tfbG9jayk7DQogCXNpZ2ZpbGxzZXQo
JmN1cnJlbnQtPmJsb2NrZWQpOw0KQEAgLTI2Nyw2ICsyNjgsNyBAQCBpbnQg
a2pvdXJuYWxkKHZvaWQgKmFyZykNCiANCiAJam91cm5hbC0+al90YXNrID0g
TlVMTDsNCiAJd2FrZV91cCgmam91cm5hbC0+al93YWl0X2RvbmVfY29tbWl0
KTsNCisJdW5sb2NrX2tlcm5lbCgpOw0KIAlqYmRfZGVidWcoMSwgIkpvdXJu
YWwgdGhyZWFkIGV4aXRpbmcuXG4iKTsNCiAJcmV0dXJuIDA7DQogfQ0K
---1463811840-1230555238-1017957749=:572--
