Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUBCAzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbUBCAzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:55:18 -0500
Received: from mail1.speakeasy.net ([216.254.0.201]:49599 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S265127AbUBCAzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:55:15 -0500
Date: Mon, 2 Feb 2004 16:55:11 -0800
Message-Id: <200402030055.i130tBT3018213@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: Linus Torvalds's message of  Monday, 2 February 2004 16:30:18 -0800 <Pine.LNX.4.58.0402021616340.9720@home.osdl.org>
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The follow_page issue should be fixable by just marking the _page_ dirty 
> inside the ptrace routines. I think we do that anyway (or we'd already be 
> buggy wrt perfectly normal writes).

access_process_vm already calls set_page_dirty_locked, in fact.
So things are relatively simple.

I suggested using pte_modify(pte, vma->vm_page_prot).  That is not the
right thing to do, in fact.  For private mappings, the vm_page_prot value
is always unwritable (PAGE_COPY).  So getting the right bits is tiny bit
hairier.  Either it can do:

	if (vma->vm_flags & VM_WRITE)
		entry = pte_mkwrite(entry);

or it can do something branchless like:

	entry = pte_modify(entry, protection_map[vma->vm_flags & 0x7]);

Or maybe there is a more optimal formulation I haven't thought of.


Thanks,
Roland
