Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTDVRJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbTDVRJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:09:45 -0400
Received: from holomorphy.com ([66.224.33.161]:22172 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263229AbTDVRJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:09:43 -0400
Date: Tue, 22 Apr 2003 10:21:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@digeo.com>,
       mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422172110.GK8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com, mingo@elte.hu,
	hugh@veritas.com, dmccr@us.ibm.com,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030422145644.GG8978@holomorphy.com> <Pine.LNX.4.44.0304221110560.10400-100000@devserv.devel.redhat.com> <20030422162055.GJ8978@holomorphy.com> <20030422165746.GK23320@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422165746.GK23320@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 06:57:46PM +0200, Andrea Arcangeli wrote:
> could we focus and solve the remap_file_pages current breakage first?
> I proposed my fix that IMHO is optimal and simple (I recall Hugh also
> proposed something on these lines):
> 1) allow it only inside mmap(VM_NONLINAER) vmas only
> 2) have the VM skip over VM_NONLINEAR vmas enterely
> 3) set vma->vm_file to NULL for those vams and forbid paging and allow
>    multiple files to be mapped in the same nonlinaer vma (add an fd
>    parameter to the syscall)
> 4) enable it as non-root (w/o IPC_LOCK capability) only with a sysctl
>    enabled
> 5) avoid any overhead connected with the potential paging of the
>    nonlinaer vmas

Some of these are controversial; it _can_ be fixed in other ways, but
the question is whether the sacrifice in functionality is with the
code simplification, or vice-versa evaluating the performance impact.

I'm trying to be objective here, though my own bias is in favor of full
retention of functionality (i.e. best of both worlds, maximal code
complexity).


On Tue, Apr 22, 2003 at 06:57:46PM +0200, Andrea Arcangeli wrote:
> 6) populate it with pmd on hugetlbfs
> 7) if a truncate happens leave the page pinned outside the pagecache
>    but still mapped into userspace, we don't care about it and it will
>    be freed during the munmap of the nonlinear vma

I'll implement the hugetlbfs part; it should fit nicely into the
infrastructure introduced with the rest of the virtwin patch, all it
really needs is some additional error checking. hugetlbfs is 100%
CAP_IPC_LOCK -- there should be no issue under either scheme.

There are also some unnameable databases clamoring for this
functionality but not quite ready to utilize it. They'll be quite happy
when closure on the issue is achieved even if not immediately able to
take advantage of it in userspace.


On Tue, Apr 22, 2003 at 06:57:46PM +0200, Andrea Arcangeli wrote:
> Note: in the longer run if you want, you can as well change the kernel
> internals to make this area pageable and then you won't need a sysctl
> anymore.
> The mmap and remap_file_pages kind of overlaps, remap_file_pages is the
> "hack" that should be quick and simple IMHO. Everything not just
> intersting as a pte mangling vm-bypass should happen in the mmap layer
> IMHO.

As it stands now it's supposed to be pageable. I think hugh and akpm
will have to intercede here. The true core of this discussion was around
a fresh state of a page that would have to be introduced to correctly
implement this that introduced certain complexities and some semantics
that negated most of the validation checks in mm/rmap.c. (AIUI --
please let them clarify, my understanding of this subtlety is limited
and at the risk of disseminating incorrect information I hoped to shed
_some_ light on it).

I think I know a bit more but would like to curtail the risk of
disseminating more incorrect information than necessary.


-- wli
