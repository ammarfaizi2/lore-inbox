Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWCGBoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWCGBoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWCGBoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:44:34 -0500
Received: from kanga.kvack.org ([66.96.29.28]:20423 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932307AbWCGBod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:44:33 -0500
Date: Mon, 6 Mar 2006 20:39:15 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: drepper@gmail.com, da-x@monatomic.org, linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
Message-ID: <20060307013915.GU20768@kvack.org>
References: <20060306233300.GR20768@kvack.org> <20060306.162444.107249907.davem@davemloft.net> <20060307004237.GT20768@kvack.org> <20060306.165129.62204114.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306.165129.62204114.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 04:51:29PM -0800, David S. Miller wrote:
> I think any such VM tricks need serious thought.  It has serious
> consequences as far as cost especially on SMP.  Evgivny has some data
> that shows this, and chapter 5 of Networking Algorithmics has a lot of
> good analysis and paper references on this topic.

VM tricks do suck, so you just have to use the tricks that nobody else 
is...  My thinking is to do something like the following: have a structure 
to reference a set of pages.  When it is first created, it takes a reference 
on the pages in question, and it is added to the vm_area_struct of the user 
so that the vm can poke it for freeing when memory pressure occurs.  The 
sk_buff dataref also has to have a pointer to the pageref added.  Now, the 
trick to making it useful is as follows:

	struct pageref {
		atomic_t	free_count;
		int		use_count;	/* protected by socket lock */
		...
		unsigned long	user_address;
		unsigned long	length;
		struct socket	*sock;		/* backref for VM */
		struct page	*pages[];
	};

The fast path in network transmit becomes:

	if (sock->pageref->... overlaps buf) {
		for each packet built {
			use_count++;
			<add pageref to skb's dataref happily without atomics 
			or memory copying>
		}
	}

Then the kfree_skb() path does an atomic_dec() on pageref->free_count 
instead of the page.  (Or get rid of the atomic using knowledge about the 
fact that a given pageref could only be freed by the network driver it was 
given to.)  That would make the transmit path bloody cheap, and the tx irq 
context no more expensive than it already is.

It's probably easier to show this tx path with code that gets the details 
right.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
