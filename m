Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVAGWOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVAGWOn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVAGWOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:14:19 -0500
Received: from [213.85.13.118] ([213.85.13.118]:31618 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261665AbVAGWMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:12:43 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: pmarques@grupopie.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [RFC] per thread page reservation patch
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	<20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>
	<1105019521.7074.79.camel@tribesman.namesys.com>
	<20050107144644.GA9606@infradead.org>
	<1105118217.3616.171.camel@tribesman.namesys.com>
	<41DEDF87.8080809@grupopie.com> <m1llb5q7qs.fsf@clusterfs.com>
	<20050107132459.033adc9f.akpm@osdl.org>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Sat, 08 Jan 2005 01:12:28 +0300
In-Reply-To: <20050107132459.033adc9f.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 7 Jan 2005 13:24:59 -0800")
Message-ID: <m1d5wgrir7.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

[...]

>
> Maybe I'm being thick, but I don't see how you can protect the reservation
> of an outer reserver in the above way:
>
> 	perthread_pages_reserve(10);
> 	...				/* current->private_pages_count = 10 */
> 		perthread_pages_reserve(10)	/* private_pages_count = 20 */
> 		use 5 pages			/* private_pages_count = 15 */
> 		perthread_pages_release(5);
>
> But how does the caller come up with the final "5"?

	wasreserved = perthread_pages_count();
	result = perthread_pages_reserve(estimate_reserve(), GFP_KERNEL);
	if (result != 0)
		return result;

    /* do something that consumes reservation */

	perthread_pages_release(perthread_pages_count() - wasreserved);

>
> Seems better to me if prethread_pages_reserve() were to return the initial
> value of private_pages_count, so the caller can do:
>
> 	old = perthread_pages_reserve(10);
> 		use 5 pages
> 	perthread_pages_release(old);
>
> or whatever.
>
> That kinda stinks too in a way, because both the outer and the inner
> callers need to overallocate pages on behalf of the worst case user in some
> deep call stack.
>
> And the whole idea is pretty flaky really - how can one precalculate how
> much memory an arbitrary md-on-dm-on-loop-on-md-on-NBD stack will want to
> use?  It really would be better if we could drop the whole patch and make
> reiser4 behave more sanely when its writepage is called with for_reclaim=1.

Reiser4 doesn't use this for ->writepage(), by the way. This is used by
tree balancing code to assure that balancing cannot get -ENOMEM in the
middle of tree modification, because undo is _so_ very complicated.

Nikita.
