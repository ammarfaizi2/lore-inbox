Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTIZRkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbTIZRkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:40:18 -0400
Received: from fmr03.intel.com ([143.183.121.5]:28040 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261460AbTIZRkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:40:09 -0400
Subject: Re: HT not working by default since 2.4.22
From: Len Brown <len.brown@intel.com>
To: Jan Evert van Grootheest <j.grootheest@euronext.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, marcelo@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
In-Reply-To: <3F73EE77.3000906@euronext.nl>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8718@hdsmsx402.hd.intel.com>
	 <3F73EE77.3000906@euronext.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1064597917.2559.77.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Sep 2003 13:38:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm thinking now that 2.4.21 had right:

CONFIG_ACPI == ACPI
!CONFIG_ACPI == !ACPI

No special config option to include/exclude HT.


Internally, the table parsing code will be included if (CONFIG_SMP ||
CONFIG_ACPI) -- since that code doesn't even know about HT, it just
knows about parsing ACPI tables and enumerating processors etc.  This
makes sense as this code is needed, for example, by an SMP system that
doesn't implement HT, and also by uni-processor ACPI-enabled systems. 
Inventing an "HT-something" config option to describe this code was
probably a mistake.

So at the config option level, we'll be compatible with 2.4.21.  Under
the covers we'll be different as 2.4.21 erroneously made acpitables
depend on the IOAPIC -- which didn't support HT on IO-APIC-less boxes
(eg the volume P4 desktops we see today).

thanks,
-Len

ps. Thanks for emphasizsing the "config selects a feature concept".  I
really do agree.  Indeed, I implemented it this summer, but I got hung
up on the fact that when I was done, in the CONFIG_ACPI case, CONFIG_HT
== !CONFIG_HT so I discarded that scheme.

> Len,
> 
> I think you're missing Jeffs point.
> He's really saying that the user want to select features. The user 
> doesn't really care how it is implemented. And there is no requirement 
> (I think) that some source files match one on one with a configuration 
> option.
> 
> As a user I like Jeffs proposal very much. It allows me to indicate what 
> I want without bothering about the implementation.
> I think it would be wise to indicate in the help that HT does include 
> parts of ACPI.
> 
> As a programmer, I can understand your point too. But perhaps you should 
> do something like this (in the Makefile):
> if CONFIG_HT
> 	include part of ACPI needed for HT
> endif
> if CONFIG_ACPI
> 	include all of acpi
> endif
> And let make fix things up.
> 
> -- Jan Evert
> 
> Brown, Len wrote:
> >>Now that I've thought of it (aren't I humble), I rather like 
> >>CONFIG_HT.
> >>It's simple and it's effects should be obvious to both developer and
> >>user:
> >>
> >>	CONFIG_HT, CONFIG_ACPI == ACPI
> >>	!CONFIG_HT, CONFIG_ACPI == ACPI
> >>	CONFIG_HT, !CONFIG_ACPI == HT-only ACPI
> >>	!CONFIG_HT, !CONFIG_ACPI == no ACPI
> >>
> >>Following the "autoconf model", what we really want to be testing with
> >>CONFIG_xxx is _features_, where possible. "hyperthreading: yes/no" is
> >>IMO more clear than "do I want ht-only ACPI or full ACPI", 
> >>while at the
> >>same time being more fine-grained and future-proof.
> > 
> > 
> > I like positive logic too.
> > I went so far as to try to implement this back when I deleted "noht".
> > 
> > The problem is that "!CONFIG_HT" is meaningless.  It implies that
> > you can have CONFIG_ACPI but still "config-out" HT, which you can't.
> > 
> > Ie. The 2nd row above says to give me ACPI w/o HT.
> > If you delete that row and reverse the polarity you get:
> > 
> > !CONFIG_ACPI_HT_ONLY, CONFIG_ACPI == ACPI
> > CONFIG_ACPI_HT_ONLY, !CONFIG_ACPI == HT-only ACPI
> > !CONFIG_ACPI_HT_ONLY, !CONFIG_ACPI == no ACPI
> > 
> > Here we can use config to emphasize that it is not possible to select
> > CONFIG_ACPI and CONFIG_ACPI_HT_ONLY at the same time.
> > 
> > Cheers,
> > -Len
> > 
> > Ps. Note that in 2.6 CONFIG_X86_HT exists and covers the sibling code.
> > It depends on CONFIG_SMP, and CONFIG_ACPI_HT_ONLY depends on it. (in the
> > ACPI patch)
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 

