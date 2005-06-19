Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVFSK0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVFSK0b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 06:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVFSK0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 06:26:31 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:5852 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262227AbVFSKRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 06:17:47 -0400
X-ME-UUID: 20050619101745167.28C691C003CB@mwinf0303.wanadoo.fr
Message-ID: <29985680.1119176265153.JavaMail.www@wwinf0301>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.13.91.99]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Sun, 19 Jun 2005 12:17:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 17/06/05 20:23
> De : "Francois Romieu" <romieu@fr.zoreil.com>
[...]
> It should be fixed now. Please try the patch of the day:
> http://www.fr.zoreil.com/people/francois/misc/20050617-2.6.12-rc-sis190-test.patch
> 
[...]
Nice, it works :)
It is now usable, but it can freeze the box in some cases (see below).

First try : network (dhcp) initialized correctly, but the box froze
immediatly as i tried to transfer a 35MB file via scp 
(not really frozen, as the transfer achieved correctly).
I  had to switch power button...

i raised NUM_RX_DESC from 16 to 256 : i could achieve 2 transfers 
before i lost keyboard; as i was on the console, i could see that
 sis190 printks were still printed (very slowly), but nothing else
was working.

[...many tries...]

I disabled PREEMPT in the kernel : the driver worked correctly.

# modinfo sis190
[...]
alias:          pci:v00001039d00000190sv*sd*bc*sc*i*
depends:
vermagic:       2.6.12-rc6 gcc-3.4

# cat /var/log/messages
[...]
Jun 18 11:04:41 local kernel: eth0: Rx status = 76040040
Jun 18 11:04:41 local kernel: eth0: Rx PSize = 01010046
Jun 18 11:04:41 local kernel: sk_buff[0]->tail = ffff81000cc78810
Jun 18 11:04:41 local kernel: eth0: Rx status = c0000000
Jun 18 11:04:41 local kernel: eth0: status = 20000004
Jun 18 11:04:41 local kernel: eth0: status = 00000040
Jun 18 11:04:41 local kernel: eth0: dirty_rx=143 cur_rx=143
Jun 18 11:04:41 local kernel:    PSize    status   addr     size     PSize    status   addr     size
Jun 18 11:04:41 local kernel: 00:00000000 c0000000 1018c010 00000600 00000000 c0000000 040a6010 00000600
Jun 18 11:04:41 local kernel: 01:00000000 c0000000 03d64010 00000600 00000000 c0000000 1ce5a010 00000600
Jun 18 11:04:41 local kernel: 02:00000000 c0000000 1ce5a810 00000600 00000000 c0000000 1179e010 00000600
Jun 18 11:04:41 local kernel: 03:00000000 c0000000 1c28f810 00000600 00000000 c0000000 1c283010 00000600
Jun 18 11:04:41 local kernel: 04:00000000 c0000000 0c863010 00000600 00000000 c0000000 0eba9010 00000600
Jun 18 11:04:41 local kernel: 05:00000000 c0000000 0eba9810 00000600 00000000 c0000000 0a24a010 00000600
Jun 18 11:04:41 local kernel: 06:00000000 c0000000 03d62010 00000600 00000000 c0000000 0cc78010 00000600
Jun 18 11:04:41 local kernel: 07:00000000 c0000000 0cc78810 00000600 01010046 76040040 040a6810 80000600
Jun 18 11:04:41 local kernel: eth0: dirty_tx=174 cur_tx=174
[...]

I also tried :
1) to comment out sis190_make_unusable_by_asic() in sis190_rx_interrupt() :
			if (sis190_try_rx_copy(&skb, pkt_size, desc,
					       tp->rx_buf_sz)) {
				pci_action = pci_unmap_single;
				tp->Rx_skbuff[entry] = NULL;
				/* sis190_make_unusable_by_asic(desc); */
			}

No difference (it worked the same way).

