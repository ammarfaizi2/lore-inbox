Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132444AbRAPTZG>; Tue, 16 Jan 2001 14:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132442AbRAPTY4>; Tue, 16 Jan 2001 14:24:56 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:49113 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132444AbRAPTYr>; Tue, 16 Jan 2001 14:24:47 -0500
Date: Tue, 16 Jan 2001 20:23:59 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Frank de Lange <frank@unternet.org>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
In-Reply-To: <20010112165104.A22465@unternet.org>
Message-ID: <Pine.GSO.3.96.1010116191045.5546V-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Frank de Lange wrote:

[I've cut syslog junk away for clarity -- you could just do `dmesg -s 32768'.]
> before network hang
> ===================
[...]
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[...]
>  13 0FF 0F  0    1    0   1   0    1    1    99
[...]
> printing local APIC contents on CPU#0/0:
[...]
> ... APIC TMR field:
> 0123456789abcdef0123456789abcdef
[...]
> 00000000010000000000000001000000
                           ^
[...]
> printing local APIC contents on CPU#1/1:
[...]
> ... APIC TMR field:
> 0123456789abcdef0123456789abcdef
[...]
> 00000000000000000000000001000000
                           ^
[...]

 Here everything is fine.  Vector 0x99 (the one you are having troubles
with) is set up as level-triggered (Trig is 1) and the respective bits of
the Trigger Mode Register (TMR) of the local APIC of both CPUs are set,
i.e. the last 0x99 IRQ processed was level-triggered as expected.  As a
part of the ususal inter-APIC handshake for level-triggered interrupts an
EOI message was sent to the originating I/O APIC (IRR is 0) to inform it,
it's free to send the IRQ again if still asserted. 

> after network hang
> ==================
[...]
> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
[...]
>  13 0FF 0F  0    1    1   1   0    1    1    99
[...]
> printing local APIC contents on CPU#1/1:
[...]
> ... APIC TMR field:
> 0123456789abcdef0123456789abcdef
[...]
> 00000000000000000000000001000000
                           ^
> printing local APIC contents on CPU#0/0:
[...]
> ... APIC TMR field:
> 0123456789abcdef0123456789abcdef
[...]
> 00000000010000000000000000000000
                           ^ Gotcha!
[...]

 Here the last 0x99 IRQ delivered to CPU#1 was fine, just like before. 
But the last 0x99 IRQ CPU#0 received was apparently delivered as
edge-triggered -- the respective bits of the Trigger Mode Register (TMR)
of the local APIC is cleared.  Hence the local APIC decided no EOI message
is needed for the originating I/O APIC as edge-triggered interrupts are
always sent by an I/O APIC whenever arriving (it's not possible for
level-triggered ones as an IRQ storm would result).  Upon receiving an EOI
command from Linux the local APIC decides everything is finished and the
I/O APIC is left stuck with the IRR bit set to 1.  It's still waiting for
an EOI message to arrive for further 0x99 IRQs to send.

 How could it happen?  Well, I guess a transmission error could have
happened that remained unnoticed by the checksumming hardware.  As the
checksum algorithm is pretty trivial -- a cumulative sum of 2-bit values
-- it might just have happened two bits got toggled.  I believe such
errors are happening due to marginal hardware -- not every i386 SMP box
shows this problem, even if a high volume of level-triggered interrupts is
observed. 

 Thank you very much for the log.  I already have an idea how to
automatically recover from such a situation.  No driver change is required
-- apparently no driver is at fault, it's just a load of the inter-APIC
bus, I/O APICs (including system bus accesses) or the whole system in
general. 

 I'm hereby asking everyone not to modify drivers just to circumvent APIC
lock-ups.  Especially if such changes would "punish" perfectly good
systems.  It won't cure anything -- it might only make it happen less
frequently due to different conditions.  I hope to have changes ready to
test by the next week.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
