Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129680AbRBXXP2>; Sat, 24 Feb 2001 18:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbRBXXPS>; Sat, 24 Feb 2001 18:15:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64009 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129680AbRBXXPG>;
	Sat, 24 Feb 2001 18:15:06 -0500
Date: Sun, 25 Feb 2001 00:14:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Swanson <swansma@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 242-ac3 loop bug
Message-ID: <20010225001427.B420@suse.de>
In-Reply-To: <20010224173234.14673.qmail@web1301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20010224173234.14673.qmail@web1301.mail.yahoo.com>; from swansma@yahoo.com on Sat, Feb 24, 2001 at 09:32:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 24 2001, Mark Swanson wrote:
> First, good job on the loop device. It's rock stable for me - except

thanks, glad to hear it.

> when I try to load the blowfish module which oops the kernel and
> crashes the loop device:-) No problem, I just use another cipher.

cipher bug or? never the less, could you ksymoops that and send
it along?

> The bug I'm reporting is that when a loop device is in use the load of
> the machine stays at 1.00 even though nothing is happening. If I umount
> the loop filesystem the load goes down to 0.00.
> 
> > ps -aux | grep loop
> 1674 tty1     DW<   0:00 [loop0]
> 
> The system is doing nothing to the loop filesystem.
> Strange that the process isn't logging any cpu usage time. It's
> definately responsible for the 1.00 load.

Oops, this slipped by me. Patch should fix it.

-- 
Jens Axboe


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=loop_sig-1

--- drivers/block/loop.c~	Sat Feb 24 23:08:38 2001
+++ drivers/block/loop.c	Sat Feb 24 23:11:13 2001
@@ -507,7 +507,7 @@
 	sprintf(current->comm, "loop%d", lo->lo_number);
 
 	spin_lock_irq(&current->sigmask_lock);
-	siginitsetinv(&current->blocked, sigmask(SIGKILL));
+	sigfillset(&current->blocked);
 	flush_signals(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
@@ -525,7 +525,7 @@
 	up(&lo->lo_sem);
 
 	for (;;) {
-		down(&lo->lo_bh_mutex);
+		down_interruptible(&lo->lo_bh_mutex);
 		if (!atomic_read(&lo->lo_pending))
 			break;
 

--VbJkn9YxBvnuCH5J--
