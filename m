Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUKNKgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUKNKgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 05:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUKNKgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 05:36:09 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:4872 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261275AbUKNKgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 05:36:03 -0500
Date: Sun, 14 Nov 2004 11:35:03 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: Linux 2.4.28-rc3
Message-ID: <20041114103503.GA23021@alpha.home.local>
References: <20041112180052.GE23215@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112180052.GE23215@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Fri, Nov 12, 2004 at 04:00:52PM -0200, Marcelo Tosatti wrote:
> Here goes the third release candidate.

Just compiled it right now (with Adrian's patch applied).

results :
  - it builds and runs on athlon SMP+scsi (aic7xxx)
  - it builds and runs on sparc64 SMP+scsi (ncr), except for aic7xxx,
    which needs the attached patch to remove an unused function (aic7xxx
    compiles with -Werror).

Regards,
Willy

AIC7xxx build error on sparc64 :

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4.28-rc3-fix/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs -finline-limit=100000 -DMODULE -I/usr/src/linux-2.4.28-rc3-fix/drivers/scsi -Werror -nostdinc -iwithprefix include -DKBUILD_BASENAME=aic79xx_osm_pci  -c -o aic79xx_osm_pci.o aic79xx_osm_pci.c
cc1: warnings being treated as errors
aic79xx_osm_pci.c:278: warning: `ahd_linux_pci_reserve_mem_region' defined but not used
make[1]: *** [aic79xx_osm_pci.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.28-rc3-fix/drivers/scsi/aic7xxx'
make: *** [_mod_drivers/scsi/aic7xxx] Error 2


Trivial patch (the function is used only if MMAPIO is defined) :

--- ./drivers/scsi/aic7xxx/aic79xx_osm_pci.c.orig	Sun Nov 14 10:17:41 2004
+++ ./drivers/scsi/aic7xxx/aic79xx_osm_pci.c	Sun Nov 14 10:19:35 2004
@@ -52,9 +52,12 @@
 					const struct pci_device_id *ent);
 static int	ahd_linux_pci_reserve_io_regions(struct ahd_softc *ahd,
 						 u_long *base, u_long *base2);
+#ifdef MMAPIO
 static int	ahd_linux_pci_reserve_mem_region(struct ahd_softc *ahd,
 						 u_long *bus_addr,
 						 uint8_t **maddr);
+#endif
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static void	ahd_linux_pci_dev_remove(struct pci_dev *pdev);
 
@@ -271,6 +274,7 @@
 	return (0);
 }
 
+#ifdef MMAPIO
 static int
 ahd_linux_pci_reserve_mem_region(struct ahd_softc *ahd,
 				 u_long *bus_addr,
@@ -318,6 +322,7 @@
 		error = ENOMEM;
 	return (error);
 }
+#endif
 
 int
 ahd_pci_map_registers(struct ahd_softc *ahd)


