Return-Path: <linux-kernel-owner+w=401wt.eu-S1755221AbXAAPEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbXAAPEh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 10:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbXAAPEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 10:04:36 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:60831 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755219AbXAAPEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 10:04:36 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20061221165744.GD3958@flint.arm.linux.org.uk>
References: <20061221152621.GB3958@flint.arm.linux.org.uk>
	 <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu>
	 <20061221165744.GD3958@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 10:04:22 -0500
Message-Id: <1167663862.5302.54.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 16:57 +0000, Russell King wrote:
> I'm not entirely convinced that it can be replaced.  What if the page
> is in the page cache and is shared with other processes?  That quite
> clearly falls under flush_dcache_page()'s remit.

Actually, it should work.  flush_dcache_page() is the big hammer, it
clears the caches of all the user processes and the kernel for that
page.  On most architectures this is not that expensive, but on parisc
it is.  Most of the paths out of fuse have already called
flush_dcache_page() coming in to make the page coherent for the kernel
to use. Then fuse writes data to the page. There's no point calling it
again since there shouldn't be anything in the user cache (the model has
the kernel owning the page), so flush_kernel_dcache_page() is the
shortcut to simply flush out the kernel cache above the page (knowing
the users still have the page uncached).

James


