Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRHaPB0>; Fri, 31 Aug 2001 11:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266448AbRHaPBQ>; Fri, 31 Aug 2001 11:01:16 -0400
Received: from pf107.gdansk.sdi.tpnet.pl ([213.77.129.107]:4359 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S272718AbRHaPBJ>; Fri, 31 Aug 2001 11:01:09 -0400
Subject: Re: [patch] serial.c ALI/SMSC/VIA high speed support
In-Reply-To: <20010830145943.B3114@thunk.org> "from Theodore Tso at Aug 30, 2001
 02:59:43 pm"
To: Theodore Tso <tytso@mit.edu>
Date: Fri, 31 Aug 2001 16:52:08 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E15cpeS-0007QQ-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> This patch hard codes magic divisor values for a specific motherboard

It's not just one specific motherboard - several chips from different
manufacturers use exactly the same magic divisor values, so this looks
like some sort of "industry standard".  The patch includes VT82C686A
detection simply because it's a reasonably safe PCI probe.  Other chips
(SMSC, ALI) would need more dangerous ISA probes, but once you know what
chip you have, high speed mode can be enabled even from user space, and
the magic divisors will work the same way.

> into the serial driver.  The fact that the motherboard is using magic
> divisor values is in incredible bad taste (unlike the motherboards

I guess they did it that way for DOS/Win* backwards compatibility -
lower speeds (max 115200 bps) work as usual, so the high speed mode
could even be enabled by the BIOS if it cared enough.  These magic
values correspond to not very often used baud rates, about 3.5 bps ;)
Other chips (NSC/Winbond) use baud_base 921600 which is cleaner but
not very backwards-compatible...

> If you're going to do something like this, then it must be conditional

This would require a new version of setserial that recognizes a new
UART type (16550A with magic divisors).  If you can release it, I see
no problem with making magic divisors conditional as you suggest.

One more thing - these special features can't be auto-detected by
simply looking at UART registers.  These chips have programmable
UART I/O base and IRQ which don't have to be standard COM1/COM2
(or even COM3/COM4 for that matter - only the BIOS setup limits your
choices, the chip allows any multiple of 8 as UART I/O base).

Now, I can read the two I/O base addresses from the chip, but what to
do next?  Should I search rs_table[] for a matching I/O port address
to change UART type (ALI/SMSC/VIA) or baud_base (NSC/Winbond) there?
What if not found (non-standard I/O base set by the BIOS), should a new
entry be added after the standard ones like for PCI ports?

Of course, auto-detection is not something very important right now, but
I'd like to see basic support for magic divisors (spd_cust is a kludge,
the driver thinks the speed is very low, sets wrong FIFO trigger level
and much too long timeout) at least for people who know how to enable
high speed mode in their chips...

Thanks,
Marek

