Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317696AbSGKAxi>; Wed, 10 Jul 2002 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317695AbSGKAxg>; Wed, 10 Jul 2002 20:53:36 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:48366 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317694AbSGKAx1>; Wed, 10 Jul 2002 20:53:27 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 10 Jul 2002 18:54:24 -0600
To: Daniel Phillips <phillips@arcor.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
Message-ID: <20020711005424.GE1045@clusterfs.com>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SPsV-00028p-00@starship> <20020710233616.GA696482@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020710233616.GA696482@sgi.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 10, 2002  16:36 -0700, Jesse Barnes wrote:
> Sounds like a great idea to me.  Were you thinking of something along
> the lines of what I have below or perhaps something more
> sophisticated?  I suppose it would be helpful to have the name of the
> lock in addition to the file and line number...
> 
> Jesse
> 
> 
> diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/fs/inode.c linux-2.5.25-spinassert/fs/inode.c
> --- linux-2.5.25/fs/inode.c	Fri Jul  5 16:42:38 2002
> +++ linux-2.5.25-spinassert/fs/inode.c	Wed Jul 10 16:30:18 2002
> @@ -183,6 +183,8 @@
>   */
>  void __iget(struct inode * inode)
>  {
> +	spin_assert_locked(&inode_lock);
> +
>  	if (atomic_read(&inode->i_count)) {
>  		atomic_inc(&inode->i_count);
>  		return;
> diff -Naur -X /home/jbarnes/dontdiff linux-2.5.25/include/linux/spinlock.h linux-2.5.25-spinassert/include/linux/spinlock.h
> --- linux-2.5.25/include/linux/spinlock.h	Fri Jul  5 16:42:24 2002
> +++ linux-2.5.25-spinassert/include/linux/spinlock.h	Wed Jul 10 16:20:06 2002
> @@ -118,6 +118,18 @@
>  
>  #endif /* !SMP */
>  
> +/*
> + * Simple lock assertions for debugging and documenting where locks need
> + * to be locked/unlocked.
> + */
> +#ifdef CONFIG_DEBUG_SPINLOCK
> +#define spin_assert_locked(lock)	if (!spin_is_locked(lock)) { printk("lock assertion failure: lock at %s:%d should be locked!\n", __FILE__, __LINE__); }

You can use CPP to add in the lock name like:

#define spin_assert_locked(lock)	if (!spin_is_locked(lock))	\
	printk("lock assertion error: %s:%d: " #lock			\
	       " should be locked!\n", __FILE__, __LINE__)

#define spin_assert_unlocked(lock)	if (!spin_is_locked(lock))	\
	printk("lock assertion error: %s:%d: " #lock			\
	       " should be unlocked!\n", __FILE__, __LINE__)

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

