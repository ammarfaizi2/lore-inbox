Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVKNPBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVKNPBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVKNPBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:01:07 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:293 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751140AbVKNPBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:01:06 -0500
Date: Mon, 14 Nov 2005 17:00:22 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114150022.GG5492@minantech.com>
References: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com> <20051114145252.GT20871@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114145252.GT20871@mellanox.co.il>
X-OriginalArrivalTime: 14 Nov 2005 15:01:05.0445 (UTC) FILETIME=[3C997550:01C5E92C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 04:52:52PM +0200, Michael S. Tsirkin wrote:
> Index: linux-2.6.14-dontcopy/mm/madvise.c
> ===================================================================
> --- linux-2.6.14-dontcopy.orig/mm/madvise.c	2005-10-28 02:02:08.000000000 +0200
> +++ linux-2.6.14-dontcopy/mm/madvise.c	2005-11-14 17:04:51.000000000 +0200
> @@ -22,14 +22,20 @@ static long madvise_behavior(struct vm_a
>  	struct mm_struct * mm = vma->vm_mm;
>  	int error = 0;
>  	pgoff_t pgoff;
> -	int new_flags = vma->vm_flags & ~VM_READHINTMASK;
> +	int new_flags = vma->vm_flags;
>  
>  	switch (behavior) {
>  	case MADV_SEQUENTIAL:
> -		new_flags |= VM_SEQ_READ;
> +		new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
>  		break;
>  	case MADV_RANDOM:
> -		new_flags |= VM_RAND_READ;
> +		new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
> +		break;
> +	case MADV_DONTFORK:
> +		new_flags |= VM_DONTFORK;
> +		break;
> +	case MADV_DOFORK:
> +		new_flags &= ~VM_DONTFORK;
>  		break;
>  	default:
>  		break;
It seams now you broke MADV_NORMAL.

--
			Gleb.
