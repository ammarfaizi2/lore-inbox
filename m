Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291718AbSBNPtW>; Thu, 14 Feb 2002 10:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291720AbSBNPtM>; Thu, 14 Feb 2002 10:49:12 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:62626 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S291718AbSBNPtC>; Thu, 14 Feb 2002 10:49:02 -0500
Message-Id: <200202141501.IAA04461@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.5-pre1 fix build error in drivers/video/vesafb.c
Date: Thu, 14 Feb 2002 08:47:52 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Gerd Knorr <kraxel@goldbach.in-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This patch is some hackery-quackery to fix a problem with drivers/video/vesafb.c.

I got the following error building 2.5.5-pre1.  I also had this error with 2.5.4-preX,
but after seeing the discussions relating to bus_to_virt etc., I hoped that a 
real fix would appear.

drivers/video/video.o: In function `vesafb_init':
drivers/video/video.o(.text.init+0x154b): undefined reference to `bus_to_virt_not_defined_use_pci_map'
make: *** [vmlinux] Error 1

Quoting Andrew Morton in his recent interview with kerneltrap.org,
"One hot tip: if you spot a bug which is being ignored, send a completely botched fix 
to the mailing list. This causes thousands of kernel developers to rally to the cause. 
Nobody knows why this happens. (I really have deliberately done this several times. It works)."

Well this bug is certainly not being ignored, but here is my completely botched fix.

Cheers,
Steven

--- linux-2.5.5-pre1/drivers/video/vesafb.c.orig        Thu Feb 14 08:16:25 2002
+++ linux-2.5.5-pre1/drivers/video/vesafb.c     Thu Feb 14 08:17:24 2002
@@ -550,7 +550,7 @@
                ypan = pmi_setpal = 0; /* not available or some DOS TSR ... */

        if (ypan || pmi_setpal) {
-               pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
+               pmi_base  = (unsigned short*)phys_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
                pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
                pmi_pal   = (void*)((char*)pmi_base + pmi_base[2]);
                printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
