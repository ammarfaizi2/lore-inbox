Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVAIJpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVAIJpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 04:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVAIJpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 04:45:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:57483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262032AbVAIJpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 04:45:34 -0500
Date: Sun, 9 Jan 2005 01:45:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: panic on bootup due to __GFP_ZERO patch
Message-Id: <20050109014519.412688f6.akpm@osdl.org>
In-Reply-To: <20050108010629.M469@build.pdx.osdl.net>
References: <20050108010629.M469@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> I'm getting a panic during pidmap_init with a backtrace that looks
> something like:
> 
> buffered_rmqueue
> __alloc_pages
> get_zeroed_page
> pidmap_init
> start_kernel
> 
> Reverting the __GFP_ZERO patch fixes the issue, haven't drilled down
> any deeper yet to see what in the patch is causing the problem.  This is
> x86 w/out HIGHMEM (and no NUMA).
> 

Well it's doing clear_highpage() before __alloc_pages() has called
kernel_map_pages(), so CONFIG_DEBUG_PAGEALLOC is quite kaput.

So the current __GFP_ZERO buglist is:

1: Breaks CONFIG_DEBUG_PAGEALLOC

2: Breaks the cache aliasing protection for anonymous pages

3: prep_zero_page() uses KM_USER0 so __GFP_ZERO from IRQ context will
   cause rare memory corruption.

