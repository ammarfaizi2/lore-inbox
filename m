Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279669AbRJ0BtA>; Fri, 26 Oct 2001 21:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279670AbRJ0Bsk>; Fri, 26 Oct 2001 21:48:40 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:29457 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S279669AbRJ0Bsc>; Fri, 26 Oct 2001 21:48:32 -0400
Date: Fri, 26 Oct 2001 21:49:08 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] More ioctls for VIA sound driver, Flash 5 now fixed
Message-ID: <Pine.LNX.4.33.0110262134440.1121-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Flash plugin version 5 refuses to work with the VIA 82Cxxx driver.  It
turns out that Flash uses SNDCTL_DSP_NONBLOCK on /dev/dsp, which is not
supported by the driver.

I also looked what other ioctls can be implemented easily on VIA 82Cxxx.  
There is another one - SNDCTL_DSP_GETTRIGGER.  Everything else is not 
trivial, sorry.

This patch add support for SNDCTL_DSP_NONBLOCK and SNDCTL_DSP_GETTRIGGER.
It can be found at http://www.red-bean.com/~proski/linux/via-ioctl.diff

Flash 5 plugin plays just fine after applying the patch (check e.g.  
http://wcrb.com/sparks.html)

The patch is against 2.4.13-ac2.

----------------------------------------
--- linux.orig/drivers/sound/via82cxxx_audio.c
+++ linux/drivers/sound/via82cxxx_audio.c
@@ -2800,6 +2800,11 @@ static int via_dsp_ioctl (struct inode *
 		rc = 0;
 		break;
 
+	case SNDCTL_DSP_NONBLOCK:
+		file->f_flags |= O_NONBLOCK;
+		rc = 0;
+		break;
+
 	/* obtain bitmask of device capabilities, such as mmap, full duplex, etc. */
 	case SNDCTL_DSP_GETCAPS:
 		DPRINTK ("DSP_GETCAPS\n");
@@ -2898,6 +2903,15 @@ static int via_dsp_ioctl (struct inode *
 		if (!rc && wr)
 			rc = via_dsp_ioctl_trigger (&card->ch_out, val);
 
+		break;
+
+	case SNDCTL_DSP_GETTRIGGER:
+		val = 0;
+		if ((file->f_mode & FMODE_READ) && card->ch_in.is_enabled)
+			val |= PCM_ENABLE_INPUT;
+		if ((file->f_mode & FMODE_WRITE) && card->ch_out.is_enabled)
+			val |= PCM_ENABLE_OUTPUT;
+		rc = put_user(val, (int *)arg);
 		break;
 
 	/* Enable full duplex.  Since we do this as soon as we are opened
----------------------------------------

Thanks for applying my previous patches.

P.S. Loading and unloading the driver with CONFIG_SOUND_VIA82CXXX_PROCFS
enabled blocks something in the kernel (no new process can be run).  The 
kernel prints:

de_put: deferred delete of 0
de_put: deferred delete of via

Just be aware that it can happen and that it's not related to my ioctl 
patch.  If I fix it, I'll post a separate patch.

-- 
Regards,
Pavel Roskin

