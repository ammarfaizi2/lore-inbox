Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUJUMD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUJUMD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbUJUMBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:01:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:27107 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268735AbUJTRT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:19:57 -0400
Date: Wed, 20 Oct 2004 10:19:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include all vmas with unbacked pages in ELF core dumps
In-Reply-To: <200410200822.i9K8MHtp024040@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410201003192.2317@ppc970.osdl.org>
References: <200410200822.i9K8MHtp024040@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Oct 2004, Roland McGrath wrote:
>
> This patch changes the criteria for including vm regions in a core dump.
> In recent glibc, the dynamic linker uses mprotect on part of a data segment
> to write-protect pages that should never be touched after startup time
> (this makes it harder for exploits to clobber indirection tables and the like).
> Currently, this part of the segment is omitted from core dumps, losing
> information about what the program did before it died.

Augh. Not all filesystems support holes, and I think VM_SHARED should 
trump VM_WRITE.

In general, I'd much prefer just adding a VM_DIRTY flag, and making the
COW logic set it. That should guarantee that we write out the minimal 
required sections.

> Including unreadable regions gives you things like guard pages, showing
> an accurate representation of of those in the core dump image. Since we
> now have the ZERO_PAGE check, this won't actually write any more pages
> to disk for those cases.

But any non-dumped section _will_ show up in the ELF headers, so things
like guard pages have nothing to do with "maydump()", imho. And as 
mentioned, some filesystems _will_ write many more pages.

So if gdb has trouble with guard pages, pls get somebody to fix gdb 
instead, and tell them what the difference between p_filesz and p_memsz 
is. Putting them into the dump is just stupid.

So "maydump()" might sanely look something like

	/* Shared or IO mappings are never written out */
	if (vma->vm_flags & (VM_IO | VM_SHARED | VM_SHM))
		return 0;

	/*
	 * Was the mapped backing store opened for writing?
	 * This really only happens for VM_SHARED (which we
	 * don't write out anyway), but it's conceptually
	 * the right thing to do. Some future internal use
	 * might end up doing this.
	 */
	if (!(vma->vm_flags & VM_MAYWRITE))
		return 0;

	/* We really should add this flag */
	if (!(vma->vm_flags & VM_DIRTY))
		return 0;

	/* otherwise, write it out */
	return 1;

and that should make people happy. No?

		Linus
