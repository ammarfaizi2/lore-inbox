Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbTDVQqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbTDVQqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:46:39 -0400
Received: from mail-4.tiscali.it ([195.130.225.150]:53162 "EHLO
	mail-4.tiscali.it") by vger.kernel.org with ESMTP id S263217AbTDVQqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:46:37 -0400
Date: Tue, 22 Apr 2003 18:57:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@redhat.com>,
       Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422165746.GK23320@dualathlon.random>
References: <20030422145644.GG8978@holomorphy.com> <Pine.LNX.4.44.0304221110560.10400-100000@devserv.devel.redhat.com> <20030422162055.GJ8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422162055.GJ8978@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

could we focus and solve the remap_file_pages current breakage first?

I proposed my fix that IMHO is optimal and simple (I recall Hugh also
proposed something on these lines):

1) allow it only inside mmap(VM_NONLINAER) vmas only
2) have the VM skip over VM_NONLINEAR vmas enterely
3) set vma->vm_file to NULL for those vams and forbid paging and allow
   multiple files to be mapped in the same nonlinaer vma (add an fd
   parameter to the syscall)
4) enable it as non-root (w/o IPC_LOCK capability) only with a sysctl
   enabled
5) avoid any overhead connected with the potential paging of the
   nonlinaer vmas
6) populate it with pmd on hugetlbfs
7) if a truncate happens leave the page pinned outside the pagecache
   but still mapped into userspace, we don't care about it and it will
   be freed during the munmap of the nonlinear vma

Note: in the longer run if you want, you can as well change the kernel
internals to make this area pageable and then you won't need a sysctl
anymore.

The mmap and remap_file_pages kind of overlaps, remap_file_pages is the
"hack" that should be quick and simple IMHO. Everything not just
intersting as a pte mangling vm-bypass should happen in the mmap layer
IMHO.

Andrea
