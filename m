Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270870AbUJUTQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270870AbUJUTQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270861AbUJUTMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:12:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:53197 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S270837AbUJUTJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:09:16 -0400
Date: Thu, 21 Oct 2004 20:05:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include all vmas with unbacked pages in ELF core dumps
In-Reply-To: <Pine.LNX.4.58.0410201003192.2317@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0410211939570.12985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Linus Torvalds wrote:
> 
> In general, I'd much prefer just adding a VM_DIRTY flag, and making the
> COW logic set it. That should guarantee that we write out the minimal 
> required sections.

VM_DIRTY flag would be problematic, since you need mmap_sem exclusively
to modify vm_flags, whereas faulting holds mmap_sem non-exclusively.

But if I understand you aright, testing vma->anon_vma should do it.

> So "maydump()" might sanely look something like
> 
> 	/* Shared or IO mappings are never written out */
> 	if (vma->vm_flags & (VM_IO | VM_SHARED | VM_SHM))
> 		return 0;

VM_SHM is a relic, there might be a driver or two still setting it,
but we should have deleted it long ago: you mean VM_RESERVED, I think.

> 	/*
> 	 * Was the mapped backing store opened for writing?
> 	 * This really only happens for VM_SHARED (which we
> 	 * don't write out anyway), but it's conceptually
> 	 * the right thing to do. Some future internal use
> 	 * might end up doing this.
> 	 */
> 	if (!(vma->vm_flags & VM_MAYWRITE))
> 		return 0;

Conceptually the right thing to do?  I think it's best left out until
that future internal use makes sense of it.  As it stands, I can't work
out what it's up to; and VM_MAYWRITE doesn't say if the backing store
was opened for writing, but whether the memory may be mprotected writable.

> 	/* We really should add this flag */
> 	if (!(vma->vm_flags & VM_DIRTY))
> 		return 0;

	if (!vma->anon_vma)
		return 0;

> 	/* otherwise, write it out */
> 	return 1;

Hugh

