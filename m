Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTDWHzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 03:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTDWHzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 03:55:21 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:13 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263983AbTDWHzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 03:55:19 -0400
Date: Wed, 23 Apr 2003 10:08:58 +0200
From: Jerome Chantelauze <jchantelauze@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030423080858.GA5325@i486X33>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 03:47:32PM -0300, Marcelo Tosatti wrote:
> 
> Here goes the first candidate for 2.4.21.
> 
> Please test it extensively.

Hi

drivers/ide/Makefile seems broken on 2.4.21-rc1 (it was OK on 2.4.20,
and not on 2.4.21-pre6 and 2.4.21-pre7).

I try to build a kernel with Old hard disk (MFM/RLL/IDE) support only 
(and without Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support).

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


The kernel was built on a x86 computer running a debian woody (gcc
2.95.4 and glibc 2.2.5).

Regards

--
Jerome Chantelauze
