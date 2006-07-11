Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWGKWAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWGKWAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWGKWAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:00:24 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:46225 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932168AbWGKWAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:00:23 -0400
Message-ID: <44B41F87.9080306@free.fr>
Date: Wed, 12 Jul 2006 00:00:39 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 inconsistent lock state in netpoll_send_skb
References: <20060709021106.9310d4d1.akpm@osdl.org>	 <44B17735.4060006@free.fr> <1152520823.4874.0.camel@laptopd505.fenrus.org>	 <44B2A522.2080703@free.fr> <1152607239.3128.21.camel@laptopd505.fenrus.org>
In-Reply-To: <1152607239.3128.21.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 11.07.2006 10:40, Arjan van de Ven a écrit :
>> Reversed (or previously applied) patch detected! 
>>
>> Wrong patch ? This one won't apply, it seems to be already 
>> applied to 2.6.18-rc1-mm1.
> 
> ok these patches ought to fix this for real (sorry I don't have this
> hardware so I cannot actually do the testing)
> 
> I hope you have time to test these..
> 
> Greetings,
>    Arjan van de Ven
> 
> From: Arjan van de Ven <arjan@linux.intel.com>
> Subject: lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs
> 
> Introduce the disable_irq_nosync_lockdep_irqsave() and enable_irq_lockdep_irqrestore() APIs.
> These are needed for NE2000; basically NE2000 calls disable_irq and enable_irq as locking
> against the IRQ handler, but both in cases where interrupts are on and off. This means that
> lockdep needs to track the old state of the virtual irq flags on disable_irq, and restore these
> at enable_irq time.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Index: linux-2.6.18-rc1/include/linux/interrupt.h
> ===================================================================
> --- linux-2.6.18-rc1.orig/include/linux/interrupt.h
> +++ linux-2.6.18-rc1/include/linux/interrupt.h
> @@ -123,6 +123,14 @@ static inline void disable_irq_nosync_lo
>  #endif
>  }
>  
> +static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
> +{
> +	disable_irq_nosync(irq);
> +#ifdef CONFIG_LOCKDEP
> +	local_irq_save(*flags);
> +#endif
> +}
> +
>  static inline void disable_irq_lockdep(unsigned int irq)
>  {
>  	disable_irq(irq);
> @@ -139,6 +147,14 @@ static inline void enable_irq_lockdep(un
>  	enable_irq(irq);
>  }
>  
> +static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	local_irq_restore(*flags);
> +#endif
> +	enable_irq(irq);
> +}
> +
>  /* IRQ wakeup (PM) control: */
>  extern int set_irq_wake(unsigned int irq, unsigned int on);
>  
> From: Arjan van de Ven <arjan@linux.intel.com>
> Subject: lockdep: annotate the ne2000 driver with the new disable_irq API addition
> 
> The ne2000 driver's xmit function gets called from netpoll with the
> _xmit_lock spinlock held as _irqsave. This means the xmit function needs to preserve this
> irq-off state throughout to avoid deadlock. It does, but we need to also tell lockdep that
> the function indeed does this by using the proper disable_irq annotation.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Index: linux-2.6.18-rc1/drivers/net/8390.c
> ===================================================================
> --- linux-2.6.18-rc1.orig/drivers/net/8390.c
> +++ linux-2.6.18-rc1/drivers/net/8390.c
> @@ -299,7 +299,7 @@ static int ei_start_xmit(struct sk_buff 
>  	 *	Slow phase with lock held.
>  	 */
>  	 
> -	disable_irq_nosync_lockdep(dev->irq);
> +	disable_irq_nosync_lockdep_irqsave(dev->irq, &flags);
>  	
>  	spin_lock(&ei_local->page_lock);
>  	
> @@ -338,7 +338,7 @@ static int ei_start_xmit(struct sk_buff 
>  		netif_stop_queue(dev);
>  		outb_p(ENISR_ALL, e8390_base + EN0_IMR);
>  		spin_unlock(&ei_local->page_lock);
> -		enable_irq_lockdep(dev->irq);
> +		enable_irq_lockdep_irqrestore(dev->irq, &flags);
>  		ei_local->stat.tx_errors++;
>  		return 1;
>  	}
> @@ -379,7 +379,7 @@ static int ei_start_xmit(struct sk_buff 
>  	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
>  	
>  	spin_unlock(&ei_local->page_lock);
> -	enable_irq_lockdep(dev->irq);
> +	enable_irq_lockdep_irqrestore(dev->irq, &flags);
>  
>  	dev_kfree_skb (skb);
>  	ei_local->stat.tx_bytes += send_length;
> 
> 

Well, the warning did not go away:

=================================
[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
swapper/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&dev->_xmit_lock){-+..}, at: [<c0252bfb>] netpoll_send_skb+0x6b/0xdb
{in-softirq-W} state was registered at:
  [<c012cfb7>] lock_acquire+0x60/0x80
  [<c02923d0>] _spin_lock+0x19/0x28
  [<c025480d>] dev_watchdog+0x11/0xaf
  [<c011df77>] run_timer_softirq+0xed/0x145
  [<c011b0c9>] __do_softirq+0x46/0x9c
  [<c0104fc1>] do_softirq+0x4d/0xab
irq event stamp: 616419
hardirqs last  enabled at (616419): [<c0102c8b>] restore_nocheck+0x12/0x15
hardirqs last disabled at (616417): [<c011b0e2>] __do_softirq+0x5f/0x9c
softirqs last  enabled at (616418): [<c011b11a>] __do_softirq+0x97/0x9c
softirqs last disabled at (616413): [<c0104fc1>] do_softirq+0x4d/0xab

other info that might help us debug this:
no locks held by swapper/1.

stack backtrace:
 [<c0104d2c>] show_trace+0xd/0x10
 [<c0104d48>] dump_stack+0x19/0x1d
 [<c012b5d1>] print_usage_bug+0x1cc/0x1d9
 [<c012c160>] mark_lock+0x22d/0x349
 [<c012ca15>] __lock_acquire+0x463/0x9a5
 [<c012cfb7>] lock_acquire+0x60/0x80
 [<c02923d0>] _spin_lock+0x19/0x28
 [<c0252bfb>] netpoll_send_skb+0x6b/0xdb
 [<c02538d6>] netpoll_send_udp+0x1fd/0x207
 [<c0223b50>] write_msg+0x42/0x6a
 [<c01167f3>] __call_console_drivers+0x3b/0x48
 [<c0116854>] _call_console_drivers+0x54/0x58
 [<c0116a0c>] release_console_sem+0x118/0x1ed
 [<c0116d77>] register_console+0x190/0x197
 [<c0223afa>] init_netconsole+0x4e/0x62
 [<c0100378>] init+0x88/0x1e1
 [<c0101005>] kernel_thread_helper+0x5/0xb

FYI, here is a diff between previous dmesg and current 
one (with above patch applied). Please note the 
"+no locks held by swapper/1." line. 

--- dmesg-2.6.18-rc1-mm1	2006-07-09 23:23:33.000000000 +0200
+++ -	2006-07-11 23:51:20.760770585 +0200
@@ -1,4 +1,4 @@
-Linux version 2.6.18-rc1-mm1 (laurent@antares.localdomain) (gcc version 4.1.1 20060330 (prerelease)) #67 Sun Jul 9 19:41:56 CEST 2006
+Linux version 2.6.18-rc1-mm1 (laurent@antares.localdomain) (gcc version 4.1.1 20060330 (prerelease)) #68 Tue Jul 11 23:13:20 CEST 2006
 BIOS-provided physical RAM map:
 sanitize start
 sanitize end
@@ -40,7 +40,7 @@
 ACPI: DSDT (v001   ASUS A7V133-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
 ACPI: PM-Timer IO Port: 0xe408
 Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
-Detected 1410.216 MHz processor.
+Detected 1410.384 MHz processor.
 Built 1 zonelists.  Total pages: 131052
 Kernel command line: root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb6 netconsole=@192.163.0.3/,@192.168.0.1/00:0E:9B:91:ED:72
 netconsole: local port 6665
@@ -153,7 +153,7 @@
 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
 Memory: 514484k/524208k available (1612k kernel code, 9184k reserved, 1175k data, 176k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 2824.42 BogoMIPS (lpj=5648858)
+Calibrating delay using timer specific routine.. 2824.46 BogoMIPS (lpj=5648924)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
 CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
@@ -236,40 +236,39 @@
 ---------------------------------
 inconsistent {in-softirq-W} -> {softirq-on-W} usage.
 swapper/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
- (&dev->_xmit_lock){-+..}, at: [<c0252bcb>] netpoll_send_skb+0x6b/0xdb
+ (&dev->_xmit_lock){-+..}, at: [<c0252bfb>] netpoll_send_skb+0x6b/0xdb
 {in-softirq-W} state was registered at:
-  [<c012cfb3>] lock_acquire+0x60/0x80
-  [<c02923a0>] _spin_lock+0x19/0x28
-  [<c02547dd>] dev_watchdog+0x11/0xaf
+  [<c012cfb7>] lock_acquire+0x60/0x80
+  [<c02923d0>] _spin_lock+0x19/0x28
+  [<c025480d>] dev_watchdog+0x11/0xaf
   [<c011df77>] run_timer_softirq+0xed/0x145
   [<c011b0c9>] __do_softirq+0x46/0x9c
   [<c0104fc1>] do_softirq+0x4d/0xab
-irq event stamp: 616842
-hardirqs last  enabled at (616841): [<c0292668>] _spin_unlock_irqrestore+0x36/0x3c
-hardirqs last disabled at (616842): [<c02926b9>] _spin_lock_irqsave+0xf/0x32
-softirqs last  enabled at (616802): [<c024afd5>] dev_mc_upload+0x36/0x3a
-softirqs last disabled at (616798): [<c02923ba>] _spin_lock_bh+0xb/0x2d
+irq event stamp: 616419
+hardirqs last  enabled at (616419): [<c0102c8b>] restore_nocheck+0x12/0x15
+hardirqs last disabled at (616417): [<c011b0e2>] __do_softirq+0x5f/0x9c
+softirqs last  enabled at (616418): [<c011b11a>] __do_softirq+0x97/0x9c
+softirqs last disabled at (616413): [<c0104fc1>] do_softirq+0x4d/0xab
 
 other info that might help us debug this:
-1 lock held by swapper/1:
- #0:  (&dev->_xmit_lock){-+..}, at: [<c0252bcb>] netpoll_send_skb+0x6b/0xdb
+no locks held by swapper/1.
 
 stack backtrace:
  [<c0104d2c>] show_trace+0xd/0x10
  [<c0104d48>] dump_stack+0x19/0x1d
- [<c012b5cd>] print_usage_bug+0x1cc/0x1d9
- [<c012c15c>] mark_lock+0x22d/0x349
- [<c012c2bf>] mark_held_locks+0x47/0x65
- [<c012c468>] trace_hardirqs_on+0xef/0x119
- [<c022395a>] ei_start_xmit+0x242/0x260
- [<c0252be9>] netpoll_send_skb+0x89/0xdb
- [<c02538a6>] netpoll_send_udp+0x1fd/0x207
- [<c0223b18>] write_msg+0x42/0x6a
+ [<c012b5d1>] print_usage_bug+0x1cc/0x1d9
+ [<c012c160>] mark_lock+0x22d/0x349
+ [<c012ca15>] __lock_acquire+0x463/0x9a5
+ [<c012cfb7>] lock_acquire+0x60/0x80
+ [<c02923d0>] _spin_lock+0x19/0x28
+ [<c0252bfb>] netpoll_send_skb+0x6b/0xdb
+ [<c02538d6>] netpoll_send_udp+0x1fd/0x207
+ [<c0223b50>] write_msg+0x42/0x6a
  [<c01167f3>] __call_console_drivers+0x3b/0x48
  [<c0116854>] _call_console_drivers+0x54/0x58
  [<c0116a0c>] release_console_sem+0x118/0x1ed
  [<c0116d77>] register_console+0x190/0x197
- [<c0223ac2>] init_netconsole+0x4e/0x62
+ [<c0223afa>] init_netconsole+0x4e/0x62
  [<c0100378>] init+0x88/0x1e1
  [<c0101005>] kernel_thread_helper+0x5/0xb
 netconsole: network logging started
@@ -347,8 +346,8 @@
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
 ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
-usb 1-2: new low speed USB device using uhci_hcd and address 2
 ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[c5800000-c58007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
+usb 1-2: new low speed USB device using uhci_hcd and address 2
 usb 1-2: new device found, idVendor=044f, idProduct=b303
 usb 1-2: new device strings: Mfr=4, Product=30, SerialNumber=0
 usb 1-2: Product: FireStorm Dual Analog 2
@@ -359,14 +358,14 @@
 input: USB HID v1.10 Gamepad [THRUSTMASTER FireStorm Dual Analog 2] on usb-0000:00:04.2-2
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.6:USB HID core driver
-ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
-ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
+ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
+ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
 agpgart: AGP aperture is 256M @ 0xd0000000
 input: PC Speaker as /class/input/input3
-ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00308d0120e085ca]
 Using specific hotkey driver
+ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00308d0120e085ca]
 EXT3 FS on dm-4, internal journal
 Adding 257000k swap on /dev/hdb6.  Priority:1 extents:1 across:257000k
 Adding 64220k swap on /dev/hda5.  Priority:2 extents:1 across:64220k
@@ -382,7 +381,7 @@
 z_hash_table: 8192 buckets
 z_hash_table: 8192 buckets
 j_hash_table: 16384 buckets
-loading reiser4 bitmap......done (33 jiffies)
+loading reiser4 bitmap......done (31 jiffies)
 ReiserFS: hda7: found reiserfs format "3.6" with standard journal
 ReiserFS: hda7: using ordered data mode
 ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
@@ -409,8 +408,3 @@
 Using specific hotkey driver
 ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
 NET: Registered protocol family 17
-zcip uses obsolete (PF_INET,SOCK_PACKET)
-device eth0 entered promiscuous mode
-device eth0 left promiscuous mode
-martian source 255.255.255.255 from 82.64.105.254, on dev eth0
-ll header: ff:ff:ff:ff:ff:ff:00:07:cb:0e:8e:f9:08:00

-- 
laurent