2) to comment out the test "if (pkt_size < rx_copybreak)" in sis190_try_rx_copy() :
It worked with kernel PREEMPT.
The transfer speed was the same.
I imagine that rx_copybreak is better for large packets, but i still do not
understand why it is better :( (less upload ?)

> > I also tried to force 10H, 10F, 100H, 100F autoneg off on the other card.
[...] 
> Did the sis190 driver report a link change event ?
> 
> --
> Ueimor
> 
I made new tests with 2 differents boards on the remote (modes + transfer speed) : 
worked good in some cases, bad in another.
In one case (10 full with r8169) , it froze the box (see below).

I used your patch without modifications (I only remove printks to have real perfs).
NUM_TX_DESC     64
NUM_RX_DESC     256
Kernel was compiled without PREEMPT.

I transferred (twice for each test) a 35MB file in both directions.


1) local = sis190 remote = r8169
--------------------------------

remote # uname -a
Linux remote 2.6.11.11 #3 SMP Sat Jun 18 16:23:51 CEST 2005 i686 i686 i386 GNU/Linux
remote # ethtool -i eth2
driver: r8169
version: 2.2LK

remote # ethtool -s eth2 autoneg on
local  # dmesg
[...]
[ 2954.467733] sis190 Gigabit Ethernet driver 1.2 loaded
[ 2954.467958] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[ 2954.467961] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[ 2954.467970] PCI: Setting latency timer of device 0000:00:04.0 to 64
[ 2954.475927] 0000:00:04.0: sis190 at ffffc20000004c00 (IRQ: 11), 00:11:2f:e9:42:70
[ 2954.475932] eth0: Enabling Auto-negotiation.
[ 2954.510049] eth0: link change
[ 2954.512912] eth0: mii 0x1f = 0000.
[ 2954.514038] eth0: mii lpa = 0000.
[ 2954.514041] eth0: Link on unknown mode.
[ 2960.061387] eth0: PHY reset until link up
[ 2960.097462] eth0: no IPv6 routers present
[ 2965.614860] eth0: PHY reset until link up
           [ i plug the wire ]
[ 2971.168332] eth0: PHY reset until link up
[ 2972.171635] eth0: link change
[ 2972.174572] eth0: mii 0x1f = 0000.
[ 2972.175683] eth0: mii lpa = c1e1.
[ 2972.175685] eth0: Link on 100 Mbps Full Duplex mode.
[...]

-> 35MB  11.6MB/s   00:03
<- 35MB  11.6MB/s   00:03

remote # ethtool -s eth2 speed 10 duplex half autoneg off
local  # dmesg
[...]
[ 3169.769898] eth0: link change
[ 3169.773250] eth0: mii 0x1f = 0000.
[ 3169.774364] eth0: mii lpa = 4021.
[ 3169.774366] eth0: Link on 10 Mbps Half Duplex mode.
       [ could not ping remote]

I had to reload sis190 (network restart was not sufficient).

->        35MB 334.2KB/s   01:47
<-   8% 2976KB  40.2KB/s   13:35 ETA

remote # ethtool -s eth2 speed 10 duplex full autoneg off
local  # dmesg
[...]
[ 3467.070750] eth0: pad error. status = 01000042
[ 3467.208669] eth0: pad error. status = 01000048
[ 3467.329894] eth0: pad error. status = 01000043
[ 3469.350736] eth0: pad error. status = 01000044
[ 3469.351500] eth0: pad error. status = 0100005a
[ 3487.685124] eth0: link change
[ 3487.687358] eth0: PHY reset until link up
[ 3488.846780] eth0: link change
[ 3488.850113] eth0: mii 0x1f = 0000.
[ 3488.851224] eth0: mii lpa = 4061.
[ 3488.851226] eth0: Link on 10 Mbps Full Duplex mode.

No need to restart network...

the transfer from local to remote froze immediatly the box.

It's always reproductible : box freshly started,
network restarted, sis190 reloaded...

-> do not try it!
<- 35MB   1.1MB/s   00:31

In the other direction (remote -> local), i could transfer
the file as many times as i wanted.


remote # ethtool -s eth2 speed 100 duplex half autoneg off
local  # dmesg
[...]
[  638.939950] eth0: link change
[  638.943171] eth0: mii 0x1f = 0000.
[  638.944282] eth0: mii lpa = 4081.
[  638.944284] eth0: Link on 100 Mbps Half Duplex mode.

No need to restart network...

-> 35MB   1.0MB/s   00:35
<- 35MB   2.9MB/s   00:12

