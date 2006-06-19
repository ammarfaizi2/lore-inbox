Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWFSRw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWFSRw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWFSRw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:52:58 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:42216 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S964791AbWFSRw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:52:57 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Mon, 19 Jun 2006 19:52:43 +0200
Message-Id: <20060619175243.24655.76005.sendpatchset@lappy>
Subject: [PATCH 0/6] mm: tracking dirty pages -v9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The latest version of the tracking dirty pages patch-set.
On request against -mm.

This version handles VM_PFNMAP vmas and the COW case of shared RO mappings.

follow_page() got a comment for being weird, but in the light of the 
set_page_dirty() call that can not yet be removed does something sane.

copy_one_pte() also does the right thing, although I wonder why it clears
the dirty bit for children?

f_op->open() - sets a backing_dev_info
f_op->mmap() - modifies both vma->vm_flags and vma->vm_page_prot

Since our condition depends on both the backing_dev_info and vma->vm_flags
it cannot set vma->vm_page_prot before f_op->mmap().

However this means that !VM_PFNMAP vmas that are shared writable but do not
provide a f_op->nopage() and whos backing_dev_info does not have 
BDI_CAP_NO_ACCT_DIRTY, are left writable.

Peter
