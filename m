Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbRGYIi6>; Wed, 25 Jul 2001 04:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266698AbRGYIit>; Wed, 25 Jul 2001 04:38:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20783 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266682AbRGYIik>; Wed, 25 Jul 2001 04:38:40 -0400
To: landley@webofficenow.com
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva>
	<01072501092707.00520@starship>
	<01072415352102.00631@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jul 2001 02:32:14 -0600
In-Reply-To: <01072415352102.00631@localhost.localdomain>
Message-ID: <m1vgkhh0j5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rob Landley <landley@webofficenow.com> writes:

> Stupid question time:
> 
> So basically (lemme get this straight):
> 
> All VM allocation in 2.4 has become some variant of mmap.  Either we're 
> mmaping in the executable and libraries when we exec, we're mmaping in a 
> file, or we're mmaping in the swap file/block device which is how we do 
> anonymous page allocations.

You are getting warm.  In 2.4 most caching is moving exclusively to
the page cache.  Page cache write support was added between 2.2 and
2.4 allowing things to stop using the block cache.  However everything
you are mentioning used the page cache in 2.2.  The page cache is
superior to the block cache as it caches the data we want to use not
some intermediate form of it.

Having one general purpose cache layer, increases the reliability
of the system, as we only have to have that layer debugged to know
everything is working.  It is by know means the entire VM but it is
the majority and it is where we most pages that can be freed on demand
so the page cache receives most of the attention.

> And this is why 2.4 keeps wanting to allocate swap space for pages that are 
> still in core.  And why the 2.4 VM keeps going ballistic on boxes that have 
> more physical DRAM than they have swap space.  (I.E. the 2X swap actually 
> being NECESSARY now, and 256 megs of "overflow" swap files for a 2 gig ram 
> box actually hurting matters by confusing the VM if swap is enabled AT ALL, 
> since it clashes conceptually.)

Nope.  There are several canidates for this but none of the is simply
using the page cache.

The description, and characterization of the 2.4 VM with respect to
swapping is wrong.  I have seen to much overgeneralization on this
topic already, and refuse to treat it in the abstract.  If you have a
reproducible problem case report it specifically. 

The biggest 2.4 swapping bug was failure free pages in the swap cache
that were not connected to any process.  This should now be fixed.

The biggest issue is that the 2.4 VM has been heavily modified since
2.2 and the bugs are still being worked out.  If you have a an
application that needs noticeably more swap than 2.2 did report it as
a bug.  Any other treatment at this point would be over confidence in
the correctness of the VM in corner cases.

> So getting swap to exclude in-core pages (so they don't take up space in the 
> swap file) would therefore be conceptually similar to implementing "files 
> with holes in them" support like EXT2 has for these swap file mmaps.

Not really.  There are some similiarities.
 
> And the argument that doing so might "fragment the swap file", while true, is 
> actually a bit of a red herriing because the real objection is that it 
> unnecessarily complicates an otherwise clean and straightforward concept.

Fragmenting the swap file is a read herring.  

I have seen no real objections, just no real code.  The thing to watch
out for is that you need to make certain that you actually have the
resources to swap a file out to.  Consider having a swapfile on tmpfs.
Having a deadlock in the swapping code would be bad.

> Am I even close here?  (That was the stupid question I mentioned earlier, 
> knew I'd get around to it...)  Reading the code's a bit harder when you don't 
> have any sort of conceptual understanding of what the heck it's actually 
> trying to do.

See my earlier answers for closenes.
 
> I don't suppose we could get some variant of your initial post into 
> /Documentation/vm/HowItActuallyWorks.txt?  (I take it the biggest "detail" 
> you glossed over was the seperation of memory into zones?)

Becareful here, what is maintainable is a concepts behind how it
works.  The page cache, multpile memory zones, etc.

You have the code for a detailed how it works document, and it is
continually changing.  The driving forces, tools, and ideas behind
what is happening should be static enough to document however.

Eric
