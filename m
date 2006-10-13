Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWJMRDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWJMRDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWJMRDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:03:22 -0400
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:32236 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1751284AbWJMRDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:03:21 -0400
Date: Fri, 13 Oct 2006 18:03:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: RE: Hugepage regression
In-Reply-To: <000201c6ecc0$565cdc00$cb34030a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0610131744580.14935@blonde.wat.veritas.com>
References: <000201c6ecc0$565cdc00$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2006 17:02:57.0576 (UTC) FILETIME=[6E86DA80:01C6EEE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Chen, Kenneth W wrote:
> Hugh Dickins wrote on Tuesday, October 10, 2006 1:10 PM
> > > can we reverse that order (call unmap_region
> > > and then nulls out vma->vmfile and fput)?
> > 
> > I'm pretty sure we cannot: the ordering is quite intentional, that if
> > a driver ->mmap failed, then it'd be wrong to call down to driver in
> > the unmap_region (if a driver is nicely behaved, that unmap_region
> > shouldn't be unnecessary; but some do rely on us clearing ptes there).

Looking at it again, my explanation seems wrong: I can't see any danger
of calling down to the _driver_ there (there's no remove_vma): rather,
it's __remove_shared_vm_struct we're avoiding by setting vm_file NULL.

> 
> Even not something like the following?  I believe you that nullifying
> vma->vm_file can not be done after unmap_region(),

Yet in your patch below, you do nullify vm_file _after_ unmap_region.

> I just want to make sure we are talking the same thing.

So I'm not sure if we are!

> It looks OK to me to defer the fput in the do_mmap_pgoff clean up path.

Yes, it would be quite okay to defer the fput until after the
unmap_region; but there's no point in making that change, is there?

Hugh (sorry, I was off sick for a couple of days)

> 
> 
> --- ./mm/mmap.c.orig	2006-10-10 15:58:17.000000000 -0700
> +++ ./mm/mmap.c	2006-10-10 15:59:02.000000000 -0700
> @@ -1159,11 +1159,12 @@ out:	
>  unmap_and_free_vma:
>  	if (correct_wcount)
>  		atomic_inc(&inode->i_writecount);
> -	vma->vm_file = NULL;
> -	fput(file);
>  
>  	/* Undo any partial mapping done by a device driver. */
>  	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
> +
> +	vma->vm_file = NULL;
> +	fput(file);
>  	charged = 0;
>  free_vma:
>  	kmem_cache_free(vm_area_cachep, vma);
> 
