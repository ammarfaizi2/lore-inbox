Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbULJQNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbULJQNM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbULJQCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:02:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261751AbULJPqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:46:17 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20041209141718.6acec9ee.akpm@osdl.org>
References: <20041209141718.6acec9ee.akpm@osdl.org>  <7ad0b24c-4955-11d9-8e19-0002b3163499@redhat.com> <200412082012.iB8KCTBK010123@warthog.cambridge.redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@snapgear.com, gerg%snapgear.com.wli@holomorphy.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 2/5] NOMMU: High-order page management overhaul
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Fri, 10 Dec 2004 15:45:53 +0000
Message-ID: <30544.1102693553@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > The attached patch overhauls high-order page handling.
>
> This patch (which is actually twelve patches)

How did you work that one out? Just because there're twelve points in my list
doesn't mean the patch can be split twelve ways. If you really want it
dissociating into sub-patches, I'm sure I can do that, but not all the
intermediate stages would be compilable and testable.

> seems to be taking out old code and replacing it with new code for no
> apparent reason.

 (1) I've been moaned at by a lot of people for:

     (a) #ifdefs in page_alloc.c... This gets rid of some of them, even if I
       	 didn't add them.

     (b) The way page_alloc.c was handling page refcounting differently under
     	 nommu conditions. All I did was to fix it, but it seems it's my
     	 fault:-/ This fixes it to use compound pages "as [I] should've done
     	 in the first place".

 (2) Splitting high-order pages has to be done differently on MMU vs
     NOMMU. Part of this makes it simpler by providing convenience functions
     for the job.

 (3) More robust nommu high-order page handling. I'm wary of the current way
     the individual secondary pages of a high-order page are handled in nomuu
     conditions. I can see ways it can go wrong all too easily (the existence
     of the whole thing is contingent on the count on the first page, but
     pinning the secondary pages doesn't affect that).

 (4) Making it easier to debug problems with compound pages (bad_page
     changes).

 (5) Abstraction of some compound page related functions, including a way to
     make it more efficient to access the first page (PG_compound_slave).

> I mean, what is the *objective* of doing all of this stuff?  What problems
> does it cause if the patch is simply dropped???

Objectives? Well:

 (1) More robust high-order page handling in nommu conditions.

 (2) Use compound pages to achieve (1) as per the numerous suggestions.

 (3) Remove #ifdefs as per the numerous suggestions.

I think the drivers need a good auditing too. A lot of them allocate
high-order pages for various uses, some for use as single units, and some for
use as arrays of pages.

David
