Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264787AbUDWMSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264787AbUDWMSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbUDWMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:18:13 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:14535 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264787AbUDWMSJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:18:09 -0400
Date: Fri, 23 Apr 2004 14:18:07 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Len Brown <len.brown@intel.com>
Cc: Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
In-Reply-To: <1082669345.16332.411.camel@dhcppc4>
Message-ID: <Pine.LNX.4.55.0404231347210.14494@jurand.ds.pg.gda.pl>
References: <200404131117.31306.ross@datscreative.com.au> 
 <200404131703.09572.ross@datscreative.com.au>  <1081893978.2251.653.camel@dhcppc4>
  <200404160110.37573.ross@datscreative.com.au>  <1082060255.24425.180.camel@dhcppc4>
  <1082063090.4814.20.camel@amilo.bradney.info>  <1082578957.16334.13.camel@dhcppc4>
 <4086E76E.3010608@gmx.de>  <1082587298.16336.138.camel@dhcppc4> 
 <20040422163958.GA1567@tesore.local>  <1082654469.16333.351.camel@dhcppc4>
 <1082669345.16332.411.camel@dhcppc4>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Len Brown wrote:

> date seems to gain 9sec/hour on my Shuttle/SN41G2/FN41 when using IOAPIC
> timer.
> 
> booted with "noapic" for XT-PIC timer, it stays locked
> onto my wristwatch after an hour.  If the workaround is disabled,
> and XT-PIC timer is used, it matches the "noapic" behaviour -- no drift.
> 
> I can't explain it.  I think it is a timer problem independent of the
> IRQ routing.
> 
> -Len
> 
> ps. when i ran in XT-PIC mode there were lots of ERR's registered in
> /proc/interrupts -- doesn't look healthy.

 It looks like a noise on the timer IRQ line causing spurious interrupt
edges.  In the XT-PIC mode it gets ignored -- at the time the CPU issues
an ack, the request is already gone and the PIC signals a spurious
interrupt.  In the APIC mode the interrupt is delivered as a regular one
as edge interrupt events are persistent for the APICs -- if a falling edge
happens before an interrupt is acked it's not assumed to be gone and is
delivered as a real one.

 Another possibility is there's a bug in our APIC interrupt setup, leading
to the timer interrupt being enabled both in the APIC and in the PIC.  
You can verify that by calling debug functions for dumping states of the
controllers from io_apic.c.  They are print_IO_APIC(), print_local_APIC()  
and print_PIC() -- you may call them from an ad-hoc written small module,
although the first one is (accidentally?) marked __init, so you'd have to
remove the mark first.  You need to call all of them to get a complete
view.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
