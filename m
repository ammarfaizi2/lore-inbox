Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRCNOSp>; Wed, 14 Mar 2001 09:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRCNOSf>; Wed, 14 Mar 2001 09:18:35 -0500
Received: from porsta.cs.Helsinki.FI ([128.214.48.124]:11561 "EHLO
	porsta.cs.Helsinki.FI") by vger.kernel.org with ESMTP
	id <S131369AbRCNOS0>; Wed, 14 Mar 2001 09:18:26 -0500
Date: Wed, 14 Mar 2001 16:17:41 +0200 (EET)
From: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix a bug in ioctl(CDROMREADAUDIO) in cdrom.c in 2.2.18
Message-ID: <Pine.LNX.4.30.0103141549340.733-100000@hallikari.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using ioctl(CDROMREADAUDIO) with nframes argument being larger than 8 and
not divisible by 8 causes kernel to read and return more audio data than
was requested. This is bad since it clobbers up processes memory
(I noticed this when my patched cdparanoia segfaulted).

This _might_ also have a security impact, since it could be used to
overwrite memory which the user should not have write access with
cdrom audio data. (_might_ since I do not know the exact semantics of
__copy_to_user() and I am too lazy to check them out. The attacker needs
access to cdrom device with audio cdrom in drive, preferably with a
custom made audio cd).

I have not checked if the same bug is also present in 2.4 kernels.

If you have any comments, please Cc: them to me, since I am not present in
the list.

Here is a trivial patch against drivers/cdrom/cdrom.c of kernel 2.2.18:

--- cdrom.c.orig	Wed Mar 14 13:15:13 2001
+++ cdrom.c	Wed Mar 14 15:42:19 2001
@@ -1946,6 +1946,7 @@
 			ra.buf += (CD_FRAMESIZE_RAW * frames);
 			ra.nframes -= frames;
 			lba += frames;
+			if (frames>ra.nframes) frames=ra.nframes;
 		}
 		kfree(cgc.buffer);
 		return ret;

