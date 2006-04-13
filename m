Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWDMAxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWDMAxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 20:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWDMAxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 20:53:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:59318 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932389AbWDMAxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 20:53:23 -0400
Date: Wed, 12 Apr 2006 17:53:56 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix file lookup without ref
Message-ID: <20060413005356.GF1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060412183106.GD25957@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060412183106.GD25957@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 12:01:06AM +0530, Dipankar Sarma wrote:
> This patch fixes a problem with some places in the kernel where
> we look up file structure from the fd table but don't hold
> a reference to the file. Those places cannot be lock-free.
> These places aren't in fast path, so it is not a problem.
> I have tested this patch on powerpc and x86_64 using basic
> tests and ltp. We should aim to merge this for 2.6.17.
> 
> Thanks
> Dipankar
> 
> 
> 
> There are places in the kernel where we look up files in fd tables 
> and access the file structure without holding refereces to the file. 
> So, we need special care to avoid the race between
> looking up files in the fd table and tearing down of the file
> in another CPU. Otherwise, one might see a NULL f_dentry or
> such torn down version of the file. This patch fixes those
> special places where such a race may happen.

Acked-by: <paulmck@us.ibm.com>
> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> ---
> 
> 
>  drivers/char/tty_io.c |    8 ++++++--
>  fs/locks.c            |    9 +++++++--
>  fs/proc/base.c        |   21 +++++++++++++++------
>  3 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff -puN drivers/char/tty_io.c~fix-proc-fd-ops drivers/char/tty_io.c
> --- linux-2.6.16-rcu/drivers/char/tty_io.c~fix-proc-fd-ops	2006-04-12 21:06:24.000000000 +0530
> +++ linux-2.6.16-rcu-dipankar/drivers/char/tty_io.c	2006-04-12 21:06:24.000000000 +0530
> @@ -2706,7 +2706,11 @@ static void __do_SAK(void *arg)
>  		}
>  		task_lock(p);
>  		if (p->files) {
> -			rcu_read_lock();
> +			/*
> +			 * We don't take a ref to the file, so we must
> +			 * hold ->file_lock instead.
> +			 */
> +			spin_lock(&p->files->file_lock);
>  			fdt = files_fdtable(p->files);
>  			for (i=0; i < fdt->max_fds; i++) {
>  				filp = fcheck_files(p->files, i);
> @@ -2721,7 +2725,7 @@ static void __do_SAK(void *arg)
>  					break;
>  				}
>  			}
> -			rcu_read_unlock();
> +			spin_unlock(&p->files->file_lock);
>  		}
>  		task_unlock(p);
>  	} while_each_task_pid(session, PIDTYPE_SID, p);
> diff -puN fs/locks.c~fix-proc-fd-ops fs/locks.c
> --- linux-2.6.16-rcu/fs/locks.c~fix-proc-fd-ops	2006-04-12 21:06:24.000000000 +0530
> +++ linux-2.6.16-rcu-dipankar/fs/locks.c	2006-04-12 21:06:24.000000000 +0530
> @@ -2212,7 +2212,12 @@ void steal_locks(fl_owner_t from)
>  
>  	lock_kernel();
>  	j = 0;
> -	rcu_read_lock();
> +
> +	/*
> +	 * We are not taking a ref to the file structures, so
> +	 * we need to acquire ->file_lock.
> +	 */
> +	spin_lock(&files->file_lock);
>  	fdt = files_fdtable(files);
>  	for (;;) {
>  		unsigned long set;
> @@ -2230,7 +2235,7 @@ void steal_locks(fl_owner_t from)
>  			set >>= 1;
>  		}
>  	}
> -	rcu_read_unlock();
> +	spin_unlock(&files->file_lock);
>  	unlock_kernel();
>  }
>  EXPORT_SYMBOL(steal_locks);
> diff -puN fs/proc/base.c~fix-proc-fd-ops fs/proc/base.c
> --- linux-2.6.16-rcu/fs/proc/base.c~fix-proc-fd-ops	2006-04-12 21:06:24.000000000 +0530
> +++ linux-2.6.16-rcu-dipankar/fs/proc/base.c	2006-04-12 21:06:24.000000000 +0530
> @@ -294,16 +294,20 @@ static int proc_fd_link(struct inode *in
>  
>  	files = get_files_struct(task);
>  	if (files) {
> -		rcu_read_lock();
> +		/*
> +		 * We are not taking a ref to the file structure, so we must
> +		 * hold ->file_lock.
> +		 */
> +		spin_lock(&files->file_lock);
>  		file = fcheck_files(files, fd);
>  		if (file) {
>  			*mnt = mntget(file->f_vfsmnt);
>  			*dentry = dget(file->f_dentry);
> -			rcu_read_unlock();
> +			spin_unlock(&files->file_lock);
>  			put_files_struct(files);
>  			return 0;
>  		}
> -		rcu_read_unlock();
> +		spin_unlock(&files->file_lock);
>  		put_files_struct(files);
>  	}
>  	return -ENOENT;
> @@ -1485,7 +1489,12 @@ static struct dentry *proc_lookupfd(stru
>  	if (!files)
>  		goto out_unlock;
>  	inode->i_mode = S_IFLNK;
> -	rcu_read_lock();
> +
> +	/*
> +	 * We are not taking a ref to the file structure, so we must
> +	 * hold ->file_lock.
> +	 */
> +	spin_lock(&files->file_lock);
>  	file = fcheck_files(files, fd);
>  	if (!file)
>  		goto out_unlock2;
> @@ -1493,7 +1502,7 @@ static struct dentry *proc_lookupfd(stru
>  		inode->i_mode |= S_IRUSR | S_IXUSR;
>  	if (file->f_mode & 2)
>  		inode->i_mode |= S_IWUSR | S_IXUSR;
> -	rcu_read_unlock();
> +	spin_unlock(&files->file_lock);
>  	put_files_struct(files);
>  	inode->i_op = &proc_pid_link_inode_operations;
>  	inode->i_size = 64;
> @@ -1503,7 +1512,7 @@ static struct dentry *proc_lookupfd(stru
>  	return NULL;
>  
>  out_unlock2:
> -	rcu_read_unlock();
> +	spin_unlock(&files->file_lock);
>  	put_files_struct(files);
>  out_unlock:
>  	iput(inode);
> 
> _
