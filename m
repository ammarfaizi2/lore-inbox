Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQLFV3h>; Wed, 6 Dec 2000 16:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbQLFV31>; Wed, 6 Dec 2000 16:29:27 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:62735 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S129627AbQLFV3N>; Wed, 6 Dec 2000 16:29:13 -0500
Date: Wed, 6 Dec 2000 15:59:21 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: Pete Zaitcev <zaitcev@metabyte.com>
cc: <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
Subject: Re: YMF PCI - thanks, glitches, patches (fwd)
In-Reply-To: <Pine.LNX.4.30.0012061423450.3758-101000@fonzie.nine.com>
Message-ID: <Pine.LNX.4.30.0012061539070.2504-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ioctl 0x5401 is a mystery. I do not know what it is
> > (looks like SNDCTL_TMR_TIMEBASE without uppper bits).
>
> It is caused by an attempt to play at 5512 Hz. In fact, this time (I've

I was wrong. It happens for all sounds when sox calls

setvbuf (ft->fp,NULL,_IOFBF,sizeof(char)*BUFSIZ)

Ioctl 0x5401 is not a mystery. It's TCGETS (see
include/asm-i386/ioctls.h). Other drivers (sb_mixer.c) return -EINVAL
silently while ymfpci.c returns -ENOTTY and writes to the log.

> upgraded to test12-pre6 in the meantime) it hung very badly, so that even
> "kill -KILL" doesn't help:

This problem is also fixed by my patch.

_____________________
--- ymfpci.c	Wed Dec  6 11:19:15 2000
+++ ymfpci.c	Wed Dec  6 15:50:46 2000
@@ -1867,18 +1867,12 @@
 	case SNDCTL_DSP_SETSYNCRO:
 	case SOUND_PCM_WRITE_FILTER:
 	case SOUND_PCM_READ_FILTER:
-		return -ENOTTY;
+		printk("ymfpci: ioctl cmd 0x%x\n not yet supported", cmd);
+		return -EINVAL;

 	default:
-	/* P3 */ printk("ymfpci: ioctl cmd 0x%x\n", cmd);
-		/*
-		 * Some programs mix up audio devices and ioctls
-		 * or perhaps they expect "universal" ioctls,
-		 * for instance we get SNDCTL_TMR_CONTINUE here.
-		 * XXX Is there sound_generic_ioctl() around?
-		 */
+		return -EINVAL;
 	}
-	return -ENOTTY;
 }

 static int ymf_open(struct inode *inode, struct file *file)
_____________________

> Maybe it explains why I'll have to reboot now to kill that "sox" :-/

Nope :-)

Regards,
Pavel Roskin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
