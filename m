Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314285AbSEBIzd>; Thu, 2 May 2002 04:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314287AbSEBIzc>; Thu, 2 May 2002 04:55:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:26005 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314285AbSEBIza>;
	Thu, 2 May 2002 04:55:30 -0400
Date: Thu, 2 May 2002 14:24:41 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        marcelo@brutus.conectiva.com.br, linux-mm@kvack.org
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order allocs
Message-ID: <20020502142441.A1668@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020429202446.A2326@in.ibm.com> <m1r8ky1jzu.fsf@frodo.biederman.org> <20020430110108.A1275@in.ibm.com> <3CCEF4CC.C56E31B8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 12:47:24PM -0700, Andrew Morton wrote:
> Suparna Bhattacharya wrote:
> > 
> > ...
> > > It might make sense to add a PG_large flag and
> > > then in the immediately following struct page add a pointer to the next
> > > page, so you can identify these pages by inspection.  Doing something
> > > similar to the PG_skip flag.
> > 
> > Maybe different solutions could emerge for this in 2.4 and 2.5.
> > 
> > Even a PG_partial flag for the partial pages will enable us to
> > traverse back to the main page, and vice-versa to determine the
> > partial pages covered by the main page, without any additional
> > pointers. Is that an acceptable option for 2.4 ? (That's one
> > more page flag ...)
> > 
> 
> I'd suggest that you go with the PG_partial thing for the
> follow-on pages.
> 
> If you have a patch for crashdumps, and that patch is
> included in the main kernel, and it happens to rely on the
> addition of a new page flag well gee, that's a tiny change.
> 
> Plus it only affects code paths in the `order > 0' case,
> which are rare.
> 
> Plus you can independently use PG_partial to detect when
> someone is freeing pages from the wrong part of a higher-order
> allocation - that's a feature ;)

I guess the current check for page count during free should catch
this too in general. Possibly PG_partial would be more reliable 
because the page count is more susceptible to modification as it
is touched more often ... 

> 
> An alternative is to just set PG_inuse against _all_ pages
> in rmqueue(), and clear PG_inuse against all pages in
> __free_pages_ok().  Which seems cleaner, and would fix other
> problems, I suspect.

This works well for us. If no one minds the extra flag, and it
is preferable to the option of initializing page count for 
higher order pages, we'll go ahead and do this.
 
BTW, with PG_inuse, we can detect higher order pages too - ones
which are in use, but have a zero page count, i.e. PG_inuse +
zero page count == equivalent to == PG_partial. So it is possible
to locate the main page (or initial page) of the higher order
area, just as with PG_partial.

Likewise, with PG_partial, since this would be set and cleared
during alloc/free, we can figure out if a page is in use by
checking if page count is non-zero or this is a partial page,
i.e. PG_Partial | page_count > 0 == equivalent to == PG_inuse.

We can take any one way and define appropriate macros to
get both effects.

Regards
Suparna

> 
> -
