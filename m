Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSKNU0Y>; Thu, 14 Nov 2002 15:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSKNU0Y>; Thu, 14 Nov 2002 15:26:24 -0500
Received: from holomorphy.com ([66.224.33.161]:23498 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265205AbSKNU0X>;
	Thu, 14 Nov 2002 15:26:23 -0500
Date: Thu, 14 Nov 2002 12:30:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114203035.GF22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20021113184555.B10889@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113184555.B10889@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 06:45:55PM -0500, Benjamin LaHaise wrote:
> Since the functionality of the hugetlb syscalls is now available via 
> hugetlbfs with better control over permissions, could you apply the 
> following patch that gets rid of a lot of duplicate and unnescessary 
> code by removing the two hugetlb syscalls?  This patch was only tested 
> on x86, so if people could take a look over it and see if I missed 
> anything I'd appreciate it.  Thanks,

The main reason I haven't considered doing this is because they already
got in and there appears to be a user (Oracle/IA64).

My strategy has been instead to contribute fixes, cleanups, and some
redesign of internal data structure management so that the code is more
palatable and robust in general. And I think this process has gone well
enough to say that the system calls are relatively inoffensive, or will
be once what's in various patch queues as of today hits mainline.

Basically, I myself don't have a user of the stuff I need to service,
but I already know who's going to scream if it hits the chopping block.

The primary motivation behind the funding of hugetlbfs was to export
the superpage functionality as a tmpfs-like filesystem to other
in-kernel facilities, most notably SysV shm, for interoperability with
other databases (DB2) that are very insistent about utilizing superpages
in combination with SysV shm. Some additional benefits are available,
though not utilized, because the files may be larger than the virtual
address space on i386, and so mmap()-based windowing into a large
virtual arena could reap both TLB and space consumption benefits, which
benefit is also desired for (eventual) database usage, and is already
very beneficial to simpler applications with high concurrency levels
operating on shared memory arenas backed by it..

Oracle itself prefers to perform scatter/gather mappings at a
granularity too small for hugetlb on i386, and so sys_remap_file_pages()
is its preferred solution.

There are various oddities here. sys_remap_file_pages() is a new
syscall, hugetlbfs is a RAM-backed filesystem that supports only mmap()
and truncate(), and only on specifically-aligned regions. But IMHO with
effort and careful design, these facilities have either been cleanly
implemented or made clean once re-examined, and so supporting databases
has in the end not damaged the integrity or cleanliness of the generic VM.


Bill
