Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263336AbSJFEwc>; Sun, 6 Oct 2002 00:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263339AbSJFEwc>; Sun, 6 Oct 2002 00:52:32 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:28831 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S263336AbSJFEwb>;
	Sun, 6 Oct 2002 00:52:31 -0400
Message-ID: <3D9FC2D9.8010805@candelatech.com>
Date: Sat, 05 Oct 2002 21:58:01 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
References: <Mutt.LNX.4.44.0210051117240.23965-100000@blackbird.intercode.com.au>	<20021004.181537.104336257.davem@redhat.com>	<3D9F46A2.6050004@candelatech.com> <20021005.212355.122592301.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Sat, 05 Oct 2002 13:08:02 -0700
>    
>    With raw ethernet packets, sent from user-space, at around 40Mbps bi-directional,
>    I see loads of these messages:
>    
>    tg3: eth3: Error, poll already scheduled
> 
> This, frankly, isn't possible.
> 
> When we get the first interrupt, we hold the spinlock and have IRQs
> disabled, in that environment we invoke netif_rx_schedule_prep(dev)
> and then disable device interrupts....
> 
> is the tg3 sharing it's IRQ with something else?  That might be
> an important clue.  In that case what you report might be possible.

Here is what the interrupts look like:

[root@localhost lanforge]# cat /proc/interrupts
            CPU0       CPU1
   0:      14734      19562    IO-APIC-edge  timer
   1:          3          1    IO-APIC-edge  keyboard
   2:          0          0          XT-PIC  cascade
   4:       1163       1124    IO-APIC-edge  serial
   5:          0          0   IO-APIC-level  eth1
   8:          0          1    IO-APIC-edge  rtc
   9:        558          0   IO-APIC-level  eth2, eth4
  10:          0          0   IO-APIC-level  usb-ohci
  11:       1385       1454   IO-APIC-level  eth0, eth3, eth5
  12:         20         12    IO-APIC-edge  PS/2 Mouse
  14:       3958       4169    IO-APIC-edge  ide0
  15:          7         13    IO-APIC-edge  ide1
NMI:          0          0
LOC:      34138      34183
ERR:          0
MIS:          0
[root@localhost lanforge]#


eth0-1 is the 3com built-in nics
eth2-3 is the e1000 dual nic
eth4-5 is the tg3

Oct  5 21:42:10 localhost kernel: tg3.c:v1.1 (Aug 30, 2002)
Oct  5 21:42:11 localhost kernel: eth4: Tigon3 [partno(AC91002A1) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:40:f4:47:22:fd
Oct  5 21:42:11 localhost kernel: eth5: Tigon3 [partno(AC91002A1) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:40:f4:47:20:56


Upon starting a user-space TCP connection to myself (no traffic running on eth2-3,
eth1 is not plugged in to a cable.  eth0 is handling a small amount of traffic,
no more than about 25 packets per second on average):

[root@localhost lanforge]# tg3: eth5: Error, poll already scheduled
tg3: eth5: Error, poll already scheduled
tg3: eth5: Error, poll already scheduled
tg3: eth5: Error, poll already scheduled
tg3: eth5: Error, poll already scheduled
tg3: eth5: Error, poll already scheduled
tg3: eth5: Error, poll already scheduled


Please let me know what other debugging info I can get you.

> Otherwise the message you see appears to be totally impossible.

I told the machine that...but it only blinked it's little leds in mirth!  ;)


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


