Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTATKpu>; Mon, 20 Jan 2003 05:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTATKpu>; Mon, 20 Jan 2003 05:45:50 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:20382 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id <S265578AbTATKpi>; Mon, 20 Jan 2003 05:45:38 -0500
Date: Mon, 20 Jan 2003 10:54:27 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18: Oops in slip module in sl_tx_timeout
Message-ID: <20030120105427.GB12828@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we've been configuring SLIP links to connect to remote sites
over satellite.  These are very slow links (4800 baud) with extreme
latency.

However we recently plugged the wrong data stream (a 4800 baud control
channel) into our slip link and it caused the kernel to Oops.  This
Oops happens within 30 seconds of connecting the wrong data feed.  It
would seem to indicate some incorrect data checking in the slip code.

The machines that are Oopsing are NFS root machines with keyspan USB
serial cards plugged in (24 ports worth!).  They've been reliably
pumping serial data for nearly a year until we started on slip
configuration!

slattach -p cslip -L -s 4800 /dev/ttyUSB4

ifconfig sl0 10.0.0.3 pointopoint 10.0.0.1 netmask 255.255.255.255 mtu 296 up

sl0       Link encap:VJ Serial Line IP  
          inet addr:10.0.0.2  P-t-P:10.0.0.1  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:296  Metric:1
          RX packets:235781 errors:0 dropped:0 overruns:0 frame:0
             compressed:0
          TX packets:250293 errors:0 dropped:0 overruns:0 carrier:0
          collisions:1 compressed:0 txqueuelen:10 
          RX bytes:16614825 (15.8 MiB)  TX bytes:17399377 (16.5 MiB)

Here is the decoded Oops - it was copied from the screen by hand so
may not be 100% but it seemed to decode OK.

Any ideas gratefully received as this particular misconfiguration will
happen again for certain in the next round of network
reconfigurations!

------------------------------------------------------------

ksymoops 2.4.5 on i686 2.4.18-nfs2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-nfs2/ (default)
     -m /boot/System.map-2.4.18-nfs2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

c884a752
*pde = 00000000
CPU:   0
EIP: 0010:[<c884a752>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
eax: 00000000  ebx: c6030a00  ecx: c5e38000   edx: 00000000
esi: c6030a9c  edi: 00000000  ebp: c026f5c0   esp: c5e39f30
ds: 0018 es: 0018 ss: 0018
Stack: 00000000 c6030a9c c01a87a8 c01a87fb c6030a9c c0206920 c6030a9c c6030a9c
       c011ca62 c6030a9c 00000000 c026f5a0 00000000 c025f5c0 c4671130 c011c3a6
       c021e7bc c0119702 c0119640 00000000 00000001 c026f5c0 fffffffe c011946a
Call Trace: c01a87a8 c01a87fb c011ca62 c011c3a6 c0119702
  c0119640 c011946a c0108132 c0109f28
Code: 8b 40 7c ff d0 83 c4 04 85 c0 75 06 83 7b 28 00 74 0c b8 4b


>>EIP; c884a752 <[slip]sl_tx_timeout+36/bc>   <=====

>>ebx; c6030a00 <_end+5d89740/8567d40>
>>ecx; c5e38000 <_end+5b90d40/8567d40>
>>esi; c6030a9c <_end+5d897dc/8567d40>
>>ebp; c026f5c0 <softirq_vec+0/100>
>>esp; c5e39f30 <_end+5b92c70/8567d40>

Trace; c01a87a8 <dev_watchdog+0/9c>
Trace; c01a87fb <dev_watchdog+53/9c>
Trace; c011ca62 <timer_bh+222/25c>
Trace; c011c3a6 <tqueue_bh+16/1c>
Trace; c0119702 <bh_action+1a/40>

Code;  c884a752 <[slip]sl_tx_timeout+36/bc>
00000000 <_EIP>:
Code;  c884a752 <[slip]sl_tx_timeout+36/bc>   <=====
   0:   8b 40 7c                  mov    0x7c(%eax),%eax   <=====
Code;  c884a755 <[slip]sl_tx_timeout+39/bc>
   3:   ff d0                     call   *%eax
Code;  c884a757 <[slip]sl_tx_timeout+3b/bc>
   5:   83 c4 04                  add    $0x4,%esp
Code;  c884a75a <[slip]sl_tx_timeout+3e/bc>
   8:   85 c0                     test   %eax,%eax
Code;  c884a75c <[slip]sl_tx_timeout+40/bc>
   a:   75 06                     jne    12 <_EIP+0x12> c884a764 <[slip]sl_tx_timeout+48/bc>
Code;  c884a75e <[slip]sl_tx_timeout+42/bc>
   c:   83 7b 28 00               cmpl   $0x0,0x28(%ebx)
Code;  c884a762 <[slip]sl_tx_timeout+46/bc>
  10:   74 0c                     je     1e <_EIP+0x1e> c884a770 <[slip]sl_tx_timeout+54/bc>
Code;  c884a764 <[slip]sl_tx_timeout+48/bc>
  12:   b8 4b 00 00 00            mov    $0x4b,%eax

 <0>Kernel panic: Aiee, killing inteterrupr handler!

1 warning issued.  Results may not be reliable.

------------------------------------------------------------

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
