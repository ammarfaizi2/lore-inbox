Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRJ3NTJ>; Tue, 30 Oct 2001 08:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275983AbRJ3NS7>; Tue, 30 Oct 2001 08:18:59 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:6162 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S275082AbRJ3NSp>;
	Tue, 30 Oct 2001 08:18:45 -0500
Date: Wed, 31 Oct 2001 00:14:09 +1100
From: Anton Blanchard <anton@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Juergen Doelle <jdoelle@de.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Pls apply this spinlock patch to the kernel
Message-ID: <20011031001409.A22589@krispykreme>
In-Reply-To: <3BDD8241.8002B946@de.ibm.com> <E15yG7P-0003Kb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15yG7P-0003Kb-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> spinlock_t pagecache_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
> cache_line_pad;
> 
> where cache_line_pad is an asm(".align") - I would assume that is
> sufficient - Linus ?

In include/asm-ppc64/cache.h I ended up redefining ____cacheline_aligned_in_smp
to avoid the problem of things sharing a cacheline: 

#ifdef CONFIG_SMP
#define ____cacheline_aligned_in_smp __cacheline_aligned
#else
#define ____cacheline_aligned_in_smp
#endif /* CONFIG_SMP */

so that these things end up in the cacheline_aligned section and no variables
share a cacheline. Maybe there are some places where we want to group
variables in the same cacheline, but for consistency I think we should
have:

__cacheline_aligned{,_in_smp}
	variable goes into cacheline_aligned section

____cacheline_aligned{,_in_smp}
	just align to a cacheline

Anton
