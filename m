Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbQLSTIr>; Tue, 19 Dec 2000 14:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbQLSTIh>; Tue, 19 Dec 2000 14:08:37 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:55959 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130105AbQLSTIY>; Tue, 19 Dec 2000 14:08:24 -0500
Date: Tue, 19 Dec 2000 19:30:13 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu
Subject: Re: Startup IPI (was: Re: test13-pre3)
In-Reply-To: <100F3C80070F@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1001219190520.18507E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2000, Petr Vandrovec wrote:

> Uh. It took couple of hours to find it. Just place 
> 
> { int i; volatile unsigned short* p = 0xC00B8000; for (i = 0; i < 6553600;
>    i++) { *p; } }                                            (**)
> 
> instead of udelay(300) and this loop does not finish. Same for 
> unsigned long* p. inb/outb(0x3C0) are ok. Writes are OK too. Only 
> simple fetches from videoram kills it.
> 
> When I replaced address with 0xC01B8000 (some cachable memory), it worked
> fine. When replaced with 0xC00C8000 (supposedly unused address, but maybe
> it is just set as cacheable in chipset), it works too.

 Hmm, a read from an uncached location could result in sending delayed
APIC writes to the bus in case of an incorrect MTRR setting for the APIC
space.  Could you please disable CONFIG_X86_GOOD_APIC?  This will result
in using locked cycles for APIC writes, i.e. immediate bus accesses.

 Please also check MTRR settings, especially for the APIC range.  They
might need fixing. 

> at the beginning of trampoline.S, and then boot with 'no-scroll', but
> character in upper left corner did not change, so secondary CPU probably
> even did not start code fetches. That's all I can say until
> I put non-AGP card into the box (but I need AGP, so it is not real
> option).

 An easier way to check an application processor is alive could be
enabling the speaker -- after setting it up by the bootstrap CPU it only
takes three instructions to set bits 0 and 1 of port 0x61 and the result
is not volatile.  A LED diagnostic display would be better, but typical
PCs don't have one, unfortunately.

> Yeah. Just do not read video memory when another CPU starts. I'll try
> disabling cache on both CPUs, maybe it will make some difference, as
> secondary CPU should start with caches disabled. But maybe that it is 
> just broken AGP bus, and nothing else. But until I find what's really
> broken on my hardware, I'd like to leave 'udelay(300)' in.

 If the problem is with write combining then disabling the cache won't
help, I'm afraid.

> (*) When I was calling directly 
> vt_console_print(NULL, "Message1\n", 9);
> vt_console_print(NULL, "Message2\n", 9);
> instead of printk, I got
> Message1
> Messag<0x..><0x..><0x00><0x80><0x..><0x80><0x..><0x80>...
> - wrong text with wrong length, so it probably started fetching garbage 
> instead of string as soon as second CPU started (no, it did not race due 
> to missing console_lock; before first printk() secondary CPU should fill 
> whole screen with letter '2'. It did not).

 I would still verify (i.e. with the speaker) that's really the second CPU
causing the corruption. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
