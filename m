Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318519AbSHUR0s>; Wed, 21 Aug 2002 13:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318529AbSHUR0r>; Wed, 21 Aug 2002 13:26:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60689 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318519AbSHUR0r>;
	Wed, 21 Aug 2002 13:26:47 -0400
Message-ID: <3D63D0DC.271B6130@zip.com.au>
Date: Wed, 21 Aug 2002 10:41:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Thomas Molina <tmolina@cox.net>
Subject: Re: Race in pagevec code
References: <20020821154535.11432.qmail@thales.mathematik.uni-ulm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ehrhardt wrote:
> 
> ...
>       Both processors succeeded in bringing the page_count to zero,
>       i.e. both processors will add the page to their own
>       pages_to_free_list.

This is why __pagevec_release() has the refcount check inside the lock.
If someone else grabbed a ref to the page (also inside the lock) via
the LRU, __pagevec_release doesn't free it.

So the rule could be stated as: the page gets freed when there are
no references to it, presence on the LRU counts as a reference,
serialisation is via pagemap_lru_lock.
 
> ..
> 
> I don't have a fix but I think the only real solution is to
> increment the page count if a page is on a lru list. After all
> this is a reference to the page.

One would think so, but that doesn't really change anything.

I agree the locking and reffing in there is really nasty.  It 
doesn't help that I put four, repeat four bugs in the 20-line
__page_cache_release().  __pagevec_release() is, I think, OK.

It would be much simpler to grab the lock each time
page_cache_release() is executed, but our performance targets
for 2.5 preclude that.

The page->pte.chain != NULL problems predate the locking changes.
We haven't found that one yet.
