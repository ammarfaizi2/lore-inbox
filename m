Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277616AbRJRIZi>; Thu, 18 Oct 2001 04:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277618AbRJRIZ1>; Thu, 18 Oct 2001 04:25:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5465 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277616AbRJRIZM>; Thu, 18 Oct 2001 04:25:12 -0400
Date: Thu, 18 Oct 2001 10:22:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Chip Salzenberg <chip@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13pre3aa1: expand_fdset() may use invalid pointer
Message-ID: <20011018102226.I12055@athlon.random>
In-Reply-To: <20011017113245.A3849@perlsupport.com> <20011017204204.C2380@athlon.random> <20011018121124.L11266@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011018121124.L11266@in.ibm.com>; from maneesh@in.ibm.com on Thu, Oct 18, 2001 at 12:11:24PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 12:11:24PM +0530, Maneesh Soni wrote:
> +struct rcu_fd_array {
> +	struct rcu_head rh;
> +	struct file **array;   
> +	int nfds;
> +};
> +
> +struct rcu_fd_set {
> +	struct rcu_head rh;
> +	fd_set *openset;
> +	fd_set *execset;
> +	int nfds;
> +};

Some other very minor comment. I'd also rename them fd_array, and
fd_set.

think, when we add a spinlock to a data structure (say a semaphore or a
waitqueue) to scale per-spinlock or per-waitqueue we're not going to
rename the "struct semaphore" into "struct per_spinlock_semaphore", at
least unless we also provide two different types of semaphores.

same happens if we move a data structure into the slab cache, we don't
call it "struct slab_semaphore" just because it gets allocated/freed via
the slab cache rather than by using kmalloc/kfree.

I'd also put the rcu_head at the end of the structure, the rcu_head
should be used only when we are going to free the data, so it's not used
at runtime and it worth to keep the other fields in the first cacheline
so they're less likely to be splitted off in more than one cacheline.

Andrea
