Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLSUum>; Tue, 19 Dec 2000 15:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbQLSUuc>; Tue, 19 Dec 2000 15:50:32 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:53776 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129383AbQLSUuZ>;
	Tue, 19 Dec 2000 15:50:25 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Tue, 19 Dec 2000 21:18:56 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Startup IPI (was: Re: test13-pre3)
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu
X-mailer: Pegasus Mail v3.40
Message-ID: <1023FFA13E5F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec 00 at 19:30, Maciej W. Rozycki wrote:
> > When I replaced address with 0xC01B8000 (some cachable memory), it worked
> > fine. When replaced with 0xC00C8000 (supposedly unused address, but maybe
> > it is just set as cacheable in chipset), it works too.
> 
>  Hmm, a read from an uncached location could result in sending delayed
> APIC writes to the bus in case of an incorrect MTRR setting for the APIC
> space.  Could you please disable CONFIG_X86_GOOD_APIC?  This will result
> in using locked cycles for APIC writes, i.e. immediate bus accesses.

I did... So it uses 'xchg %eax,APIC_ICR' instead of 'movl %eax,APIC_ICR',
yes (as verified in generated code...)? No change, still dies, as expected
(do not forget that before it dies, it can do ~0x1300 write-read cycles
from videomemory (AGP4x), so secondary CPU just does some thinking before 
it kills machine; only problem is that 0x1300 wr-rd cycles to VGA apperture
take 3.48ms, and this does not correspond with needed 200us udelay.
Maybe chipset decides to do something when second CPU cannot obtain
bus access in 100000 pci cycles?).
 
>  Please also check MTRR settings, especially for the APIC range.  They
> might need fixing. 

Do you (or anyone else) have code which can dump MTRR registers of each
of CPU before mtrr driver takes over them? At least first CPU does not have
any problem...
 
> > at the beginning of trampoline.S, and then boot with 'no-scroll', but
> > character in upper left corner did not change, so secondary CPU probably
> > even did not start code fetches. That's all I can say until
> > I put non-AGP card into the box (but I need AGP, so it is not real
> > option).
> 
>  An easier way to check an application processor is alive could be
> enabling the speaker -- after setting it up by the bootstrap CPU it only
> takes three instructions to set bits 0 and 1 of port 0x61 and the result
> is not volatile.  A LED diagnostic display would be better, but typical
> PCs don't have one, unfortunately.

Fortunately secondary CPU starts with AL & 3 == 0, so it is just
one 'outb %al,$0x61' instruction. When first CPU reads memory in loop,
it beeps and beeps and beeps. If first CPU does 'udelay(300);', it
works fine (I put mdelay(100) after enabling speaker, so I hear short
1000Hz beep during boot). So secondary CPU does not correctly execute
even first instruction. But it either locks bus forever (looks like that
because of ATX poweroff button does not work anymore), or confuses first
CPU so much that it also cannot continue...
 
> > Yeah. Just do not read video memory when another CPU starts. I'll try
> > disabling cache on both CPUs, maybe it will make some difference, as
> > secondary CPU should start with caches disabled. But maybe that it is 
> > just broken AGP bus, and nothing else. But until I find what's really
> > broken on my hardware, I'd like to leave 'udelay(300)' in.
> 
>  If the problem is with write combining then disabling the cache won't
> help, I'm afraid.

Read loop reads one short from one constant address, so any write* should
not make any problem.
 
> > instead of string as soon as second CPU started (no, it did not race due 
> > to missing console_lock; before first printk() secondary CPU should fill 
> > whole screen with letter '2'. It did not).
                      ^ digit. I'm sorry ;-)
> 
>  I would still verify (i.e. with the speaker) that's really the second CPU
> causing the corruption. 

I even placed 'wbinvd' and 'wbinvd; cpuid' before sending startup IPI,
but it does not matter. Secondary CPU just does not finish even first
instruction when first CPU reads from videoram again and again.

Without VIA datasheet I cannot try to disable some PCI features to find
which one is culprit, so I'm sorry.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
