Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQLSAFI>; Mon, 18 Dec 2000 19:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131354AbQLSAE7>; Mon, 18 Dec 2000 19:04:59 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:63501 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129849AbQLSAEx>;
	Mon, 18 Dec 2000 19:04:53 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Tue, 19 Dec 2000 00:33:47 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Startup IPI (was: Re: test13-pre3)
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu
X-mailer: Pegasus Mail v3.40
Message-ID: <100F3C80070F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 00 at 19:44, Maciej W. Rozycki wrote:
> > No, I'll try. It occured with either AGP (Matrox G200/G400/G450) or
> > PCI (S3, CL5434) VGA adapter. I did not tried real ISA VGA...
> 
>  Oops, I've forgotten there exist non-ISA display adapters. ;-)  Just try
> if accessing one bus or another changes the behaviour. 

Uh. It took couple of hours to find it. Just place 

{ int i; volatile unsigned short* p = 0xC00B8000; for (i = 0; i < 6553600;
   i++) { *p; } }                                            (**)

instead of udelay(300) and this loop does not finish. Same for 
unsigned long* p. inb/outb(0x3C0) are ok. Writes are OK too. Only 
simple fetches from videoram kills it.

When I replaced address with 0xC01B8000 (some cachable memory), it worked
fine. When replaced with 0xC00C8000 (supposedly unused address, but maybe
it is just set as cacheable in chipset), it works too.

Symptoms of lockup are same as hangup in printk() without udelay(300), only 
problem is that 'vt_console_print' (*) does not do fetches from videoram, it 
does stores only...

Placing this loop before sending startup IPI, or just below udelay(300)
is OK (modulo that this loop takes so long that secondary CPU complains
about no callin received).

I even tried to add:

   mov $0xB800,%ax
   mov %ax,%ds
   movw %ax,0
   
at the beginning of trampoline.S, and then boot with 'no-scroll', but
character in upper left corner did not change, so secondary CPU probably
even did not start code fetches. That's all I can say until
I put non-AGP card into the box (but I need AGP, so it is not real option).
 
> > and VT82C686 (rev 22) ISA bridge. I tried to request documentation
> > of 694X from VIA, but I did not heard from them. They have probably
> > some secrets hidden in their hardware...
> 
>  They wan't to keep the competition from being bug-compatible, it would
> seem...

Yeah. Just do not read video memory when another CPU starts. I'll try
disabling cache on both CPUs, maybe it will make some difference, as
secondary CPU should start with caches disabled. But maybe that it is 
just broken AGP bus, and nothing else. But until I find what's really
broken on my hardware, I'd like to leave 'udelay(300)' in.

(*) When I was calling directly 
vt_console_print(NULL, "Message1\n", 9);
vt_console_print(NULL, "Message2\n", 9);
instead of printk, I got
Message1
Messag<0x..><0x..><0x00><0x80><0x..><0x80><0x..><0x80>...
- wrong text with wrong length, so it probably started fetching garbage 
instead of string as soon as second CPU started (no, it did not race due 
to missing console_lock; before first printk() secondary CPU should fill 
whole screen with letter '2'. It did not).

(**) When I had '*p = i; *p' in loop, from visual inspection it was
dying in range i=0x1380-0x13FF (blue background, cyan letter with diacritics).

End of guessing.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
