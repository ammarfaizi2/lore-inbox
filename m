Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWFMLVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWFMLVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWFMLVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:21:46 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:25648 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750960AbWFMLVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:21:45 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Date: Tue, 13 Jun 2006 13:21:20 +0200
Message-Id: <20060613112120.27913.71986.sendpatchset@lappy>
Subject: [PATCH 0/6] mm: tracking dirty pages -v8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The latest version of the tracking dirty pages patch-set.

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
