Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVL0Uuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVL0Uuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 15:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVL0Uuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 15:50:39 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:42257 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751143AbVL0Uuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 15:50:39 -0500
Date: Tue, 27 Dec 2005 21:53:51 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Recursive dependency for SAA7134 in 2.6.15-rc7
Message-Id: <20051227215351.3d581b13.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I gave a try to 2.6.15-rc7 and "make menuconfig" tells me:
Warning! Found recursive dependency: VIDEO_SAA7134_ALSA VIDEO_SAA7134_OSS VIDEO_SAA7134_ALSA

This seems to be the consequence of this patch:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7bb9529602f8bb41a92275825b808a42ed33e5be

How do we fix that? menuconfig is indeed really confused by the current
setup. I have the following patch which makes it happier:

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/saa7134/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc7.orig/drivers/media/video/saa7134/Kconfig	2005-12-26 11:04:35.000000000 +0100
+++ linux-2.6.15-rc7/drivers/media/video/saa7134/Kconfig	2005-12-27 11:35:34.000000000 +0100
@@ -14,7 +14,7 @@
 
 config VIDEO_SAA7134_ALSA
 	tristate "Philips SAA7134 DMA audio support"
-	depends on VIDEO_SAA7134 && SOUND && SND && (!VIDEO_SAA7134_OSS || VIDEO_SAA7134_OSS = m)
+	depends on VIDEO_SAA7134 && SND
 	select SND_PCM_OSS
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
@@ -25,7 +25,7 @@
 
 config VIDEO_SAA7134_OSS
 	tristate "Philips SAA7134 DMA audio support (OSS, DEPRECATED)"
-	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || VIDEO_SAA7134_ALSA = m)
+	depends on VIDEO_SAA7134 && SOUND_PRIME && VIDEO_SAA7134_ALSA!=y && m
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
 	  Philips SAA713x based TV cards using OSS

However, I am not entirely happy with it because it introduces an
asymmetry: the OSS variant can no more be built-in, it is now only
available as a module. Not sure this is acceptable.

Another possibility would be to fix Kconfig to properly support this
case. Roman, what do you think?

Yet another possibility would be to not express the dependencies,
explain the mutual exclusion in the help texts, and hope that the user
will read the help texts. I doubt this will work. This seems to be what
was done for the eepro100/e100 case though (well, not even help texts
in this case).

Are there other similar cases in the kernel right now?

It would be nice to fix this before 2.6.15.

Thanks,
-- 
Jean Delvare