remote # ethtool -s eth2 speed 100 duplex full autoneg off
local  # dmesg
[...]
[  281.822151] eth0: link change
[  281.825442] eth0: mii 0x1f = 0000.
[  281.826553] eth0: mii lpa = 4181.
[  281.826555] eth0: Link on 100 Mbps Full Duplex mode.

No need to restart network...

-> 35MB  11.6MB/s   00:03
<- 35MB  11.6MB/s   00:03



2) local = sis190 remote = 8139too
----------------------------------

remote # ethtool -i eth2
driver: 8139too
version: 0.9.27

remote # ethtool -s eth2 autoneg on
local  # dmesg
[...]
[ 1122.883216] eth0: link change
[ 1122.886164] eth0: mii 0x1f = 0000.
[ 1122.887275] eth0: mii lpa = 45e1.
[ 1122.887278] eth0: Link on 100 Mbps Full Duplex mode.

No need to restart network...

-> 35MB  11.6MB/s   00:03
<- 35MB  11.6MB/s   00:03

remote # ethtool -s eth2 speed 10 duplex half autoneg off
local  # dmesg
[...]
[ 1297.412384] eth0: link change
[ 1297.415299] eth0: mii 0x1f = 0000.
[ 1297.416410] eth0: mii lpa = 0021.
[ 1297.416412] eth0: Link on 10 Mbps Half Duplex mode.

No need to restart network...

->  3% 1296KB  61.8KB/s   09:17 ETA
<- 43%   15MB 336.1KB/s   00:59 ETA

remote # ethtool -s eth2 speed 10 duplex full autoneg off
local  # dmesg
[...]
[ 1396.959707] eth0: pad error. status = 01000048
[ 1396.961143] eth0: pad error. status = 0100004a
[ 1396.962580] eth0: pad error. status = 0100004a
[ 1396.964014] eth0: pad error. status = 01000042
[ 1396.965448] eth0: pad error. status = 01000042
[ 1396.966886] eth0: pad error. status = 0100004c
         [ i did not find mode report ]

No need to restart network...

-> 35MB 337.3KB/s   01:46
<- 35MB   1.1MB/s   00:31

I restarted network, but nothing worked anymore; so i
also reloaded sis190.

local  # dmesg
[...]
[ 1741.049314] eth0: Enabling Auto-negotiation.
[ 1746.626290] eth0: mii 0x1f = 0000.
[ 1746.627399] eth0: mii lpa = 0021.
[ 1746.627401] eth0: Link on 10 Mbps Half Duplex mode.
                    [false detection ^^^^]

-> 13% 4816KB 357.6KB/s   01:26 ETA
<-       35MB   1.1MB/s   00:32

remote # ethtool -s eth2 speed 100 duplex half autoneg off
local  # dmesg
[...]
[ 1990.441900] eth0: link change
[ 1990.445110] eth0: mii 0x1f = 0000.
[ 1990.446222] eth0: mii lpa = 0081.
[ 1990.446224] eth0: Link on 100 Mbps Half Duplex mode.

No need to restart network...

-> 35MB   1.1MB/s   00:33
<- 35MB   2.2MB/s   00:16

remote # ethtool -s eth2 speed 100 duplex full autoneg off
local  # dmesg
[...]
[ 2075.194365] eth0: pad error. statad error. status = 01000232
[...]
[ 2125.300416] eth0: pad error. status = 01000040
[ 2129.465137] eth0: pad error. status = 01000046
[ 2129.804272] eth0: pad error. status = 01000040
[ 2130.498300] eth0: pad error. status = 01000044
         [ i did not find mode report ]

-> 35MB   1.2MB/s   00:30
<- 35MB  11.6MB/s   00:03

I restarted network, it worked, but still pad errors.
So i reloaded sis190.

local  # dmesg
[...]
[ 2346.490911] eth0: Enabling Auto-negotiation.
[ 2352.068364] eth0: mii 0x1f = 0000.
[ 2352.069478] eth0: mii lpa = 0081.
[ 2352.069482] eth0: Link on 100 Mbps Half Duplex mode.
                     [false detection ^^^^]

-> 35MB   1.1MB/s   00:32
<- 35MB  11.6MB/s   00:03


As you can see, it always works fine with autoneg on, and
only 100 full with r8169 is OK with autoneg off.



Regards
Pascal


