Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSHZSMi>; Mon, 26 Aug 2002 14:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318219AbSHZSMi>; Mon, 26 Aug 2002 14:12:38 -0400
Received: from dsl-213-023-020-192.arcor-ip.net ([213.23.20.192]:10938 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318218AbSHZSMg>;
	Mon, 26 Aug 2002 14:12:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: MM patches against 2.5.31
Date: Mon, 26 Aug 2002 19:56:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <E17jKlX-0001i0-00@starship> <20020826152950.9929.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020826152950.9929.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jO6g-0002XU-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 August 2002 17:29, Christian Ehrhardt wrote:
> On Mon, Aug 26, 2002 at 04:22:50PM +0200, Daniel Phillips wrote:
> > On Monday 26 August 2002 11:10, Christian Ehrhardt wrote:
> > > + * A special Problem is the lru lists. Presence on one of these lists
> > > + * does not increase the page count.
> > 
> > Please remind me... why should it not?
> 
> Pages that are only on the lru but not reference by anyone are of no
> use and we want to free them immediatly. If we leave them on the lru
> list with a page count of 1, someone else will have to walk the lru
> list and remove pages that are only on the lru.

I don't understand this argument.  Suppose lru list membership is worth a 
page count of one.  Then anyone who finds a page by way of the lru list can 
safely put_page_testzero and remove the page from the lru list.  Anyone who 
finds a page by way of a page table can likewise put_page_testzero and clear 
the pte, or remove the mapping and pass the page to Andrew's pagevec 
machinery, which will eventually do the put_page_testzero.  Anyone who 
removes a page from a radix tree will also do a put_page_testzero.  Exactly 
one of those paths will result in the page count reaching zero, which tells 
us nobody else holds a reference and it's time for __free_pages_ok.  The page 
is thus freed immediately as soon as there are no more references to it, and 
does not hang around on the lru list.

Nobody has to lock against the page count.  Each put_page_testzero caller 
only locks the data structure from which it's removing the reference.

This seems so simple, what is the flaw?

-- 
Daniel
