Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUDPEag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 00:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUDPEaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 00:30:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:56203 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262205AbUDPEae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 00:30:34 -0400
Date: Thu, 15 Apr 2004 21:30:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: Fix bogus get_page() calls in hugepage code
Message-Id: <20040415213011.09748d77.akpm@osdl.org>
In-Reply-To: <20040416041231.GB13552@zax>
References: <20040416041231.GB13552@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On some archs the functions used to implement follow_page() for
>  hugepages do a get_page().  This is unlike the normal-page path for
>  follow_page(), so presumably a bug.  This patch fixes it.

get_user_pages() is supposed to pin the pages which it placed into the
callers pages[] array.

And the caller of get_user_pages() is supposed to unpin those pages when
they are finished with.

So follow_hugetlb_page() is currently doing the right thing.  The asymmetry
with follow_page() is awkward, but the overall intent was to minimise the
amount of impact which the hugepage code has on core MM.


Aside: note that get_user_pages() doesn't hold page_table_lock while
walking the pagetables, whereas it does hold that lock while walking the
regular pages' pagetables.  This is because the caller of get_user_pages()
holds down_read(mmap_sem), whereas hugetlb pagetable setup and teardown
always happens under down_write(mmap_sem).

