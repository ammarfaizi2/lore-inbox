Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVECMsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVECMsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 08:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVECMsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 08:48:40 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:28128 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261501AbVECMsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 08:48:37 -0400
Message-ID: <42777318.2070508@brturbo.com.br>
Date: Tue, 03 May 2005 09:48:24 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] PAL-M support fix for CX88 chipsets
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    This patch fixes PAL-M chroma subcarrier frequency (FSC) to its 
correct value of 3.5756115 MHz and adjusts horizontal total samples for 
PAL-M, according with formula Line Draw Time / (4*FSC), where Line Draw 
Time is 63.555 us.
     Without this patch, the Notch subcarrier filter was trying to 
capture using NTSC-M frequency, which is very close, but not equal. This 
could result in Black and White or miscolored frames.

-----

diff -puNr linux-2.6.12-rc3.org/drivers/media/video/cx88/cx88-core.c 
linux-2.6.12-rc3/drivers/media/video/cx88/cx88-core.c
--- linux-2.6.12-rc3.org/drivers/media/video/cx88/cx88-core.c   
2005-04-20 21:03:14.000000000 -0300
+++ linux-2.6.12-rc3/drivers/media/video/cx88/cx88-core.c       
2005-05-03 09:23:21.000000000 -0300
@@ -736,6 +736,9 @@ static unsigned int inline norm_fsc8(str
 {
        static const unsigned int ntsc = 28636360;
        static const unsigned int pal  = 35468950;
+        static const unsigned int palm  = 28604892;
+
+       if (V4L2_STD_PAL_M  & norm->id) return palm;

        return (norm->id & V4L2_STD_625_50) ? pal : ntsc;
 }
@@ -749,6 +752,8 @@ static unsigned int inline norm_notchfil

 static unsigned int inline norm_htotal(struct cx88_tvnorm *norm)
 {
+       // Should allways be Line Draw Time / 4FSC
+       if (V4L2_STD_PAL_M  & norm->id) return 909;
        return (norm->id & V4L2_STD_625_50) ? 1135 : 910;
 }

