Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbTHaDUL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 23:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTHaDUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 23:20:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33191 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262417AbTHaDUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 23:20:08 -0400
Date: Sun, 31 Aug 2003 04:20:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Matthew Wilcox <willy@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmalloc might sleep
Message-ID: <20030831032007.GZ454@parcelfarce.linux.theplanet.co.uk>
References: <20030831030643.GQ13467@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831030643.GQ13467@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 04:06:43AM +0100, Matthew Wilcox wrote:
> 
> So let's whack people upside the head when they misuse it.
> 
> vmalloc-might-sleep.diff:
> 
> Index: mm/vmalloc.c
> ===================================================================
> RCS file: /var/cvs/linux-2.6/mm/vmalloc.c,v
> retrieving revision 1.2
> diff -u -p -r1.2 vmalloc.c
> --- a/mm/vmalloc.c	23 Aug 2003 02:47:26 -0000	1.2
> +++ b/mm/vmalloc.c	31 Aug 2003 03:04:25 -0000
> @@ -438,7 +438,8 @@ fail:
>   */
>  void *vmalloc(unsigned long size)
>  {
> -       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
> +	might_sleep();
> +	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);

__vmalloc() goes kmalloc() to get an array of struct page pointers.  And
both for vmalloc() and vmalloc_32() kmalloc() will be called with GFP_KERNEL
as gfp_mask.  Which already has might_sleep().
