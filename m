Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbRCHOw6>; Thu, 8 Mar 2001 09:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129126AbRCHOws>; Thu, 8 Mar 2001 09:52:48 -0500
Received: from blueberry.jellybean.co.uk ([194.88.75.31]:61964 "EHLO
	blueberry.jellybean.co.uk") by vger.kernel.org with ESMTP
	id <S129091AbRCHOwi>; Thu, 8 Mar 2001 09:52:38 -0500
Date: Thu, 8 Mar 2001 14:51:42 +0000
From: Jules Bean <jules@jellybean.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Can't use high IRQs on ISA ethernet card
Message-ID: <20010308145142.A7572@blueberry.jellybean.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just had a weird and frustrating experience trying to get an
ethernet card to work. I think the problem lies in the kernel's IRQ
handling, which is why I'm reporting it here.  I'll try to think of al 
lthe relevenat details, but it's been one of those mornings consisting 
of much rebooting, and I may forget something:

My machine is an AMD k6-2 500 using a gigabyte motherboard with an
aladdin 5 chipset.  FWIW, dmesg says:

Serial Number SYS-9876543210.
Board Vendor: GA. INC..
Board Name: ALADDIN5.
Board Version: VER:1.0.
Asset Tag: ASS-9876543210.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0.
ALI15X3: chipset revision 194
ALI15X3: not 100% native mode: will probe irqs later

Oh, and I'm using the debian source package of 2.4.0.

The ethernet card concerned has definitely worked many times in the
past, but it wasn't working this monring.  It's a long time since I
last used it, so I can't quite remember for sure what's changed since
them, but I'm almost 100% no new hardware has gone into the machine
apart from a CD writer. The internal modem may be new, though.

As I say, the card is ISA.  The symptoms of it not working were as
follows: It's on a 2-node BNC network with a win98 laptop.  The win98
ethernet is known good, I think. Running a 'ping' (or anything else)
from the linux end resulted in the activity light on the laptop's
adapter flashing, but no response. tcpdump indicates that arp requests 
are being sent, but no reply is being heard.

Conversely, running a ping from the win98 end also flashes the light,
but tcpdump show nothing at all.

I'm pretty sure that the linux ethernet card was capable of sending,
but not receiving. (I.e. it wasn't seeing the ARp reply, so it wasn't
even getting to the ICMP stage). Furthermore, /proc/interrupts
revealed that it wasn't getting any interrupts. Donald Becker's
3c5x9.c program said that the card had unprocessed interrupts (sorry,
I didn't save the message) which it indicated shold never happen.

Sounds like an IRQ conflict, right?

Well, it was.  But what's weird is that the /only/ IRQ it will work on 
is 5. I tried everything from 9 to 13, with no luck.  Now it was
originally on 10, but 10 might conceivably conflict with my PCI bus.
9, however, I'm pretty sure doesn't conflict with anything, and 9
definitely didn't work. [Incidentally, I did go into the BIOS and
assign 9 to 'ISA/EISA' instead of 'PCI/PnP', but that didn't help; I
don't think it's necessary since I haven't done that for IRQ 5 and it
works now].

I know for a fact that when I last had this card working, it was on
IRQ 12.  I am sure about this because I remember having to move it to
a different IRQ when I got a PS/2 mouse for the first time a few weeks 
ago. At that point I moved the ethernet card to IRQ 10, but didn't
bother to check if it worked.

I don't think it's the card at fault because, before I thought of
trying IRQ 5, I switched to a different card -- a simple cheap ne2000
compatible. (Also known to definitely work in the past). It's with the 
ne2000 compatible that I finally tried IRQ 5, and when that worked, I
switched back to the 3c509 (trying to be scientific) and that worked
on IRQ 5, as well.

So, in summary, what seems to me to be happening is that the high IRQs 
(9-13, say) appear to be unavailable for use by ISA cards on my
machine, at the moment.  The kernel allows ISA cards to claim these
IRQs (and the cards then show up in /proc/interrupts) but they don't
actually seem to get the interrupts.  I don't know if the BIOS is
stealing them, or the kernel, or what.

I tried with 2.2.14 (which is what I mainly used until I bit the
bullet and upgraded to 2.4.0), and it also has the same problem.
Which is weird; I'm pretty sure I've had this card working on high
numbered IRQs under some 2.2.x kernel, although I couldn't be sure
which.

Sorry for the length of the message.  The problem is no longer
inconveniencing me (IRQ 5 is fine) but I thought it might be relevant
or interesting to someone.  If it isn't just a stupid hardware
conflict.

Yours,

Jules Bean

(cc: me on any replies you want me to see)
