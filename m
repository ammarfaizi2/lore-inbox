Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTJDA1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 20:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTJDA1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 20:27:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:37062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261528AbTJDA1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 20:27:31 -0400
Date: Fri, 3 Oct 2003 17:27:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, andrea@suse.de
Subject: Re: mlockall and mmap of IO devices don't mix
Message-Id: <20031003172727.3d2b6cb2.akpm@osdl.org>
In-Reply-To: <20031003235416.GA27201@rudolph.ccur.com>
References: <20031003214411.GA25802@rudolph.ccur.com>
	<20031003152349.7194b73d.akpm@osdl.org>
	<20031003225509.GA26590@rudolph.ccur.com>
	<20031003161540.42ff98bb.akpm@osdl.org>
	<20031003235416.GA27201@rudolph.ccur.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
>  Your third patch worked perfectly for all the tested cases:
>     o /dev/mem at offset fd000000 (my video card mem addr)
>     o /dev/mem at offset 0
>     o with an mmapable device driver.

OK, thanks.

> I did have to make two changes to get it to compile:


> --- mm/memory.c.am3	2003-10-03 19:44:17.000000000 -0400
> +++ mm/memory.c	2003-10-03 19:43:47.000000000 -0400
> @@ -738,7 +738,7 @@
>  #endif
>  
>  		special = vma->vm_flags & (VM_IO | VM_RESERVED);
> -		if (!vma || (pages && vm_io) || !(flags & vma->vm_flags))
> +		if (!vma || (pages && special) || !(flags & vma->vm_flags))
>  			return i ? : -EFAULT;
>  
>  		if (is_vm_hugetlb_page(vma)) {
> @@ -755,7 +755,7 @@
>  			 * mappings of /dev/mem - they may have no pageframes.
>  			 * And the caller passed NULL for `pages' anyway.
>  			 */
> -			while (!special && !(map=follow_page(mm,start,write)) {
> +			while (!special && !(map=follow_page(mm,start,write))) {
>  				spin_unlock(&mm->page_table_lock);
>  				switch (handle_mm_fault(mm,vma,start,write)) {
>  				case VM_FAULT_MINOR:
> 
> In the first change, 'special' != '(vma->vma_flags & VM_IO)' which
> was what was originally being tested.  Could that cause a problem?

Yes, this is saying that you cannot extract pageframes from a mapping of
/dev/mem.  It means that you can no longer, for example, do a direct-IO
write of a chunk of /dev/mem onto disk.  I seem to recall that this is
disallowed for other reasons anwyay.

> Also, could the use of VM_RESERVED cause in some cases memory with
> pageframes to skip adjustment/use of those pageframes?

Could be so, if someone is trying to (say) do a direct-IO write of some
sound card's DMA buffer to disk.  Which is a pretty reasonable thing to do.

Maybe it's best to not overload VM_RESERVED in this manner, but to always
mark /dev/mem as VM_IO. 
