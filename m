Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbRBHXAi>; Thu, 8 Feb 2001 18:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbRBHXA2>; Thu, 8 Feb 2001 18:00:28 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:34640 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S129404AbRBHXAQ>; Thu, 8 Feb 2001 18:00:16 -0500
Message-ID: <3A8324D7.C03D5274@metabyte.com>
Date: Thu, 08 Feb 2001 14:59:36 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: pl, ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: zaitcev@metabyte.com, yosh@gimp.org, smackinlay@mail.com
Subject: Patch for ymfpci and xmms
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Feb 2001 23:00:02.0691 (UTC) FILETIME=[DE903530:01C09222]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Courtesy of Manish Singh, little bit extended
(I hope I did not break it too badly).
Supposedly it fixes bad skipping with xmms.

-- Pete

diff -ur -X dontdiff linux-2.4.1/drivers/sound/ymfpci.c linux-2.4.1-p3/drivers/sound/ymfpci.c
--- linux-2.4.1/drivers/sound/ymfpci.c	Fri Jan 26 23:31:16 2001
+++ linux-2.4.1-p3/drivers/sound/ymfpci.c	Thu Feb  8 11:29:45 2001
@@ -370,16 +370,14 @@
 
 	/*
 	 * Create fake fragment sizes and numbers for OSS ioctls.
+	 * Import what Doom might have set with SNDCTL_DSP_SETFRAGMENT.
 	 */
 	bufsize = PAGE_SIZE << dmabuf->buforder;
-	if (dmabuf->ossfragshift) {
-		if ((1000 << dmabuf->ossfragshift) < bytepersec)
-			dmabuf->fragshift = ld2(bytepersec/1000);
-		else
-			dmabuf->fragshift = dmabuf->ossfragshift;
-	} else {
-		/* lets hand out reasonable big ass buffers by default */
-		dmabuf->fragshift = (dmabuf->buforder + PAGE_SHIFT -2);
+	/* lets hand out reasonable big ass buffers by default */
+	dmabuf->fragshift = (dmabuf->buforder + PAGE_SHIFT -2);
+	if (dmabuf->ossfragshift > 3 &&
+	    dmabuf->ossfragshift < dmabuf->fragshift) {
+		dmabuf->fragshift = dmabuf->ossfragshift;
 	}
 	dmabuf->numfrag = bufsize >> dmabuf->fragshift;
 	while (dmabuf->numfrag < 4 && dmabuf->fragshift > 3) {
@@ -389,9 +387,6 @@
 	dmabuf->fragsize = 1 << dmabuf->fragshift;
 	dmabuf->dmasize = dmabuf->numfrag << dmabuf->fragshift;
 
-	/*
-	 * Import what Doom might have set with SNDCTL_DSD_SETFRAGMENT.
-	 */
 	if (dmabuf->ossmaxfrags >= 2 && dmabuf->ossmaxfrags < dmabuf->numfrag) { 		dmabuf->numfrag = dmabuf->ossmaxfrags;
 		dmabuf->dmasize = dmabuf->numfrag << dmabuf->fragshift;
@@ -1718,21 +1713,13 @@
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
 		return 0;
 
 	case SNDCTL_DSP_GETOSPACE:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
