Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTJINMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTJINMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:12:02 -0400
Received: from users.linvision.com ([62.58.92.114]:55515 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262126AbTJINL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:11:57 -0400
Date: Thu, 9 Oct 2003 15:11:52 +0200
From: Erik Mouw <erik@harddisk-recovery.nl>
To: Matthew Wilcox <willy@debian.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Xose Vazquez Perez <xose@wanadoo.es>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: two sym53c8xx.o modules
Message-ID: <20031009131152.GG11525@bitwizard.nl>
References: <3F84AF3C.9050408@wanadoo.es> <Pine.LNX.4.44.0310090826290.2569-100000@logos.cnet> <20031009122428.GF11525@bitwizard.nl> <20031009123857.GC27861@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009123857.GC27861@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 01:38:57PM +0100, Matthew Wilcox wrote:
> Is it really important to change this at this stage of 2.4?  For
> reference, sym1 has already gone away in 2.6, so it'll be incovenient
> for users no matter what you change.  Let's stick with the devil we know.

Yes it is. The _2 driver supports newer hardware (or better: can do
faster speeds on newer hardware), while the old driver doesn't. The old
driver, however, is more reliable in case of hardware errors. It's very
nice to be able to change drivers on the fly without having to figure
out the full path to the correct module.

Hmm, just tested the _2 driver and now I remember why I hardly use it
with flakey drives:

  root@dagobert:~ # scsiinfo -eXR /dev/sda 0 0 0 0 0 0 0 0 0 0 0 0 0 1
  <4>sym0:4:0:extraneous data discarded.
  <4>sym0:4:0:extraneous data discarded.
  <4>sym0:4:0:extraneous data discarded.
  <4>sym0:4:0:extraneous data discarded.
  <4>sym0:4:0:extraneous data discarded.
  Unable to store Read-Write Error Recovery Page 01h
  18 00 00 00 18 00 00 00 70 00 05 00 00 00 00 18 
  00 00 00 00 26 00 00 80 02 00 01 0a 00 00 00 00 
  00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 

I haven't figured out what it could be yet, scsiinfo works perfectly
well with the old sym58xxx driver (and the aic7xxx driver, FWIW).

Anyway, here's a patch to rename sym53c8xx_2/sym53c8xx.o to
sym53c8xx_2/sym53c8xx_2.o. It's against 2.4.22, but should apply to all
2.4 kernels.


Erik

--- linux/drivers/scsi/Makefile.old	Tue Aug 26 12:16:09 2003
+++ linux/drivers/scsi/Makefile	Thu Oct  9 14:48:40 2003
@@ -97,7 +97,7 @@
 obj-$(CONFIG_SCSI_NCR53C7xx)	+= 53c7,8xx.o 
 subdir-$(CONFIG_SCSI_SYM53C8XX_2)	+= sym53c8xx_2
 ifeq ($(CONFIG_SCSI_SYM53C8XX_2),y)
-  obj-$(CONFIG_SCSI_SYM53C8XX_2)	+= sym53c8xx_2/sym53c8xx.o
+  obj-$(CONFIG_SCSI_SYM53C8XX_2)	+= sym53c8xx_2/sym53c8xx_2.o
 endif
 obj-$(CONFIG_SCSI_SYM53C8XX)	+= sym53c8xx.o 
 obj-$(CONFIG_SCSI_NCR53C8XX)	+= ncr53c8xx.o 
--- linux/drivers/scsi/sym53c8xx_2/Makefile.old	Sat Nov 10 00:22:54 2001
+++ linux/drivers/scsi/sym53c8xx_2/Makefile	Thu Oct  9 14:49:43 2003
@@ -1,14 +1,14 @@
-# File: drivers/sym53c8xx/Makefile
+# File: drivers/scsi/sym53c8xx_2/Makefile
 # Makefile for the NCR/SYMBIOS/LSI 53C8XX PCI SCSI controllers driver.
 
-list-multi := sym53c8xx.o
-sym53c8xx-objs := sym_fw.o sym_glue.o sym_hipd.o sym_malloc.o sym_misc.o sym_nvram.o
-obj-$(CONFIG_SCSI_SYM53C8XX_2) := sym53c8xx.o
+list-multi := sym53c8xx_2.o
+sym53c8xx_2-objs := sym_fw.o sym_glue.o sym_hipd.o sym_malloc.o sym_misc.o sym_nvram.o
+obj-$(CONFIG_SCSI_SYM53C8XX_2) := sym53c8xx_2.o
 
 EXTRA_CFLAGS += -I.
 
-sym53c8xx.o: $(sym53c8xx-objs)
-	$(LD) -r -o $@ $(sym53c8xx-objs)
+sym53c8xx_2.o: $(sym53c8xx_2-objs)
+	$(LD) -r -o $@ $(sym53c8xx_2-objs)
 
 include $(TOPDIR)/Rules.make
 


-- 
+-- Erik Mouw -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Eigen lab: Delftechpark 26, 2628 XH, Delft, Nederland
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!
