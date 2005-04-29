Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVD2Fg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVD2Fg5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVD2Fg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:36:56 -0400
Received: from lixom.net ([66.141.50.11]:54675 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S262387AbVD2FgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:36:10 -0400
Date: Fri, 29 Apr 2005 00:36:15 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/4] ppc64: Add driver for BPA iommu
Message-ID: <20050429053615.GA30219@lixom.net>
References: <200504190318.32556.arnd@arndb.de> <200504280813.j3S8DNLc019256@post.webmailer.de> <20050428140558.GB1023@austin.ibm.com> <200504290635.44965.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504290635.44965.arnd@arndb.de>
User-Agent: Mutt/1.5.6+20040907i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 06:35:43AM +0200, Arnd Bergmann wrote:
> On Dunnersdag 28 April 2005 16:05, Olof Johansson wrote:
> 
> > On Thu, Apr 28, 2005 at 09:59:26AM +0200, Arnd Bergmann wrote:
> > > +/* some constants */
> > > +enum {
> > > +	/* segment table entries */
> > [...]
> > > +};
> > 
> > Hmm. I thought the benefit of enum was to be able to do type checking
> > later on if it's a typed enum. Here you mix different definitions in
> > the same large untyped enum declaration. Can they be moved to a
> > bpa_iommu.h file and #defined instead?
> 
> I prefer to avoid macros altogether, and this is one of the ways to
> do it. We have had the discussion about how to define constants
> a few times before on lkml without reaching a conclusion.

Most of arch/ppc64/* uses #defines, for whatever that's worth. Still,
CodingStyle seems to recommend enums for "related constants", I assume
it's so they can be typed. I don't care enough either way to argue
it further.

Anyhow, enum or #define, it should be moved to bpa_iommu.h.

> > Why do we need to detect this at link time?
> 
> I want to avoid doing BUG() or something similar, so I
> try to detect a user error as early as possible.

User or developer error? I thought it was a developer one, and a quite
specialized one at that. Either way, there's already a primitive that
can be used instead of making your own: BUILD_BUG_ON().

> > > +	nnpt++; /* XXX is this right? */
> > 
> > Well, does it work?  :-)
> 
> Yes, but it seems to contradict the specs...

A comment to that effect could be nice.

> > > +static inline unsigned long
> > > +get_ioptep(ioste iost_entry, unsigned long io_address)
> > > +{
> > > +	unsigned long iopt_base;
> > > +	unsigned long ps;
> > > +	unsigned long iopt_offset;
> > > +
> > > +	iopt_base = iost_entry.val & IOST_PT_BASE_MASK;
> > > +	ps        = iost_entry.val & IOST_PS_MASK;
> > > +
> > > +	iopt_offset = ((io_address & 0x0fffffff) >> (7 + 2 * ps)) & 0x7fff8ul;
> > 
> > Magic. Can we get it explained either by defines instead of constants
> > or by a comment?
> 
> This comes from a graphical representation in the specs. I'll add a comment
> to point to that image.

I guess it'd be a bit much information to just add in a comment, but for
readability that's probably the best way to go.  Not many people have
the specs, but on the other hand if you're messing around with this code
then chances are you have them.

I don't know what the status is for a release of public specifications,
but if they're not available then people will be looking to learn from
the implementation and the documentation around it instead.


-Olof
