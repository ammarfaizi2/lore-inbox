Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbUJ0V6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbUJ0V6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUJ0VsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:48:14 -0400
Received: from lucidpixels.com ([66.45.37.187]:28100 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262928AbUJ0Vkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:40:47 -0400
Date: Wed, 27 Oct 2004 17:40:41 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Kernel 2.6.9 Multiple Page Allocation Failures (Part 2)
In-Reply-To: <417CE49B.4060308@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0410271733440.10927@p500>
References: <Pine.LNX.4.61.0410250645540.9868@p500> <417CE49B.4060308@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a couple days the errors have shown up again.

Can anyone help me debug this problem further?

Is there any chance Linus will freeze 2.6 and make the current development 
tree 2.7?  It seems like ever since around 2.6.8 things have been getting 
progressively worse (page allocation failures/nvidia 
breakage/XFS-oops-when-copying-over-nfs-when-the-file-is-being-written-to)?


$ uptime
  17:34:32 up 2 days,  8:53, 29 users,  load average: 0.29, 0.38, 0.36

jpiszcz@p500:/usr/src/linux$ grep -i sysrq .config
CONFIG_MAGIC_SYSRQ=y

I tried various combinations of sysrq+M but it did not seem to do anything 
special?

Also, all of the failures below, could they possibly be causing data 
corruption?

Once again, box = Dell GX1 p3 500mhz / 768MB ram (Intel 440BX/ZX/DX) 
chipset.

$ lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20269 
(rev 02)
00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20267 
(rev 02)
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 24)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 
1X/2X (rev 5c)
02:09.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet 
Controller
02:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
02:0b.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]

$ cat /proc/interrupts
            CPU0
   0:  204979514          XT-PIC  timer
   1:       2484          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  Crystal audio controller
   8:          1          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:    3866403          XT-PIC  ide2, ide3
  11:  129079320          XT-PIC  ide4, ide5, eth0, eth1, eth2, eth3
  12:      16198          XT-PIC  i8042
  15:         50          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:       1022
MIS:          0

$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0184-0187 : MPU-401 UART
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial
0530-0533 : Crystal audio controller
0800-083f : 0000:00:07.3
   0800-0803 : PM1a_EVT_BLK
   0804-0805 : PM1a_CNT_BLK
   0808-080b : PM_TMR
   080c-080f : GPE0_BLK
0840-085f : 0000:00:07.3
   0850-0857 : piix4-smbus
0cf8-0cff : PCI conf1
c880-c8ff : 0000:00:11.0
   c880-c8ff : 0000:00:11.0
cc40-cc7f : 0000:00:0e.0
   cc40-cc47 : ide4
   cc48-cc4f : ide5
   cc50-cc7f : PDC20267
cca0-ccaf : 0000:00:0d.0
   cca0-cca7 : ide2
   cca8-ccaf : ide3
ccb0-ccb7 : 0000:00:0e.0
   ccb0-ccb7 : ide5
ccb8-ccbb : 0000:00:0d.0
   ccba-ccba : ide3
ccbc-ccbf : 0000:00:0e.0
   ccbe-ccbe : ide5
ccc0-ccc7 : 0000:00:0d.0
   ccc0-ccc7 : ide3
ccc8-cccf : 0000:00:0e.0
   ccc8-cccf : ide4
ccd0-ccd3 : 0000:00:0d.0
   ccd2-ccd2 : ide2
ccd4-ccd7 : 0000:00:0e.0
   ccd6-ccd6 : ide4
ccd8-ccdf : 0000:00:0d.0
   ccd8-ccdf : ide2
cce0-ccff : 0000:00:07.2
d000-dfff : PCI Bus #02
   dc00-dc7f : 0000:02:0a.0
     dc00-dc7f : 0000:02:0a.0
   dc80-dcbf : 0000:02:0b.0
     dc80-dcbf : 0000:02:0b.0
   dcc0-dcff : 0000:02:09.0
     dcc0-dcff : e1000
