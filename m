Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbUKKXKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUKKXKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbUKKXIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:08:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:58522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262405AbUKKXHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:07:18 -0500
Date: Thu, 11 Nov 2004 15:07:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] VM accounting change
Message-Id: <20041111150710.6855398a.akpm@osdl.org>
In-Reply-To: <20041111223245.GA15759@hygelac>
References: <20041111223245.GA15759@hygelac>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda <tripperda@nvidia.com> wrote:
>
> I've been told that recent changes in vm accounting in mmap have
>  caused some problems with our driver during mmap.
> 
>  the problem seems to stem from us oring vma->vm_flags w/ (VM_LOCKED 
>  | VM_IO). we do this for agp and pci pages that are mapped to push
>  buffers. VM_LOCKED since we don't want the pages to move and VM_IO so
>  they are not dumped during a core dump.

VM_LOCKED|VM_IO doesn't seem to be a sane combination.  VM_LOCKED means
"don't page it out" and VM_IO means "an IO region".  The kernel never even
attempts to page out IO regions because they don't have reverse mappings. 
Heck, they don't even have pageframes.

How about you drop the VM_LOCKED?

>  diff -ru linux-2.6.10-rc1-bk8/mm/mmap.c linux-2.6.10-rc1-bk8-2/mm/mmap.c
>  --- linux-2.6.10-rc1-bk8/mm/mmap.c	2004-11-06 15:04:28.000000000 +0100
>  +++ linux-2.6.10-rc1-bk8-2/mm/mmap.c	2004-11-06 15:39:47.000000000 +0100
>  @@ -1011,7 +1011,8 @@
>   	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
>   	if (vm_flags & VM_LOCKED) {
>   		mm->locked_vm += len >> PAGE_SHIFT;
>  -		make_pages_present(addr, addr + len);
>  +		if (!(vm_flags & VM_IO))
>  +			make_pages_present(addr, addr + len);

Spose we could do that on the basis of "don't break existing drivers which
are doing peculiar things".

