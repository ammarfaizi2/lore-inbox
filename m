Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbQLRSvw>; Mon, 18 Dec 2000 13:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132515AbQLRSvm>; Mon, 18 Dec 2000 13:51:42 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:15115 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132476AbQLRSv0>;
	Mon, 18 Dec 2000 13:51:26 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Mon, 18 Dec 2000 19:19:38 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Startup IPI (was: Re: test13-pre3)
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu
X-mailer: Pegasus Mail v3.40
Message-ID: <1009FFDF1491@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 00 at 18:18, Maciej W. Rozycki wrote:
> On Mon, 18 Dec 2000, Petr Vandrovec wrote:
> 
> > No. Without udelay() before first printk() it just does not boot on my
> > motherboard. There were two choices: either remove all printk() from
> > these loops (define Dprintk to null), or add udelay(x), where x >= 200,
> > before first printk. I sent patch twice to linux-kernel, and to 
> > mingo@redhat.com, and nobody said anything against it.
> 
>  I see.  But are you sure this is the right fix?  You may be covering
> the real problem with this arbitrary delay.

It is possible. But it is hard to track, as it works with serial console,
and it is not possible to paint characters to VGA screen, as vgacon uses
hardware panning instead of scrolling :-( And if it dies, shift-pageup
apparently does not work... And filling whole 32KB with some char
does not work, as it changes timing too much...
 
> > analyzer (or if I should come with motherboard), I'm willing to continue
> > testing. But current idea is that inb/outb done by cursor positioning
> > code is incompatible with something else done in secondary CPU startup.
> 
>  Have you tried putting explicit display adapter (other ISA) I/O accesses
> after sending the IPI to see if they trigger the problem?  IPIs are

No, I'll try. It occured with either AGP (Matrox G200/G400/G450) or
PCI (S3, CL5434) VGA adapter. I did not tried real ISA VGA...

> > Without delay() both CPU die, and board does not react to anything except
> > hard reset anymore (and sometime it does not react even to hard reset; lookup
> > for my messages during last week).
> 
>  Now THAT is weird.  It might mean a chipset bug.  Still no idea how an
> inter-APIC message might trigger it -- it completely bypasses MB

Yes. I could understand if I had to place bigger udelay() after INIT IPI,
as this can cause some specific PIII initialization and Intel says that
there should not be any MESI traffic during this init (at least I understand
it that way). But after startup IPI it should just start executing code...
I tried to put 'wbinvd' here and there, but it did not make any change,
only udelay() between startup IPI cmd and first printk() did.

> chipset...  Hmm, maybe not...  Is your I/O APIC discrete (like Intel's
> 82093AA) or integrated?  It appears there are vendors manufacturing I/O
> APIC clones and this may imply new problems, sigh...

I have no idea. I know that board has VT82C694X (rev c4) host and PCI bridge,
and VT82C686 (rev 22) ISA bridge. I tried to request documentation
of 694X from VIA, but I did not heard from them. They have probably
some secrets hidden in their hardware...
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
