Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTLaJ65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 04:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTLaJ65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 04:58:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:49096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263775AbTLaJ64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 04:58:56 -0500
Date: Wed, 31 Dec 2003 01:59:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-Id: <20031231015913.34fc0176.akpm@osdl.org>
In-Reply-To: <20031231095503.GA4069@in.ibm.com>
References: <3FCD4B66.8090905@us.ibm.com>
	<1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	<1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	<1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	<1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	<20031216180319.6d9670e4.akpm@osdl.org>
	<20031231091828.GA4012@in.ibm.com>
	<20031231013521.79920efd.akpm@osdl.org>
	<20031231095503.GA4069@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> > If you are referring to this code in mpage_writepage():
>  > 
>  > 		lock_page(page);
>  > 
>  > 		if (wbc->sync_mode != WB_SYNC_NONE)
>  > 			wait_on_page_writeback(page);
>  > 
>  > 		if (page->mapping == mapping && !PageWriteback(page) &&
>  > 					test_clear_page_dirty(page)) {
>  > 
>  > 
>  > then I don't see the race - the page lock synchronises the two threads?
>  > 
> 
>  But filemap_fdatawait does not look at the page lock. So there's a
>  tiny window when the page is on locked_pages with PG_dirty cleared
>  and PG_writeback not set.

OK, but the thread which is running fdatawrite/fdatawait isn't interested
in that page, because it must have been dirtied _after_ this thread has
passed through filemap_fdatawrite(), yes?

Which is desired behaviour for fsync(), but perhaps not suitable when this
code is reused for the O_DIRECT pagecache synchronisation function.

