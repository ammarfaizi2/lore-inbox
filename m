Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263668AbRFASbz>; Fri, 1 Jun 2001 14:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263669AbRFASbs>; Fri, 1 Jun 2001 14:31:48 -0400
Received: from pD951F76B.dip.t-dialin.net ([217.81.247.107]:53254 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S263668AbRFASbd>; Fri, 1 Jun 2001 14:31:33 -0400
Date: Fri, 1 Jun 2001 20:31:27 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 still breaks dhcpcd with 8139too
Message-ID: <20010601203127.B17137@emma1.emma.line.org>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010529215647.A3955@greenhydrant.com> <3B147F80.31EC7520@mandrakesoft.com> <20010531104437.C10057@emma1.emma.line.org> <3B17D471.D636E208@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B17D471.D636E208@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jun 01, 2001 at 13:44:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jun 2001, Jeff Garzik wrote:

> Matthias Andree wrote:
> > 
> > Will that 8139too be able to share its IRQ with a bttv card (Hauppauge
> > WinTV in my case)? With 2.2.19, it's currently possible, at least after
> > unloading and reloading the 8139too module, but it's a no-go with 2.4.5.
> 
> Can you be more explicit than "no-go"?  8139too should share interrupts
> just fine.

Not sure if it's related to IRQ sharing or another initialization issue.

Here's the hardware setup, machine at the time of testing also had 2 64
MB DIMMS and a Duron 700, all in a Gigabyte 7ZX-R.

First column is the IRQ (decimally), if any. (lspci, merged with lspci
-v IRQ information)

   00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
   00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
   00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
05 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
05 00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
   00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
12 00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
12 00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
11 00:0a.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 03)
12 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
11 00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
05 00:0f.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
05 00:10.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
09 01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04] (rev 04)

/proc/interrupts (2.2)

  0:    1536577          XT-PIC  timer
  1:      33313          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          9          XT-PIC  serial
  4:      57284          XT-PIC  serial
  5:      24965          XT-PIC  ide2, eth0
  6:         28          XT-PIC  floppy
  8:       2503          XT-PIC  rtc
 10:        340          XT-PIC  serial
 11:       9581          XT-PIC  sym53c8xx, es1371
 12:      64495          XT-PIC  eth1
 13:          1          XT-PIC  fpu
 14:      80681          XT-PIC  ide0

So, here's the story. Initially, the card was in the next-to-bottom PCI
slot, sharing its IRQ with the nvidia (which isn't listed here for
reasons beyond my knowledge), IRQ 09. With Linux 2.2.19, I caught error
messages I already reported on May 19, thread subject "RTL8139
difficulties in 2.2, not in 2.4"; the IRQs weren't reported properly.
That report related to rtl8139, but 8139too showed the same problems, it
just was less verbose in its error reporting. I got replies by Donald
Becker, who suggested to boot with "noapic", but that didn't help.

On May 21, I found out, that 2.4.4 didn't work either.

While the RTL8139 card shared its IRQs with the nvidia, unloading the
module (rmmod 8139too), reloading it by running "ifconfig eth1 up"
(literally) brought the card to work on Linux 2.2 reliably, and I
believe also with 2.4. "To work" means: pppoe on that card talks through
the DSL modem, discovers the Access Concentrator and tunnels PPP for use
with pppd 2.4.0. Not working means: pppoe does not receive PAD replies.

Note: PPPoE doesn't talk IP.

A couple of days ago, I moved the card down one slow, now it shares its
IRQ with the Hauppauge WinTV BT878 board.

With Linux 2.2, the situation is the same, although, from time to time,
the card just works.

With Linux 2.4, the situation is worse now, the card almost never works,
and it won't work at all in 2.4.5.

As I'm totally unaware of how the card initalization procedures are
done, I don't know how to reasonably debug this, I'd like to do that
systematically. I'm also willing to move the card around to figure
what's going on, but I need directions on what to look for.

I'm talking about initialization because I believe it might be involved
as unloading and reloading the 8139too.o driver module seems to help
out.

Again, please send directions on how to track this down. What output is
helpful and what is unnecessary (mii-diag? /proc/interrupts of either
kernel version? what else?). What am I supposed to change in hardware
configuration to find the problem? What debug options should I switch on
when recompiling a debug kernel?

Thanks in advance,
Matthias
