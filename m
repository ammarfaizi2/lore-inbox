Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272590AbTG3BGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272601AbTG3BGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:06:10 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:23516 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S272590AbTG3BF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:05:56 -0400
Date: Wed, 30 Jul 2003 11:05:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: clepple@ghz.cc
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" after
 2.5.31 (incl. 2.6.0testX)
Message-Id: <20030730110548.73919ca0.sfr@canb.auug.org.au>
In-Reply-To: <1059502242.5987.24.camel@dhcp22.swansea.linux.org.uk>
References: <28705.216.12.38.216.1059490232.squirrel@www.ghz.cc>
	<1059491223.6094.6.camel@dhcp22.swansea.linux.org.uk>
	<32460.216.12.38.216.1059494755.squirrel@www.ghz.cc>
	<1059502242.5987.24.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

I may have missed this, but do you have the APIC or IO-APIC enabled?

The patch in question merely moved where the 0x40 descriptor was installed
in the descriptor table.

On 29 Jul 2003 19:10:42 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> > -static struct desc_struct      bad_bios_desc = { 0, 0x00409200 };
> > +static struct desc_struct      bad_bios_desc = { 0x00109300, 0x00409200 };
> >  static char                    driver_version[] = "1.16ac";    /* no
> > spaces */
> > 
> > I tried this on top of 2.6.0-test2, and it didn't work. Where does the
> > first number in that initializer come from?
> 
> I wasnt sure if the kernel code was initialising all the flag and control bits
> of the segment entry. That should have set the bits required anyway just in
> case if I got it right (Pentium pro dev manual vol III chapter 7)
> 
> It might be 0x00009300, it might be set already, or it might be some other
> effect thats breaking your laptop of course

The 0 above initialises the base and limit parts of the descriptor and
should be zero as it is filled in later (or should be).

The 0x00409200 means this is a byte granularity (0x800000 not present)
32-bit (0x400000) present (0x8000) memory (0x1000) read/write (0x200)
descriptor.  The 32-bit part should be irrelevent as this descriptor
should only be loaded into the DS register (that bit only affect code and
stack segments).

The base and limit parts of the descriptor get initialised at run time by
the code:

	set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
	_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));

These could be set statically, but it was easier to use the availble
macros.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
