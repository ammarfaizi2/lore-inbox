Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUCPLXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 06:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUCPLXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 06:23:46 -0500
Received: from alesia-4-82-66-59-64.fbx.proxad.net ([82.66.59.64]:40610 "HELO
	rooter.tripnotik.fr") by vger.kernel.org with SMTP id S261171AbUCPLXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 06:23:42 -0500
X-Qmail-Scanner-Mail-From: jdidron@tripnotik.dyndns.org via rooter
X-Qmail-Scanner: 1.20 (Clear:RC:1(192.168.0.249):. Processed in 0.04081 secs)
Message-ID: <4056F093.5020909@tripnotik.dyndns.org>
Date: Tue, 16 Mar 2004 13:18:27 +0100
From: Julien Didron <jdidron@tripnotik.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: joe.rutledge@oxtel.com
Subject: Re : Kernel 2.6.1 - SiI 3112 & Asus MBoard & WD Raptor cause complete
 hang with DMA and heavy load
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Joe rutledge (see message below) and I had the same problem with 
what we thougth was the SiI3112 chipset (Box would hang under heavy disc 
access load). It in fact was caused by the Nforce2 chipset. Resolution 
of this thread is done by applying the patch below for 2.6.4 (should 
work for -mm2 and -bk4 too : nforce2-no-disconnect-quirk.patch) :
   
--- linux-2.6.4-orig/arch/i386/pci/fixup.c      2004-03-11 
03:55:36.000000000 +0100
+++ linux-2.6.4/arch/i386/pci/fixup.c   2004-03-16 13:12:25.706569480 +0100
@@ -187,6 +187,22 @@
                dev->transparent = 1;
 }
 
+/*
+ * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
+ * must be disabled when APIC is used (or lockups will happen).
+ */
+static void __devinit pci_fixup_nforce2_disconnect(struct pci_dev *d)
+{
+       u8 t;
+
+       pci_read_config_byte(d, 0x6F, &t);
+       if (t & 0x10) {
+               printk(KERN_INFO "PCI: disabling nForce2 Halt Disconnect"
+                                " and Stop Grant Disconnect\n");
+               pci_write_config_byte(d, 0x6F, (t & 0xef));
+       }
+}
+
 struct pci_fixup pcibios_fixups[] = {
        {
                .pass           = PCI_FIXUP_HEADER,
@@ -290,5 +306,11 @@
                .device         = PCI_ANY_ID,
                .hook           = pci_fixup_transparent_bridge
        },
+        {
+               .pass           = PCI_FIXUP_HEADER,
+               .vendor         = PCI_VENDOR_ID_NVIDIA,
+               .device         = PCI_DEVICE_ID_NVIDIA_NFORCE2,
+               .hook           = pci_fixup_nforce2_disconnect
+        },
        { .pass = 0 }
 };

Thanks to the guys for this post on the forum : 
http://forums.gentoo.org/viewtopic.php?t=140343&highlight=a7n8x
Hope this helps someone ;o)

PS : My configuration is now working flawlessly, using libata and 
sata_sil, I haven't tested it with the siimage.c driver ...

Julien

>Hello everyone,
>
>Initially using a Seagate SATA drive I was experiencing random lockups, 
>no kernel
>panic just a complete hang. Having read about issues with DMA and some 
>Seagates
>I replaced the drive with a Western Digital Raptor. However I still see 
>the same
>lockups. I've tried a variety of options to hdparm (based around -X70 
>-d1) none
>of them making any difference to stability. I then swapped to the libata 
>driver
>expecting this to be more solid. It does appear to last a little longer 
>than the
>IDE driver but the same problems manifest themselves. I then found that 
>there
>were potentially some problems with the Asus board and shared interrupt 
>lines to
>the SiI3112 so I upgraded the BIOS to the most recent version (1007). 
>This has
>made no difference whatsoever. I also read that APIC and ACPI support could
>exascerbate this problem so I removed them from the kernel and disabled 
>them in
>the BIOS. This has given better stability but still not to the point of 
>a usable
>system. This is a desktop system and it will become locked if any heavy 
>disk
>access is done. At the moment I'm running in PIO mode as this is the 
>only stable
>way of handling the disk. I'm not doing any RAID and have no need to. 
>Merely a boot
>of my 2.6.1/2.6.0/2.4.24 system to runlevel 1 and then running bonnie++ 
>-u nobody
>will guarantee a hang before all the write checks have been completed.
>
>Asus A7N8X Deluxe (nforce2) BIOS V1007, AMD Athlon XP (Barton) 2800+, 
>1GB DDR
>RAM (2 x 512 as Dual Channel), WD Raptor 36G SATA HD, Asus GeForce FX 5600
>(256MB), Lite-On 52x CDRW, DVD-ROM. Fresh Gentoo build optimised for 
>Athlon-XP
>(GCC 3.2.3 -march athlon-xp).
>
>2.6.1 kernel patched for forcedeth and nvidia graphics card. APIC & ACPI 
>support
>removed from kernel and turned off in BIOS. Both the IDE and libata 
>drivers have
>been built into the kernel at separate times. It makes no difference 
>what other
>applications are running.
>
>I'm not on the list so a copy of anything posted would be much appreciated.
>
>Thanks in advance to everyone working on the kernel - excellent stuff, 
>it's been
>my working environment for years and a happy one at that!
>
>Joe
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