e000-efff : PCI Bus #01
   ec00-ecff : 0000:01:00.0
ffa0-ffaf : 0000:00:07.1
   ffa8-ffaf : ide1

  [<c01ca635>] nfsd_open+0x45/0x190
  [<c01cae1e>] nfsd_write+0x4e/0x390
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c036f9e2>] skb_drop_fraglist+0x42/0x50
  [<c036faa6>] skb_release_data+0x96/0xc0
  [<c01d335b>] nfsd3_proc_write+0xbb/0x120
  [<c01c6663>] nfsd_dispatch+0xa3/0x250
  [<c041f841>] svc_process+0x6e1/0x7f0
  [<c01c6403>] nfsd+0x203/0x3c0
  [<c01c6200>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18
swapper: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c02d9471>] add_interrupt_randomness+0x31/0x40
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c0101df0>] default_idle+0x0/0x40
  [<c0101e13>] default_idle+0x23/0x40
  [<c0101e9f>] cpu_idle+0x2f/0x50
  [<c04f2967>] start_kernel+0x157/0x180
  [<c04f2540>] unknown_bootoption+0x0/0x180
nfsd: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c038abd0>] ip_rcv_finish+0x0/0x2d0
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c011007b>] setup_pit_timer+0x2b/0x60
  [<c0124d23>] sigprocmask+0x3/0xe0
  [<c01c63f3>] nfsd+0x1f3/0x3c0
  [<c01c6200>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18
nfsd: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c038abd0>] ip_rcv_finish+0x0/0x2d0
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c011007b>] setup_pit_timer+0x2b/0x60
  [<c0124d23>] sigprocmask+0x3/0xe0
  [<c01c63f3>] nfsd+0x1f3/0x3c0
  [<c01c6200>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18
nfsd: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c011007b>] setup_pit_timer+0x2b/0x60
  [<c0124d23>] sigprocmask+0x3/0xe0
  [<c01c63f3>] nfsd+0x1f3/0x3c0
  [<c01c6200>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18
nfsd: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c032c184>] boomerang_rx+0x254/0x490
  [<c032b869>] boomerang_interrupt+0xb9/0x430
  [<c0339798>] ide_intr+0x188/0x1e0
  [<c01069fd>] handle_IRQ_event+0x3d/0x80
  [<c0106e3f>] do_IRQ+0x8f/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c013de66>] __kmalloc+0x56/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c011007b>] setup_pit_timer+0x2b/0x60
  [<c0124d23>] sigprocmask+0x3/0xe0
  [<c01c63f3>] nfsd+0x1f3/0x3c0
  [<c01c6200>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18
eth2: memory shortage
nfsd: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c032c184>] boomerang_rx+0x254/0x490
  [<c032b869>] boomerang_interrupt+0xb9/0x430
  [<c0339798>] ide_intr+0x188/0x1e0
  [<c01069fd>] handle_IRQ_event+0x3d/0x80
  [<c0106e3f>] do_IRQ+0x8f/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c013de66>] __kmalloc+0x56/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c011007b>] setup_pit_timer+0x2b/0x60
  [<c0124d23>] sigprocmask+0x3/0xe0
  [<c01c63f3>] nfsd+0x1f3/0x3c0
  [<c01c6200>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18
nfsd: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c032c184>] boomerang_rx+0x254/0x490
  [<c032b869>] boomerang_interrupt+0xb9/0x430
  [<c0339798>] ide_intr+0x188/0x1e0
  [<c01069fd>] handle_IRQ_event+0x3d/0x80
  [<c0106e3f>] do_IRQ+0x8f/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c013de66>] __kmalloc+0x56/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c011007b>] setup_pit_timer+0x2b/0x60
  [<c0124d23>] sigprocmask+0x3/0xe0
  [<c01c63f3>] nfsd+0x1f3/0x3c0
  [<c01c6200>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18
nfsd: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c011007b>] setup_pit_timer+0x2b/0x60
  [<c0124d23>] sigprocmask+0x3/0xe0
  [<c01c63f3>] nfsd+0x1f3/0x3c0
  [<c01c6200>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18
lftp: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
kswapd0: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c038abd0>] ip_rcv_finish+0x0/0x2d0
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c030941a>] __make_request+0x4ea/0x560
  [<c0309563>] generic_make_request+0xd3/0x190
  [<c0137b85>] mempool_alloc+0x85/0x190
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c0309671>] submit_bio+0x51/0xf0
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c015915b>] bio_alloc+0x17b/0x1f0
  [<c0155ab0>] end_buffer_async_write+0x0/0x110
  [<c0158925>] submit_bh+0xe5/0x140
  [<c0289fa5>] xfs_submit_page+0xb5/0x100
  [<c028a16a>] xfs_convert_page+0x17a/0x2b0
  [<c01345b7>] find_trylock_page+0x27/0x60
  [<c0289aef>] xfs_probe_delalloc_page+0x1f/0xa0
  [<c028a30f>] xfs_cluster_write+0x6f/0x90
  [<c028a633>] xfs_page_state_convert+0x303/0x6e0
  [<c028b0f4>] linvfs_writepage+0x74/0x130
  [<c013fe89>] pageout+0xb9/0x100
  [<c0134290>] wake_up_page+0x10/0x30
  [<c0140165>] shrink_list+0x295/0x4b0
  [<c01404e3>] shrink_cache+0x163/0x380
  [<c01150cd>] wake_up_process+0x1d/0x20
  [<c028d1f5>] pagebuf_daemon_wakeup+0x15/0x20
  [<c013fbc8>] shrink_slab+0x98/0x1a0
  [<c0140c82>] shrink_zone+0xa2/0xd0
  [<c01410c0>] balance_pgdat+0x1e0/0x2c0
  [<c014125f>] kswapd+0xbf/0xe0
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c0103f32>] ret_from_fork+0x6/0x14
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c01411a0>] kswapd+0x0/0xe0
  [<c010207d>] kernel_thread_helper+0x5/0x18
