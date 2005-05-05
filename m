Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVEEB5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVEEB5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 21:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEEB5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 21:57:06 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:37803 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S261782AbVEEB5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 21:57:02 -0400
Date: Wed, 4 May 2005 18:57:00 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Rik van Riel <riel@redhat.com>
Cc: William Jordan <bjordan.ics@gmail.com>,
       Caitlin Bestler <caitlin.bestler@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, hch@infradead.org,
       Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050505015700.GA5205@hexapodia.org>
References: <469958e00504291731eb8287c@mail.gmail.com> <20050503184325.GA19351@hexapodia.org> <78d18e2050504112240e43a08@mail.gmail.com> <Pine.LNX.4.61.0505042123410.18390@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505042123410.18390@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 09:27:21PM -0400, Rik van Riel wrote:
> On Wed, 4 May 2005, William Jordan wrote:
> > On 5/3/05, Andy Isaacson <adi@hexapodia.org> wrote:
> > > Rather than replacing the fully-registered pages with pages of zeros,
> > > you could simply unmap them.
> > 
> > I don't like this option. It is nearly free to map all of the pages to
> > the zero-page. You never have to allocate a page if the user never
> > writes to it.
> 
> Unmapping should work fine, as long as the VMA flags are
> set appropriately.  The page fault handler can take care
> of the rest...

I think there may be a difference in terminology here.  What I
originally proposed (and what I think Bill was reacting to) is the
equivalent of sys_munmap() on the range of registered pages.  That has
the downsides that he mentioned; an address that was valid in the parent
will now result in SIGSEGV or SIGBUS in the child, and it's explicitly
endorsed by the userland APIs (such as MPI2) that it's valid to register
stack addresses (for example).

What I think you're proposing, Rik, is that VMA get destroyed (or split,
if only part of it had been registered) and replaced with an anonymous
one.  That's a very low-overhead way of going about it, I think.  Then
as you say, the page fault handler will automatically give a zero page
to the process when it faults on those addresses.

Did I understand your suggestion correctly?  I think I agree with
Bill that having the child fault on pages which happened to have been
registered by the parent would be a bad thing.

This would, if I understand correctly, be visible in /proc/$$/maps.
Which is OK, if a little bit suprising; but the alternatives are worse.

-andy
