Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVKPEaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVKPEaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 23:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbVKPEaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 23:30:07 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:24195 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965213AbVKPEaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 23:30:06 -0500
Subject: [PATCH -rt] race condition in fs/compat.c with compat_sys_ioctl
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: pavel@suse.cz, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <5bdc1c8b0511141057l60a2e778x89155cd5484d532f@mail.gmail.com>
References: <1131821278.5047.8.camel@localhost.localdomain>
	 <5bdc1c8b0511121725u6df7ad9csb9cb56777fa6fe64@mail.gmail.com>
	 <Pine.LNX.4.58.0511122149020.25152@localhost.localdomain>
	 <5bdc1c8b0511121914v12dc4402u424fbaf416bf3710@mail.gmail.com>
	 <1131853456.5047.14.camel@localhost.localdomain>
	 <5bdc1c8b0511130634h501fb565v58906bdfae788814@mail.gmail.com>
	 <1131994030.5047.17.camel@localhost.localdomain>
	 <5bdc1c8b0511141057l60a2e778x89155cd5484d532f@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 15 Nov 2005 23:29:46 -0500
Message-Id: <1132115386.5047.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and friends.

Well I finally got my AMD64 x2 up and running and a cross compiler
working (is there a better way in Debian to get a AMD64 cross compiler
than building one from scratch?).

I got Thomas' kthrt running with no problem (my default kernel in
fact ;-)

Then I felt good and compiled -rt.  After a few problems (mostly
configuration) it booted and I got the gdm login.  "cool" I thought.

Well, as soon as I logged in, the system froze.  Well not really. I had
interrupts working, and the mouse moved around, but all the bash shells
would lock up immediately, as well as all the gnome-terminals ???

Well I solved it, and this might even be a problem with the vanilla
kernel.  Grant you, this is most susceptible with a dual AMD64 on RT.

Here's the problem: 

in fs/compat.c: compat_sys_ioctl

It has this hash table of ioctl commands protected with a ioctl32_sem.
To get an ioctl you must grab the sem and then search for your ioctl in
the hash table.  When you find it, you call your ioctl and then release
the sem. 

That's the problem. I found out that one ioctl might sleep holding the
sem and won't be woken up until another process calls another ioctl to
wake it up. But unfortunately, the one waking up the sleeper will block
on the sem.  (the killer was tty_wait_until_sent)

I don't know how this doesn't lock up the non-rt kernels.  I guess the
ioctls just don't sleep. I haven't looked too deep into why this works
outside of -rt, I just solved it for -rt and will look deeper into this
tomorrow.

Here's the patch:

I created a temporary variable to hold the function pointer when it
finds the ioctl to call, and then release the semaphore.  This is
definitely the solution for -rt, since I can't login without this patch.

-- Steve

PS. There's other bug messages I'm getting (in -rt), but I'll work on
those tomorrow ;-)

Index: linux-2.6.14-rt13/fs/compat.c
===================================================================
--- linux-2.6.14-rt13.orig/fs/compat.c	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.14-rt13/fs/compat.c	2005-11-15 23:00:14.000000000 -0500
@@ -347,6 +347,7 @@
 	int error = -EBADF;
 	struct ioctl_trans *t;
 	int fput_needed;
+	ioctl_trans_handler_t handler = NULL;
 
 	filp = fget_light(fd, &fput_needed);
 	if (!filp)
@@ -394,8 +395,11 @@
 	   this lock! -AK */
 	down_read(&ioctl32_sem);
 	for (t = ioctl32_hash_table[ioctl32_hash(cmd)]; t; t = t->next) {
-		if (t->cmd == cmd)
+		if (t->cmd == cmd) {
+			handler = t->handler;
+			up_read(&ioctl32_sem);
 			goto found_handler;
+		}
 	}
 	up_read(&ioctl32_sem);
 
@@ -413,15 +417,13 @@
 	goto out_fput;
 
  found_handler:
-	if (t->handler) {
+	if (handler) {
 		lock_kernel();
-		error = t->handler(fd, cmd, arg, filp);
+		error = handler(fd, cmd, arg, filp);
 		unlock_kernel();
-		up_read(&ioctl32_sem);
 		goto out_fput;
 	}
 
-	up_read(&ioctl32_sem);
  do_ioctl:
 	error = vfs_ioctl(filp, fd, cmd, arg);
  out_fput:


