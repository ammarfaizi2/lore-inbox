Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbULJVCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbULJVCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbULJVCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:02:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:57243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261173AbULJVCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:02:07 -0500
Date: Fri, 10 Dec 2004 13:01:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: davidm@snapgear.com, gerg%snapgear.com.wli@holomorphy.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 2/5] NOMMU: High-order page management overhaul
Message-Id: <20041210130137.432edacb.akpm@osdl.org>
In-Reply-To: <30544.1102693553@redhat.com>
References: <20041209141718.6acec9ee.akpm@osdl.org>
	<7ad0b24c-4955-11d9-8e19-0002b3163499@redhat.com>
	<200412082012.iB8KCTBK010123@warthog.cambridge.redhat.com>
	<30544.1102693553@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > The attached patch overhauls high-order page handling.
> >
> > This patch (which is actually twelve patches)
> 
> How did you work that one out? Just because there're twelve points in my list
> doesn't mean the patch can be split twelve ways. If you really want it
> dissociating into sub-patches, I'm sure I can do that, but not all the
> intermediate stages would be compilable and testable.

Of course, splitting the work into one-concept-per-patch would be a big help.

> > seems to be taking out old code and replacing it with new code for no
> > apparent reason.
> 
>  (1) I've been moaned at by a lot of people for:
> 
>      (a) #ifdefs in page_alloc.c... This gets rid of some of them, even if I
>        	 didn't add them.
> 
>      (b) The way page_alloc.c was handling page refcounting differently under
>      	 nommu conditions. All I did was to fix it, but it seems it's my
>      	 fault:-/ This fixes it to use compound pages "as [I] should've done
>      	 in the first place".

I think I was the original "use compound pages" culprit.  But when I
realised that nommu needs access to fields in the sub-pages which are
currently used for compound page metadata I withdrew into the "if what's
there now works, stick with it" camp.

>  (2) Splitting high-order pages has to be done differently on MMU vs
>      NOMMU.

Oh.  Why?

> Part of this makes it simpler by providing convenience functions
>      for the job.
> 
>  (3) More robust nommu high-order page handling. I'm wary of the current way
>      the individual secondary pages of a high-order page are handled in nomuu
>      conditions. I can see ways it can go wrong all too easily (the existence
>      of the whole thing is contingent on the count on the first page, but
>      pinning the secondary pages doesn't affect that).

The current code (which pins each subpage individually) seems robust
enough.  I assume that nommu will thenceforth simply treat the region as an
array of zero-order pages.

>  (4) Making it easier to debug problems with compound pages (bad_page
>      changes).
> 
>  (5) Abstraction of some compound page related functions, including a way to
>      make it more efficient to access the first page (PG_compound_slave).

If there is any way at all in which we can avoid consuming another page
flag then we should do so.  There are various concepts (many zones,
advanced page aging algorithms) which would be unfeasible if there are not
several more bits available in ->flags.   And they continue to dribble away.

> > I mean, what is the *objective* of doing all of this stuff?  What problems
> > does it cause if the patch is simply dropped???
> 
> Objectives? Well:
> 
>  (1) More robust high-order page handling in nommu conditions.
> 
>  (2) Use compound pages to achieve (1) as per the numerous suggestions.
> 
>  (3) Remove #ifdefs as per the numerous suggestions.

But there's nothing actually *essential* here, is there?  No bugs are
fixed?

> I think the drivers need a good auditing too. A lot of them allocate
> high-order pages for various uses, some for use as single units, and some for
> use as arrays of pages.

I think an ARM driver is freeing zero-order pages within a higher-order
page.  But as long as the driver didn't set __GFP_COMP then the higher
order page is not compound, and that splitting treatment is appropriate.

