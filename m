Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTEOCXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTEOCXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:23:44 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:2742 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263681AbTEOCXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:23:42 -0400
Date: Wed, 14 May 2003 22:36:23 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       <mika.penttila@kolumbus.fi>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
In-Reply-To: <20030515004915.GR1429@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0305142234120.20800-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Andrea Arcangeli wrote:

> --- x/include/linux/fs.h.~1~	2003-05-14 23:26:19.000000000 +0200
> +++ x/include/linux/fs.h	2003-05-15 02:35:57.000000000 +0200
> @@ -421,6 +421,8 @@ struct address_space {
>  	struct vm_area_struct	*i_mmap;	/* list of private mappings */
>  	struct vm_area_struct	*i_mmap_shared; /* list of shared mappings */
>  	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
> +	int			truncate_sequence1; /* serialize ->nopage against truncate */
> +	int			truncate_sequence2; /* serialize ->nopage against truncate */

How about calling them truncate_start and truncate_end ?

> --- x/mm/vmscan.c.~1~	2003-05-14 23:26:12.000000000 +0200
> +++ x/mm/vmscan.c	2003-05-15 00:22:57.000000000 +0200
> @@ -165,11 +165,10 @@ drop_pte:
>  		goto drop_pte;
>  
>  	/*
> -	 * Anonymous buffercache pages can be left behind by
> +	 * Anonymous buffercache pages can't be left behind by
>  	 * concurrent truncate and pagefault.
>  	 */
> -	if (page->buffers)
> -		goto preserve;
> +	BUG_ON(page->buffers);

I wonder if there is nothing else that can leave behind
buffers in this way.

> +	mb(); /* spin_lock has inclusive semantics */
> +	if (unlikely(truncate_sequence != mapping->truncate_sequence1)) {
> +		struct inode *inode;

This code looks like it should work, but IMHO it is very subtle
so it should really get some documentation.


