Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSGDAgC>; Wed, 3 Jul 2002 20:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317301AbSGDAgB>; Wed, 3 Jul 2002 20:36:01 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:12008 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S317299AbSGDAf7>; Wed, 3 Jul 2002 20:35:59 -0400
Date: Wed, 3 Jul 2002 20:02:18 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Alan Cox <alan@www.linux.org.uk>
cc: linux-kernel@vger.kernel.org, David Hinds <dhinds@sonic.net>,
       Martin Mares <mj@ucw.cz>
Subject: Re: Cyrix IRQ routing is wrong?
In-Reply-To: <E17Ptae-0002Ir-00@www.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207031946230.4282-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan!

[Adding PCI maintainter Martin Mares to cc:]

On Thu, 4 Jul 2002, Alan Cox wrote:

> > The existing code uses the upper nibble in the same byte for lower pirq,
> > but it seems that we should start with the lower nibble for EM-350A.
> 
> On all my boards its upper first and the current code works while the 
> patch you have hangs the box

Ive just sent another message to the mailing list.  I can easily accept
that EM-350A (embedded system with Geode) may have hardware bugs.  But
let's consider following:

1) 2.4.17 was using the code I want to restore.  Where was your hanging 
box then?
2) The comment in 2.5.24 is saying what my code does and what 2.4.17 was 
doing.

In case if it turns out that we need to distinguish between different 
systems, here's more info about my box:

lspci (version 2.1.8):

00:00.0 Host bridge: Cyrix Corporation PCI Master
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 
10)
00:11.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00:11.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00:12.0 ISA bridge: Cyrix Corporation 5530 Legacy [Kahlua] (rev 30)
00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]
00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua]
00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]
00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua]

dump_pirq (from pcmcia-cs.02-Jul-02):

Interrupt routing table found at address 0xfdae0:
  Version 1.0, size 0x0050
  Interrupt router is device 00:12.0
  PCI exclusive interrupt mask: 0x8c00 [10,11,15]
  Compatible router: vendor 0x1078 device 0x0002

Device 00:13.0 (slot 1): 
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:11.0 (slot 2): CardBus bridge
  INTA: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:10.0 (slot 3): Ethernet controller
  INTA: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Interrupt router at 00:12.0: CYRIX 5530 PCI-to-ISA bridge
  PIRQ (link 0x01): irq 10
  PIRQ (link 0x02): irq 10
  PIRQ (link 0x03): irq 15
  PIRQ (link 0x04): irq 11
  Level mask: 0x8c00 [10,11,15]

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 9
model name      : Geode(TM) Integrated Processor by National Semi
stepping        : 1
cpu MHz         : 233.865
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx
bogomips        : 466.94

# cat /proc/interrupts 
           CPU0       
  0:     483792          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:       1368          XT-PIC  serial
  8:          1          XT-PIC  rtc
 10:         18          XT-PIC  eth0
 11:          0          XT-PIC  i82365
 12:          0          XT-PIC  PS/2 Mouse
 14:       2213          XT-PIC  ide0
 15:          0          XT-PIC  i82365
NMI:          0 
ERR:          0

# lspci -x -s 00:11
00:11.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00: 80 11 76 04 07 00 10 02 80 00 07 06 00 20 82 00
10: 00 00 00 d1 dc 00 00 02 00 01 04 b0 00 10 00 d1
20: 00 20 00 d1 00 30 00 d1 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 80 07
40: 12 34 56 78 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00: 80 11 76 04 07 00 10 02 80 00 07 06 00 20 82 00
10: 00 50 00 d1 dc 00 00 02 00 05 08 b0 00 60 00 d1
20: 00 70 00 d1 00 80 00 d1 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 80 07
40: 12 34 56 78 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
Regards,
Pavel Roskin

