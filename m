Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVALWrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVALWrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVALWrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:47:31 -0500
Received: from fmr14.intel.com ([192.55.52.68]:36298 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261545AbVALWqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:46:17 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] Avoiding fragmentation through different allocator
Date: Wed, 12 Jan 2005 14:45:44 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB008C77C45@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Avoiding fragmentation through different allocator
Thread-Index: AcT46zICQ/iuC/zNRy+oGacQwELb+QABGpjg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Mel Gorman" <mel@csn.ul.ie>,
       "Linux Memory Management List" <linux-mm@kvack.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Jan 2005 22:45:51.0595 (UTC) FILETIME=[77A2C3B0:01C4F8F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel!

>Instead of having one global MAX_ORDER-sized array of free 
>lists, there are
>three, one for each type of allocation. Finally, there is a 
>list of pages of
>size 2^MAX_ORDER which is a global pool of the largest pages 
>the kernel deals with.

I've got a patch that I've been testing recently for memory
hotplug that does nearly the exact same thing - break up the 
management of page allocations based on type - after having
had a number of conversations with Dave Hansen on this topic.  
I've also prototyped this to use as an alternative to adding
duplicate zones for delineating between memory that may be
removed and memory that is not likely to ever be removable.  I've
only tested in the context of memory hotplug, but it does
greatly simplify memory removal within individual zones.   Your
distinction between areas is pretty cool considering I've only 
distinguished at the coarser granularity of user vs. kernel 
to date.  It would be interesting to throw KernelNonReclaimable 
into the mix as well although I haven't gotten there yet...  ;-)

>Once a 2^MAX_ORDER block of pages it split for a type of 
>allocation, it is
>added to the free-lists for that type, in effect reserving it. 
>Hence, over
>time, pages of the related types can be clustered together. This means
>that if we wanted 2^MAX_ORDER number of pages, we could linearly scan a
>block of pages allocated for UserReclaimable and page each of them out.

Interesting.  I took a slightly different approach due to some
known delineations between areas that are defined to be non-
removable vs. areas that may be removed at some point.  Thus I'm
only managing two distinct free_area lists currently.  I'm curious
as to the motivation for having a global MAX_ORDER size list that
is allocation agnostic initially...is it so that the pages can
evolve according to system demands (assuming MAX_ORDER sized 
chunks are eventually available again)?

It looks like you left the per_cpu_pages as-is.  Did you
consider separating those as well to reflect kernel vs. user
pools?

>-	struct free_area	free_area[MAX_ORDER];
>+	struct free_area	free_area_lists[ALLOC_TYPES][MAX_ORDER];
>+	struct free_area	free_area_global;
>+
>+	/*
>+	 * This map tracks what each 2^MAX_ORDER sized block 
>has been used for.
>+	 * When a page is freed, it's index within this bitmap 
>is calculated
>+	 * using (address >> MAX_ORDER) * 2 . This means that pages will
>+	 * always be freed into the correct list in free_area_lists
>+	 */
>+	unsigned long		*free_area_usemap;

So, the current user/kernelreclaim/kernelnonreclaim determination
is based on this bitmap.  Couldn't this be managed in individual
struct pages instead, kind of like the buddy bitmap patches?  

I'm trying to figure out one last bug when I remove memory (via
nonlinear sections) that has been dedicated to user allocations.  
After which perhaps I'll post it as well, although it is *very*
similar.  However it does demonstrate the utility of this approach
for memory hotplug - specifically memory removal - without the 
complexity of adding more zones.  

matt
