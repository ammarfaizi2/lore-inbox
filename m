Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTELVKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTELVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:10:16 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:15118 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262710AbTELVKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:10:10 -0400
Date: Mon, 12 May 2003 23:25:46 +0200
From: Jerome Chantelauze <jerome.chantelauze@finix.eu.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc2
Message-ID: <20030512212546.GC570@i486X33>
References: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 10:15:12PM -0300, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes release canditate 2. The aic7xxx problems should be fixed.


Hi Marcello

Here is a patch I sent to lkml a few days ago. It tries to fix a problem
with 2.4.21-rc1 ide driver Makefile.

drivers/ide/Makefile is broken on 2.4.21-rc2 (it's broken at least since
2.4.421-pre6. 2.4.20 is OK).

I try to build a kernel with Old hard disk (MFM/RLL/IDE) support only
(I don't need the Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support).

Here is my .config:

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
# CONFIG_BLK_DEV_IDE is not set
CONFIG_BLK_DEV_HD_ONLY=y
CONFIG_BLK_DEV_HD=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

The resulting kernel has no support for ide hard disks:

# ls -l drivers/ide/*.o
-rw-r--r--    1 root     root            8 apr 23 08:56 drivers/ide/idedriver.o
#

The following patch fixes the problem for the x86 arch (sorry, I have no
access to other archs). 


*** linux-2.4.21-rc1/drivers/ide/Makefile.orig  Wed Apr 23 08:45:48 2003
--- linux-2.4.21-rc1/drivers/ide/Makefile       Wed Apr 23 09:20:14 2003
***************
*** 21,26 ****
--- 21,28 ----
  
  subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid pci
  
+ subdir-$(CONFIG_BLK_DEV_HD_ONLY) += legacy
+ 
  # First come modules that register themselves with the core
  
  ifeq ($(CONFIG_BLK_DEV_IDE),y)
***************
*** 50,55 ****
--- 52,60 ----
    obj-y               += arm/idedriver-arm.o
  endif
  
+ ifeq ($(CONFIG_BLK_DEV_HD_ONLY),y)
+   obj-y               += legacy/idedriver-legacy.o
+ endif
  
  ifeq ($(CONFIG_BLK_DEV_IDE),y)
  # RAID must be last of all


I used a x86 computer running a debian woody (gcc 2.95.4, glibc 2.2.5)
to build the kernel.

Regards

--
Jerome Chantelauze
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


