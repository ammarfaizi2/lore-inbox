Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUAVACB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 19:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbUAVACB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 19:02:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:46813 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266157AbUAVAB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 19:01:57 -0500
Date: Wed, 21 Jan 2004 16:03:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] sisfb update 2.6.1
Message-Id: <20040121160309.2fd26f0a.akpm@osdl.org>
In-Reply-To: <400F0F8C.8070900@winischhofer.net>
References: <400F0F8C.8070900@winischhofer.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Winischhofer <thomas@winischhofer.net> wrote:
>
> Update for SiS framebuffer driver for 2.6.1 vanilla

It still has floating point stuff in sis_init().  Could you please
review, integrate and test the below patch?

After that we need to coordinate this with James and Ben who are also doing
things in this area.  But we wouldn't want to have to defer this SiS patch
until everything is sorted out in the fbdev core - life is too short ;)





From: Andi Kleen <ak@muc.de>

Here's the matching patch from the SuSE 2.4 tree which also compiles with
soft-float.  No i haven't even checked if it applies to 2.6.  But maybe it
will help somebody fix the 2.6 driver.



---

 25-akpm/drivers/video/sis/init.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff -puN drivers/video/sis/init.c~sis-DRM-floating-point-removal drivers/video/sis/init.c
--- 25/drivers/video/sis/init.c~sis-DRM-floating-point-removal	Fri Jan  9 13:22:47 2004
+++ 25-akpm/drivers/video/sis/init.c	Fri Jan  9 13:22:47 2004
@@ -5165,7 +5165,8 @@ SiSBuildBuiltInModeList(ScrnInfoPtr pScr
    unsigned short HRE, HBE, HRS, HBS, HDE, HT;
    unsigned char  sr_data, cr_data, cr_data2, cr_data3;
    unsigned char  sr2b, sr2c;
-   float          num, denum, postscalar, divider;
+   //float          num, denum, postscalar, divider;
+   unsigned int	  num, denum, postscalar, divider;
    int            A, B, C, D, E, F, temp, i, j, index, vclkindex;
    DisplayModePtr new = NULL, current = NULL, first = NULL, backup = NULL;
 
@@ -5230,19 +5231,19 @@ SiSBuildBuiltInModeList(ScrnInfoPtr pScr
       sr2b = pSiS->SiS_Pr->SiS_VCLKData[vclkindex].SR2B;
       sr2c = pSiS->SiS_Pr->SiS_VCLKData[vclkindex].SR2C;
 
-      divider = (sr2b & 0x80) ? 2.0 : 1.0;
+      divider = (sr2b & 0x80) ? 2 : 1;
       postscalar = (sr2c & 0x80) ?
-              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6.0 : 8.0) : (((sr2c >> 5) & 0x03) + 1.0);
-      num = (sr2b & 0x7f) + 1.0;
-      denum = (sr2c & 0x1f) + 1.0;
+              ( (((sr2c >> 5) & 0x03) == 0x02) ? 6 : 8) : (((sr2c >> 5) & 0x03) + 1);
+      num = (sr2b & 0x7f) + 1;
+      denum = (sr2c & 0x1f) + 1;
       
 #ifdef TWDEBUG
       xf86DrvMsg(0, X_INFO, "------------\n");
-      xf86DrvMsg(0, X_INFO, "sr2b: %x sr2c %x div %f ps %f num %f denum %f\n",
+      xf86DrvMsg(0, X_INFO, "sr2b: %x sr2c %x div %i ps %i num %i denum %i\n",
          sr2b, sr2c, divider, postscalar, num, denum);
 #endif
 
-      current->Clock = (int)(14318 * (divider / postscalar) * (num / denum));
+      current->Clock = (int)(14318 * divider / postscalar * num / denum);
 
       sr_data = pSiS->SiS_Pr->SiS_CRT1Table[index].CR[14];
 	/* inSISIDXREG(SISSR, 0x0b, sr_data); */

_

