Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136045AbRD2Tnr>; Sun, 29 Apr 2001 15:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136066AbRD2Tng>; Sun, 29 Apr 2001 15:43:36 -0400
Received: from leng.mclure.org ([64.81.48.142]:21773 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S136045AbRD2TnW>; Sun, 29 Apr 2001 15:43:22 -0400
Date: Sun, 29 Apr 2001 12:43:17 -0700
From: Manuel McLure <manuel@mclure.org>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: panic when booting 2.4.4
Message-ID: <20010429124317.A947@ulthar.internal.mclure.org>
In-Reply-To: <20010429212545.A2208@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010429212545.A2208@gondor.com>; from jan@gondor.com on Sun, Apr 29, 2001 at 12:25:45 -0700
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001.04.29 12:25 Jan Niehusmann wrote:
> I get the following kernel panic when booting 2.4.4. (2.4.3 works fine)
> 
> This is on an asus-a7v133 (VIA chipset), Duron 800, HD is hda, CDRW is
> hdc,
> no other ide devices attached (ie no devices on the onboard promise
> controller)
> 
> gcc version 2.95.4 20010319 (Debian prerelease)
> (the working 2.4.3 has been compiled with the same gcc version)
> 
> Jan
> 
> 
> ksymoops 2.4.1 on i686 2.4.3.  Options used
>      -V (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.4 (specified)
>      -m /boot/System.map-2.4.4 (specified)
> 
> No modules in ksyms, skipping objects
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000024
> c02532a8
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c02532a8>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c144c800
> esi: c144c800   edi: 0003e308   ebp: 00000000   esp: cffe7f34
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=cffe7000)
> Stack: c0258524 c144c800 0003e308 0008e000 00000001 c027e351 cffe7f76
> 00000000 
>        0000000a 00000001 00000000 00000286 00000001 c027e351 0000002e
> 00000002 
>        0007fae0 c0253bf4 c144c800 c0258524 c144c800 55555556 c0253c1c
> c144c800 
> Call Trace: [<c0105007>] [<c0105488>] 
> Code: 81 78 24 86 80 60 09 75 12 68 00 f8 20 c0 e8 75 01 ec ff 83 
> 
> >>EIP; c02532a8 <ide_setup_pci_device+1c8/820>   <=====
> Trace; c0105007 <init+7/110>
> Trace; c0105488 <kernel_thread+28/40>
> Code;  c02532a8 <ide_setup_pci_device+1c8/820>
> 00000000 <_EIP>:
> Code;  c02532a8 <ide_setup_pci_device+1c8/820>   <=====
>    0:   81 78 24 86 80 60 09      cmpl   $0x9608086,0x24(%eax)   <=====
> Code;  c02532af <ide_setup_pci_device+1cf/820>
>    7:   75 12                     jne    1b <_EIP+0x1b> c02532c3
> <ide_setup_pci_device+1e3/820>
> Code;  c02532b1 <ide_setup_pci_device+1d1/820>
>    9:   68 00 f8 20 c0            push   $0xc020f800
> Code;  c02532b6 <ide_setup_pci_device+1d6/820>
>    e:   e8 75 01 ec ff            call   ffec0188 <_EIP+0xffec0188>
> c0113430 <printk+0/160>
> Code;  c02532bb <ide_setup_pci_device+1db/820>
>   13:   83 00 00                  addl   $0x0,(%eax)
> 
> Kernel panic: Attempted to kill init!


Does your motherboard have a Promise FastTrak on it? If so this is a bug I
reported in 2.4.3-ac10/11 and that Alan Cox fixed in -ac12 - for some
reason it didn't make it into 2.4.4. I was just about to report it myself
when I saw your mail. The following patch fixes:

--- ide-pci.c.orig	Sun Apr 29 12:41:05 2001
+++ ide-pci.c	Sun Apr 29 12:33:19 2001
@@ -581,7 +581,7 @@
 		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265))
 		{
 			printk(KERN_INFO "ide: Found promise 20265 in RAID
mode.\n");
-			if(dev->bus->self->vendor == PCI_VENDOR_ID_INTEL
&&
+			if(dev->bus->self && dev->bus->self->vendor ==
PCI_VENDOR_ID_INTEL &&
 				dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960)
 			{
 				printk(KERN_INFO "ide: Skipping Promise
PDC20265 attached to I2O RAID controller.\n");


-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

