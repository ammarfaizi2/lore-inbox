Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTJGJGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 05:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTJGJGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 05:06:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:7394 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbTJGJGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 05:06:43 -0400
Date: Tue, 7 Oct 2003 02:06:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dump read-only anonymous memory in core files
In-Reply-To: <200310070828.h978SFQO028412@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0310070155110.1749-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What about shared mappings (that test should be VM_MAYSHARE)?

My inclination would be to not dump them if they are backed by a file, 
even if the mmap is writable.

Also, the VM_WRITE test should possibly be VM_MAYWRITE, since the thing
could have been mprotect()'ed. Alternatively, we could really add a "this
mapping has been writable" flag (a kind of "sticky VM_WRITE" bit). It's
only mprotect that can do this, anyway.

Ehh?

Which would make the logic be something like

	/* Do not dump I/O mapped devices! -DaveM */
	if (vma->vm_flags & VM_IO)
		return 0;

	/* file-backed mapping? */
	if (vma->vm_file) {
		if (vma->vm_flags & VM_MAYSHARE)
			return 0;
		if (!(vma->vm_flags & VM_MAYWRITE))
			return 0;
	}

	return 1;

Hmm?

		Linus

