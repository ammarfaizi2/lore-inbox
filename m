Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSELXrr>; Sun, 12 May 2002 19:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSELXrq>; Sun, 12 May 2002 19:47:46 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:59620 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315455AbSELXro>; Sun, 12 May 2002 19:47:44 -0400
Date: Mon, 13 May 2002 01:40:51 +0200
From: Andi Kleen <ak@muc.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA
Message-ID: <20020513014051.A1737@averell>
In-Reply-To: <20020512203615.A12612@averell> <25899.1021244460@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 01:01:00AM +0200, Keith Owens wrote:
> On Sun, 12 May 2002 20:36:15 +0200, 
> Andi Kleen <ak@muc.de> wrote:
> >This patch make CONFIG_ISA an configuration option for i386. This makes
> >sense considering that most PCs do not ship with ISA slots anymore.
> 
> make xconfig
> drivers/ide/Config.in: 129: can't handle dep_bool/dep_mbool/dep_tristate condition
> 
> Your dep_* conditions are wrong.  The conditional fields require
> $CONFIG, not a bare CONFIG.

Fixed now. 

Linus, please consider applying.

-Andi


diff -burp linux-vanilla/arch/i386/config.in linux/arch/i386/config.in
--- linux-vanilla/arch/i386/config.in	Mon May  6 13:11:55 2002
+++ linux/arch/i386/config.in	Sun May 12 20:28:38 2002
@@ -5,7 +5,6 @@
 mainmenu_name "Linux Kernel Configuration"
 
 define_bool CONFIG_X86 y
-define_bool CONFIG_ISA y
 define_bool CONFIG_SBUS n
 
 define_bool CONFIG_UID16 y
@@ -238,6 +237,7 @@ else
          define_bool CONFIG_PCI_DIRECT y
       fi
    fi
+   bool 'ISA support' CONFIG_ISA
 fi
 
 source drivers/pci/Config.in
