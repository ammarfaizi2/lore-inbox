Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUAQTtu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUAQTtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:49:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25919 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266164AbUAQTtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:49:46 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel Alder IOAPIC fix
References: <1073876117.2549.65.camel@mulgrave>
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave>
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
	<1073954751.4178.98.camel@mulgrave>
	<Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
	<1074012755.2173.135.camel@mulgrave>
	<m1smihg56u.fsf@ebiederm.dsl.xmission.com>
	<1074185897.1868.118.camel@mulgrave>
	<m17jztau8l.fsf@ebiederm.dsl.xmission.com>
	<1074196460.1868.250.camel@mulgrave>
	<m13cagbgrc.fsf@ebiederm.dsl.xmission.com>
	<1074352704.2015.8.camel@mulgrave>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Jan 2004 12:43:35 -0700
In-Reply-To: <1074352704.2015.8.camel@mulgrave>
Message-ID: <m13cae9x94.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> writes:

> On Fri, 2004-01-16 at 00:32, Eric W. Biederman wrote:
> > Yes, this is the extreme case.  In normal cases I would just
> > expect to push to one side and probably shrink it to 0.  I guess
> > I have something against implying a hierarchal relationship that
> > does not exist.
> 
> Well, it makes sense to me that the resource would be a child of the
> reserved area, because the reserved area covers the APICs and this
> rather annoying PCI device has one of the IO APICs tied to BAR0.
> 
> In this case, we have a PCI device claiming something we already
> discovered and made use of long ago in bootup.

Yes, when the BIOS is trustworthy that sounds reasonable. 
The nasty theoretical case I can think of is what happens when that
annoying PCI device is behind a bridge?  How do we reserve the
bridge resources and become a child of them?
 
> > Right.  To me it looks like separate cases.  What I keep envisioning
> > scanning the PCI devices and then realizing they are behind
> > a bridge.  Before I go to far I guess I should ask.
> > 
> > The splitting/pushing aside looks especially useful for those
> > cases where you subdivide the resource again.
> > 
> > As for the bridge case I think that is something different.  
> 
> The pragmatist in me says we can handle them all as a single case. 
> Simply put, it means insert_resource() says "I know this belongs in the
> resource tree, just put it in where it should go, please".  As long as
> we make sure we only use it for the exception cases, it should all work
> fine.
> 
> All I really want is to get the alter 4 and 8 way boxes working again,
> I'm happy to go with whatever people decide about resources.  What other
> uses are there for the TENTATIVE regions?

The case I care about is BIOS ROMS.  That case is fun because frequently
the reserved region is smaller than region the ROM sits in.  But it
really comes down to trusting the BIOS.  And anytime we trust the BIOS
to do the right thing some BIOS will do it wrong.  So when we have a
conflict and we know we are right I would much rather throw away what
the BIOS has told me.

If we are somehow scanning the busses and stop and oh wait there is a
bridge above everything that I had not noticed before.  And in a root
complex (the pci express term) where the resources are non standard, I
can really see this happening.  I know on Opteron systems we currently
omit the resources on the cpu/HT chain.  That is what I think
insert_resource was designed for.

And there was another case a few days ago where someone was having
similar BIOS problems with the AGP GART window.


Eric
