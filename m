Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbTIDR1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265318AbTIDR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:27:14 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42892 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265316AbTIDR1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:27:07 -0400
Date: Thu, 4 Sep 2003 18:26:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030904172639.GB30394@mail.jlokier.co.uk>
References: <20030903173928.GA22555@mail.jlokier.co.uk> <Pine.LNX.4.44.0309031052000.26650-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309031052000.26650-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The only person who should ever test VM_MAYSHARE is somebody who does
> reporting back to user space: VM_MAYSHARE basically ends up meaning "the
> user _asked_ for a shared mapping". While "VM_SHARED" means "this mapping
> can actually contain a shared dirty page".

Precisely.  And for futex, the correct meaning is "the user asked for
a shared mapping": a FUTEX_WAIT on a shared mapping of a file opened
read-only _should_ be woken by a FUTEX_WAKE on the same file by
another process.

> The VM itself should only ever care about VM_SHARED. Because that's the 
> only bit that has real semantic meaning.

remap_file_pages() returns -EINVAL on mappings of
read-only file handles because it tests VM_SHARED.  There is no good
reason not to remap a read-only file - it doesn't complain about
remapping a PROT_READ mapping of a writable file!

Patch tested and attached.

Enjoy,
-- Jamie

Subject: [PATCH] Allow remap_file_pages() on read-only files
Patch: nonlinear-mayshare-2.6.0-test4-02.2jl

This changes remap_file_pages() to work on mappings of read-only file
handles.  Without this it returns -EINVAL.

diff -urN --exclude-from=dontdiff orig-2.6.0-test4/mm/fremap.c nonlinear-2.6.0-test4/mm/fremap.c
--- orig-2.6.0-test4/mm/fremap.c	2003-07-08 21:44:29.000000000 +0100
+++ nonlinear-2.6.0-test4/mm/fremap.c	2003-09-04 18:19:45.000000000 +0100
@@ -145,10 +145,11 @@
 	vma = find_vma(mm, start);
 	/*
 	 * Make sure the vma is shared, that it supports prefaulting,
-	 * and that the remapped range is valid and fully within
-	 * the single existing vma:
+	 * and that the remapped range is valid and fully within the
+	 * single existing vma.  VM_MAYSHARE is checked (not VM_SHARED)
+	 * so that read-only files can be remapped too:
 	 */
-	if (vma && (vma->vm_flags & VM_SHARED) &&
+	if (vma && (vma->vm_flags & VM_MAYSHARE) &&
 		vma->vm_ops && vma->vm_ops->populate &&
 			end > start && start >= vma->vm_start &&
 				end <= vma->vm_end)
