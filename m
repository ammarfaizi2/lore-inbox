Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284691AbSADT7n>; Fri, 4 Jan 2002 14:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSADT71>; Fri, 4 Jan 2002 14:59:27 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:49553
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288743AbSADT5C>; Fri, 4 Jan 2002 14:57:02 -0500
Date: Fri, 4 Jan 2002 14:41:46 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104144146.A20097@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020103133454.A17280@suse.cz> <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl> <20020104200410.E21887@suse.cz> <20020104140538.A19746@thyrsus.com> <20020104202151.A22445@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104202151.A22445@suse.cz>; from vojtech@suse.cz on Fri, Jan 04, 2002 at 08:21:51PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz>:
> You'll have to add motherboards that have no ISA slots, but onboard ISA
> devices to the list.
>
> I'd suggest looking at the output of /proc/bus/isapnp as well, because
> if it lists any devices, you certainly need ISA support. 

OK, apparently some people are still confused about what I'm trying to do.
That's no surprise.  It confuses *me* sometimes!

The issue is not ISA support, it is ISA *card* support.  At the moment,
and for the foreseeable future, X86 implies ISA.  Someday there may be
X86 motherboards without on-board ISA devices, but that's a few years off.
When that does happen, my logic will be something like this, where 
PCI_BRIDGE is the test for whether PC reports an ISA bridge.

X86 and ((PCI and ISA_BRIDGE) or not PCI) => ISA

The "not PCI" case represents old ISA-only machines.  

What I'm actually trying to do is determine whether the machine can 
take ISA *cards*, and use that computation to suppress questions about
ISA cards (probed ones would still be found).  For this, the logic
should look as follows, where:

* DMI means "reports DMI"
* DMI_ISA means "DMI reports ISA slots"
* BLACKLISTED means the motherboard is in an exception list of PCI-supporting,
       DMI-supporting motherboards that falsely claim not to have ISA slots.

X86 and ((not PCI) or (not DMI) or DMI_ISA or BLACKLISTED => ISA_CARDS

This is one reason I want /sys/dmi -- because if I *don't* see it, that
means I should assume the machine is old enough to take ISA cards.  This
filter should make the blacklist relatively small -- we wouldn't have to
track even PCI motherboards older than the DMI standard.

A key point is that as ISA phases out (near future now), the blacklist 
will stop growing.  Ballpark guess is it will top out below 150 entries.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

If I were to select a jack-booted group of fascists who are 
perhaps as large a danger to American society as I could pick today,
I would pick BATF [the Bureau of Alcohol, Tobacco, and Firearms].
        -- U.S. Representative John Dingell, 1980
