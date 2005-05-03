Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVECSnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVECSnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVECSnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:43:35 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:45829 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S261568AbVECSn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:43:26 -0400
Date: Tue, 3 May 2005 11:43:25 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Caitlin Bestler <caitlin.bestler@gmail.com>
Cc: Libor Michalek <libor@topspin.com>, Bill Jordan <woodennickel@gmail.com>,
       Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050503184325.GA19351@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469958e00504291731eb8287c@mail.gmail.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 05:31:44PM -0700, Caitlin Bestler wrote:
> Attempting to provide *any* support for applications that fork children
> after doing RDMA registrations is a ratshole best avoided. The general
> rule that application developers should follow is to do RDMA *only*
> in the child processes.

I think it's unreasonable to *prohibit* fork-after-registration; for one
thing, there's lots of code that forks under the covers.  Setuid helpers
like getpty just assume that they're going to be able to fork.  Even
stuff like get*by*(3) can potentially fork.  And with site-configured
stuff like PAM, you end up with things that work on the developer's
system but break in deployment.

I think it's exceedingly reasonable to say "RDMA doesn't work in
children".  But the child should get a sane memory image:  at least
zeros in fully-registered pages, and preferably copies of
partially-registered pages.  Differentiating between fully-registered
and partially-registered pages avoids (I think) the pathological case of
having to copy a GB of data just to system("/bin/ls > /tmp/tmpfile").
You can still go pathological if you've partially-registered gigabytes
of address space (for example a linked list where each node is allocated
with malloc and then registered) but that's a case of "Well, don't do
that then".

Rather than replacing the fully-registered pages with pages of zeros,
you could simply unmap them.

A consistent statement would be

    After fork(2), any regions which were registered are UNDEFINED.
    Region boundaries are byte-accurate; a registration can cover just
    part of a page, in which case the non-registered part of the page
    has normal fork COW semantics.

Probably the most sane solution is to simply unmap the fully-registered
pages at fork time, and copy any partially-registered pages.  But the
statement above does not require this.

> Keep in mind that it is not only the memory regions that must be dealt
> with, but control data invisible to the user (the QP context, etc.). This
> data frequently is interlinked between kernel residente and user resident
> data (such as a QP context has the PD ID somewhere on-chip or in
> kernel, which the Send Queue ring needs to be in user memory). Having
> two different user processes that both think they have the user half to
> this type of split data structure is just asking for trouble, even if you 
> manage to get the copy on write bit timing problems all solved.

Obviously, calling *any* RDMA-userland-stuff in the child is completely
undefined [1].  One place where I can see a potential problem is in
atexit()-type handlers registered by the RDMA library.  Since those
aren't performance-critical they can and should do sanity checks with
getpid() and/or checking with the kernel driver.

[1] You might want to allow the child to start a completely new RDMA
    context, but I don't see that as necessary.

-andy
