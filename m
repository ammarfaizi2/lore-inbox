Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264760AbUDWIgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264760AbUDWIgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUDWIgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:36:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:16306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264760AbUDWIgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:36:00 -0400
Date: Fri, 23 Apr 2004 01:34:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: apw@shadowen.org, agl@us.ibm.com, mbligh@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-Id: <20040423013437.1f2b8fc6.akpm@osdl.org>
In-Reply-To: <20040423081856.GJ9243@zax>
References: <20040423081856.GJ9243@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> Andrew, please apply.
> 
> The code of put_page() is misleading, in that it appears to have code
> handling PageCompound pages (i.e. hugepages).  However it won't
> actually handle them correctly - __page_cache_release() will not work
> properly on a compound.  Instead, hugepages should be and are released
> with huge_page_release() from mm/hugetlb.c.  This patch removes the
> broken PageCompound path from put_page(), replacing it with a
> BUG_ON().  This also removes the initialization of page[1].mapping
> from compoound pages, which was only ever used in this broken code
> path.

We could certainly remove the test for a null destructor in there and
require that compound pages have a destructor installed.

But the main reason why that code is in there is for transparently handling
direct-io into hugepage regions.  That code does perform put_page against
4k pageframes within the huge page and it does follow the pointer to the
head page.

With your patch applied get_user_pages() and bio_release_pages() will
manipulate the refcounts of the inner 4k pages rather than the head pages
and things will explode.

We could change follow_hugetlb_page() to always take a ref against the head
page and we could teach bio_release_pages() to perform appropriate pfn
masking to locate the head page, and perform similar tricks for
futexes-in-large-pages.  But with the code as-is the refcounting works
transparently.


If it's "broken" I wanna know why.
