Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUAKXoN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUAKXoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:44:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:6106 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266031AbUAKXoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:44:11 -0500
Date: Sun, 11 Jan 2004 15:44:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Janet Morgan <janetmor@us.ibm.com>
Cc: suparna@in.ibm.com, daniel@osdl.org, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-Id: <20040111154400.31f5fa53.akpm@osdl.org>
In-Reply-To: <4001D8BF.902@us.ibm.com>
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
	<4001D8BF.902@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janet Morgan <janetmor@us.ibm.com> wrote:
>
>  >diff -puN mm/filemap.c~a mm/filemap.c
>  >--- 25/mm/filemap.c~a	2003-12-31 03:10:29.000000000 -0800
>  >+++ 25-akpm/mm/filemap.c	2003-12-31 03:17:05.000000000 -0800
>  >@@ -206,7 +206,13 @@ restart:
>  > 		page_cache_get(page);
>  > 		spin_unlock(&mapping->page_lock);
>  > 
>  >-		wait_on_page_writeback(page);
>  >+		lock_page(page);
>  >+		if (PageDirty(page) && mapping->a_ops->writepage) {
>  >+			write_one_page(page, 1);
>  >+		} else {
>  >+			wait_on_page_writeback(page);
>  >+			unlock_page(page);
>  >+		}
>  > 		if (PageError(page))
>  > 			ret = -EIO;
>  > 
>  >
>  >  
>  >
>  That fixed the problem!  Stephen's testcase is running successfully on 
>  2.6.1-mm1 plus your patch -- no more uninitialized data!

Could you please test 2.6.1-mm2 with that patch?  If that works, send the
patch back to me?  (I lost it ;))

It still leaves the AIO situation open.
