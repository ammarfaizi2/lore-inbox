Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTA2LbU>; Wed, 29 Jan 2003 06:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTA2LbU>; Wed, 29 Jan 2003 06:31:20 -0500
Received: from mail.ithnet.com ([217.64.64.8]:2833 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S265667AbTA2LbT>;
	Wed, 29 Jan 2003 06:31:19 -0500
Date: Wed, 29 Jan 2003 12:40:32 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-ns83820@kvack.org
Subject: Problems with 83820 driver / 2.4.20 and above
Message-Id: <20030129124032.55983208.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I would like to give a short description of a box that has some weird flaws within several days and I cannot really nail down the reason. Box looks like:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:11.0 Ethernet controller: National Semiconductor Corporation DP83820 10/100/1000 Ethernet Controller
00:12.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)
00:14.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)
02:05.0 Ethernet controller: National Semiconductor Corporation DP83820 10/100/1000 Ethernet Controller
02:07.0 Ethernet controller: National Semiconductor Corporation DP83820 10/100/1000 Ethernet Controller
02:09.0 Ethernet controller: National Semiconductor Corporation DP83820 10/100/1000 Ethernet Controller

on 2.4.21-pre4 (but is all the same with 2.4.20 and above, haven't tested older kernels yet)

I experience kernel oopses _or_ segfaults every few days like:

Jan 28 01:27:03 core-2 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001
Jan 28 01:27:03 core-2 kernel:  printing eip:
Jan 28 01:27:03 core-2 kernel: c012e114
Jan 28 01:27:03 core-2 kernel: *pde = 00000000
Jan 28 01:27:03 core-2 kernel: Oops: 0002
Jan 28 01:27:03 core-2 kernel: CPU:    0
Jan 28 01:27:03 core-2 kernel: EIP:    0010:[shrink_cache+180/784]    Not tainted
Jan 28 01:27:03 core-2 kernel: EIP:    0010:[<c012e114>]    Not tainted
Jan 28 01:27:03 core-2 kernel: EFLAGS: 00010246
Jan 28 01:27:03 core-2 kernel: eax: c0257db8   ebx: 00000000   ecx: c19102a4   edx: 00000001
Jan 28 01:27:03 core-2 kernel: esi: c1910288   edi: 00006b24   ebp: c0257f30   esp: c19d7f40
Jan 28 01:27:03 core-2 kernel: ds: 0018   es: 0018   ss: 0018
Jan 28 01:27:03 core-2 kernel: Process kswapd (pid: 4, stackpage=c19d7000)
Jan 28 01:27:03 core-2 kernel: Stack: c1835200 000001d0 c19d6000 00000200 000001d0 0000001f 00000020 000001d0 
Jan 28 01:27:03 core-2 kernel:        00000020 00000006 c012e4c3 00000006 e2e4a000 c0257f30 00000006 000001d0
Jan 28 01:27:03 core-2 kernel:        c0257f30 00000000 c012e536 00000020 c0257f30 00000001 c19d6000 c012e64c
Jan 28 01:27:03 core-2 kernel: Call Trace:    [shrink_caches+99/160] [try_to_free_pages_zone+54/80] [kswapd_balance_pgdat+92/176] [ksw
Jan 28 01:27:03 core-2 kernel: Call Trace:    [<c012e4c3>] [<c012e536>] [<c012e64c>] [<c012e6c8>] [<c012e7fd>]
Jan 28 01:27:03 core-2 kernel:   [rest_init+0/64] [kernel_thread+46/64] [kswapd+0/192]
Jan 28 01:27:03 core-2 kernel:   [<c0105000>] [<c010578e>] [<c012e760>]
Jan 28 01:27:03 core-2 kernel: 
Jan 28 01:27:03 core-2 kernel: Code: 89 02 c7 01 00 00 00 00 89 50 04 a1 b8 7d 25 c0 89 48 04 89

The only thing I can say for sure, that something is wrong with the NS drivers because there are 4 such cards in and they say this:

eth0: link now 1000 mbps, full duplex and up.
eth1: link now down.
eth2: link now 10 mbps, full duplex and up.
eth3: link now 1000 mbps, full duplex and up.
eth1: link now 10 mbps, half duplex and up.

But there are in fact 3 (eth0, eth2, eth3) connected to 1000 TX switches and one (eth1) to 100TX switches (all full duplex). The switches tell me, that eth0 and eth3 are as expected, whereas eth2 is indeed only connected with 10 mbps, whereas eth1 is correctly connected with 100 mbps/fdx. All in all I would say that the link detection in this driver is broken somehow.
I can test patches if there are any.
Any hints appreciated.
-- 
Regards,
Stephan
