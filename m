Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265156AbTLROFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbTLROFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:05:02 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:61351 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265156AbTLROEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:04:54 -0500
Date: Thu, 18 Dec 2003 15:04:47 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <200312180414.17925.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0312181347540.23601@jurand.ds.pg.gda.pl>
References: <200312180414.17925.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Ross Dickson wrote:

> Here is where to find Intel's MP arch spec Maceij mentions.
> I had to find it recently wrt nforce2 issues
> 
> http://www.intel.com/design/pentium/datashts/24201606.pdf
> 
> Section 3.6.1 Apic Architecture is relevant
> particularly
> Section 3.6.2.2 Virtual Wire Mode

 BTW, I have revision 1.1 as well in case anyone was interested in the 
differences.

> I would like to add a footnote to highlight a potential gotcha as I
> understand it.
> 
> To clarify, the xt pic 8259A does not in itself have a transparent mode
> as would a logic buffer or inverter. It always needs inta cycles to
> function. In PIC mode it is wired to processor pins as per old 8086 and
> original cpu architecture provides the inta cycles to it (bypasses apic,
> apic seems off).

 It does have such a mode. ;-)  You just have not to ack a pending
interrupt -- if a request goes away, the INT output gets deasserted as
well.  We are super cautious though and we reprogram the 8259A into the
AEOI mode to prevent a lockup in case INTA cycles escape to the 8259A
(which is theoretically possible for a broken design of an i82489DX-based
system).  See the 8259A datasheet for details.

> I certainly agree with Marceij's comments that mixed mode of having 8254 PIT
> routed via the 8259A was never meant to occur alongside ioapic handling of
> the other interrupts. It is very problematic not to mention confusing. 

 Well, the true "mixed mode", i.e. where certain interrupts are delivered
as I/O APIC (either LoPri or Fixed) interrupts and others are routed
through an 8259A controller and delivered as ExtINTA interrupts was
specifically designed to work since the i8248DX APIC.  What wasn't 
designed but works by the properties of the 8259A PIC is the transparent
"through-8259A" mode.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
