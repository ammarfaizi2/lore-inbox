Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUDHDMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 23:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUDHDMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 23:12:25 -0400
Received: from ozlabs.org ([203.10.76.45]:7912 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261472AbUDHDMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 23:12:23 -0400
Date: Thu, 8 Apr 2004 13:09:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, ak@suse.de,
       linux-kernel@vger.kernel.org, anton@samba.org, paulus@samba.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-ID: <20040408030923.GA29551@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, ak@suse.de,
	linux-kernel@vger.kernel.org, anton@samba.org, paulus@samba.org,
	linuxppc64-dev@lists.linuxppc.org
References: <20040407074239.GG18264@zax> <20040407143447.4d8f08af.ak@suse.de> <1081386710.1401.86.camel@gaston> <20040407190126.06a9c38f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407190126.06a9c38f.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 07:01:26PM -0700, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > 
> > > Implementing this for ppc64 only is just wrong. Before you do this 
> > > I would suggest to factor out the common code in the various hugetlbpage
> > > implementations and then implement it in common code.
> > 
> > Have you actually looked at it and how huge pages are implemented
> > on the various architectures ?
> > 
> > Honestly, I don't think we have any common abstraction on things
> > like hugepte's etc... actually, archs aren't even required to use
> > PTEs at all.
> > 
> > I don't see how we can make that code arch-neutral, at least not
> > without a major redesign of the whole large pages mecanism.
> 
> I don't see much in the COW code which is ppc64-specific.  All the hardware
> needs to do is to provide a way to make the big pages readonly.  With a bit
> of an abstraction for the TLB manipulation in there it should be pretty
> straightforward.
> 
> Certainly worth the attempt, no?

Yes, you have a point.  However doing it in a cross-arch way will
require building more of a shared abstraction about hugepage pte
entries that exists currently.  And that will mean making significant
changes to all the archs to create that abstraction.  I don't know
enough about the other archs to be confident of debugging such
changes, but I'll see what I can do.

That should let the actual handle_mm_fault->hugepage_cow codepath be
shared.  However how the hugepage ptes fit in with the rest of the
pagetables varies from arch to arch - on ppc64 we're considering
putting hugepages into their own entirely separate pagetables, even -
so anything that actually walks the pagetables (like
copy_hugetlb_page_range()) will still have to be arch-specific.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
