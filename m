Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWIHSee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWIHSee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWIHSee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:34:34 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:51322 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751157AbWIHSed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:34:33 -0400
Date: Fri, 8 Sep 2006 20:33:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/2] own header file for struct page.
Message-ID: <20060908183340.GA8421@osiris.ibm.com>
References: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com> <20060908094616.48849a7a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908094616.48849a7a.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This moves the definition of struct page from mm.h to its own header file
> > page.h.
> > This is a prereq to fix SetPageUptodate which is broken on s390:
> > 
> > #define SetPageUptodate(_page)
> >        do {
> >                struct page *__page = (_page);
> >                if (!test_and_set_bit(PG_uptodate, &__page->flags))
> >                        page_test_and_clear_dirty(_page);
> >        } while (0)
> > 
> > _page gets used twice in this macro which can cause subtle bugs. Using
> > __page for the page_test_and_clear_dirty call doesn't work since it
> > causes yet another problem with the page_test_and_clear_dirty macro as
> > well.
> > In order to get of all these problems caused by macros it seems to
> > be a good idea to get rid of them and convert them to static inline
> > functions. Because of header file include order it's necessary to have a
> > seperate header file for the struct page definition.
> > 
> 
> hmm.
> 
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6/include/linux/page.h	2006-09-08 13:10:23.000000000 +0200
> 
> We have asm/page.h, and one would expect that a <linux/page.h> would be
> related to <asm/page.h> in the usual fashion.  But it isn't.
> 
> Can we think of a different filename? page-struct.h, maybe? pageframe.h?

Yes, of course.

> > +#ifndef CONFIG_DISCONTIGMEM
> > +/* The array of struct pages - for discontigmem use pgdat->lmem_map */
> > +extern struct page *mem_map;
> > +#endif
> 
> Am surprised to see this declaration in this file.

Hmm... first I thought I could add the same declaration to asm-s390/pgtable.h.
But then deciced against it, since I would just duplicate code.
Any better idea where to put it?