diff -burp linux-vanilla/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-vanilla/drivers/char/Config.in	Sun May 12 19:37:24 2002
+++ linux/drivers/char/Config.in	Mon May 13 01:32:50 2002
@@ -39,7 +39,7 @@ if [ "$CONFIG_SERIAL_NONSTANDARD" = "y" 
    if [ "$CONFIG_DIGIEPCA" = "n" ]; then
       tristate '  Digiboard PC/Xx Support' CONFIG_DIGI
    fi
-   tristate '  Hayes ESP serial port support' CONFIG_ESPSERIAL
+   dep_tristate '  Hayes ESP serial port support' CONFIG_ESPSERIAL $CONFIG_ISA
    tristate '  Moxa Intellio support' CONFIG_MOXA_INTELLIO
    tristate '  Moxa SmartIO support' CONFIG_MOXA_SMARTIO
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -burp linux-vanilla/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-vanilla/drivers/ide/Config.in	Sun May 12 19:37:25 2002
+++ linux/drivers/ide/Config.in	Mon May 13 01:31:02 2002
@@ -125,7 +125,8 @@ if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; the
 	      EXT_DIRECT	CONFIG_IDE_EXT_DIRECT"	8xx_PCCARD
    fi
 
-   bool '  Other IDE chipset support' CONFIG_IDE_CHIPSETS
+   # assume no ISA -> also no VLB
+   dep_bool '  Other ISA/VLB IDE chipset support' CONFIG_IDE_CHIPSETS $CONFIG_ISA
    if [ "$CONFIG_IDE_CHIPSETS" = "y" ]; then
       comment 'Note: most of these also require special kernel boot parameters'
       bool '    ALI M14xx support' CONFIG_BLK_DEV_ALI14XX
diff -burp linux-vanilla/drivers/media/radio/Config.in linux/drivers/media/radio/Config.in
--- linux-vanilla/drivers/media/radio/Config.in	Sun Apr 14 21:18:54 2002
+++ linux/drivers/media/radio/Config.in	Thu May  9 20:07:45 2002
@@ -4,6 +4,7 @@
 mainmenu_option next_comment
 comment 'Radio Adapters'
 
+if [ "$CONFIG_ISA" = "y" ]; then
 dep_tristate '  ADS Cadet AM/FM Tuner' CONFIG_RADIO_CADET $CONFIG_VIDEO_DEV
 dep_tristate '  AIMSlab RadioTrack (aka RadioReveal) support' CONFIG_RADIO_RTRACK $CONFIG_VIDEO_DEV
 if [ "$CONFIG_RADIO_RTRACK" = "y" ]; then
@@ -21,9 +22,11 @@ dep_tristate '  GemTek Radio Card suppor
 if [ "$CONFIG_RADIO_GEMTEK" = "y" ]; then
    hex '    GemTek i/o port (0x20c, 0x30c, 0x24c or 0x34c)' CONFIG_RADIO_GEMTEK_PORT 34c
 fi
+fi
 dep_tristate '  GemTek PCI Radio Card support' CONFIG_RADIO_GEMTEK_PCI $CONFIG_VIDEO_DEV $CONFIG_PCI
 dep_tristate '  Guillemot MAXI Radio FM 2000 radio' CONFIG_RADIO_MAXIRADIO $CONFIG_VIDEO_DEV
 dep_tristate '  Maestro on board radio' CONFIG_RADIO_MAESTRO $CONFIG_VIDEO_DEV
+if [ "$CONFIG_ISA" = "y" ]; then
 dep_tristate '  miroSOUND PCM20 radio' CONFIG_RADIO_MIROPCM20 $CONFIG_VIDEO_DEV $CONFIG_SOUND_ACI_MIXER
 dep_tristate '    miroSOUND PCM20 radio RDS user interface (EXPERIMENTAL)' CONFIG_RADIO_MIROPCM20_RDS $CONFIG_RADIO_MIROPCM20 $CONFIG_EXPERIMENTAL
 dep_tristate '  SF16FMI Radio' CONFIG_RADIO_SF16FMI $CONFIG_VIDEO_DEV
@@ -48,6 +51,7 @@ fi
 dep_tristate '  Zoltrix Radio' CONFIG_RADIO_ZOLTRIX $CONFIG_VIDEO_DEV
 if [ "$CONFIG_RADIO_ZOLTRIX" = "y" ]; then
    hex '    ZOLTRIX I/O port (0x20c or 0x30c)' CONFIG_RADIO_ZOLTRIX_PORT 20c
+fi
 fi
 
 endmenu
diff -burp linux-vanilla/drivers/net/hamradio/Config.in linux/drivers/net/hamradio/Config.in
--- linux-vanilla/drivers/net/hamradio/Config.in	Sun Apr 14 21:18:42 2002
+++ linux/drivers/net/hamradio/Config.in	Thu May  9 19:59:53 2002
@@ -4,8 +4,10 @@ dep_tristate 'Serial port KISS driver' C
 dep_tristate 'Serial port 6PACK driver' CONFIG_6PACK $CONFIG_AX25
 dep_tristate 'BPQ Ethernet driver' CONFIG_BPQETHER $CONFIG_AX25
     
-dep_tristate 'High-speed (DMA) SCC driver for AX.25' CONFIG_DMASCC $CONFIG_AX25
-dep_tristate 'Z8530 SCC driver' CONFIG_SCC $CONFIG_AX25
+if [ "$CONFIG_ISA" = "y" ]; then
+  dep_tristate 'High-speed (DMA) SCC driver for AX.25' CONFIG_DMASCC $CONFIG_AX25
+  dep_tristate 'Z8530 SCC driver' CONFIG_SCC $CONFIG_AX25
+fi
 if [ "$CONFIG_SCC" != "n" ]; then
    bool '  additional delay for PA0HZP OptoSCC compatible boards' CONFIG_SCC_DELAY
    bool '  support for TRX that feedback the tx signal to rx' CONFIG_SCC_TRXECHO
diff -burp linux-vanilla/drivers/net/wan/Config.in linux/drivers/net/wan/Config.in
--- linux-vanilla/drivers/net/wan/Config.in	Mon May  6 13:11:57 2002
+++ linux/drivers/net/wan/Config.in	Thu May  9 19:59:54 2002
@@ -9,11 +9,12 @@ bool 'Wan interfaces support' CONFIG_WAN
 if [ "$CONFIG_WAN" = "y" ]; then
 # There is no way to detect a comtrol sv11 - force it modular for now.
 
+   if [ "$CONFIG_ISA" = "y" ]; then
    dep_tristate '  Comtrol Hostess SV-11 support' CONFIG_HOSTESS_SV11 m
-
 # The COSA/SRP driver has not been tested as non-modular yet.
 
    dep_tristate '  COSA/SRP sync serial boards support' CONFIG_COSA m
+   fi
 
 #
 # COMX drivers
diff -burp linux-vanilla/drivers/scsi/Config.in linux/drivers/scsi/Config.in
--- linux-vanilla/drivers/scsi/Config.in	Fri May  3 13:22:27 2002
+++ linux/drivers/scsi/Config.in	Fri May 10 01:12:53 2002
@@ -42,11 +42,17 @@ fi
 if [ "$CONFIG_PCI" = "y" ]; then
    dep_tristate '3ware Hardware ATA-RAID support' CONFIG_BLK_DEV_3W_XXXX_RAID $CONFIG_SCSI
 fi
-dep_tristate '7000FASST SCSI support' CONFIG_SCSI_7000FASST $CONFIG_SCSI
+if [ "$CONFIG_ISA" = "y" ]; then
+   dep_tristate '7000FASST SCSI support' CONFIG_SCSI_7000FASST $CONFIG_SCSI
+fi
 dep_tristate 'ACARD SCSI support' CONFIG_SCSI_ACARD $CONFIG_SCSI
-dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI
-dep_tristate 'Adaptec AHA1542 support' CONFIG_SCSI_AHA1542 $CONFIG_SCSI
-dep_tristate 'Adaptec AHA1740 support' CONFIG_SCSI_AHA1740 $CONFIG_SCSI
+if [ "$CONFIG_ISA" = "y" ]; then
+   dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI
+   dep_tristate 'Adaptec AHA1542 support' CONFIG_SCSI_AHA1542 $CONFIG_SCSI
+fi
+if [ "$CONFIG_EISA" = "y" ]; then
+  dep_tristate 'Adaptec AHA1740 support' CONFIG_SCSI_AHA1740 $CONFIG_SCSI
+fi
 source drivers/scsi/aic7xxx/Config.in
 if [ "$CONFIG_SCSI_AIC7XXX" != "y" ]; then
    dep_tristate 'Old Adaptec AIC7xxx support' CONFIG_SCSI_AIC7XXX_OLD $CONFIG_SCSI
@@ -56,10 +62,16 @@ if [ "$CONFIG_SCSI_AIC7XXX" != "y" ]; th
       bool '  Collect statistics to report in /proc' CONFIG_AIC7XXX_OLD_PROC_STATS
    fi
 fi
-dep_tristate 'Adaptec I2O RAID support ' CONFIG_SCSI_DPT_I2O $CONFIG_SCSI
+# All the I2O code and drivers do not seem to be 64bit safe.
+if [ "$CONFIG_X86_64" != "y" ]; then
+  dep_tristate 'Adaptec I2O RAID support ' CONFIG_SCSI_DPT_I2O $CONFIG_SCSI
+fi
 dep_tristate 'AdvanSys SCSI support' CONFIG_SCSI_ADVANSYS $CONFIG_SCSI
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
-dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
+# does not use pci dma and seems to be isa/onboard only for old machines
+if [ "$CONFIG_X86_64" != "y" ]; then
+  dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
+fi
 dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
@@ -70,7 +82,9 @@ if [ "$CONFIG_PCI" = "y" ]; then
    dep_tristate 'Compaq Fibre Channel 64-bit/66Mhz HBA support' CONFIG_SCSI_CPQFCTS $CONFIG_SCSI
 fi
 dep_tristate 'DMX3191D SCSI support' CONFIG_SCSI_DMX3191D $CONFIG_SCSI $CONFIG_PCI
-dep_tristate 'DTC3180/3280 SCSI support' CONFIG_SCSI_DTC3280 $CONFIG_SCSI
+if [ "$CONFIG_ISA" != "y" ]; then
+  dep_tristate 'DTC3180/3280 SCSI support' CONFIG_SCSI_DTC3280 $CONFIG_SCSI
+fi
 dep_tristate 'EATA ISA/EISA/PCI (DPT and generic EATA/DMA-compliant boards) support' CONFIG_SCSI_EATA $CONFIG_SCSI
 if [ "$CONFIG_SCSI_EATA" != "n" ]; then
    bool '  enable tagged command queueing' CONFIG_SCSI_EATA_TAGGED_QUEUE
@@ -111,7 +125,9 @@ if [ "$CONFIG_PARPORT" != "n" ]; then
       bool  '  ppa/imm option - Assume slow parport control register' CONFIG_SCSI_IZIP_SLOW_CTR
    fi
 fi
-dep_tristate 'NCR53c406a SCSI support' CONFIG_SCSI_NCR53C406A $CONFIG_SCSI
+if [ "$CONFIG_ISA" = "y" ]; then
+  dep_tristate 'NCR53c406a SCSI support' CONFIG_SCSI_NCR53C406A $CONFIG_SCSI
+fi
 if [ "$CONFIG_MCA" = "y" ]; then
    dep_tristate 'NCR Dual 700 MCA SCSI support' CONFIG_SCSI_NCR_D700 $CONFIG_SCSI
    if [ "$CONFIG_SCSI_NCR_D700" != "n" ]; then
@@ -164,11 +180,17 @@ fi
 if [ "$CONFIG_MCA" = "y" ]; then
    dep_tristate 'NCR MCA 53C9x SCSI support' CONFIG_SCSI_MCA_53C9X $CONFIG_SCSI
 fi
-dep_tristate 'PAS16 SCSI support' CONFIG_SCSI_PAS16 $CONFIG_SCSI
+if [ "$CONFIG_ISA" = "y" ]; then
+   dep_tristate 'PAS16 SCSI support' CONFIG_SCSI_PAS16 $CONFIG_SCSI
+fi
 dep_tristate 'PCI2000 support' CONFIG_SCSI_PCI2000 $CONFIG_SCSI
 dep_tristate 'PCI2220i support' CONFIG_SCSI_PCI2220I $CONFIG_SCSI
-dep_tristate 'PSI240i support' CONFIG_SCSI_PSI240I $CONFIG_SCSI
-dep_tristate 'Qlogic FAS SCSI support' CONFIG_SCSI_QLOGIC_FAS $CONFIG_SCSI
+if [ "$CONFIG_ISA" = "y" ]; then
+   dep_tristate 'PSI240i support' CONFIG_SCSI_PSI240I $CONFIG_SCSI
+fi
+if [ "$CONFIG_ISA" = "y" ]; then
+   dep_tristate 'Qlogic FAS SCSI support' CONFIG_SCSI_QLOGIC_FAS $CONFIG_SCSI
+fi
 if [ "$CONFIG_PCI" = "y" ]; then
    dep_tristate 'Qlogic ISP SCSI support' CONFIG_SCSI_QLOGIC_ISP $CONFIG_SCSI
    dep_tristate 'Qlogic ISP FC SCSI support' CONFIG_SCSI_QLOGIC_FC $CONFIG_SCSI
@@ -177,24 +199,31 @@ if [ "$CONFIG_PCI" = "y" ]; then
    fi
    dep_tristate 'Qlogic QLA 1280 SCSI support' CONFIG_SCSI_QLOGIC_1280 $CONFIG_SCSI
 fi
-if [ "$CONFIG_X86" = "y" ]; then
+if [ "$CONFIG_X86" = "y" -a "$CONFIG_ISA" = "y" ]; then
    dep_tristate 'Seagate ST-02 and Future Domain TMC-8xx SCSI support' CONFIG_SCSI_SEAGATE $CONFIG_SCSI
 fi
-dep_tristate 'Simple 53c710 SCSI support (Compaq, NCR machines)' CONFIG_SCSI_SIM710 $CONFIG_SCSI
-dep_tristate 'Symbios 53c416 SCSI support' CONFIG_SCSI_SYM53C416 $CONFIG_SCSI
+# definitely looks note 64bit safe:
+if [ "$CONFIG_ISA" = "y" -o "$CONFIG_MCA" = "y" -a "$CONFIG_X86_64" != "y" ]; then
+  dep_tristate 'Simple 53c710 SCSI support (Compaq, NCR machines)' CONFIG_SCSI_SIM710 $CONFIG_SCSI
+fi
+if [ "$CONFIG_ISA" = "y" ]; then
+  dep_tristate 'Symbios 53c416 SCSI support' CONFIG_SCSI_SYM53C416 $CONFIG_SCSI
+fi
 if [ "$CONFIG_PCI" = "y" ]; then
    dep_tristate 'Tekram DC390(T) and Am53/79C974 SCSI support' CONFIG_SCSI_DC390T $CONFIG_SCSI
    if [ "$CONFIG_SCSI_DC390T" != "n" ]; then
       bool '  _omit_ support for non-DC390 adapters' CONFIG_SCSI_DC390T_NOGENSUPP
    fi
 fi
-dep_tristate 'Trantor T128/T128F/T228 SCSI support' CONFIG_SCSI_T128 $CONFIG_SCSI
+if [ "$CONFIG_ISA" = "y" ]; then
+  dep_tristate 'Trantor T128/T128F/T228 SCSI support' CONFIG_SCSI_T128 $CONFIG_SCSI
+fi
 dep_tristate 'UltraStor 14F/34F support' CONFIG_SCSI_U14_34F $CONFIG_SCSI
-   if [ "$CONFIG_SCSI_U14_34F" != "n" ]; then
+if [ "$CONFIG_SCSI_U14_34F" != "n" ]; then
       bool '  enable elevator sorting' CONFIG_SCSI_U14_34F_LINKED_COMMANDS
       int  '  maximum number of queued commands' CONFIG_SCSI_U14_34F_MAX_TAGS 8
-   fi
-if [ "$CONFIG_X86" = "y" ]; then
+fi
+if [ "$CONFIG_X86" = "y" -a "$CONFIG_ISA" = "y" ]; then
    dep_tristate 'UltraStor SCSI support' CONFIG_SCSI_ULTRASTOR $CONFIG_SCSI
 fi
 #
