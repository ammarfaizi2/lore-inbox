Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTLaLRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTLaLRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:17:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:37007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263221AbTLaLRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:17:14 -0500
Date: Wed, 31 Dec 2003 03:17:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-Id: <20031231031736.0416808f.akpm@osdl.org>
In-Reply-To: <20031231025410.699a3317.akpm@osdl.org>
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
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Let me actually think about this a bit.

Nasty.  The same race is present in 2.4.x...

How's about we start new I/O in filemap_fdatawait() if the page is dirty?


diff -puN mm/filemap.c~a mm/filemap.c
--- 25/mm/filemap.c~a	2003-12-31 03:10:29.000000000 -0800
+++ 25-akpm/mm/filemap.c	2003-12-31 03:17:05.000000000 -0800
@@ -206,7 +206,13 @@ restart:
 		page_cache_get(page);
 		spin_unlock(&mapping->page_lock);
 
-		wait_on_page_writeback(page);
+		lock_page(page);
+		if (PageDirty(page) && mapping->a_ops->writepage) {
+			write_one_page(page, 1);
+		} else {
+			wait_on_page_writeback(page);
+			unlock_page(page);
+		}
 		if (PageError(page))
 			ret = -EIO;
 


