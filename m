Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133095AbRDZQAj>; Thu, 26 Apr 2001 12:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135520AbRDZQA3>; Thu, 26 Apr 2001 12:00:29 -0400
Received: from cninexchsrv01.crane.navy.mil ([164.227.4.52]:43020 "EHLO
	cninexchsrv01.crane.navy.mil") by vger.kernel.org with ESMTP
	id <S133095AbRDZQAU>; Thu, 26 Apr 2001 12:00:20 -0400
Message-ID: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57135@cninexchsrv01.crane.navy.mil>
From: Friedrich Steven E CONT CNIN <friedrich_s@crane.navy.mil>
To: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: questions about virtual/physical addresses, remap_page_range, and
	 ioremap
Date: Thu, 26 Apr 2001 10:59:53 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running redhat 7.1 (seawolf) with kernel 2.4.3 (I also have 2.4.2).

I'm writing my first linux device driver, and I have been reading Linux
Device Drivers (ORA, Rubini) and a pre-release copy of the next edition.
The next edition I have is missing the chapter on PCI.

I call ioremap to create maps to the PCI space pointed to by bar2, which
points at memory mapped IP modules.
After the ioremap, I try to use __pa() or virt_to_phys() to translate back
to physical and they return bogus info.

1. Am I wrong to use these calls for this purpose?

In my mmap file operation, I use remap_page_range(), which needs the
physical address.  I CAN still get it from pci_resource_start(), but I'm
thinking I shouldn't.

The authors of the next edition say that you can remap virtual addresses
returned by ioremap, but didn't give an example, and I just can't figure it
out.  
2. How do I use the virtual address returned from ioremap in a call to
remap_page_range?


Each of these IP modules is a *device*, but each only has 0x40 bytes of ID
info, and 0x80 bytes of i/o in the address space. And of course, the ID
spaces are contiguous, followed by the i/o spaces for each of the 5 modules.


I have captured some detail with the script command and then added some
comments (search for SEF)

# cat /proc/pci /proc/iomem

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 1).
      Master Capable.  Latency=64.  
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev
1).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
(rev 0).
      Master Capable.  Latency=64.  
      I/O at 0xf450 [0xf45f].
  Bus  0, device  15, function  0:	SEF this is an Acromag 8620 IP
carrier with 5 IP modules installed
    Bridge: PCI device 10b5:1024 (PLX Technology, Inc.) (rev 1).
      IRQ 11.
      Non-prefetchable 32 bit memory at 0xfdfff000 [0xfdffffff].
      I/O at 0xf480 [0xf4ff].
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device  16, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 5).
      IRQ 10.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xfdffe000 [0xfdffefff].
      I/O at 0xf460 [0xf47f].
      Non-prefetchable 32 bit memory at 0xfde00000 [0xfdefffff].
  Bus  0, device  18, function  0:
    VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 2).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-01ffffff : System RAM
  00100000-001e3e99 : Kernel code
  001e3e9a-00237d5b : Kernel data
10000000-10000fff : PCI device 10b5:1024 (PLX Technology, Inc.) SEF this is
bar2, which points to memory mapped IP modules
f8000000-fbffffff : S3 Inc. 86c325 [ViRGE]
fde00000-fdefffff : Intel Corporation 82557 [Ethernet Pro 100]
fdffe000-fdffefff : Intel Corporation 82557 [Ethernet Pro 100]
  fdffe000-fdffefff : eepro100
fdfff000-fdffffff : PCI device 10b5:1024 (PLX Technology, Inc.) SEF this is
bar0, which points to pci config space
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff1cf4-ffffffff : reserved

