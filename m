Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTAKMSv>; Sat, 11 Jan 2003 07:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbTAKMSv>; Sat, 11 Jan 2003 07:18:51 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:27092 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267200AbTAKMSt>; Sat, 11 Jan 2003 07:18:49 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
References: <20030110165441$1a8a@gated-at.bofh.it>
	<20030110165505$38d9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: 11 Jan 2003 13:27:24 +0100
In-Reply-To: <20030110165505$38d9@gated-at.bofh.it>
Message-ID: <m3iswv27o3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Fri, 2003-01-10 at 16:10, William Lee Irwin III wrote:
> > Any specific concerns/issues/wishlist items you want taken care of
> > before doing it or is it a "generalized comfort level" kind of thing?
> > Let me know, I'd be much obliged for specific directions to move in.
> 
> IDE is all broken still and will take at least another three months to
> fix - before we get to 'improve'. The entire tty layer locking is terminally

Can you quickly summarize what is broken with IDE ?

Are just some low level drivers broken or are there some generic
nasty problems.

If it is just some broken low level drivers I guess they can 
be marked dangerous or CONFIG_EXPERIMENTAL.

How does it differ from the code that was just merged into 2.4.21pre3
(has the later all the problems fixed?)

> broken and nobody has even started fixing it. Just try a mass of parallel
> tty/pty activity . It was problematic before, pre-empt has taken it  to dead, 
> defunct and buried. 

Can someone shortly describe what is the main problem with TTY?

>From what I can see the high level tty code mostly takes lock_kernel
before doing anything.
On reads access to file->private_data is not serialized, but it at 
least shouldn't go away because VFS takes care of struct file
reference counting.

The tty_drivers list does seem to need a spinlock, but I guess
just taking lock_kernel in tty_open would fix that for now.

[i didn't look at low level ldiscs]

Any particular test cases that break ?

If yes I would recommend to post them as scripts and their oopses so 
that people can start working on them.


The appended untested patch adds some lock_kernel()s that appear to be missing
to tty_io.c. The rest seems to already run under BKL or not access
any global data
(except tty_paranoia_check, but is probably ok with the reference counting
in the VFS)

> 
> Most of the drivers still don't build either.

In UP most did last time I tried.
On SMP a lot of problems are caused by the cli removal

My personal (i386) problem list is relatively short.
I use used 2.5.54 on my desktop without any problems (without preempt)

- BIO still oopses when XFS tries replay a log on RAID-0

-Andi

--- linux-2.5.56-work/drivers/char/tty_io.c-o	2003-01-02 05:13:12.000000000 +0100
+++ linux-2.5.56-work/drivers/char/tty_io.c	2003-01-11 13:23:15.000000000 +0100
@@ -1329,6 +1329,8 @@
 		int major, minor;
 		struct tty_driver *driver;
 
+		lock_kernel(); 
+
 		/* find a device that is not in use. */
 		retval = -1;
 		for ( major = 0 ; major < UNIX98_NR_MAJORS ; major++ ) {
@@ -1340,6 +1342,8 @@
 				if (!init_dev(device, &tty)) goto ptmx_found; /* ok! */
 			}
 		}
+
+		unlock_kernel();
 		return -EIO; /* no free ptys */
 	ptmx_found:
 		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
@@ -1357,6 +1361,8 @@
 #endif  /* CONFIG_UNIX_98_PTYS */
 	}
 
+	lock_kernel();
+
 	retval = init_dev(device, &tty);
 	if (retval)
 		return retval;
@@ -1389,6 +1395,8 @@
 #endif
 
 		release_dev(filp);
+
+		unlock_kernel(); 
 		if (retval != -ERESTARTSYS)
 			return retval;
 		if (signal_pending(current))
@@ -1397,6 +1405,7 @@
 		/*
 		 * Need to reset f_op in case a hangup happened.
 		 */
+		lock_kernel();
 		filp->f_op = &tty_fops;
 		goto retry_open;
 	}
@@ -1424,6 +1433,7 @@
 			nr_warns++;
 		}
 	}
+	unlock_kernel();
 	return 0;
 }
 
@@ -1444,8 +1454,13 @@
 	if (tty_paranoia_check(tty, filp->f_dentry->d_inode->i_rdev, "tty_poll"))
 		return 0;
 
-	if (tty->ldisc.poll)
-		return (tty->ldisc.poll)(tty, filp, wait);
+	if (tty->ldisc.poll) { 
+		int ret;
+		lock_kernel();
+		ret = (tty->ldisc.poll)(tty, filp, wait);
+		unlock_kernel();
+		return ret;
+	}
 	return 0;
 }
 
