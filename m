Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSGYTS3>; Thu, 25 Jul 2002 15:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSGYTS3>; Thu, 25 Jul 2002 15:18:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45071 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316106AbSGYTSX>;
	Thu, 25 Jul 2002 15:18:23 -0400
Message-ID: <3D404F41.77537E67@zip.com.au>
Date: Thu, 25 Jul 2002 12:19:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Duponcheel <mduponch@cisco.com>
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19-rc2 -> 2.4.19-rc3 : no more eth (fwd)
References: <Pine.LNX.4.44.0207232309370.30729-100000@freak.distro.conectiva> <3D3E1FB8.20CB0F@zip.com.au> <20020725170131.GA22527@cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Duponcheel wrote:
> 
> On Tue, Jul 23, 2002 at 08:32:08PM -0700, Andrew Morton wrote:
> > Marcelo Tosatti wrote:
> ...
> > > Warning (compare_Version): Version mismatch.  3c59x says 2.4.18, System.map says 2.4.19.  Expect lots of address mismatches.
> >
> > This is a worry.  Are we sure it was a clean build?
> > Please do a `make mrproper' and retest?
> 
>  Recall,
> 
> This is about ethernet interfaces not initialising (and hence not working)
> with 2.4.19-rc3 (they do initialise and work with 2.4.19-rc2).
> 
> As suggested, I have, for all certainty, repatched linux-2.4.18.tar.gz with patch-2.4.19-rc3.gz
> and rebuilt from a 'mrproper' /usr/src/linux, but the issue remains.
> 
> This time I ran ksymoops on the 2.4.19-rc3 system so no more mismatches
> 
> When doing 'lsmod' one sees the modules eepro100 and 3c59x as 'initialising'
> and one cannot 'rmmod' them because they are 'busy'.
> 

Odd.  There's not a lot of difference between -rc2 and -rc3.
The entire diff is below.  You didn't switch compilers or
something?

 Makefile                               |    2 
 arch/i386/kernel/apm.c                 |    4 -
 arch/i386/kernel/pci-irq.c             |    4 +
 arch/i386/kernel/traps.c               |   11 ++--
 drivers/char/agp/agp.h                 |    3 +
 drivers/char/agp/agpgart_be.c          |   12 ++++
 drivers/ide/ide-features.c             |    6 ++
 drivers/ide/ide-pci.c                  |    2 
 drivers/media/radio/radio-zoltrix.c    |    3 -
 drivers/net/wireless/orinoco_plx.c     |    2 
 drivers/pci/names.c                    |   10 +--
 drivers/pci/quirks.c                   |   16 ++++++
 drivers/scsi/aha152x.c                 |    6 ++
 drivers/scsi/atp870u.c                 |   23 ++++++--
 drivers/scsi/megaraid.c                |    8 +--
 drivers/scsi/scsi_scan.c               |    9 +++
 drivers/sound/cs4232.c                 |   38 ++++++++++++++
 drivers/sound/maestro.c                |   10 +++
 drivers/usb/rtl8150.c                  |    2 
 include/linux/agp_backend.h            |    1 
 include/linux/pci_ids.h                |    8 +--
 include/linux/personality.h            |    3 -
 mm/shmem.c                             |    1 
 net/ipv4/netfilter/ip_conntrack_core.c |    8 +--
 net/rose/af_rose.c                     |    6 +-
 scripts/kernel-doc                     |   86 +++++++++++++++++++++++++--------
 26 files changed, 226 insertions, 58 deletions

Could you please back out the changes until the problem
goes away?

This script which someone wrote will break the diff into
standalone chunks.   Suggest you start with the patch
against drivers/pci/names.c.

#!/usr/bin/perl -w
$out = "";
while (<>) {
	next if (/^Only/);
	next if (/^Binary/);
	if (/^diff/ || /^Index/) {
		if ($out) {
			close OUT;
		}
		(@out) = split(' ', $_);
		shift(@out) if (/^diff/);
		$out = pop(@out);
		$out =~ s:/*usr/:/:;
		$out =~ s:/*src/:/:;
		$out =~ s:^/*linux[^/]*::;
		$out =~ s:\(w\)::;
		next if ($out eq "");
		$out = "/var/tmp/patches/$out";
		$dir = $out;
		$dir =~ s:/[^/]*$::;
		print STDERR "$out\n";
		system("mkdir -p $dir");
		open(OUT, ">$out") || die("cannot open $out");
	}
	if ($out) {
		print OUT $_;
	}
}

diff -uNrp linux-2.4.19-rc2/Makefile linux-2.4.19-rc3/Makefile
--- linux-2.4.19-rc2/Makefile	Sun Jul 21 20:16:21 2002
+++ linux-2.4.19-rc3/Makefile	Sun Jul 21 22:07:56 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 19
-EXTRAVERSION = -rc2
+EXTRAVERSION = -rc3
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -uNrp linux-2.4.19-rc2/arch/i386/kernel/apm.c linux-2.4.19-rc3/arch/i386/kernel/apm.c
--- linux-2.4.19-rc2/arch/i386/kernel/apm.c	Sun Jul 21 20:16:22 2002
+++ linux-2.4.19-rc3/arch/i386/kernel/apm.c	Sun Jul 21 22:07:56 2002
@@ -1198,12 +1198,12 @@ static int suspend(int vetoable)
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
 	get_time_diff();
-	cli();
+	__cli();
 	err = set_system_power_state(APM_STATE_SUSPEND);
 	reinit_timer();
 	set_time();
 	ignore_normal_resume = 1;
-	sti();
+	__sti();
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
diff -uNrp linux-2.4.19-rc2/arch/i386/kernel/pci-irq.c linux-2.4.19-rc3/arch/i386/kernel/pci-irq.c
--- linux-2.4.19-rc2/arch/i386/kernel/pci-irq.c	Sun Jul 21 20:16:22 2002
+++ linux-2.4.19-rc3/arch/i386/kernel/pci-irq.c	Sun Jul 21 22:07:56 2002
@@ -489,6 +489,10 @@ static struct irq_router pirq_routers[] 
 	  pirq_serverworks_get, pirq_serverworks_set },
 	{ "AMD756 VIPER", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B,
 		pirq_amd756_get, pirq_amd756_set },
+	{ "AMD766", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413,
+		pirq_amd756_get, pirq_amd756_set },
+	{ "AMD768", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7443,
+		pirq_amd756_get, pirq_amd756_set },
 
 	{ "default", 0, 0, NULL, NULL }
 };
diff -uNrp linux-2.4.19-rc2/arch/i386/kernel/traps.c linux-2.4.19-rc3/arch/i386/kernel/traps.c
--- linux-2.4.19-rc2/arch/i386/kernel/traps.c	Sun Jul 21 20:16:22 2002
+++ linux-2.4.19-rc3/arch/i386/kernel/traps.c	Sun Jul 21 22:07:56 2002
@@ -139,14 +139,14 @@ void show_trace(unsigned long * stack)
 	if (!stack)
 		stack = (unsigned long*)&stack;
 
-	printk("Call Trace: ");
+	printk("Call Trace:   ");
 	i = 1;
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
 			if (i && ((i % 6) == 0))
-				printk("\n   ");
-			printk("[<%08lx>] ", addr);
+				printk("\n ");
+			printk(" [<%08lx>]", addr);
 			i++;
 		}
 	}
@@ -618,9 +618,10 @@ void math_error(void *eip)
 		default:
 			break;
 		case 0x001: /* Invalid Op */
-		case 0x040: /* Stack Fault */
-		case 0x240: /* Stack Fault | Direction */
+		case 0x041: /* Stack Fault */
+		case 0x241: /* Stack Fault | Direction */
 			info.si_code = FPE_FLTINV;
+			/* Should we clear the SF or let user space do it ???? */
 			break;
 		case 0x002: /* Denormalize */
 		case 0x010: /* Underflow */
diff -uNrp linux-2.4.19-rc2/drivers/char/agp/agp.h linux-2.4.19-rc3/drivers/char/agp/agp.h
--- linux-2.4.19-rc2/drivers/char/agp/agp.h	Sun Jul 21 20:16:24 2002
+++ linux-2.4.19-rc3/drivers/char/agp/agp.h	Sun Jul 21 22:07:59 2002
@@ -265,6 +265,9 @@ struct agp_bridge_data {
 #ifndef PCI_DEVICE_ID_AL_M1651_0
 #define PCI_DEVICE_ID_AL_M1651_0	0x1651
 #endif
+#ifndef PCI_DEVICE_ID_AL_M1671_0
+#define PCI_DEVICE_ID_AL_M1671_0	0x1671
+#endif
 
 /* intel register */
 #define INTEL_APBASE    0x10
diff -uNrp linux-2.4.19-rc2/drivers/char/agp/agpgart_be.c linux-2.4.19-rc3/drivers/char/agp/agpgart_be.c
--- linux-2.4.19-rc2/drivers/char/agp/agpgart_be.c	Sun Jul 21 20:16:24 2002
+++ linux-2.4.19-rc3/drivers/char/agp/agpgart_be.c	Sun Jul 21 22:07:59 2002
@@ -3946,6 +3946,12 @@ static struct {
 		"Ali",
 		"M1651",
 		ali_generic_setup },  
+	{ PCI_DEVICE_ID_AL_M1671_0,
+		PCI_VENDOR_ID_AL,
+		ALI_M1671,
+		"Ali",
+		"M1671",
+		ali_generic_setup },  
 	{ 0,
 		PCI_VENDOR_ID_AL,
 		ALI_GENERIC,
@@ -4094,6 +4100,12 @@ static struct {
 		"SiS",
 		"735",
 		sis_generic_setup },
+	{ PCI_DEVICE_ID_SI_745,
+		PCI_VENDOR_ID_SI,
+		SIS_GENERIC,
+		"SiS",
+		"745",
+		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_730,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,
diff -uNrp linux-2.4.19-rc2/drivers/ide/ide-features.c linux-2.4.19-rc3/drivers/ide/ide-features.c
--- linux-2.4.19-rc2/drivers/ide/ide-features.c	Sun Jul 21 20:16:25 2002
+++ linux-2.4.19-rc3/drivers/ide/ide-features.c	Sun Jul 21 22:07:59 2002
@@ -240,13 +240,16 @@ int set_transfer (ide_drive_t *drive, id
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_IDEDMA
 /*
  *  All hosts that use the 80c ribbon mus use!
  */
 byte eighty_ninty_three (ide_drive_t *drive)
 {
+#ifdef CONFIG_BLK_DEV_IDEPCI
 	if (HWIF(drive)->pci_devid.vid==0x105a)
 	    return(HWIF(drive)->udma_four);
+#endif
 	/* PDC202XX: that's because some HDD will return wrong info */
 	return ((byte) ((HWIF(drive)->udma_four) &&
 #ifndef CONFIG_IDEDMA_IVB
@@ -254,6 +257,7 @@ byte eighty_ninty_three (ide_drive_t *dr
 #endif /* CONFIG_IDEDMA_IVB */
 			(drive->id->hw_config & 0x6000)) ? 1 : 0);
 }
+#endif // CONFIG_BLK_DEV_IDEDMA
 
 /*
  * Similar to ide_wait_stat(), except it never calls ide_error internally.
@@ -374,6 +378,8 @@ EXPORT_SYMBOL(ide_auto_reduce_xfer);
 EXPORT_SYMBOL(ide_driveid_update);
 EXPORT_SYMBOL(ide_ata66_check);
 EXPORT_SYMBOL(set_transfer);
+#ifdef CONFIG_BLK_DEV_IDEDMA
 EXPORT_SYMBOL(eighty_ninty_three);
+#endif // CONFIG_BLK_DEV_IDEDMA
 EXPORT_SYMBOL(ide_config_drive_speed);
 
diff -uNrp linux-2.4.19-rc2/drivers/ide/ide-pci.c linux-2.4.19-rc3/drivers/ide/ide-pci.c
--- linux-2.4.19-rc2/drivers/ide/ide-pci.c	Sun Jul 21 20:16:25 2002
+++ linux-2.4.19-rc3/drivers/ide/ide-pci.c	Sun Jul 21 22:07:59 2002
@@ -669,7 +669,7 @@ check_if_enabled:
 	 */
 	pciirq = dev->irq;
 	
-#ifdef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_FORCE
 	if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID) {
 		/*
 		 * By rights we want to ignore Promise FastTrak and SuperTrak
diff -uNrp linux-2.4.19-rc2/drivers/media/radio/radio-zoltrix.c linux-2.4.19-rc3/drivers/media/radio/radio-zoltrix.c
--- linux-2.4.19-rc2/drivers/media/radio/radio-zoltrix.c	Sun Sep 30 12:26:06 2001
+++ linux-2.4.19-rc3/drivers/media/radio/radio-zoltrix.c	Sun Jul 21 22:07:59 2002
@@ -23,6 +23,7 @@
  *		(can detect if station is in stereo)
  *	      - Added unmute function
  *	      - Reworked ioctl functions
+ * 2002-07-15 - Fix Stereo typo
  */
 
 #include <linux/module.h>	/* Modules                        */
@@ -280,7 +281,7 @@ static int zol_ioctl(struct video_device
 			struct video_audio v;
 			memset(&v, 0, sizeof(v));
 			v.flags |= VIDEO_AUDIO_MUTABLE | VIDEO_AUDIO_VOLUME;
-			v.mode != zol_is_stereo(zol)
+			v.mode |= zol_is_stereo(zol)
 				? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;
 			v.volume = zol->curvol * 4096;
 			v.step = 4096;
diff -uNrp linux-2.4.19-rc2/drivers/net/wireless/orinoco_plx.c linux-2.4.19-rc3/drivers/net/wireless/orinoco_plx.c
--- linux-2.4.19-rc2/drivers/net/wireless/orinoco_plx.c	Sun Jul 21 20:16:26 2002
+++ linux-2.4.19-rc3/drivers/net/wireless/orinoco_plx.c	Sun Jul 21 22:08:00 2002
@@ -385,7 +385,7 @@ static struct pci_driver orinoco_plx_dri
 	name:"orinoco_plx",
 	id_table:orinoco_plx_pci_id_table,
 	probe:orinoco_plx_init_one,
-	remove:orinoco_plx_remove_one,
+	remove:__devexit_p(orinoco_plx_remove_one),
 	suspend:0,
 	resume:0
 };
diff -uNrp linux-2.4.19-rc2/drivers/pci/names.c linux-2.4.19-rc3/drivers/pci/names.c
--- linux-2.4.19-rc2/drivers/pci/names.c	Fri Nov  9 14:03:11 2001
+++ linux-2.4.19-rc3/drivers/pci/names.c	Sun Jul 21 22:08:00 2002
@@ -32,18 +32,18 @@ struct pci_vendor_info {
  * real memory.. Parse the same file multiple times
  * to get all the info.
  */
-#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __initdata = name;
+#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __devinitdata = name;
 #define ENDVENDOR()
-#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __initdata = name;
+#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __devinitdata = name;
 #include "devlist.h"
 
 
-#define VENDOR( vendor, name )		static struct pci_device_info __devices_##vendor[] __initdata = {
+#define VENDOR( vendor, name )		static struct pci_device_info __devices_##vendor[] __devinitdata = {
 #define ENDVENDOR()			};
 #define DEVICE( vendor, device, name )	{ 0x##device, 0, __devicestr_##vendor##device },
 #include "devlist.h"
 
-static struct pci_vendor_info __initdata pci_vendor_list[] = {
+static struct pci_vendor_info __devinitdata pci_vendor_list[] = {
 #define VENDOR( vendor, name )		{ 0x##vendor, sizeof(__devices_##vendor) / sizeof(struct pci_device_info), __vendorstr_##vendor, __devices_##vendor },
 #define ENDVENDOR()
 #define DEVICE( vendor, device, name )
@@ -121,7 +121,7 @@ pci_class_name(u32 class)
 
 #else
 
-void __init pci_name_device(struct pci_dev *dev)
+void __devinit pci_name_device(struct pci_dev *dev)
 {
 }
 
diff -uNrp linux-2.4.19-rc2/drivers/pci/quirks.c linux-2.4.19-rc3/drivers/pci/quirks.c
--- linux-2.4.19-rc2/drivers/pci/quirks.c	Sun Jul 21 20:16:26 2002
+++ linux-2.4.19-rc3/drivers/pci/quirks.c	Sun Jul 21 22:08:00 2002
@@ -457,10 +457,26 @@ static void __init quirk_amd_ordering(st
 }
 
 /*
+ *	DreamWorks provided workaround for Dunord I-3000 problem
+ *
+ *	This card decodes and responds to addresses not apparently
+ *	assigned to it. We force a larger allocation to ensure that
+ *	nothing gets put too close to it.
+ */
+
+static void __init quirk_dunord ( struct pci_dev * dev )
+{
+	struct resource * r = & dev -> resource [ 1 ];
+	r -> start = 0;
+	r -> end = 0xffffff;
+}
+
+/*
  *  The main table of quirks.
  */
 
 static struct pci_fixup pci_fixups[] __initdata = {
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
 	/*
diff -uNrp linux-2.4.19-rc2/drivers/scsi/aha152x.c linux-2.4.19-rc3/drivers/scsi/aha152x.c
--- linux-2.4.19-rc2/drivers/scsi/aha152x.c	Sun Jul 21 20:16:27 2002
+++ linux-2.4.19-rc3/drivers/scsi/aha152x.c	Sun Jul 21 22:08:01 2002
@@ -1368,7 +1368,13 @@ int aha152x_detect(Scsi_Host_Template * 
 
 		printk(KERN_INFO "aha152x%d: trying software interrupt, ", HOSTNO);
 		SETPORT(DMACNTRL0, SWINT|INTEN);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+		spin_unlock_irq(&io_request_lock);
+#endif
 		mdelay(1000);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+		spin_lock_irq(&io_request_lock);
+#endif
 		free_irq(shpnt->irq, shpnt);
 
 		if (!HOSTDATA(shpnt)->swint) {
diff -uNrp linux-2.4.19-rc2/drivers/scsi/atp870u.c linux-2.4.19-rc3/drivers/scsi/atp870u.c
--- linux-2.4.19-rc2/drivers/scsi/atp870u.c	Sun Sep 30 12:26:07 2001
+++ linux-2.4.19-rc3/drivers/scsi/atp870u.c	Sun Jul 21 22:08:01 2002
@@ -11,7 +11,8 @@
  *		   enable 32 bit fifo transfer
  *		   support cdrom & remove device run ultra speed
  *		   fix disconnect bug  2000/12/21
- *		   support atp880 chip lvd u160 2001/05/15 (7.1)
+ *		   support atp880 chip lvd u160 2001/05/15
+ *		   fix prd table bug 2001/09/12 (7.1)
  */
 
 #include <linux/module.h>
@@ -803,8 +804,18 @@ oktosend:
 		sgpnt = (struct scatterlist *) workrequ->request_buffer;
 		i = 0;
 		for (j = 0; j < workrequ->use_sg; j++) {
-			(unsigned long) (((unsigned long *) (prd))[i >> 1]) = virt_to_bus(sgpnt[j].address);
-			(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = sgpnt[j].length;
+			bttl = virt_to_bus(sgpnt[j].address);
+			l = sgpnt[j].length;
+			while (l > 0x10000) {
+				(unsigned short int) (((unsigned short int *) (prd))[i + 3]) = 0x0000;
+				(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = 0x0000;
+				(unsigned long) (((unsigned long *) (prd))[i >> 1]) = bttl;
+				l -= 0x10000;
+				bttl += 0x10000;
+				i += 0x04;
+			}
+			(unsigned long) (((unsigned long *) (prd))[i >> 1]) = bttl;
+			(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = l;
 			(unsigned short int) (((unsigned short int *) (prd))[i + 3]) = 0;
 			i += 0x04;
 		}
@@ -2527,7 +2538,7 @@ int atp870u_detect(Scsi_Host_Template * 
 		   host_id = inb(base_io + 0x39);
 		   host_id >>= 0x04;
 
-		   printk(KERN_INFO "   ACARD AEC-67160 PCI Ultra160 LVD/SE SCSI Adapter: %d    IO:%x, IRQ:%d.\n"
+		   printk(KERN_INFO "   ACARD AEC-67160 PCI Ultra3 LVD Host Adapter: %d    IO:%x, IRQ:%d.\n"
 			  ,h, base_io, irq);
 		   dev->ioport = base_io + 0x40;
 		   dev->pciport = base_io + 0x28;
@@ -2764,7 +2775,7 @@ const char *atp870u_info(struct Scsi_Hos
 {
 	static char buffer[128];
 
-	strcpy(buffer, "ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver V2.5+ac ");
+	strcpy(buffer, "ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver V2.6+ac ");
 
 	return buffer;
 }
@@ -2809,7 +2820,7 @@ int atp870u_proc_info(char *buffer, char
 	if (offset == 0) {
 		memset(buff, 0, sizeof(buff));
 	}
-	size += sprintf(BLS, "ACARD AEC-671X Driver Version: 2.5+ac\n");
+	size += sprintf(BLS, "ACARD AEC-671X Driver Version: 2.6+ac\n");
 	len += size;
 	pos = begin + len;
 	size = 0;
diff -uNrp linux-2.4.19-rc2/drivers/scsi/megaraid.c linux-2.4.19-rc3/drivers/scsi/megaraid.c
--- linux-2.4.19-rc2/drivers/scsi/megaraid.c	Sun Jul 21 20:16:41 2002
+++ linux-2.4.19-rc3/drivers/scsi/megaraid.c	Sun Jul 21 22:08:01 2002
@@ -3076,10 +3076,12 @@ static int mega_findCard (Scsi_Host_Temp
 			/*
 			 * which firmware
 			 */
-			if( strcmp(megaCfg->fwVer, "H01.07") == 0 ||
-					strcmp(megaCfg->fwVer, "H01.08") == 0 ) {
+			if( strcmp(megaCfg->fwVer, "H01.07") == 0 || 
+			    strcmp(megaCfg->fwVer, "H01.08") == 0 ||
+			    strcmp(megaCfg->fwVer, "H01.09") == 0 )
+			{
 				printk(KERN_WARNING
-						"megaraid: Firmware H.01.07 or H.01.08 on 1M/2M "
+						"megaraid: Firmware H.01.07/8/9 on 1M/2M "
 						"controllers\nmegaraid: do not support 64 bit "
 						"addressing.\n"
 						"megaraid: DISABLING 64 bit support.\n");
diff -uNrp linux-2.4.19-rc2/drivers/scsi/scsi_scan.c linux-2.4.19-rc3/drivers/scsi/scsi_scan.c
--- linux-2.4.19-rc2/drivers/scsi/scsi_scan.c	Sun Jul 21 20:16:41 2002
+++ linux-2.4.19-rc3/drivers/scsi/scsi_scan.c	Sun Jul 21 22:08:01 2002
@@ -110,6 +110,10 @@ static struct dev_info device_list[] =
 	{"HP", "C1750A", "3226", BLIST_NOLUN},			/* scanjet iic */
 	{"HP", "C1790A", "", BLIST_NOLUN},			/* scanjet iip */
 	{"HP", "C2500A", "", BLIST_NOLUN},			/* scanjet iicx */
+	{"HP", "A6188A", "*", BLIST_SPARSELUN},			/* HP Va7100 Array */
+	{"HP", "A6189A", "*", BLIST_SPARSELUN},			/* HP Va7400 Array */
+	{"HP", "A6189B", "*", BLIST_SPARSELUN},			/* HP Va7410 Array */
+	{"HP", "OPEN-", "*", BLIST_SPARSELUN},			/* HP XP Arrays */
 	{"YAMAHA", "CDR100", "1.00", BLIST_NOLUN},		/* Locks up if polled for lun != 0 */
 	{"YAMAHA", "CDR102", "1.00", BLIST_NOLUN},		/* Locks up if polled for lun != 0  
 								 * extra reset */
@@ -173,7 +177,10 @@ static struct dev_info device_list[] =
 	{"HP", "C1557A", "*", BLIST_FORCELUN},
 	{"IBM", "AuSaV1S2", "*", BLIST_FORCELUN},
 	{"FSC", "CentricStor", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
-
+	{"DDN", "SAN DataDirector", "*", BLIST_SPARSELUN},
+	{"HITACHI", "DF400", "*", BLIST_SPARSELUN},
+	{"HITACHI", "DF500", "*", BLIST_SPARSELUN},
+	{"HITACHI", "DF600", "*", BLIST_SPARSELUN},
 
 	/*
 	 * Must be at end of list...
diff -uNrp linux-2.4.19-rc2/drivers/sound/cs4232.c linux-2.4.19-rc3/drivers/sound/cs4232.c
--- linux-2.4.19-rc2/drivers/sound/cs4232.c	Mon Feb 25 11:38:04 2002
+++ linux-2.4.19-rc3/drivers/sound/cs4232.c	Sun Jul 21 22:08:01 2002
@@ -34,6 +34,8 @@
  * anyway.
  *
  * Changes
+ *      John Rood               Added Bose Sound System Support.
+ *      Toshio Spoor
  *	Alan Cox		Modularisation, Basic cleanups.
  *      Paul Barton-Davis	Separated MPU configuration, added
  *                                       Tropez+ (WaveFront) support
@@ -58,6 +60,10 @@
 
 #define KEY_PORT	0x279	/* Same as LPT1 status port */
 #define CSN_NUM		0x99	/* Just a random number */
+#define INDEX_ADDRESS   0x00    /* (R0) Index Address Register */
+#define INDEX_DATA      0x01    /* (R1) Indexed Data Register */
+#define PIN_CONTROL     0x0a    /* (I10) Pin Control */
+#define ENABLE_PINS     0xc0    /* XCTRL0/XCTRL1 enable */
 
 static void CS_OUT(unsigned char a)
 {
@@ -67,6 +73,7 @@ static void CS_OUT(unsigned char a)
 #define CS_OUT2(a, b)		{CS_OUT(a);CS_OUT(b);}
 #define CS_OUT3(a, b, c)	{CS_OUT(a);CS_OUT(b);CS_OUT(c);}
 
+static int __initdata bss       = 0;
 static int mpu_base = 0, mpu_irq = 0;
 static int synth_base = 0, synth_irq = 0;
 static int mpu_detected = 0;
@@ -97,6 +104,30 @@ static void sleep(unsigned howlong)
 	schedule_timeout(howlong);
 }
 
+static void enable_xctrl(int baseio)
+{
+        unsigned char regd;
+                
+        /*
+         * Some IBM Aptiva's have the Bose Sound System. By default
+         * the Bose Amplifier is disabled. The amplifier will be 
+         * activated, by setting the XCTRL0 and XCTRL1 bits.
+         * Volume of the monitor bose speakers/woofer, can then
+         * be set by changing the PCM volume.
+         *
+         */
+                
+        printk("cs4232: enabling Bose Sound System Amplifier.\n");
+        
+        /* Switch to Pin Control Address */                   
+        regd = inb(baseio + INDEX_ADDRESS) & 0xe0;
+        outb(((unsigned char) (PIN_CONTROL | regd)), baseio + INDEX_ADDRESS );
+        
+        /* Activate the XCTRL0 and XCTRL1 Pins */
+        regd = inb(baseio + INDEX_DATA);
+        outb(((unsigned char) (ENABLE_PINS | regd)), baseio + INDEX_DATA );
+}
+
 int __init probe_cs4232(struct address_info *hw_config, int isapnp_configured)
 {
 	int i, n;
@@ -275,6 +306,11 @@ void __init attach_cs4232(struct address
 		}
 		hw_config->slots[1] = hw_config2.slots[1];
 	}
+	
+	if (bss)
+	{
+        	enable_xctrl(base);
+	}
 }
 
 void unload_cs4232(struct address_info *hw_config)
@@ -349,6 +385,8 @@ MODULE_PARM(synthirq,"i");
 MODULE_PARM_DESC(synthirq,"Maui WaveTable IRQ");
 MODULE_PARM(isapnp,"i");
 MODULE_PARM_DESC(isapnp,"Enable ISAPnP probing (default 1)");
+MODULE_PARM(bss,"i");
+MODULE_PARM_DESC(bss,"Enable Bose Sound System Support (default 0)");
 
 /*
  *	Install a CS4232 based card. Need to have ad1848 and mpu401
diff -uNrp linux-2.4.19-rc2/drivers/sound/maestro.c linux-2.4.19-rc3/drivers/sound/maestro.c
--- linux-2.4.19-rc2/drivers/sound/maestro.c	Sun Jul 21 20:16:41 2002
+++ linux-2.4.19-rc3/drivers/sound/maestro.c	Sun Jul 21 22:08:01 2002
@@ -3569,9 +3569,19 @@ maestro_probe(struct pci_dev *pcidev,con
 static void maestro_remove(struct pci_dev *pcidev) {
 	struct ess_card *card = pci_get_drvdata(pcidev);
 	int i;
+	u32 n;
 	
 	/* XXX maybe should force stop bob, but should be all 
 		stopped by _release by now */
+
+	/* Turn off hardware volume control interrupt.
+	   This has to come before we leave the IRQ below,
+	   or a crash results if a button is pressed ! */
+
+	n = inw(card->iobase+0x18);
+	n&=~(1<<6);
+	outw(n, card->iobase+0x18);
+
 	free_irq(card->irq, card);
 	unregister_sound_mixer(card->dev_mixer);
 	for(i=0;i<NR_DSPS;i++)
diff -uNrp linux-2.4.19-rc2/drivers/usb/rtl8150.c linux-2.4.19-rc3/drivers/usb/rtl8150.c
--- linux-2.4.19-rc2/drivers/usb/rtl8150.c	Sun Jul 21 20:16:42 2002
+++ linux-2.4.19-rc3/drivers/usb/rtl8150.c	Sun Jul 21 22:08:01 2002
@@ -84,7 +84,7 @@ MODULE_DEVICE_TABLE (usb, rtl8150_table)
 
 
 struct rtl8150 {
-	unsigned int		flags;
+	unsigned long		flags;
 	struct usb_device	*udev;
 	struct usb_interface	*interface;
 	struct semaphore	sem;
diff -uNrp linux-2.4.19-rc2/include/linux/agp_backend.h linux-2.4.19-rc3/include/linux/agp_backend.h
--- linux-2.4.19-rc2/include/linux/agp_backend.h	Sun Jul 21 20:16:44 2002
+++ linux-2.4.19-rc3/include/linux/agp_backend.h	Sun Jul 21 22:08:04 2002
@@ -73,6 +73,7 @@ enum chipset_type {
 	ALI_M1644,
 	ALI_M1647,
 	ALI_M1651,
+	ALI_M1671,
 	ALI_GENERIC,
 	SVWRKS_HE,
 	SVWRKS_LE,
diff -uNrp linux-2.4.19-rc2/include/linux/pci_ids.h linux-2.4.19-rc3/include/linux/pci_ids.h
--- linux-2.4.19-rc2/include/linux/pci_ids.h	Sun Jul 21 20:16:44 2002
+++ linux-2.4.19-rc3/include/linux/pci_ids.h	Sun Jul 21 22:08:04 2002
@@ -1602,13 +1602,15 @@
 #define PCI_DEVICE_ID_S3_ViRGE_MXPMV	0x8c03
 #define PCI_DEVICE_ID_S3_SONICVIBES	0xca00
 
+#define PCI_VENDOR_ID_DUNORD		0x5544
+#define PCI_DEVICE_ID_DUNORD_I3000	0x0001
+#define PCI_VENDOR_ID_GENROCO		0x5555
+#define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
+
 #define PCI_VENDOR_ID_DCI		0x6666
 #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 
-#define PCI_VENDOR_ID_GENROCO		0x5555
-#define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
-
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_21145	0x0039
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
diff -uNrp linux-2.4.19-rc2/include/linux/personality.h linux-2.4.19-rc3/include/linux/personality.h
--- linux-2.4.19-rc2/include/linux/personality.h	Sun Jul 21 20:16:44 2002
+++ linux-2.4.19-rc3/include/linux/personality.h	Sun Jul 21 22:08:04 2002
@@ -62,7 +62,8 @@ enum {
 	PER_RISCOS =		0x000c,
 	PER_SOLARIS =		0x000d | STICKY_TIMEOUTS,
 	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
-	PER_OSF4 =		0x000f,			 /* OSF/1 v4 */
+	PER_HPUX =		0x000f,
+	PER_OSF4 =		0x0010,			 /* OSF/1 v4 */
 	PER_MASK =		0x00ff,
 };
 
diff -uNrp linux-2.4.19-rc2/mm/shmem.c linux-2.4.19-rc3/mm/shmem.c
--- linux-2.4.19-rc2/mm/shmem.c	Sun Jul 21 20:16:44 2002
+++ linux-2.4.19-rc3/mm/shmem.c	Sun Jul 21 22:08:04 2002
@@ -905,7 +905,6 @@ out:
 fail_write:
 	status = -EFAULT;
 	ClearPageUptodate(page);
-	kunmap(page);
 	goto unlock;
 }
 
diff -uNrp linux-2.4.19-rc2/net/ipv4/netfilter/ip_conntrack_core.c linux-2.4.19-rc3/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.4.19-rc2/net/ipv4/netfilter/ip_conntrack_core.c	Sun Jul 21 20:16:44 2002
+++ linux-2.4.19-rc3/net/ipv4/netfilter/ip_conntrack_core.c	Sun Jul 21 22:08:04 2002
@@ -497,11 +497,9 @@ init_conntrack(const struct ip_conntrack
 		/* Try dropping from random chain, or else from the
                    chain about to put into (in case they're trying to
                    bomb one hash chain). */
-		if (drop_next == ip_conntrack_htable_size-1)
-			drop_next = 0;
-		else
-			drop_next++;
-		if (!early_drop(&ip_conntrack_hash[drop_next])
+		unsigned int next = (drop_next++)%ip_conntrack_htable_size;
+
+		if (!early_drop(&ip_conntrack_hash[next])
 		    && !early_drop(&ip_conntrack_hash[hash])) {
 			if (net_ratelimit())
 				printk(KERN_WARNING
diff -uNrp linux-2.4.19-rc2/net/rose/af_rose.c linux-2.4.19-rc3/net/rose/af_rose.c
--- linux-2.4.19-rc2/net/rose/af_rose.c	Sun Jul 21 20:16:44 2002
+++ linux-2.4.19-rc3/net/rose/af_rose.c	Sun Jul 21 22:08:04 2002
@@ -26,6 +26,7 @@
  *
  *  ROSE 0.63	Jean-Paul(F6FBB) Fixed wrong length of L3 packets
  *					Added CLEAR_REQUEST facilities
+ *  ROSE 0.64	Jean-Paul(F6FBB) Fixed null pointer in rose_kill_by_device
  */
 
 #include <linux/config.h>
@@ -227,7 +228,8 @@ static void rose_kill_by_device(struct n
 	for (s = rose_list; s != NULL; s = s->next) {
 		if (s->protinfo.rose->device == dev) {
 			rose_disconnect(s, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
-			s->protinfo.rose->neighbour->use--;
+			if (s->protinfo.rose->neighbour)
+				s->protinfo.rose->neighbour->use--;
 			s->protinfo.rose->device = NULL;
 		}
 	}
@@ -1433,7 +1435,7 @@ static struct notifier_block rose_dev_no
 
 static struct net_device *dev_rose;
 
-static const char banner[] = KERN_INFO "F6FBB/G4KLX ROSE for Linux. Version 0.63 for AX25.037 Linux 2.4\n";
+static const char banner[] = KERN_INFO "F6FBB/G4KLX ROSE for Linux. Version 0.64 for AX25.037 Linux 2.4\n";
 
 static int __init rose_proto_init(void)
 {