# ./inscmd 
SEF this is the loadable kernel module containing my device driver.
apc8620: ipModule Init
apc8620: ipModule Probe
apc8620: found Acromag 8620 (5 IP slots) at: bus=0, dev=15, func=0
apc8620: enabled device 'apc8620'
apc8620: requesting mem region referenced by bar0
apc8620: requesting mem region referenced by bar2
apc8620: carrierAdx(from ioremap)=0xc281f000
apc8620: virt_to_phys(carrierAdx)=0x0281f000	SEF note that this is NOT
the correct physical address
apc8620:         __pa(carrierAdx)=0x0281f000
apc8620:      bar2_phys_adx=0x10000000 SEF from pci_resource_start(dev,2)
apc8620:   bar2_phys_length=0x00001000 SEF from pci_resource_len(dev,2)
apc8620:       bar2_virtual=0xd0000000 SEF from phys_to_virt()
apc8620: __pa(bar2_virtual)=0x10000000 SEF happens to be correct, but
actually there's no mapping, linux code merely adds/subtracts 0xc0000000 to
convert between virtual and physical
apc8620: calculated ipID[0]=0xc281f040
apc8620: calculated ipID[1]=0xc281f080
apc8620: calculated ipID[2]=0xc281f0c0
apc8620: calculated ipID[3]=0xc281f100
apc8620: calculated ipID[4]=0xc281f140
apc8620: ipModule=apc8620 @ 0xc281da40
apc8620: rc=0x00000000
apc8620: registered driver 'apc8620'
apc8620: dev pointer passed to ipModuleShow=0xc10b0c00
apc8620: device is using IRQ11
apc8620: name PCI device 10b5:1024 (PLX Technology, Inc.)
apc8620: slot_name 00:0f.0
apc8620: vendor 0x10b5    device 0x1024    class 0x068000
apc8620: bar0 0xfdfff000    bar1 0x0000f480    bar2 0x10000000
apc8620: ipID[0]=IPAC Acromag IP480-6 @ 0x10000040 SEF I cheated on all
these except ipID[2], which shows my dilema
apc8620: ipID[1]=IPAC Acromag IP408
apc8620: ipID[2]=IPAC Acromag IP440 @ 0xc281f0c0 (0x0281f0c0)
apc8620: ipID[3]=IPAC Acromag IP445 @ 0x10000100
apc8620: ipID[4]=IPAC Acromag IP445 @ 0x10000140
apc8620: device driver apc8620
apc8620: registered char device 'apc8620' as major 254
apc8620: opened minor device 0
apc8620: offset 0x00000000 bytes
apc8620: physical adx 0x10000000 bytes
apc8620: pageAdjustment 0x00000000 bytes
apc8620: write 8 bytes to minor device 0
apc8620: read 8 bytes from minor device 0

# ps -ax

  PID TTY      STAT   TIME COMMAND
...
  900 tty3     S      0:00 ./ipDemo
...
# cat /proc/900/maps 

08048000-08049000 r-xp 00000000 03:05 156190
/home/sfriedri/src/pci/apc8620/demo/ipDemo
08049000-0804a000 rw-p 00000000 03:05 156190
/home/sfriedri/src/pci/apc8620/demo/ipDemo
40000000-40015000 r-xp 00000000 03:05 31017      /lib/ld-2.2.2.so
40015000-40016000 rw-p 00014000 03:05 31017      /lib/ld-2.2.2.so
40016000-40018000 rw-p 00000000 00:00 0
40018000-40019000 rw-s 00000000 03:05 99027      /dev/apc8620 SEF I'm
guessing this is the result of my remap_page_range
40019000-4001a000 rw-p 00000000 00:00 0
4001b000-4013c000 r-xp 00000000 03:05 31026      /lib/libc-2.2.2.so
4013c000-40141000 rw-p 00120000 03:05 31026      /lib/libc-2.2.2.so
40141000-40145000 rw-p 00000000 00:00 0
bfffe000-c0000000 rwxp fffff000 00:00 0


Here's code excerpts...

		bar2_phys_adx = (void *)pci_resource_start(dev,2);
		bar2_phys_length = pci_resource_len(dev,2);
		carrierAdx = ioremap_nocache((int)bar2_phys_adx,
bar2_phys_length);
		bar2_virtual = phys_to_virt((int)bar2_phys_adx);

		printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
		printk("carrierAdx(from ioremap)=0x%08lx\n", carrierAdx);
		printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
		printk("virt_to_phys(carrierAdx)=0x%08lx\n",
virt_to_phys(carrierAdx));
		printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
		printk("        __pa(carrierAdx)=0x%08lx\n",
__pa(carrierAdx));

		printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
		printk("     bar2_phys_adx=0x%08x\n", bar2_phys_adx);
		printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
		printk("  bar2_phys_length=0x%08x\n", bar2_phys_length);
		printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
		printk("      bar2_virtual=0x%08x\n", bar2_virtual);
		printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
		printk("__pa(bar2_virtual)=0x%08x\n", __pa(bar2_virtual));


Here's the mmap file operation...
static int ipModuleMMap(struct file *filp, struct vm_area_struct *vma)
{
	unsigned long offset, physical, pageAdjustment;
	physical = pci_resource_start(ipModuleDev,2);

	pageAdjustment = (PAGE_SIZE - 1) & physical;

	offset = vma->vm_pgoff << PAGE_SHIFT;

#ifdef DEBUG1
	printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
	printk("offset 0x%08x bytes\n", offset);
	printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
	printk("physical adx 0x%08x bytes\n", physical);
#endif

#ifdef DEBUG1
	printk("%s%s%s", KERN_NOTICE, DRIVER_NAME, ": ");
	printk("pageAdjustment 0x%08x bytes\n", pageAdjustment);
#endif

	vma->vm_flags |= VM_RESERVED | VM_IO;

	if (remap_page_range(vma->vm_start, physical,
				vma->vm_end - vma->vm_start,
				vma->vm_page_prot))	/* no man page */
		return -EAGAIN;
	return 0;
}


Steven Friedrich
