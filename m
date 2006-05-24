Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbWEXMho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWEXMho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 08:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWEXMho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 08:37:44 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:36265 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932729AbWEXMhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 08:37:43 -0400
Message-ID: <348474258.29290@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 24 May 2006 20:37:40 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/33] readahead: page flag PG_readahead
Message-ID: <20060524123740.GA16304@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <20060524111858.869793445@localhost.localdomain> <1148473656.10561.46.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148473656.10561.46.camel@lappy>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 02:27:36PM +0200, Peter Zijlstra wrote:
> On Wed, 2006-05-24 at 19:12 +0800, Wu Fengguang wrote:
> > plain text document attachment
> > (readahead-page-flag-PG_readahead.patch)
> > An new page flag PG_readahead is introduced as a look-ahead mark, which
> > reminds the caller to give the adaptive read-ahead logic a chance to do
> > read-ahead ahead of time for I/O pipelining.
> > 
> > It roughly corresponds to `ahead_start' of the stock read-ahead logic.
> > 
> > Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
> > ---
> > 
> >  include/linux/page-flags.h |    5 +++++
> >  mm/page_alloc.c            |    2 +-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > --- linux-2.6.17-rc4-mm3.orig/include/linux/page-flags.h
> > +++ linux-2.6.17-rc4-mm3/include/linux/page-flags.h
> > @@ -89,6 +89,7 @@
> >  #define PG_reclaim		17	/* To be reclaimed asap */
> >  #define PG_nosave_free		18	/* Free, should not be written */
> >  #define PG_buddy		19	/* Page is free, on buddy lists */
> > +#define PG_readahead		20	/* Reminder to do readahead */
> >  
> 
> Page flags are gouped by four, 20 would start a new set.
> Also in my tree (git from a few days ago), 20 is taken by PG_unchached.

Thanks, grouped and renumbered it as 21.

> What code is this patch-set against?

It's against the latest -mm tree: linux-2.6.17-rc4-mm3.

Wu
---

Subject: readahead: page flag PG_readahead

An new page flag PG_readahead is introduced as a look-ahead mark, which
reminds the caller to give the adaptive read-ahead logic a chance to do
read-ahead ahead of time for I/O pipelining.

It roughly corresponds to `ahead_start' of the stock read-ahead logic.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---
 include/linux/page-flags.h |    5 +++++
 mm/page_alloc.c            |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/page-flags.h
+++ linux-2.6.17-rc4-mm3/include/linux/page-flags.h
@@ -90,6 +90,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
+#define PG_readahead		21	/* Reminder to do readahead */
+
 
 #if (BITS_PER_LONG > 32)
 /*
@@ -372,6 +374,10 @@ extern void __mod_page_state_offset(unsi
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define __SetPageReadahead(page) __set_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
--- linux-2.6.17-rc4-mm3.orig/mm/page_alloc.c
+++ linux-2.6.17-rc4-mm3/mm/page_alloc.c
@@ -564,7 +564,7 @@ static int prep_new_page(struct page *pa
 	if (PageReserved(page))
 		return 1;
 
-	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
+	page->flags &= ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_readahead |
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
