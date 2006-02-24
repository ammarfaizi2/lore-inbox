Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWBXLxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWBXLxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBXLxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:53:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:64646 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750738AbWBXLxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:53:08 -0500
Date: Fri, 24 Feb 2006 17:23:14 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Wendy Cheng <wcheng@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
Message-ID: <20060224115314.GA23318@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060223072955.GA14244@in.ibm.com> <43FE0904.3020900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE0904.3020900@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wendy,

On Thu, Feb 23, 2006 at 02:12:04PM -0500, Wendy Cheng wrote:
> Suparna Bhattacharya wrote:
> 
> >http://www.kernel.org/pub/linux/kernel/people/suparna/DIO-simplify.txt
> >(also inlined below)
> > 
> >
> Hi, Suparna,
>                                                                                
> 
> It would be nice to ensure that the lock sequence will not cause issues 
> for out-of-tree external kernel modules (e.g. cluster files System) that 
> require extra locking for various purposes. We've found several 
> deadlocks issues in Global File System (GFS) Direct IO path due to lock 
> order enforced by VFS layer:
>                                                                                
> 
> 1) In sys_ftruncate()->do_truncate(), VFS layer grabs
>  * i_sem
>  * then i_alloc_sem (i_mutex)
>  * then call filesystem's setattr().
>                                                                                
> 
> 2) In Direct IO read, VFS layer calls
>  * filesystem's direct_IO()
>  * grabs i_sem (i_mutex)
>  * followed by i_alloc_sem.
> 
> In our case, both gfs_setattr() and gfs_direct_IO() need its own 
> (global) locks to synchronize inter-nodes (and inter-processes) control 
> structures access but gfs_direct_IO later ends up in 
> __blockdev_direct_IO path that deadlocks with i_sem (i_mutex) and 
> i_alloc_sem.
>                                                                                
> 
> A new DIO flag is added into our distribution (2.6.9 based) to work 
> around the problem by moving the inode semaphore acquiring within 
> __blockdev_direct_IO() (patch attached) into GFS code path (so lock 
> order can be re-arranged). The new lock granularity is not ideal but it 
> gets us out of this deadlock.

Could you help me understand in a little more detail why DIO_OWN_LOCKING
does not work for you ? Is the releasing of i_sem during READ a problem ?
Doesn't holding i_sem for the entire duration of IO for read slow down
concurrent DIO reads to different parts of the file ?

> 
> We havn't had a chance to go thru your mail (and patch) in details yet 
> but would like bring up this issue earlier before it gets messy.
>                                                                                                                                                             
One of the things I wanted to achieve in the proposal was to avoid
the need for these various locking mode flag checks in the DIO code,
leaving it to the higher level to just select the right entry points,
i.e. the _nolock or lock versions of generic_file_aio_write et al.
Would appreciate your thoughts on this, once you've had a chance to
go throught it.

Regards
Suparna

> 
> -- Wendy
> 
> 

> --- linux-2.6.9-22.EL/include/linux/fs.h	2005-12-07 12:43:55.000000000 -0500
> +++ linux.truncate/include/linux/fs.h	2005-12-02 00:25:22.000000000 -0500
> @@ -1509,7 +1509,8 @@ ssize_t __blockdev_direct_IO(int rw, str
>  	int lock_type);
>  
>  enum {
> -	DIO_LOCKING = 1, /* need locking between buffered and direct access */
> +	DIO_CLUSTER_LOCKING = 0, /* allow (cluster) fs handle its own locking */
> +	DIO_LOCKING,     /* need locking between buffered and direct access */
>  	DIO_NO_LOCKING,  /* bdev; no locking at all between buffered/direct */
>  	DIO_OWN_LOCKING, /* filesystem locks buffered and direct internally */
>  };
> @@ -1541,6 +1542,15 @@ static inline ssize_t blockdev_direct_IO
>  				nr_segs, get_blocks, end_io, DIO_OWN_LOCKING);
>  }
>  
> +static inline ssize_t blockdev_direct_IO_cluster_locking(int rw, struct kiocb *iocb,
> +	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
> +	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks,
> +	dio_iodone_t end_io)
> +{
> +	return __blockdev_direct_IO(rw, iocb, inode, bdev, iov, offset,
> +			nr_segs, get_blocks, end_io, DIO_CLUSTER_LOCKING);
> +}
> +
>  extern struct file_operations generic_ro_fops;
>  
>  #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
> --- linux-2.6.9-22.EL/fs/direct-io.c	2005-11-09 17:26:02.000000000 -0500
> +++ linux.truncate/fs/direct-io.c	2005-12-07 12:27:17.000000000 -0500
> @@ -515,7 +515,7 @@ static int get_more_blocks(struct dio *d
>  			fs_count++;
>  
>  		create = dio->rw == WRITE;
> -		if (dio->lock_type == DIO_LOCKING) {
> +		if ((dio->lock_type == DIO_LOCKING) || (dio->lock_type == DIO_CLUSTER_LOCKING)) {
>  			if (dio->block_in_file < (i_size_read(dio->inode) >>
>  							dio->blkbits))
>  				create = 0;
> @@ -1183,9 +1183,16 @@ __blockdev_direct_IO(int rw, struct kioc
>  	 * For regular files using DIO_OWN_LOCKING,
>  	 *	neither readers nor writers take any locks here
>  	 *	(i_sem is already held and release for writers here)
> +	 * The DIO_CLUSTER_LOCKING allows (cluster) filesystem manages its own
> +	 *	locking (bypassing i_sem and i_alloc_sem handling within
> +	 *	__blockdev_direct_IO()).
>  	 */
> +
>  	dio->lock_type = dio_lock_type;
> -	if (dio_lock_type != DIO_NO_LOCKING) {
> +	if (dio_lock_type == DIO_CLUSTER_LOCKING)
> +		goto cluster_skip_locking;
> +
> +	if (dio_lock_type != DIO_NO_LOCKING) { 
>  		if (rw == READ) {
>  			struct address_space *mapping;
>  
> @@ -1205,6 +1212,9 @@ __blockdev_direct_IO(int rw, struct kioc
>  		if (dio_lock_type == DIO_LOCKING)
>  			down_read(&inode->i_alloc_sem);
>  	}
> +
> +cluster_skip_locking:
> +
>  	/*
>  	 * For file extending writes updating i_size before data
>  	 * writeouts complete can expose uninitialized blocks. So


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

