Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUJNPgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUJNPgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 11:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUJNPgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 11:36:03 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:41938 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266291AbUJNPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 11:35:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: 8-order memory allocations problem (update)
Date: Thu, 14 Oct 2004 17:37:31 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
       agruen@suse.de
References: <200410052314.25253.rjw@sisk.pl> <20041010134846.GD19831@elf.ucw.cz> <200410131924.34337.rjw@sisk.pl>
In-Reply-To: <200410131924.34337.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410141737.31687.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 of October 2004 19:24, Rafael J. Wysocki wrote:
> Hi,
> 
> On Sunday 10 of October 2004 15:48, Pavel Machek wrote:
> [-- snip --] 
> > > It's sort of strange, because there were 250 meg of RAM available,
> > > out of 500, at that time.
> > 
> > Well, you have 250MB free, but apparently not enough contignuous free 
> pages...
> > 
> > You may try this one, it may reduce probability of this kind of
> > failure...
> > 
> > 							Pavel
> > 
> > --- clean/kernel/power/disk.c	2004-10-01 00:30:32.000000000 +0200
> > +++ linux/kernel/power/disk.c	2004-10-02 19:43:06.000000000 +0200
> > @@ -85,13 +89,26 @@
> >  
> >  static void free_some_memory(void)
> >  {
> > -	printk("Freeing memory: ");
> > -	while (shrink_all_memory(10000))
> > -		printk(".");
> > -	printk("|\n");
> > +	int i;
> > +	for (i=0; i<5; i++) {
> > +		int i = 0, tmp;
> > +		long pages = 0;
> > +		char *p = "-\\|/";
> > +
> > +		printk("Freeing memory...  ");
> > +		while ((tmp = shrink_all_memory(10000))) {
> > +			pages += tmp;
> > +			printk("\b%c", p[i]);
> > +			i++;
> > +			if (i > 3)
> > +				i = 0;
> > +		}
> > +		printk("\bdone (%li pages freed)\n", pages);
> > +		current->state = TASK_INTERRUPTIBLE;
> > +		schedule_timeout(HZ/5);
> > +	}
> >  }
> >  
> > -
> >  static inline void platform_finish(void)
> >  {
> >  	if (pm_disk_mode == PM_DISK_PLATFORM) {
> > -- 
> 
> I'm giving it a try.  Without this patch I get an 8-order allocation failure 
> almost every time after using a computer for a day.  This one is pretty 
> scary, IMO (there are 5 times more pages free than needed to be copied and 
> still it cannot allocate enough memory):

I does not help, apparently.  Below is what I've just got on -rc4 with this 
patch applied.  Please note that there were two attempts to suspend the box 
in a row and I've stopped some memory-consuming apps after the first one.

Now, as I've stopped all of the apps that I wanted/could stop before suspend, 
the box is unsuspendable for practical purposes.

The USB-related stuff in between is retained for completeness.

Oct 14 17:22:31 albercik kernel: Stopping tasks: 
===================================================================|
Oct 14 17:22:31 albercik kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^
H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\
^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H
\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^
H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-
^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^Hdone (98884 pages freed)
Oct 14 17:22:31 albercik kernel: Freeing memory...  ^H-^Hdone (256 pages 
freed)
Oct 14 17:22:31 albercik kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^Hdone (2560 pages freed)
Oct 14 17:22:31 albercik kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|
^H/^H-^Hdone (2048 pages freed)
Oct 14 17:22:31 albercik kernel: Freeing memory...  ^H-^H\^H|^Hdone (656 pages 
freed)
Oct 14 17:22:31 albercik kernel: PM: Attempting to suspend to disk.
Oct 14 17:22:31 albercik kernel: PM: snapshotting memory.
Oct 14 17:22:31 albercik kernel: swsusp: critical section:
Oct 14 17:22:31 albercik kernel: ..<7>[nosave pfn 
0x58d]...................................................................................................
...............swsusp: Need to copy 18926 pages
Oct 14 17:22:31 albercik kernel: suspend: (pages needed: 18926 + 512 free: 
111953)
Oct 14 17:22:31 albercik kernel: hibernate.sh: page allocation failure. 
order:8, mode:0x120
Oct 14 17:22:31 albercik kernel:
Oct 14 17:22:33 albercik kernel: Call 
Trace:<ffffffff8016ec7d>{__alloc_pages+749} 
<ffffffff8016ed21>{__get_free_pages+33}
Oct 14 17:22:35 albercik kernel:        
<ffffffff80161b93>{suspend_prepare_image+531} 
<ffffffff802eae52>{suspend_device+50}
Oct 14 17:22:37 albercik kernel:        
<ffffffff80161e26>{swsusp_swap_check+22} 
<ffffffff802eaf2c>{device_suspend+76}
Oct 14 17:22:38 albercik kernel:        
<ffffffff80120dec>{swsusp_arch_suspend+124} 
<ffffffff8016123c>{swsusp_suspend+12}
Oct 14 17:22:40 albercik kernel:        <ffffffff801623ea>{pm_suspend_disk+90} 
<ffffffff8015ff54>{enter_state+68}
Oct 14 17:22:41 albercik kernel:        
<ffffffff802aed9d>{acpi_system_write_sleep+100} 
<ffffffff80194b74>{vfs_write+228}
Oct 14 17:22:43 albercik kernel:        <ffffffff80194cb3>{sys_write+83} 
<ffffffff80110c72>{system_call+126}
Oct 14 17:22:43 albercik kernel:
Oct 14 17:22:49 albercik kernel: suspend: Allocating pagedir failed.
Oct 14 17:22:50 albercik kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 
(level, low) -> IRQ 11
Oct 14 17:22:52 albercik kernel: PCI: Setting latency timer of device 
0000:00:02.0 to 64
Oct 14 17:22:54 albercik kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 
(level, low) -> IRQ 5
Oct 14 17:22:56 albercik kernel: PCI: Setting latency timer of device 
0000:00:02.1 to 64
Oct 14 17:22:57 albercik kernel: PCI: Setting latency timer of device 
0000:00:02.2 to 64
Oct 14 17:22:57 albercik kernel: ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 
(level, low) -> IRQ 5
Oct 14 17:22:57 albercik kernel: PCI: Setting latency timer of device 
0000:00:06.0 to 64
Oct 14 17:22:57 albercik kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 
(level, low) -> IRQ 11
Oct 14 17:22:57 albercik kernel: ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 
(level, low) -> IRQ 11
Oct 14 17:22:57 albercik kernel: Restarting tasks... done
Oct 14 17:22:57 albercik kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host 
Controller (OHCI) Driver (PCI)
Oct 14 17:22:58 albercik kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 
(level, low) -> IRQ 11
Oct 14 17:22:59 albercik kernel: ohci_hcd 0000:00:02.0: nVidia Corporation 
nForce3 USB 1.1
Oct 14 17:23:00 albercik kernel: PCI: Setting latency timer of device 
0000:00:02.0 to 64
Oct 14 17:23:00 albercik kernel: ohci_hcd 0000:00:02.0: irq 11, pci mem 
ffffff00000c2000
Oct 14 17:23:00 albercik kernel: ohci_hcd 0000:00:02.0: new USB bus 
registered, assigned bus number 1
Oct 14 17:23:01 albercik kernel: hub 1-0:1.0: USB hub found
Oct 14 17:23:01 albercik kernel: hub 1-0:1.0: 3 ports detected
Oct 14 17:23:01 albercik kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 
(level, low) -> IRQ 5
Oct 14 17:23:01 albercik kernel: ohci_hcd 0000:00:02.1: nVidia Corporation 
nForce3 USB 1.1 (#2)
Oct 14 17:23:01 albercik kernel: PCI: Setting latency timer of device 
0000:00:02.1 to 64
Oct 14 17:23:01 albercik kernel: ohci_hcd 0000:00:02.1: irq 5, pci mem 
ffffff00000c4000
Oct 14 17:23:01 albercik kernel: ohci_hcd 0000:00:02.1: new USB bus 
registered, assigned bus number 2
Oct 14 17:23:01 albercik kernel: hub 2-0:1.0: USB hub found
Oct 14 17:23:01 albercik kernel: hub 2-0:1.0: 3 ports detected
Oct 14 17:23:01 albercik kernel: usb 2-2: new low speed USB device using 
address 2
Oct 14 17:23:01 albercik kernel: input: USB HID v1.10 Mouse [Logitech Optical 
USB Mouse] on usb-0000:00:02.1-2
Oct 14 17:23:01 albercik kernel: eth0: network connection down
Oct 14 17:23:03 albercik kernel: eth0: network connection up using port A
Oct 14 17:23:03 albercik kernel:     speed:           100
Oct 14 17:23:03 albercik kernel:     autonegotiation: yes
Oct 14 17:23:03 albercik kernel:     duplex mode:     full
Oct 14 17:23:03 albercik kernel:     flowctrl:        symmetric
Oct 14 17:23:03 albercik kernel:     irq moderation:  disabled
Oct 14 17:23:03 albercik kernel:     scatter-gather:  enabled
Oct 14 17:23:12 albercik kernel: eth0: no IPv6 routers present
Oct 14 17:25:13 albercik kernel: SysRq : Emergency Sync
Oct 14 17:25:13 albercik kernel: Emergency Sync complete
Oct 14 17:25:29 albercik kernel: ohci_hcd 0000:00:02.0: remove, state 1
Oct 14 17:25:29 albercik kernel: usb usb1: USB disconnect, address 1
Oct 14 17:25:29 albercik kernel: ohci_hcd 0000:00:02.0: USB bus 1 deregistered
Oct 14 17:25:29 albercik kernel: ohci_hcd 0000:00:02.1: remove, state 1
Oct 14 17:25:29 albercik kernel: usb usb2: USB disconnect, address 1
Oct 14 17:25:29 albercik kernel: usb 2-2: USB disconnect, address 2
Oct 14 17:25:30 albercik kernel: ohci_hcd 0000:00:02.1: USB bus 2 deregistered
Oct 14 17:26:44 albercik kernel: Stopping tasks: 
=============================================================|
Oct 14 17:26:44 albercik kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^
H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\
^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^Hdone 
(36196 pages freed)
Oct 14 17:26:44 albercik kernel: Freeing memory...  ^H-^H\^H|^Hdone (531 pages 
freed)
Oct 14 17:26:44 albercik kernel: Freeing memory...  ^H-^Hdone (1 pages freed)
Oct 14 17:26:44 albercik kernel: Freeing memory...  ^H-^Hdone (144 pages 
freed)
Oct 14 17:26:44 albercik kernel: Freeing memory...  ^Hdone (0 pages freed)
Oct 14 17:26:44 albercik kernel: PM: Attempting to suspend to disk.
Oct 14 17:26:44 albercik kernel: PM: snapshotting memory.
Oct 14 17:26:44 albercik kernel: swsusp: critical section:
Oct 14 17:26:44 albercik kernel: ..<7>[nosave pfn 
0x58d]...................................................................................................
............swsusp: Need to copy 24528 pages
Oct 14 17:26:44 albercik kernel: suspend: (pages needed: 24528 + 512 free: 
106351)
Oct 14 17:26:44 albercik kernel: hibernate.sh: page allocation failure. 
order:8, mode:0x120
Oct 14 17:26:44 albercik kernel:
Oct 14 17:26:47 albercik kernel: Call 
Trace:<ffffffff8016ec7d>{__alloc_pages+749} 
<ffffffff8016ed21>{__get_free_pages+33}
Oct 14 17:26:49 albercik kernel:        
<ffffffff80161b93>{suspend_prepare_image+531} 
<ffffffff802eae52>{suspend_device+50}
Oct 14 17:26:50 albercik kernel:        
<ffffffff80161e26>{swsusp_swap_check+22} 
<ffffffff802eaf2c>{device_suspend+76}
Oct 14 17:26:52 albercik kernel:        
<ffffffff80120dec>{swsusp_arch_suspend+124} 
<ffffffff8016123c>{swsusp_suspend+12}
Oct 14 17:26:53 albercik kernel:        <ffffffff801623ea>{pm_suspend_disk+90} 
<ffffffff8015ff54>{enter_state+68}
Oct 14 17:26:53 albercik kernel:        
<ffffffff802aed9d>{acpi_system_write_sleep+100} 
<ffffffff80194b74>{vfs_write+228}
Oct 14 17:26:53 albercik kernel:        <ffffffff80194cb3>{sys_write+83} 
<ffffffff80110c72>{system_call+126}
Oct 14 17:26:53 albercik kernel:
Oct 14 17:26:53 albercik kernel: suspend: Allocating pagedir failed.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
