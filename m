Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131698AbRCONFZ>; Thu, 15 Mar 2001 08:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131699AbRCONFG>; Thu, 15 Mar 2001 08:05:06 -0500
Received: from deckard.concept-micro.com ([62.161.229.193]:41232 "EHLO
	deckard.concept-micro.com") by vger.kernel.org with ESMTP
	id <S131698AbRCONFF>; Thu, 15 Mar 2001 08:05:05 -0500
Message-ID: <XFMail.20010315140400.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.7p2.Linux:20010315140400:547=_"
In-Reply-To: <Pine.LNX.4.30.0103141549340.733-100000@hallikari.cs.Helsinki.FI>
Date: Thu, 15 Mar 2001 14:04:00 +0100 (CET)
X-Face: #eTSL0BRng*(!i1R^[)oey6`SJHR{3Sf4dc;"=af8%%;d"%\#"Hh0#lYfJBcm28zu3r^/H^
 d6!9/eElH'p0'*,L3jz_UHGw"+[c1~ceJxAr(^+{(}|DTZ"],r[jSnwQz$/K&@MT^?J#p"n[J>^O[\
 "%*lo](u?0p=T:P9g(ta[hH@uvv
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
Subject: RE: [PATCH] fix a bug in ioctl(CDROMREADAUDIO) in cdrom.c in 2.2
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.7p2.Linux:20010315140400:547=_
Content-Type: text/plain; charset=iso-8859-1


Le 14-Mar-2001, Jani Jaakkola écrivait :
> 
> Using ioctl(CDROMREADAUDIO) with nframes argument being larger than 8 and
> not divisible by 8 causes kernel to read and return more audio data than
> was requested. This is bad since it clobbers up processes memory
> (I noticed this when my patched cdparanoia segfaulted).
 
Same thing for 2.4.2.

Is my allocation loop "over engineering", or just plain bad thing to do ?


Regards,
Pierre.


-- 
Linux blade.concept-micro.com 2.4.3-pre4 #1 Wed Mar 14 22:19:14 CET 2001 i686 unknown
  2:04pm  up 11:29,  4 users,  load average: 2.66, 2.80, 2.26


--_=XFMail.1.4.7p2.Linux:20010315140400:547=_
Content-Disposition: attachment; filename="myreadaudio.patch"
Content-Transfer-Encoding: none
Content-Description: myreadaudio.patch
Content-Type: application/octet-stream; name=myreadaudio.patch; SizeOnDisk=1481

--- linux-2.4.2/drivers/cdrom/cdrom.c	Wed Mar 14 22:15:52 2001
+++ linux/drivers/cdrom/cdrom.c	Wed Mar 14 22:16:25 2001
@@ -1985,7 +1985,7 @@
 		}
 	case CDROMREADAUDIO: {
 		struct cdrom_read_audio ra;
-		int lba;
+		int lba, frames;
 
 		IOCTL_IN(arg, struct cdrom_read_audio, ra);
 
@@ -2002,8 +2002,13 @@
 		if (lba < 0 || ra.nframes <= 0)
 			return -EINVAL;
 
-		if ((cgc.buffer = (char *) kmalloc(CD_FRAMESIZE_RAW, GFP_KERNEL)) == NULL)
-			return -ENOMEM;
+		frames = ra.nframes > 8 ? 8 : ra.nframes;
+
+                while((cgc.buffer = (char *) kmalloc(CD_FRAMESIZE_RAW * frames,
 GFP_KERNEL)) == NULL) {
+		  frames = frames >> 1;
+		  if (!frames) 
+		    return -ENOMEM;
+                };
 
 		if (!access_ok(VERIFY_WRITE, ra.buf, ra.nframes*CD_FRAMESIZE_RAW)) {
 			kfree(cgc.buffer);
@@ -2011,12 +2016,16 @@
 		}
 		cgc.data_direction = CGC_DATA_READ;
 		while (ra.nframes > 0) {
-			ret = cdrom_read_block(cdi, &cgc, lba, 1, 1, CD_FRAMESIZE_RAW);
-			if (ret) break;
-			__copy_to_user(ra.buf, cgc.buffer, CD_FRAMESIZE_RAW);
-			ra.buf += CD_FRAMESIZE_RAW;
-			ra.nframes--;
-			lba++;
+		        if (frames > ra.nframes)
+			        frames = ra.nframes;
+			ret = cdrom_read_block(cdi, &cgc, lba, frames, 1, CD_FRAMESIZE_RAW);
+			if (ret)
+				break;
+			__copy_to_user(ra.buf, cgc.buffer,
+				       CD_FRAMESIZE_RAW * frames);
+			ra.buf += (CD_FRAMESIZE_RAW * frames);
+			ra.nframes -= frames;
+			lba += frames;
 		}
 		kfree(cgc.buffer);
 		return ret;

--_=XFMail.1.4.7p2.Linux:20010315140400:547=_--
End of MIME message
