Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSECMYu>; Fri, 3 May 2002 08:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSECMYt>; Fri, 3 May 2002 08:24:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11461 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310435AbSECMYt>; Fri, 3 May 2002 08:24:49 -0400
Date: Fri, 3 May 2002 17:54:38 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, marcelo@brutus.conectiva.com.br,
        linux-mm@kvack.org
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order allocs
Message-ID: <20020503175438.A1816@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020502142441.A1668@in.ibm.com> <Pine.LNX.4.21.0205021312370.999-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 02:08:50PM +0100, Hugh Dickins wrote:
> On Thu, 2 May 2002, Suparna Bhattacharya wrote:
> [ discussion of PG_inuse / PG_partial / PG_large snipped ]
> 
> Any of those can handle that job (distinguishing non0orders),
> but I do believe you want a further PG_ flag for crash dumps.
> 
> The pages allocated GFP_HIGHUSER are about as uninteresting
> as the free pages: the cases where they're interesting (for
> analyzing a kernel crash, as opposed to snooping on a crashed
> customer's personal data!) are _very_ rare, but the waste of
> space and time putting them in a crash dump is very often
> abominable, and of course worse on larger machines.

Well, we are working on various options to be able to dump
pages selectively, and PG_inuse is by no means the only check.
For example we have an option that tries to exclude non-kernel
pages from the dump based on a simple heuristic of checking the
PG_lru flag (actually exclude LRU pages and unreferenced pages). 
This works for vmalloc'ed pages too.

> 
> As someone else noted in this thread, the kernel tries to keep
> pages in use anyway, so omitting free pages won't buy you a great
> deal on its own.  And I think it's to omit free pages that you want

True, it is only when a system is very lightly loaded (plus not 
running for long) and has lots of memory that we'd expect 
many free pages. Maybe that not a very typical situation in a 
realistic workload, but one can envision further checks that may 
be helpful. At least in a low load situation we don't want to 
confuse free pages with kernel pages (in the example I discussed 
above).

> to distinguish the count 0 continuations from the count 0 frees?
> 
> PG_highuser? PG_data?  Or inverses: PG_internal? PG_dumpable?
> I think not PG_highuser, because it's too specific to what just
> happens to be the best, but inadequate, test I've found so far.

I wouldn't want this kind of a flag to be specific to dump, but 
am really looking at little things that help a with generic page 
classification scheme that also addresses the needs for dump.
We would like dump to make its decisions based on a configured
requirement e.g depending on the dump level, and adapt or tune
our heuristics without changing the rest of the kernel.

The flags should just indicate the nature of the page - it's up to
dump or any other kind of analyser to decide whether to pick it 
up or not. For different kind of situations and problems one
might need more or less memory to be dumped, also possibly
depending on availability of space.

If ever we introduce anything specifically for dump, it could be
a PG_dumped indicator to help avoid dumping already dumped pages
in a multi-pass selection scheme, but that's something for later
... 

> 
> A first guess is that pages allocated with __GFP_HIGHMEM can be
> omitted from a dump, but that works out wrong on vmalloced space
> and on highmem pagetables, both of which are important in a dump.
> GFP_HIGHUSER test dumps vmalloced pages, and both Andrea's 2.4 or
> Ingo's 2.5 highmem pagetables.  But (notably in reboot after crash:
> dump copied from swap) memory can be full of GFP_USER blockdev pages.
> 
> Hugh
