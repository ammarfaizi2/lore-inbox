Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTLTOn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 09:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTLTOn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 09:43:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:39581 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263158AbTLTOn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 09:43:26 -0500
X-Authenticated: #20450766
Date: Sat, 20 Dec 2003 15:41:25 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Gene Heskett <gene.heskett@verizon.net>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: SCSI AM53C974 driver missing in 2.6.0?
In-Reply-To: <200312191916.38901.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.44.0312201536430.2728-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003, Gene Heskett wrote:

> Hey, how about us advansis users?  There is at least one, me...  And
> thats the only driver in the whole compile that spits out visible
> warnings about check_region() being deprecated.  But its still
> working, so far.  I presume it will until such time as check_region()
> is actually removed from wherever it lives.

Well, wouldn't it suffice just to remove the deprecated checks? The only
(for recent kernels) request_region() does check the return code. So, this
should do:

--- drivers/scsi/advansys.c~	Mon Nov 24 20:43:42 2003
+++ drivers/scsi/advansys.c	Sat Dec 20 15:34:00 2003
@@ -4619,13 +4619,7 @@
                         ASC_DBG1(1,
                                 "advansys_detect: probing I/O port 0x%x...\n",
                             iop);
-                        if (check_region(iop, ASC_IOADR_GAP) != 0) {
-                            printk(
-"AdvanSys SCSI: specified I/O Port 0x%X is busy\n", iop);
-                            /* Don't try this I/O port twice. */
-                            asc_ioport[ioport] = 0;
-                            goto ioport_try_again;
-                        } else if (AscFindSignature(iop) == ASC_FALSE) {
+			if (AscFindSignature(iop) == ASC_FALSE) {
                             printk(
 "AdvanSys SCSI: specified I/O Port 0x%X has no adapter\n", iop);
                             /* Don't try this I/O port twice. */
@@ -10003,12 +9997,6 @@
     }
     for (; i < ASC_IOADR_TABLE_MAX_IX; i++) {
         iop_base = _asc_def_iop_base[i];
-        if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
-            ASC_DBG1(1,
-               "AscSearchIOPortAddr11: check_region() failed I/O port 0x%x\n",
-                     iop_base);
-            continue;
-        }
         ASC_DBG1(1, "AscSearchIOPortAddr11: probing I/O port 0x%x\n", iop_base);
         if (AscFindSignature(iop_base)) {
             return (iop_base);

Guennadi
---
Guennadi Liakhovetski


