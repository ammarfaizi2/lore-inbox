Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263453AbUJ2Q5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbUJ2Q5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbUJ2Qzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:55:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41693 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263358AbUJ2Qw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:52:57 -0400
Date: Fri, 29 Oct 2004 18:53:43 +0200
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
Message-ID: <20041029165343.GA10898@elte.hu>
References: <20041029090957.GA1460@elte.hu> <200410291101.i9TB1uhp002490@localhost.localdomain> <20041029111408.GA28259@elte.hu> <20041029161433.GA6717@elte.hu> <20041029183256.564897b2@mango.fruits.de> <20041029162316.GA7743@elte.hu> <20041029163155.GA9005@elte.hu> <20041029163759.GA9502@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029163759.GA9502@elte.hu>
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

> ok, next attempt. Please apply this patch and do the changeall-tree
> thing in the sound/ directory. This should in theory switch the ALSA
> ioctls (and only them) to a BKL-less variant.

ok, new version - the previous one was slighly racy. The one below works
better - it boots on my box and simple audio playback (xmms) works.

	Ingo

--- linux/sound/core/pcm_native.c.orig2	
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
--- linux/sound/pci/ali5451/ali5451.c.orig2	
+++ linux/sound/pci/ali5451/ali5451.c	
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/syscalls.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -985,11 +986,11 @@ static void snd_ali_update_ptr(ali_t *co
 	pvoice = &codec->synth.voices[channel];
 	runtime = pvoice->substream->runtime;
 
-	udelay(100);
 	spin_lock(&codec->reg_lock);
 
 	if (pvoice->pcm && pvoice->substream) {
 		/* pcm interrupt */
+		sys_gettimeofday((void *)0, (void *)1); // start the tracer
 #ifdef ALI_DEBUG
 		outb((u8)(pvoice->number), ALI_REG(codec, ALI_GC_CIR));
 		temp = inw(ALI_REG(codec, ALI_CSO_ALPHA_FMS + 2));
--- linux/fs/ioctl.c.orig2	
+++ linux/fs/ioctl.c	
@@ -68,6 +68,13 @@ asmlinkage long sys_ioctl(unsigned int f
                 goto out;
         }
 
+	error = -ENOTTY;
+	if (filp->f_op && filp->f_op->ioctl2) {
+		error = filp->f_op->ioctl2(filp->f_dentry->d_inode, filp, cmd, arg);
+		fput(filp);
+		return error;
+	}
+
 	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
@@ -132,7 +139,6 @@ asmlinkage long sys_ioctl(unsigned int f
 	}
 	unlock_kernel();
 	fput(filp);
-
 out:
 	return error;
 }
--- linux/include/linux/fs.h.orig2	
+++ linux/include/linux/fs.h	
@@ -993,6 +993,7 @@ struct file_operations {
 	int (*check_flags)(int);
 	int (*dir_notify)(struct file *filp, unsigned long arg);
 	int (*flock) (struct file *, int, struct file_lock *);
+	int (*ioctl2) (struct inode *, struct file *, unsigned int, unsigned long);
 };
 
 struct inode_operations {
