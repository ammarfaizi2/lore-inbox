Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRHTWOV>; Mon, 20 Aug 2001 18:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269651AbRHTWOM>; Mon, 20 Aug 2001 18:14:12 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:49413 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S269646AbRHTWOC>; Mon, 20 Aug 2001 18:14:02 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200108202214.AAA09066@green.mif.pg.gda.pl>
Subject: Re: [PATCH] allow hdX=scsi when ide-scsi is a module
To: ionut@cs.columbia.edu, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Date: Tue, 21 Aug 2001 00:14:18 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The current IDE code doesn't allow the user to reserve a drive to be used 
> only with ide-scsi emulation, if the ide-scsi layer is compiled as a 
> module. The following trivial patch fixes the problem, I've been using it 
> for the last 6 months or so.
> 
> The patch removes the explicit dependency on CONFIG_SCSI because ide-scsi 
> itself requires the SCSI subsystem.

Even worse.
As the following legal steps:

CONFIG_BLK_DEV_IDESCSI=y
CONFIG_SCSI=y
    |
    V
make config
    |
    V
  SCSI emulation support (CONFIG_BLK_DEV_IDESCSI) [Y/m/n/?] y
  ...
  SCSI support (CONFIG_SCSI) [Y/m/n/?] m
    |
    V
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_SCSI=m

result in an invalid configuration.
So I suggest also the following change:
**********************************************************
--- drivers/ide/ide.c.old	Mon Aug 20 23:03:11 2001
+++ drivers/ide/ide.c	Mon Aug 20 23:03:39 2001
@@ -3452,7 +3452,7 @@
  #ifdef CONFIG_SCSI
 	(void) idescsi_init();
  #else
-    #warning ide scsi-emulation selected but no SCSI-subsystem in kernel
+    #error ide scsi-emulation selected but no SCSI-subsystem in kernel
  #endif
 #endif /* CONFIG_BLK_DEV_IDESCSI */
 }



BTW, IDE config is broken in much more places :(

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
