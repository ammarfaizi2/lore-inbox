Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277646AbRJRJmJ>; Thu, 18 Oct 2001 05:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277649AbRJRJl7>; Thu, 18 Oct 2001 05:41:59 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:61911 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277646AbRJRJlo>; Thu, 18 Oct 2001 05:41:44 -0400
Date: Thu, 18 Oct 2001 15:18:28 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chip Salzenberg <chip@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13pre3aa1: expand_fdset() may use invalid pointer
Message-ID: <20011018151828.M11266@in.ibm.com>
Reply-To: maneesh@in.ibm.com
In-Reply-To: <20011017113245.A3849@perlsupport.com> <20011017204204.C2380@athlon.random> <20011018121124.L11266@in.ibm.com> <20011018102226.I12055@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011018102226.I12055@athlon.random>; from andrea@suse.de on Thu, Oct 18, 2001 at 10:22:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 10:22:26AM +0200, Andrea Arcangeli wrote:
> On Thu, Oct 18, 2001 at 12:11:24PM +0530, Maneesh Soni wrote:
> > +struct rcu_fd_array {
> > +	struct rcu_head rh;
> > +	struct file **array;   
> > +	int nfds;
> > +};
> > +
> > +struct rcu_fd_set {
> > +	struct rcu_head rh;
> > +	fd_set *openset;
> > +	fd_set *execset;
> > +	int nfds;
> > +};
> 
> Some other very minor comment. I'd also rename them fd_array, and
> fd_set.
> 
> think, when we add a spinlock to a data structure (say a semaphore or a
> waitqueue) to scale per-spinlock or per-waitqueue we're not going to
> rename the "struct semaphore" into "struct per_spinlock_semaphore", at
> least unless we also provide two different types of semaphores.
> 
> same happens if we move a data structure into the slab cache, we don't
> call it "struct slab_semaphore" just because it gets allocated/freed via
> the slab cache rather than by using kmalloc/kfree.

Got it...but both fd_set and fd_array are not very straight forward as
other structures like struct dentry, so I didnot embedd rcu head in them
fd_set is defined as 

typedef __kernel_fd_set         fd_set; 

where as __kernel_fd_set is as in (linux/posix_types.h)

typedef struct {
        unsigned long fds_bits [__FDSET_LONGS];
} __kernel_fd_set;

so I don't think it is appropriate to add  rcu_head and others (openset, 
execset and nfds) in __kernel_fd_set. and thought rcu_fd_set could be 
appropriate name.  There is no "struct fd_array". 

I think we can combine rcu_fd_set & rcu_fd_array like this

struct def_free_files_struct_args {
	int nfds;
	struct file **array;   
	fd_set *openset;
	fd_set *execset;
	struct rcu_head rh;
};
	
or just rename them as def_free_fdarray_args and def_free_fdset_args.

We also thought of embedding rcu head in the files_struct, but that was ruled
out as we are not freeing the entire files_struct but a couple of fields in
it. So it may happen that before the callback for one files_struct is processed 
we queue another one for the same files_struct.

> I'd also put the rcu_head at the end of the structure, the rcu_head
> should be used only when we are going to free the data, so it's not used
> at runtime and it worth to keep the other fields in the first cacheline
> so they're less likely to be splitted off in more than one cacheline.

There is no problem in this one.

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5262355 Extn. 3999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html
