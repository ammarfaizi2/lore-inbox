Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263434AbUJ2QR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbUJ2QR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbUJ2QPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:15:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36771 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263413AbUJ2QNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:13:48 -0400
Date: Fri, 29 Oct 2004 18:14:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029161433.GA6717@elte.hu>
References: <20041029090957.GA1460@elte.hu> <200410291101.i9TB1uhp002490@localhost.localdomain> <20041029111408.GA28259@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029111408.GA28259@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> ahh ... the ioctls. All ioctls in Linux take the 'big kernel lock'. So
> if jackd calls an ioctl() in the fastpath then that could easily get
> delayed. Also, there are a couple of other syscalls too that touch the
> BKL, so an strace of the 'jackd latency path' would be quite useful.

i straced jackd and it seems to do ioctls:

5971  ioctl(7, 0x4143, 0x446b7d3c)      = 0
5971  ioctl(7, 0x4140, 0x446b7d3c)      = 0
5971  ioctl(7, 0x4142, 0x446b7d3c)      = 0
5971  poll([{fd=7, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, 4353) = 1
5971  poll([{fd=7, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, 4353)= 1
5971  poll([{fd=7, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT|POLLERR}], 1, 4353) = 1
5971  ioctl(7, 0x806c4120, 0xb77bb960)  = 0
5971  gettimeofday({1099064915, 776665}, NULL) = 0

the BKL can generate arbitrary latencies. Anything up to 100-200
milliseconds. Rui, Florian, could you try the quick hack below?

	Ingo

--- linux/fs/ioctl.c.orig2	
+++ linux/fs/ioctl.c	
@@ -68,19 +68,26 @@ asmlinkage long sys_ioctl(unsigned int f
                 goto out;
         }
 
-	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
+			lock_kernel();
 			set_close_on_exec(fd, 1);
+			unlock_kernel();
 			break;
 
 		case FIONCLEX:
+			lock_kernel();
 			set_close_on_exec(fd, 0);
+			unlock_kernel();
 			break;
 
 		case FIONBIO:
-			if ((error = get_user(on, (int __user *)arg)) != 0)
+			lock_kernel();
+			unlock_kernel();
+			if ((error = get_user(on, (int __user *)arg)) != 0) {
+				unlock_kernel();
 				break;
+			}
 			flag = O_NONBLOCK;
 #ifdef __sparc__
 			/* SunOS compatibility item. */
@@ -91,11 +98,15 @@ asmlinkage long sys_ioctl(unsigned int f
 				filp->f_flags |= flag;
 			else
 				filp->f_flags &= ~flag;
+			unlock_kernel();
 			break;
 
 		case FIOASYNC:
-			if ((error = get_user(on, (int __user *)arg)) != 0)
+			lock_kernel();
+			if ((error = get_user(on, (int __user *)arg)) != 0) {
+				unlock_kernel();
 				break;
+			}
 			flag = on ? FASYNC : 0;
 
 			/* Did FASYNC state change ? */
@@ -104,16 +115,20 @@ asmlinkage long sys_ioctl(unsigned int f
 					error = filp->f_op->fasync(fd, filp, on);
 				else error = -ENOTTY;
 			}
-			if (error != 0)
+			if (error != 0) {
+				unlock_kernel();
 				break;
+			}
 
 			if (on)
 				filp->f_flags |= FASYNC;
 			else
 				filp->f_flags &= ~FASYNC;
+			unlock_kernel();
 			break;
 
 		case FIOQSIZE:
+			lock_kernel();
 			if (S_ISDIR(filp->f_dentry->d_inode->i_mode) ||
 			    S_ISREG(filp->f_dentry->d_inode->i_mode) ||
 			    S_ISLNK(filp->f_dentry->d_inode->i_mode)) {
@@ -122,6 +137,7 @@ asmlinkage long sys_ioctl(unsigned int f
 			}
 			else
 				error = -ENOTTY;
+			unlock_kernel();
 			break;
 		default:
 			error = -ENOTTY;
@@ -130,7 +146,6 @@ asmlinkage long sys_ioctl(unsigned int f
 			else if (filp->f_op && filp->f_op->ioctl)
 				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
 	}
-	unlock_kernel();
 	fput(filp);
 
 out:
