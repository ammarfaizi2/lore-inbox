Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266302AbUGAVwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUGAVwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUGAVwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:52:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:28105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266302AbUGAVwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:52:49 -0400
Date: Thu, 1 Jul 2004 14:55:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, david@gibson.dropbear.id.au,
       torvalds@osdl.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [BUG] hugetlb MAP_PRIVATE mapping vs /dev/zero
Message-Id: <20040701145541.0ece2898.akpm@osdl.org>
In-Reply-To: <40E43BDE.85C5D670@tv-sign.ru>
References: <40E43BDE.85C5D670@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> Hugetlbfs mmap with MAP_PRIVATE becomes MAP_SHARED
> silently, but vma->vm_flags have no VM_SHARED bit.
> I think it make sense to forbid MAP_PRIVATE in
> hugetlbfs_file_mmap() because it may confuse user
> space applications. But the real bug is that reading
> from /dev/zero into hugetlb will do:
> 
> read_zero()
> 	read_zero_pagealigned()
> 		if (vma->vm_flags & VM_SHARED)
> 			break;	// OK if MAP_PRIVATE
> 		zap_page_range();
> 		zeromap_page_range();
> 
> We can fix hugetlbfs_file_mmap() or read_zero_pagealigned()
> or both.

This could break existing applications, yes?

If so, would an appropriate fixup be to coerce private mappings
of hugetlb files into shared ones in-kernel?
