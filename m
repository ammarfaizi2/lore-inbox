Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271557AbRIBD2U>; Sat, 1 Sep 2001 23:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271560AbRIBD2L>; Sat, 1 Sep 2001 23:28:11 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:28689 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S271557AbRIBD2G>;
	Sat, 1 Sep 2001 23:28:06 -0400
Message-ID: <3B91A7A0.4020904@si.rr.com>
Date: Sat, 01 Sep 2001 23:29:36 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.9-ac5: drivers/sound/trident.c
Content-Type: multipart/mixed;
 boundary="------------060602090900070009070805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060602090900070009070805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   The attached patch addresses a locking concern with the trident 
driver. Please apply and test. It is against 2.4.9-ac5 . Thanks.
Regards,
Frank

--------------060602090900070009070805
Content-Type: text/plain;
 name="TRIDENTP"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="TRIDENTP"

--- drivers/sound/trident.c.old	Thu Aug 30 21:42:58 2001
+++ drivers/sound/trident.c	Sat Sep  1 23:04:34 2001
@@ -37,6 +37,8 @@
  *
  *  History
  *  v0.14.9c
+ *	September 1 2001 Frank Davis <fdavis112@juno.com>
+ *	added spinlock to SNDCTL_DSP_RESET
  *	August 10 2001 Peter Wächtler <pwaechtler@loewe-komp.de>
  *	added support for Tvia (formerly Integraphics/IGST) CyberPro5050
  *	this chip is often found in settop boxes (combined video+audio)
@@ -703,8 +705,7 @@
  	 *	clash with another cyberpro config event
  	 */
  
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&card->lock, flags);
 	portDat = cyber_inidx(CYBER_PORT_AUDIO, CYBER_IDX_AUDIO_ENABLE);
 	/* enable, if it was disabled */
 	if( (portDat & CYBER_BMSK_AUENZ) != CYBER_BMSK_AUENZ_ENABLE ) {
@@ -729,7 +730,7 @@
 		cyber_outidx( CYBER_PORT_AUDIO, 0xb3, 0x06 );
 		cyber_outidx( CYBER_PORT_AUDIO, 0xbf, 0x00 );
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->lock, flags);
 	return ret;
 }
 
@@ -2098,20 +2099,23 @@
 		break;
 		
 	case SNDCTL_DSP_RESET:
-		/* FIXME: spin_lock ? */
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(state);
 			synchronize_irq();
 			dmabuf->ready = 0;
+			spin_lock_irqsave(&card->lock, flags);
 			dmabuf->swptr = dmabuf->hwptr = 0;
 			dmabuf->count = dmabuf->total_bytes = 0;
+			spin_unlock_irqrestore(&card->lock, flags);
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(state);
 			synchronize_irq();
 			dmabuf->ready = 0;
+			spin_lock_irqsave(&card->lock, flags);
 			dmabuf->swptr = dmabuf->hwptr = 0;
 			dmabuf->count = dmabuf->total_bytes = 0;
+			spin_unlock_irqrestore(&card->lock, flags);
 		}
 		break;
 

--------------060602090900070009070805--

