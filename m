Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263762AbUD0FUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUD0FUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUD0FUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:20:14 -0400
Received: from ozlabs.org ([203.10.76.45]:39654 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263762AbUD0FTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:19:53 -0400
Date: Tue, 27 Apr 2004 15:16:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, agl@us.ibm.com, mbligh@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-ID: <20040427051607.GI514@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, apw@shadowen.org, agl@us.ibm.com,
	mbligh@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
References: <20040423081856.GJ9243@zax> <20040423013437.1f2b8fc6.akpm@osdl.org> <20040427043652.GF514@zax> <20040426214757.2c7d8ed5.akpm@osdl.org> <20040427050503.GH514@zax> <20040426221519.3f17c5be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426221519.3f17c5be.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 10:15:19PM -0700, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > 1) put_page() can still theoretically call
> >  __page_cache_release() which is wrong (and makes the code misleading)
> 
> Don't think so?
> 
> void put_page(struct page *page)
> {
> 	if (unlikely(PageCompound(page))) {
> 		page = (struct page *)page->private;
> 		if (put_page_testzero(page)) {
> 			void (*dtor)(struct page *page);
> 
> 			dtor = (void (*)(struct page *))page[1].mapping;
> 			(*dtor)(page);
> 		}
> 		return;
> 	}
> 	if (!PageReserved(page) && put_page_testzero(page))
> 		__page_cache_release(page);
> }

Dang.  Missed that patch in the series.  My mistake.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
