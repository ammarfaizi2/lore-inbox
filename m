Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTJWOH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTJWOH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:07:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26347 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263578AbTJWOHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:07:53 -0400
Date: Thu, 23 Oct 2003 16:07:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Matt Domsch <Matt_Domsch@dell.com>, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.23-pre8: link error with both megaraid drivers
Message-ID: <20031023140743.GF11807@fs.tum.de>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 09:24:17PM -0200, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.23-pre7 to v2.4.23-pre8
> ============================================
>...
> Matt Domsch:
>   o Fix megaraid2 compilation problems
>...

Trying to compile both megaraid drivers statically into the kernel still 
fails with the following link error:

<--  snip  -->

...
ld -m elf_i386  -r -o scsidrv.o scsi_mod.o sim710.o advansys.o pci2000.o 
pci2220i.o psi240i.o BusLogic.o dpt_i2o.o u14-34f.o ultrastor.o aha152x.o 
aha1542.o aha1740.o aacraid/aacraid.o aic7xxx/aic7xxx.o aic7xxx/aic79xx.o ips.o 
fd_mcs.o fdomain.o in2000.o g_NCR5380.o NCR53c406a.o NCR_D700.o 53c700.o sym53c416.o 
qlogicfas.o qlogicisp.o qlogicfc.o qla1280.o pas16.o seagate.o t128.o dmx3191d.o 
dtc.o 53c7,8xx.o sym53c8xx_2/sym53c8xx_2.o eata_dma.o eata_pio.o wd7000.o 
NCR53C9x.o mca_53c9x.o ibmmca.o eata.o tmscsim.o AM53C974.o megaraid.o megaraid2.o 
atp870u.o gdth.o initio.o a100u2w.o ide-scsi.o 3w-xxxx.o ppa.o imm.o scsi_debug.o 
cpqfc.o nsp32.o st.o osst.o sd_mod.o sr_mod.o sg.o
megaraid2.o(.text+0x1ff0): In function `megaraid_info':
: multiple definition of `megaraid_info'
megaraid.o(.text+0x29f8): first defined here
ld: Warning: size of symbol `megaraid_info' changed from 67 in 
megaraid.o to 57 in megaraid2.o
make[3]: *** [scsidrv.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux/kernel-2.4/linux-2.4.23-pre8-full/drivers/scsi'

<--  snip  -->

The patch below fixes this issue by disalllowing the static inclusion of 
both drivers at the same time.

cu
Adrian

--- linux-2.4.23-pre7-full/drivers/scsi/Config.in.old	2003-10-11 17:00:47.000000000 +0200
+++ linux-2.4.23-pre7-full/drivers/scsi/Config.in	2003-10-11 17:24:00.000000000 +0200
@@ -67,7 +67,12 @@
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
 dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
 dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
-dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+if [ "$CONFIG_SCSI_MEGARAID" != "y" ]; then
+  define_tristate CONFIG_SCSI_MEGARAID2_DEP $CONFIG_SCSI
+else
+  define_tristate CONFIG_SCSI_MEGARAID2_DEP m $CONFIG_SCSI
+fi
+dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI_MEGARAID2_DEP
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
 if [ "$CONFIG_SCSI_BUSLOGIC" != "n" ]; then
