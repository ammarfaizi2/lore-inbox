Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130125AbRBFBVR>; Mon, 5 Feb 2001 20:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131893AbRBFBVH>; Mon, 5 Feb 2001 20:21:07 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48136 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S130125AbRBFBU4>; Mon, 5 Feb 2001 20:20:56 -0500
Date: Mon, 5 Feb 2001 20:21:06 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cleaner SNDCTL_DSP_SETFRAGMENT for ymfpci
Message-ID: <Pine.LNX.4.30.0102051941280.6776-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The implementation of SNDCTL_DSP_SETFRAGMENT in ymfpci.c is too hacky (as
of 2.4.1-ac3). The comment says that it was done for Doom only.

The attached patch makes the implementation of SNDCTL_DSP_SETFRAGMENT
similar to those of other cards (the code from cmpci.c was used).

The patch has been tested. Abuse (my favorite linux game) produces
absolutely normal sounds. Actually, it did before. It would be nice to
test this code with something else. Does anybody have a test program?

However, it has been verified that the code in question is actually
executed when Abuse is run.

The patch is also available here:
http://www.red-bean.com/~proski/ymf/ymf_setfrag.diff

Regards,
Pavel Roskin

________________________________
--- linux.orig/drivers/sound/ymfpci.c
+++ linux/drivers/sound/ymfpci.c
@@ -1718,21 +1718,15 @@
 	case SNDCTL_DSP_SETFRAGMENT:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-	/* P3: these frags are for Doom. Amasingly, it sets [2,2**11]. */
-	/* P3 */ // printk("ymfpci: ioctl SNDCTL_DSP_SETFRAGMENT 0x%x\n", val);
-
 		dmabuf = &state->wpcm.dmabuf;
 		dmabuf->ossfragshift = val & 0xffff;
 		dmabuf->ossmaxfrags = (val >> 16) & 0xffff;
-		switch (dmabuf->ossmaxfrags) {
-		case 1:
-			dmabuf->ossfragshift = 12;
-			return 0;
-		default:
-			/* Fragments must be 2K long */
-			dmabuf->ossfragshift = 11;
-			dmabuf->ossmaxfrags = 2;
-		}
+		if (dmabuf->ossfragshift < 4)
+			dmabuf->ossfragshift = 4;
+		if (dmabuf->ossfragshift > 15)
+			dmabuf->ossfragshift = 15;
+		if (dmabuf->ossmaxfrags < 4)
+			dmabuf->ossmaxfrags = 4;
 		return 0;

 	case SNDCTL_DSP_GETOSPACE:
________________________________


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
