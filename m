Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTLSPd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 10:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTLSPd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 10:33:57 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:56803 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262094AbTLSPdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 10:33:55 -0500
Date: Fri, 19 Dec 2003 16:33:53 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <200312191406.03383.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0312191537300.29780@jurand.ds.pg.gda.pl>
References: <200312180414.17925.ross@datscreative.com.au>
 <Pine.LNX.4.55.0312181347540.23601@jurand.ds.pg.gda.pl>
 <200312191406.03383.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003, Ross Dickson wrote:

> >  It does have such a mode. ;-)  You just have not to ack a pending
> > interrupt -- if a request goes away, the INT output gets deasserted as
> > well.  We are super cautious though and we reprogram the 8259A into the
> > AEOI mode to prevent a lockup in case INTA cycles escape to the 8259A
> > (which is theoretically possible for a broken design of an i82489DX-based
> > system).  See the 8259A datasheet for details.
> 
> I believe what you have written because you say it is how the code works.

 Well, since I'm actually the author of the relevant bits (though Ingo did
some clean-ups before applying them), I must have been completely sure the 
assumptions are valid.

> I take it you mean that the INT is either never latched? or only latched with IS bit
> after receipt of first INTA?

 Yes, one of these conditions is true, although I've never bothered to
investigate exactly which one. ;-)

> It is not obvious in 8259A Datasheet published in Intel Microsystem Components
> Handbook Volume 1 1983 nor in datasheet December 1988.

 Yep, the datasheet is indeed not that clear on the matter.  The latest
version (version 3, dated Nov 1988) used to be available at the Intel's
FTP site, but I can't find it anymore.

 The 8259A core is documented in many other datasheets, perhaps more
clearly -- e.g. I've found at least one Intel datasheet providing an
unambiguos explanation of how the SFNM mode works.  I knew of the volatile
property of the INT output pretty always and it can be quite easily
verified with hardware.  Given this property some people find the way
Intel defines edge-triggered interrupts quite surprising.

> Could you please point me to the document where it is made clear? It may be
> in the i82489DX docs as I do not have them or in a later 8259A data sheet
> revision?

 Well, there is actually a hint on how this "transparent" property of the
8259A PIC can be used for delivery of EISA chaining interrupts as APIC
interrupts in the i82489DX datasheet.  The problem with these interrupts
appears with the 82357 ISP EISA component that has a pair of 8259A PICs
embedded and does not provide the interrupt line externally, only wiring
it to IRQ 13 (IR5 of the slave 8259A -- so both 8259A cores have to be
treated as "transparent"!) internally.  The same problem exists with the
8254 interrupt in this chip, but the datasheet disregards it, assuming the
local APIC timer will be used for periodic interrupts exclusively.

 Linux would use IRQ 0 in the "transparent" 8259A mode with this chip and
if that failed (which would be quite possible, since an ISP erratum
required glue logic in the 8259A path when used with an APIC and the
Intel's suggestion wasn't the most fortunate) the mixed mode with ExtINTA
interrupts would be configured.  Of course the mixed mode would also
permit simultanous use of IRQ 0 and IRQ 13 with ISP -- with the
"transparent" 8259A mode can support only a single interrupt source.

 Note the interesting internal inconsistency of the document --
implementation of the erratum workaround as proposed by Intel would make
the suggested "transparent" 8259A mode inoperational. ;-)

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
