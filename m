Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSFDU6w>; Tue, 4 Jun 2002 16:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSFDU6t>; Tue, 4 Jun 2002 16:58:49 -0400
Received: from [195.157.192.66] ([195.157.192.66]:13650 "HELO
	baobab.mtlb.co.uk") by vger.kernel.org with SMTP id <S316755AbSFDU6p>;
	Tue, 4 Jun 2002 16:58:45 -0400
Date: Tue, 4 Jun 2002 21:56:17 +0100
From: Robert Cardell <rbt@mtlb.co.uk>
To: marcelo@plucky.distro.conectiva, linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial, IDE geometry fix / defconfig changes
Message-ID: <20020604215617.A288@garfield.mtlb.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Two patches included. The first fixes a bug with really large (48-bit lba)
drives where the kernel miscomputes the geometry if the BIOS isn't 48-bit
aware. (At least I think that's when it would happen.) This messes up the EVMS
in particular, since it thinks the drives are 16 times their real size, and
tries to read past the end of the device at discovery time. I'm sending it to
the list as well as Marcelo just to be sure it's the right fix (although it's
very trivial, I'm just paranoid :), and so it can be sent to Linus/Martin D.
if it's still relevant to 2.5.

I've also taken the liberty of changing the default configuration to exclude
the Symbios 8xx SCSI, EtherExpress Pro, and Ensoniq ES1371, on the basis that:
 - In the first case, the driver is being superceded,
 - In the first two cases, they are 'hidden' from view if you use
     make menuconfig and don't specifically check for them. I'm sick of
     accidentally building them into my kernels. 
 - None of them are particularly common pieces of hardware anyway.

There are lots of other things I'd change in the default config (why is SMP
the default and parport not, for example?), but these are the things that
/really/ bother me.

First patch against drivers/ide/ide-disk.c, second against arch/i386/defconfig.
(2.4.19-pre9) I'm not on the list at the moment, cc me to reply.

Thanks,

Robert Cardell
<rbt@mtlb.co.uk>


--- ide-disk.c.old	Tue Jun  4 21:09:10 2002
+++ ide-disk.c	Tue Jun  4 21:09:44 2002
@@ -929,9 +929,9 @@
 
 	if (id->cfs_enable_2 & 0x0400) {
 		capacity_2 = id->lba_capacity_2;
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
 		drive->head		= drive->bios_head = 255;
 		drive->sect		= drive->bios_sect = 63;
+		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
 		drive->select.b.lba	= 1;
 		set_max_ext = idedisk_read_native_max_address_ext(drive);
 		if (set_max_ext > capacity_2) {



--- defconfig.old	Tue Jun  4 21:13:00 2002
+++ defconfig	Tue Jun  4 21:21:41 2002
@@ -325,10 +325,7 @@
 # CONFIG_SCSI_NCR53C7xx is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_NCR53C8XX is not set
-CONFIG_SCSI_SYM53C8XX=y
-CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
-CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
-CONFIG_SCSI_NCR53C8XX_SYNC=20
+# CONFIG_SCSI_SYM53C8XX is not set
 # CONFIG_SCSI_NCR53C8XX_PROFILE is not set
 # CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
 # CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
@@ -415,7 +412,7 @@
 # CONFIG_DE4X5 is not set
 # CONFIG_DGRS is not set
 # CONFIG_DM9102 is not set
-CONFIG_EEPRO100=y
+# CONFIG_EEPRO100 is not set
 # CONFIG_LNE390 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
@@ -694,7 +691,7 @@
 #
 # Sound
 #
-CONFIG_SOUND=y
+# CONFIG_SOUND is not set
 # CONFIG_SOUND_BT878 is not set
 # CONFIG_SOUND_CMPCI is not set
 # CONFIG_SOUND_EMU10K1 is not set
@@ -702,7 +699,7 @@
 # CONFIG_SOUND_FUSION is not set
 # CONFIG_SOUND_CS4281 is not set
 # CONFIG_SOUND_ES1370 is not set
-CONFIG_SOUND_ES1371=y
+# CONFIG_SOUND_ES1371 is not set
 # CONFIG_SOUND_ESSSOLO1 is not set
 # CONFIG_SOUND_MAESTRO is not set
 # CONFIG_SOUND_MAESTRO3 is not set

