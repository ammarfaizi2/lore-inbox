Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTLaXmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbTLaXmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:42:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:15277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265287AbTLaXmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:42:15 -0500
Date: Wed, 31 Dec 2003 15:42:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: suparna@in.ibm.com, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] filemap_fdatawait.patch
Message-Id: <20031231154239.7c4d140e.akpm@osdl.org>
In-Reply-To: <1072910061.712.67.camel@ibm-c.pdx.osdl.net>
References: <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	<1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	<1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	<20031216180319.6d9670e4.akpm@osdl.org>
	<20031231091828.GA4012@in.ibm.com>
	<20031231013521.79920efd.akpm@osdl.org>
	<20031231095503.GA4069@in.ibm.com>
	<20031231015913.34fc0176.akpm@osdl.org>
	<20031231100949.GA4099@in.ibm.com>
	<20031231021042.5975de04.akpm@osdl.org>
	<20031231104801.GB4099@in.ibm.com>
	<20031231025309.6bc8ca20.akpm@osdl.org>
	<20031231025410.699a3317.akpm@osdl.org>
	<20031231031736.0416808f.akpm@osdl.org>
	<1072910061.712.67.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> The other potential race in filemap_fdatawait() was that it
> removed the page from the locked list while waiting for a writeback
> and if there was a 2nd filemap_fdatawait() running on another cpu,
> it would not wait for the page being written since it would never see
> it on the list.

That would only happen if one thread or the other was not running under
i_sem.   The only path I see doing that is in generic_file_direct_IO()?

> +		/*
> +		 * If the page is locked, it might be in process of being 
> +		 * setup for writeback but without PG_writeback set 
> +		 * and with PG_dirty cleared.
> +		 * (PG_dirty is cleared BEFORE PG_writeback is set)
> +		 * So, wait for the PG_locked to clear, then start over.
> +		 */
> +		if (PageLocked(page)) {
> +			page_cache_get(page);
> +			spin_unlock(&mapping->page_lock);
> +			wait_on_page_locked(page);
> +			page_cache_release(page);
> +			goto restart;
> +		}

Why is this a problem which needs addressing here?  If some other thread is
in the process of starting I/O against this page then the page must have
been clean when this thread ran filemap_fdatawrite()?

