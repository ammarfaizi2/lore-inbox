Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSHXOFS>; Sat, 24 Aug 2002 10:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSHXOFS>; Sat, 24 Aug 2002 10:05:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:6335 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S316322AbSHXOFM>;
	Sat, 24 Aug 2002 10:05:12 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: IDE janitoring comments
Date: Sat, 24 Aug 2002 17:15:58 +0200
Message-Id: <20020824151558.26134@192.168.4.1>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few notes taken while adapting the ide-pmac (MMIO) code
to the new layer in -ac:

 - Do we really want to keep all those _P versions around ?
A quick grep showed _only_ by the non-portable x86 specific
recovery timer stuff that taps ISA timers (well, I think ports
0x40 and 0x43 and an ISA timer). I would strongly suggest to
get rid of those functions from the hwif, and use directly
the appropriate PIO functon i that timer routine. Also make
sure that timer stuff don't get compiled on anything but
legacy harware where we know those ports mean something.

 - In ide-iops, the insw, insl, outsw, outsl functions are
broken for big endian. They should not do byteswap on these,
however, implemeting them with a loop of IN/OUT_BYTE/WORD
will cause byteswapped access on archs like PPC.
The problem is that the macros IN/OUT_BYTE/WORD don't define
non-swapping equivalents that would allow us to correctly
implement the "s" versions.

After much thinking about the above, I came to the conslusion
we probably want to just kill all the IN_BYTE, OUT_BYTE, etc...
macros and use directly inb/outb/etc... in the default PIO
ops defined in ide-iops.c. We would then use the normal arch
provided insw/insl/outsw/outsl functions here as well.

I already added a set of ops for MMIO in there using the normal
readb/writeb/... and for the "multiple" versions, I did loops
using the __raw versions (no byteswap) and a manual io_barrier().

I grep'ed in 2.4, the only archs that use custom IN/OUT_BYTE
macros for IDE are m68k and cris. I'm pretty sure m68k is wrong
and should do like PPC :) In anyway, both should be fixed the
new 'clean' way which is to define a set of access functions
to be stuffed in the HWIF structure. The goal of ide-iops is
to provide defaults for PIO (and MMIO soon as those can be made
fairly generic too).

Also, getting rid of the _P version would make things a lot
easier as well here too.

Any comments ?

Ben.


