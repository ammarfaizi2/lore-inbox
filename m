Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263758AbUD0FPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbUD0FPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUD0FPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:15:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:20916 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263758AbUD0FPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:15:47 -0400
Date: Mon, 26 Apr 2004 22:15:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: apw@shadowen.org, agl@us.ibm.com, mbligh@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-Id: <20040426221519.3f17c5be.akpm@osdl.org>
In-Reply-To: <20040427050503.GH514@zax>
References: <20040423081856.GJ9243@zax>
	<20040423013437.1f2b8fc6.akpm@osdl.org>
	<20040427043652.GF514@zax>
	<20040426214757.2c7d8ed5.akpm@osdl.org>
	<20040427050503.GH514@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> 1) put_page() can still theoretically call
>  __page_cache_release() which is wrong (and makes the code misleading)

Don't think so?

void put_page(struct page *page)
{
	if (unlikely(PageCompound(page))) {
		page = (struct page *)page->private;
		if (put_page_testzero(page)) {
			void (*dtor)(struct page *page);

			dtor = (void (*)(struct page *))page[1].mapping;
			(*dtor)(page);
		}
		return;
	}
	if (!PageReserved(page) && put_page_testzero(page))
		__page_cache_release(page);
}

>  - patch below replaces this with a BUG() if there is no destructor. 2)
>  what about wli's concern that mapping may be accessed without first
>  checking for a PageCompound?

That shouldn't be happening (should it?).  If someone had such a page
they'd need to lock it to play with ->mapping and I cannot think of any
code which does all that and yet could stumble across a compound page?

