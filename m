Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSHZPZf>; Mon, 26 Aug 2002 11:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSHZPZf>; Mon, 26 Aug 2002 11:25:35 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:36241 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S315370AbSHZPZe>; Mon, 26 Aug 2002 11:25:34 -0400
Message-ID: <20020826152950.9929.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Mon, 26 Aug 2002 17:29:50 +0200
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <3D6989F7.9ED1948A@zip.com.au> <20020826091038.25100.qmail@thales.mathematik.uni-ulm.de> <E17jKlX-0001i0-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17jKlX-0001i0-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 04:22:50PM +0200, Daniel Phillips wrote:
> On Monday 26 August 2002 11:10, Christian Ehrhardt wrote:
> > + * A special Problem is the lru lists. Presence on one of these lists
> > + * does not increase the page count.
> 
> Please remind me... why should it not?

Pages that are only on the lru but not reference by anyone are of no
use and we want to free them immediatly. If we leave them on the lru
list with a page count of 1, someone else will have to walk the lru
list and remove pages that are only on the lru. One could argue that
try_to_free_pages could do this but try_to_free_pages will process the
pages in lru order and push out other pages first.
The next suggestion that comes to mind is: Let's have some magic in
page_cache_release that will remove the page from the lru list if
it is actually dead. However, this raises the question: How do we detect
that a page is now dead? The answer is something along the lines of

	if (put_page_testzero ()) {
		__free_pages_ok (page);
		return
	}
	spin_lock_irq(pagemap_lru_lock);
	if (PageLRU(page) && (page_count(page) == 1)) {
		lru_cache_del (page);
		spin_unlock_irq(pagemap_lru_lock);
		page_cache_release (page);
		return;
	}
	spin_unlock_irq(pagemap_lru_lock);
	return;

The sad truth is, that this solution has all the same races that
we have now, plus it makes the fast path (decreasing page count
to something not zero) slower. One problem in the above would be
that the last reference might as well not be due the the lru
cache, i.e at the time we call PageLRU(page) the page might
have been freed by another processor.

I know the idea is appealing (see one of my earlier Mails on the
subject ;-) ) but it doesn't solve the Problem.

      regards   Christian Ehrhardt

-- 
THAT'S ALL FOLKS!
