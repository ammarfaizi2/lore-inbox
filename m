Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbTICC4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 22:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTICC4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 22:56:11 -0400
Received: from dp.samba.org ([66.70.73.150]:62414 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261499AbTICC4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 22:56:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Tue, 02 Sep 2003 17:14:15 +0100."
             <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain> 
Date: Wed, 03 Sep 2003 12:40:38 +1000
Message-Id: <20030903025605.5C1722C05F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain> you 
write:
> On Tue, 2 Sep 2003, Hugh Dickins wrote:
> When sys_futex passes a uaddr in a VM_MAYSHARE vma, it should be handled
> by mapping/index (or inode/offset).  When sys_futex passes a uaddr in a
> !VM_MAYSHARE vma, it should be handled by mm/uaddr.  (If outside vma?)
> 
> That's it.  Doesn't a whole lot of code and complication fall away?
> The physical page is pretty much irrelevant.

The physical page is a relic from my original implementation, which
did "pin page and hash on it".  Life was simple and good, and then
came FUTEX_FD (which allows more than one futex per process) and
before Ingo found the COW issue, and added the vcache stuff.

Now, I am lost in a maze of VM hackers' advice, all slightly
different 8)

Assume that we do:
1) Look up vma.
2) If vma->vm_flags & VM_SHARED, index by page->mapping & page->index.
3) Otherwise, index by vma->vm_mm & uaddr.

Questions:
1) What is the difference between VM_SHARED and VM_MAYSHARE?  They
   always seem to be set/reset together.

2) If VM_SHARED, and page->mapping is NULL, what to do?  AFAICT, this
   can happen in the case of anonymous shared mappings, say mmap
   /dev/zero MAP_SHARED and fork()? Treating it as !VM_SHARED (and
   hence matching in mm & uaddr) won't work, since the mm's will be
   different (and with mremap, the uaddrs may be different).

3) Since we need the offset in the file anyway for the VM_SHARED, it
   makes more sense to use get_user_pages() to get the vma and page in
   one call, rather than find_extend_vma().

4) mremap on a futex: same case as munmap, it's undefined behavior.  A
   correct program will need to re-wait on the futex anyway.

BTW, the other solution to the COW problem which Ingo thought about (I
was away on my honeymoon), was to have the child always get the copied
page, even if the parent caused the COW fault.  If you also always
un-COW the page in FUTEX_WAIT, this scheme works.  IIRC he said the
implementation was icky.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
