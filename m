Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbUC2RQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbUC2RPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:15:15 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:1257 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263014AbUC2RNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:13:11 -0500
Date: Mon, 29 Mar 2004 12:09:37 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       <areiter@preventsys.com>, <rmk+serial@arm.linux.org.uk>,
       <tytso@mit.edu>
Subject: Re: Subject: Re: NULL pointer in proc_pid_stat -- oops.
In-Reply-To: <87d66vd9dk.fsf@devron.myhome.or.jp>
Message-ID: <Pine.GSO.4.33.0403291204360.14589-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, OGAWA Hirofumi wrote:
>> >  if (task->tty) {
>> >   tty_pgrp = task->tty->pgrp;
>> >   tty_nr = new_encode_dev(tty_devnum(task->tty));
>> >  }
>> >
>> > Some place doesn't take the any lock for ->tty.
>> > I think we need to take the lock for ->tty.
>>
>> Probably this isn't the thing for 2.6.xx,
>
>Ah, sorry for confusing. This is 2.6.x (maybe also 2.4.x).
>
>e.g. the above take the task_lock(). But disassociate_ctty() just take
>read_lock(&tasklist_lock), etc. etc. So looks like racy.

Yes, there is a race condition.  I never chased it back to the specifics.
I just did this:
===== tty.h 1.23 vs 1.24 =====
--- 1.23/include/linux/tty.h    Wed Sep 24 02:15:15 2003
+++ 1.24/include/linux/tty.h    Wed Feb 11 18:29:20 2004
@@ -404,7 +404,16 @@

 static inline dev_t tty_devnum(struct tty_struct *tty)
 {
-       return MKDEV(tty->driver->major, tty->driver->minor_start) + tty->index;
+       int ret = 0;
+
+       if(!tty) {
+               printk(KERN_CRIT "tty_devnum(): NULL tty (%p)\n", tty);
+       } else if(!tty->driver) {
+               printk(KERN_CRIT "tty_devnum(): NULL tty->driver (%p)\n", tty->d
river);
+       } else
+       ret = MKDEV(tty->driver->major, tty->driver->minor_start) + tty->index;
+
+       return ret;
 }

 #endif /* __KERNEL__ */

We were seeing this with some application(s) that called the java keytool
a bit too often.  (We moved the calls to directly calling the keytool
classes.)

"Works for me" :-)

--Ricky


