Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbUJ2Qmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUJ2Qmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ2QlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:41:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31405 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263418AbUJ2Qgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:36:54 -0400
Date: Fri, 29 Oct 2004 18:37:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029163759.GA9502@elte.hu>
References: <20041029090957.GA1460@elte.hu> <200410291101.i9TB1uhp002490@localhost.localdomain> <20041029111408.GA28259@elte.hu> <20041029161433.GA6717@elte.hu> <20041029183256.564897b2@mango.fruits.de> <20041029162316.GA7743@elte.hu> <20041029163155.GA9005@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029163155.GA9005@elte.hu>
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

> > correct, and with the changeall-tree hack in addition. And keep your
> > finger near the reset button, just in case ...
> 
> it wont even boot ...
> 
> let me try some more hacks to make this a little bit safer.

ok, next attempt. Please apply this patch and do the changeall-tree
thing in the sound/ directory. This should in theory switch the ALSA
ioctls (and only them) to a BKL-less variant.

	Ingo

--- linux/sound/core/pcm_native.c.orig
+++ linux/sound/core/pcm_native.c	
@@ -3317,7 +3317,7 @@ static struct file_operations snd_pcm_f_
 	.open =		snd_pcm_open,
 	.release =	snd_pcm_release,
 	.poll =		snd_pcm_playback_poll,
-	.ioctl =	snd_pcm_playback_ioctl,
+	.ioctl2 =	snd_pcm_playback_ioctl,
 	.mmap =		snd_pcm_mmap,
 	.fasync =	snd_pcm_fasync,
 };
@@ -3329,7 +3329,7 @@ static struct file_operations snd_pcm_f_
 	.open =		snd_pcm_open,
 	.release =	snd_pcm_release,
 	.poll =		snd_pcm_capture_poll,
-	.ioctl =	snd_pcm_capture_ioctl,
+	.ioctl2 =	snd_pcm_capture_ioctl,
 	.mmap =		snd_pcm_mmap,
 	.fasync =	snd_pcm_fasync,
 };
--- linux/fs/ioctl.c.orig
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
@@ -122,15 +137,21 @@ asmlinkage long sys_ioctl(unsigned int f
 			}
 			else
 				error = -ENOTTY;
+			unlock_kernel();
 			break;
 		default:
 			error = -ENOTTY;
-			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
+			if (S_ISREG(filp->f_dentry->d_inode->i_mode)) {
+				lock_kernel();
 				error = file_ioctl(filp, cmd, arg);
-			else if (filp->f_op && filp->f_op->ioctl)
+				unlock_kernel();
+			} else if (filp->f_op && filp->f_op->ioctl) {
+				lock_kernel();
 				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+				unlock_kernel();
+			} else if (filp->f_op && filp->f_op->ioctl2)
+				error = filp->f_op->ioctl2(filp->f_dentry->d_inode, filp, cmd, arg);
 	}
-	unlock_kernel();
 	fput(filp);
 
 out:
--- linux/include/linux/fs.h.orig
+++ linux/include/linux/fs.h
@@ -993,6 +993,7 @@ struct file_operations {
 	int (*check_flags)(int);
 	int (*dir_notify)(struct file *filp, unsigned long arg);
 	int (*flock) (struct file *, int, struct file_lock *);
+	int (*ioctl2) (struct inode *, struct file *, unsigned int, unsigned long);
 };
 
 struct inode_operations {
