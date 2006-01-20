Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422743AbWATC1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422743AbWATC1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWATC1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:27:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422743AbWATC1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:27:39 -0500
Date: Thu, 19 Jan 2006 18:27:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_list: Use of && instead || leads to unintended
 writing of pages
Message-Id: <20060119182718.575bd08a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601191744390.13937@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
	<20060119164341.0fb9c7e3.akpm@osdl.org>
	<Pine.LNX.4.62.0601191648440.13602@schroedinger.engr.sgi.com>
	<20060119172032.04bad017.akpm@osdl.org>
	<Pine.LNX.4.62.0601191744390.13937@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> [PATCH] Implement sane function of sc->may_writepage
> 
>  Make sc->may_writepage control the writeout behavior of shrink_list.
> 
>  Remove the laptop_mode trick from shrink_list and instead set may_writepage in
>  try_to_free_pages properly.
> 
>  Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
>  Index: linux-2.6.16-rc1-mm1/mm/vmscan.c
>  ===================================================================
>  --- linux-2.6.16-rc1-mm1.orig/mm/vmscan.c	2006-01-19 15:50:19.000000000 -0800
>  +++ linux-2.6.16-rc1-mm1/mm/vmscan.c	2006-01-19 17:42:07.000000000 -0800
>  @@ -491,7 +491,7 @@ static int shrink_list(struct list_head 
>   				goto keep_locked;
>   			if (!may_enter_fs)
>   				goto keep_locked;
>  -			if (laptop_mode && !sc->may_writepage)
>  +			if (!sc->may_writepage)
>   				goto keep_locked;
>   
>   			/* Page is dirty, try to write it out here */
>  @@ -1409,7 +1409,7 @@ int try_to_free_pages(struct zone **zone
>   	int i;
>   
>   	sc.gfp_mask = gfp_mask;
>  -	sc.may_writepage = 0;
>  +	sc.may_writepage = !laptop_mode;
>   	sc.may_swap = 1;
>   
>   	inc_page_state(allocstall);
>  @@ -1512,7 +1512,7 @@ loop_again:
>   	total_scanned = 0;
>   	total_reclaimed = 0;
>   	sc.gfp_mask = GFP_KERNEL;
>  -	sc.may_writepage = 0;
>  +	sc.may_writepage = 1;
>   	sc.may_swap = 1;
>   	sc.nr_mapped = read_page_state(nr_mapped);

The balance_pgdat() change is wrong, surely?  We want !laptop_mode.