kswapd0: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c032c184>] boomerang_rx+0x254/0x490
  [<c032b869>] boomerang_interrupt+0xb9/0x430
  [<c0339798>] ide_intr+0x188/0x1e0
  [<c01069fd>] handle_IRQ_event+0x3d/0x80
  [<c0106e3f>] do_IRQ+0x8f/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c013de66>] __kmalloc+0x56/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c038abd0>] ip_rcv_finish+0x0/0x2d0
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c030941a>] __make_request+0x4ea/0x560
  [<c0309563>] generic_make_request+0xd3/0x190
  [<c0137b85>] mempool_alloc+0x85/0x190
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c0309671>] submit_bio+0x51/0xf0
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c015915b>] bio_alloc+0x17b/0x1f0
  [<c0155ab0>] end_buffer_async_write+0x0/0x110
  [<c0158925>] submit_bh+0xe5/0x140
  [<c0289fa5>] xfs_submit_page+0xb5/0x100
  [<c028a16a>] xfs_convert_page+0x17a/0x2b0
  [<c01345b7>] find_trylock_page+0x27/0x60
  [<c0289aef>] xfs_probe_delalloc_page+0x1f/0xa0
  [<c028a30f>] xfs_cluster_write+0x6f/0x90
  [<c028a633>] xfs_page_state_convert+0x303/0x6e0
  [<c028b0f4>] linvfs_writepage+0x74/0x130
  [<c013fe89>] pageout+0xb9/0x100
  [<c0134290>] wake_up_page+0x10/0x30
  [<c0140165>] shrink_list+0x295/0x4b0
  [<c01404e3>] shrink_cache+0x163/0x380
  [<c01150cd>] wake_up_process+0x1d/0x20
  [<c028d1f5>] pagebuf_daemon_wakeup+0x15/0x20
  [<c013fbc8>] shrink_slab+0x98/0x1a0
  [<c0140c82>] shrink_zone+0xa2/0xd0
  [<c01410c0>] balance_pgdat+0x1e0/0x2c0
  [<c014125f>] kswapd+0xbf/0xe0
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c0103f32>] ret_from_fork+0x6/0x14
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c01411a0>] kswapd+0x0/0xe0
  [<c010207d>] kernel_thread_helper+0x5/0x18
