Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbTLaWeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbTLaWeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:34:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:27010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265273AbTLaWeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:34:31 -0500
Subject: [PATCH linux-2.6.1-rc1-mm1] filemap_fdatawait.patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, janetmor@us.ibm.com,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031231031736.0416808f.akpm@osdl.org>
References: <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	 <1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	 <20031216180319.6d9670e4.akpm@osdl.org> <20031231091828.GA4012@in.ibm.com>
	 <20031231013521.79920efd.akpm@osdl.org> <20031231095503.GA4069@in.ibm.com>
	 <20031231015913.34fc0176.akpm@osdl.org> <20031231100949.GA4099@in.ibm.com>
	 <20031231021042.5975de04.akpm@osdl.org> <20031231104801.GB4099@in.ibm.com>
	 <20031231025309.6bc8ca20.akpm@osdl.org>
	 <20031231025410.699a3317.akpm@osdl.org>
	 <20031231031736.0416808f.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-NzTphiGUryysPPqsw7Pt"
Organization: 
Message-Id: <1072910061.712.67.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Dec 2003 14:34:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NzTphiGUryysPPqsw7Pt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The other potential race in filemap_fdatawait() was that it
removed the page from the locked list while waiting for a writeback
and if there was a 2nd filemap_fdatawait() running on another cpu,
it would not wait for the page being written since it would never see
it on the list.

I've been running with filemap_fdatawait() that waits for the
locked page and writeback with the page still on the locked list.
Any other filemap_fdatawait() would see the page being written
and then wait.

I've re-diffed this patch against 2.6.1-rc1-mm1.

Thoughts?

Daniel



On Wed, 2003-12-31 at 03:17, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Let me actually think about this a bit.
> 
> Nasty.  The same race is present in 2.4.x...
> 
> How's about we start new I/O in filemap_fdatawait() if the page is dirty?
> 
> 
> diff -puN mm/filemap.c~a mm/filemap.c
> --- 25/mm/filemap.c~a	2003-12-31 03:10:29.000000000 -0800
> +++ 25-akpm/mm/filemap.c	2003-12-31 03:17:05.000000000 -0800
> @@ -206,7 +206,13 @@ restart:
>  		page_cache_get(page);
>  		spin_unlock(&mapping->page_lock);
>  
> -		wait_on_page_writeback(page);
> +		lock_page(page);
> +		if (PageDirty(page) && mapping->a_ops->writepage) {
> +			write_one_page(page, 1);
> +		} else {
> +			wait_on_page_writeback(page);
> +			unlock_page(page);
> +		}
>  		if (PageError(page))
>  			ret = -EIO;
>  
> 

--=-NzTphiGUryysPPqsw7Pt
Content-Disposition: attachment; filename=linux-2.6.1-rc1-mm1.fdatawait.patch
Content-Type: text/plain; name=linux-2.6.1-rc1-mm1.fdatawait.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.1-rc1-mm1/mm/filemap.c	2003-12-31 10:52:47.039988554 -0800
+++ linux-2.6.1-rc1-mm1.fdatawait/mm/filemap.c	2003-12-31 14:10:43.114197926 -0800
@@ -188,6 +188,32 @@ restart:
 		struct page *page;
 
 		page = list_entry(mapping->locked_pages.next,struct page,list);
+		/*
+		 * If the page is locked, it might be in process of being 
+		 * setup for writeback but without PG_writeback set 
+		 * and with PG_dirty cleared.
+		 * (PG_dirty is cleared BEFORE PG_writeback is set)
+		 * So, wait for the PG_locked to clear, then start over.
+		 */
+		if (PageLocked(page)) {
+			page_cache_get(page);
+			spin_unlock(&mapping->page_lock);
+			wait_on_page_locked(page);
+			page_cache_release(page);
+			goto restart;
+		}
+		/*
+		 * Wait for page writeback with it still on the locked list.
+		 */
+		if (PageWriteback(page)) {
+			page_cache_get(page);
+			spin_unlock(&mapping->page_lock);
+			wait_on_page_writeback(page);
+			if (PageError(page))
+				ret = -EIO;
+			page_cache_release(page);
+			goto restart;
+		}
 		list_del(&page->list);
 		if (PageDirty(page))
 			list_add(&page->list, &mapping->dirty_pages);

--=-NzTphiGUryysPPqsw7Pt--

