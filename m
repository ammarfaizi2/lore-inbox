Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUGYU1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUGYU1g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 16:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUGYU1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 16:27:36 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:15025 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S264389AbUGYU1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 16:27:10 -0400
Date: Sun, 25 Jul 2004 23:27:04 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: =?ISO-8859-1?Q?H=E9ctor_Mart=EDn?= <hector@marcansoft.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <4102CF17.2010207@marcansoft.com>
Message-ID: <Pine.LNX.4.44.0407252300170.1794-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Sun, 25 Jul 2004 23:27:06 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Héctor,

On Sat, 24 Jul 2004, Héctor Martín wrote:

> I'm running a home PC here, which is acting as a router/firewall too.  
> When I get a specific network traffic type (detailed below) ksoftirqd/0
> starts using all CPU time. Network processes also use an extremely high
> amount of CPU time when this happens. I/O is extremely jerky and
> assuming control over the console (being in X) is next to impossible
> without resorting to SysRq (a million thanks to whomever invented it
> :)). Always reproducible after some minutes of this traffic.

I'm having a same problem, discovered today. I was moving some stuff from 
windows-server (samba) to linux-server (tcp-nfs) via my workstation pc. 
Data was tranferred something like 5-6MB/sec (no problems usually to this 
point..) but after I start using ssh-connections and writing some emails 
or chatting in IRCNet my computer will totally freeze after couple 
minutes. 

I haven't been able to reproduce this with normal www-browsing or 
ssh-connections but it's always reproducible when my eth0 is under heavy 
load.
 
> Machine is an Athlon XP 1800+, ASUS A7V266-E mobo (VIA chipset), PCI 
> hardware is:
> 2x Realtek 8139 (10/100Mbps) (eth1/eth2) (LAN,
> 1x Realtek 8029 (10Mbps) (eth0) (Internet)
> NVIDIA GeForce4 graphics

I'm having AMD Duron 1300, ASUS A7V266-C, Realtek 8139 and Nvidia GeForce 
FX 5200. So our hardware is quite similar.

>   2420 rtl8139_poll                              10,8036
>   2717 acpi_os_read_port                         38,8143
>   3292 rtl8139_interrupt                          8,5729
>   8677 handle_IRQ_event                          77,4732
>  20450 total                                      0,0065

When I do altgr+sysrq+p, I'll see the current registers and when computer 
is freezing it always shows this:

 Pid: 2, comm:          ksoftirqd/0
 EIP: 0060:[pg0+541114916/1069056000] CPU: 0
 EIP: 0060:[<e0882224>] CPU: 0
 EIP is at rtl8139_poll+0xb4/0x100 [8139too]
  EFLAGS: 00000247    Tainted: P    (2.6.7-mm7)
 EAX: ffffe000 EBX: 00000040 ECX: dfc630f8 EDX: c04562f8
 ESI: dfc63000 EDI: e086e000 EBP: dff85f84 DS: 007b ES: 007b
 CR0: 8005003b CR2: b7c5a000 CR3: 1ecb4000 CR4: 000006d0
  [exit_notify+416/2192] ksoftirqd+0x0/0xc0
  [<c01194b0>] ksoftirqd+0x0/0xc0
  [sk_stream_kill_queues+58/384] net_rx_action+0x6a/0x110
  [<c02d1fba>] net_rx_action+0x6a/0x110
  [exit_fs+93/240] __do_softirq+0x7d/0x80
  [<c011917d>] __do_softirq+0x7d/0x80
  [exit_fs+134/240] do_softirq+0x26/0x30
  [<c01191a6>] do_softirq+0x26/0x30
  [exit_notify+520/2192] ksoftirqd+0x68/0xc0
  [<c0119518>] ksoftirqd+0x68/0xc0
  [parse_args+85/272] kthread+0xa5/0xb0
  [<c01276e5>] kthread+0xa5/0xb0
  [next_arg+96/176] kthread+0x0/0xb0
  [<c0127640>] kthread+0x0/0xb0
  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
  [<c0102111>] kernel_thread_helper+0x5/0x14

So I guess it's has something to do with rtl8139_poll-function or it is 
just a function which is called when some other function is in 
deadlock-state.

>   0:    7709403          XT-PIC  timer
>   1:       2319          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:        102          XT-PIC  eth1
>   8:          2          XT-PIC  rtc
>   9:  151898751          XT-PIC  acpi, uhci_hcd, uhci_hcd, uhci_hcd, eth2
>  10:     254483          XT-PIC  CMI8738-MC6, eth0
>  11:     438415          XT-PIC  bttv0
>  12:     105857          XT-PIC  i8042
>  14:      44598          XT-PIC  ide0
>  15:         21          XT-PIC  ide1
> NMI:          0
> LOC:    7709105
> ERR:     299141
 
> Interrupt 9 is surely busy, no USB hardware plugged in just in case you're
> wondering, and normally (while not using eth2) interrupt 9 is rock solid
> (i.e. I doubt ACPI interrupts at all during normal use unless e.g. the power
> button is pressed.)

Same thing for me also, except for me it's interrupt 10 (CMI8738-MC6, 
eth0), so it's pointing more and more something rtl-8139 related.

> And finally, top tells me (in.telnetd uses a lot of cpu time because I was
> accessing this through telnet, any other process using the network would 
> have the same problem once ksoftirqd goes nuts):
 
> top - 19:00:43 up  2:11,  3 users,  load average: 1.41, 1.42, 1.91
> Tasks:  29 total,   2 running,  27 sleeping,   0 stopped,   0 zombie
> Cpu(s):  0.0% us,  0.0% sy,  0.0% ni,  0.0% id,  0.0% wa, 76.5% hi, 23.5% si
> Mem:    251344k total,    82388k used,   168956k free,     6436k buffers
> Swap:  1469908k total,       84k used,  1469824k free,    49244k cached

> Normally, ksoftirqd gets exactly 0 seconds of CPU time, so surely something
> is wrong here :)
> 
> I think ACPI may be using up cycles because it is on the same interrupt and
> thus gets triggered too, I doubt it has anything to do with ACPI.

> Maybe some hardware bug that causes it to generate too many interrupts? It's
> strange though, both 8139 cards are identical and eth1 has much more traffic
> than eth2, and something like this has never happened. I use eth2 sparingly
> though, and I have never had it receive so many small packets.

I have a couple of rtl-8139 cards at work and I will probably test my 
computer with those cards. 

Hmm, on the other hand I just upgraded my home network to 100Mbps from 
10Mbps  and I didn't have same problem before that with same kernels. 
(I have tested 2.6.6, 2.6.7 and 2.6.7-mm7 for now.)
 
> Hope someone helps, it's a pain in the neck and I need eth2 ;)

I would say more like this is a pain in the ass. =) and I'm having a 
feeling that we will have to switch off from the rtl-8139 cards if nobody 
is willing to help us.

--
Pasi Sjöholm 