eth2: memory shortage
kswapd0: page allocation failure. order:0, mode:0x20
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c013ca2f>] kmem_getpages+0x1f/0xc0
  [<c013d770>] cache_grow+0xc0/0x1a0
  [<c013da1b>] cache_alloc_refill+0x1cb/0x210
  [<c013de81>] __kmalloc+0x71/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c032c184>] boomerang_rx+0x254/0x490
  [<c032b869>] boomerang_interrupt+0xb9/0x430
  [<c0339798>] ide_intr+0x188/0x1e0
  [<c01069fd>] handle_IRQ_event+0x3d/0x80
  [<c0106e3f>] do_IRQ+0x8f/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c013de66>] __kmalloc+0x56/0x80
  [<c036f8f3>] alloc_skb+0x53/0x100
  [<c031fe88>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031fb8e>] e1000_clean_rx_irq+0x18e/0x440
  [<c038abd0>] ip_rcv_finish+0x0/0x2d0
  [<c031f76b>] e1000_clean+0x5b/0x100
  [<c0375f7a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c030941a>] __make_request+0x4ea/0x560
  [<c0309563>] generic_make_request+0xd3/0x190
  [<c0137b85>] mempool_alloc+0x85/0x190
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c0309671>] submit_bio+0x51/0xf0
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c015915b>] bio_alloc+0x17b/0x1f0
  [<c0155ab0>] end_buffer_async_write+0x0/0x110
  [<c0158925>] submit_bh+0xe5/0x140
  [<c0289fa5>] xfs_submit_page+0xb5/0x100
  [<c028a16a>] xfs_convert_page+0x17a/0x2b0
  [<c01345b7>] find_trylock_page+0x27/0x60
  [<c0289aef>] xfs_probe_delalloc_page+0x1f/0xa0
  [<c028a30f>] xfs_cluster_write+0x6f/0x90
  [<c028a633>] xfs_page_state_convert+0x303/0x6e0
  [<c028b0f4>] linvfs_writepage+0x74/0x130
  [<c013fe89>] pageout+0xb9/0x100
  [<c0134290>] wake_up_page+0x10/0x30
  [<c0140165>] shrink_list+0x295/0x4b0
  [<c01404e3>] shrink_cache+0x163/0x380
  [<c01150cd>] wake_up_process+0x1d/0x20
  [<c028d1f5>] pagebuf_daemon_wakeup+0x15/0x20
  [<c013fbc8>] shrink_slab+0x98/0x1a0
  [<c0140c82>] shrink_zone+0xa2/0xd0
  [<c01410c0>] balance_pgdat+0x1e0/0x2c0
  [<c014125f>] kswapd+0xbf/0xe0
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c0103f32>] ret_from_fork+0x6/0x14
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c01411a0>] kswapd+0x0/0xe0
  [<c010207d>] kernel_thread_helper+0x5/0x18

On Mon, 25 Oct 2004, Nick Piggin wrote:

> Justin Piszcz wrote:
>> I guess people who get this should just stick with 2.6.8.1?
>> 
>
> Does it cause any noticable problems? If not, then stay with
> 2.6.9.
>
> However, it would be nice to get to the bottom of it. It might
> just be happening by chance on 2.6.9 but not 2.6.8.1 though...
>
> Anyway, how often are you getting the messages? How many
> ethernet cards in the system?
>
> Can you run a kernel with sysrq support, and do `SysRq+M`
> (close to when the allocation failure happens if possible, but
> otherwise on a normally running system after it has been up
> for a while). Then send in the dmesg.
>
> Thanks,
> Nick
>
