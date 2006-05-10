Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWEJGyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWEJGyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 02:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWEJGyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 02:54:19 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:19584 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751049AbWEJGyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 02:54:19 -0400
Date: Tue, 9 May 2006 23:53:03 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200605100653.k4A6r3Qw007727@wezen.cs.pdx.edu>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: commit of [PATCH] Fix file lookup without ref
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
In studying proc_readfd() of fs/proc/base.c, I'd looked back
at the linux-2.5.60 version which was prior to the conversion
to RCU and noticed that rather than straight spin_lock() as 
introduced in this patch, proc_fd_link() and proc_lookupfd() 
used read_lock(&files->file_lock).  Similarly, for __do_SAK() 
in drivers/char/tty_io.c

Just thought it might be something to consider after seeing 
http://www.ussg.iu.edu/hypermail/linux/kernel/9801.0/0095.html

Thanks.
Suzanne

 > List:       git-commits-head
 > Subject:    [PATCH] Fix file lookup without ref
 > From:       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
 > Date:       2006-04-19 17:00:12
 > 
 > commit ca99c1da080345e227cfb083c330a184d42e27f3
 > tree e417b4c456ae31dc1dde8027b6be44a1a9f19395
 > parent fb30d64568fd8f6a21afef987f11852a109723da
 > author Dipankar Sarma <dipankar@in.ibm.com> Wed, 19 Apr 2006 12:21:46 -0700
 > committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 19 Apr 2006 23:13:51 -0700
 > 
 > [PATCH] Fix file lookup without ref
 > 
 > There are places in the kernel where we look up files in fd tables and
 > access the file structure without holding refereces to the file.  So, we
 > need special care to avoid the race between looking up files in the fd
 > table and tearing down of the file in another CPU.  Otherwise, one might
 > see a NULL f_dentry or such torn down version of the file.  This patch
 > fixes those special places where such a race may happen.
 > 
 > Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
 > Acked-by: "Paul E. McKenney" <paulmck@us.ibm.com>
 > Signed-off-by: Andrew Morton <akpm@osdl.org>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > 
 >  drivers/char/tty_io.c |    8 ++++++--
 >  fs/locks.c            |    9 +++++++--
 >  fs/proc/base.c        |   21 +++++++++++++++------
 >  3 files changed, 28 insertions(+), 10 deletions(-)
 > 
 > diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
 > index 841f0bd..f07637a 100644
 > --- a/drivers/char/tty_io.c
 > +++ b/drivers/char/tty_io.c
 > @@ -2723,7 +2723,11 @@ static void __do_SAK(void *arg)
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
 > @@ -2738,7 +2742,7 @@ static void __do_SAK(void *arg)
 >  					break;
 >  				}
 >  			}
 > -			rcu_read_unlock();
 > +			spin_unlock(&p->files->file_lock);
 >  		}
 >  		task_unlock(p);
 >  	} while_each_thread(g, p);
 > diff --git a/fs/locks.c b/fs/locks.c
 > index dda83d6..efad798 100644
 > --- a/fs/locks.c
 > +++ b/fs/locks.c
 > @@ -2230,7 +2230,12 @@ void steal_locks(fl_owner_t from)
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
 > @@ -2248,7 +2253,7 @@ void steal_locks(fl_owner_t from)
 >  			set >>= 1;
 >  		}
 >  	}
 > -	rcu_read_unlock();
 > +	spin_unlock(&files->file_lock);
 >  	unlock_kernel();
 >  }
 >  EXPORT_SYMBOL(steal_locks);
 > diff --git a/fs/proc/base.c b/fs/proc/base.c
 > index a3a3eec..6cc77dc 100644
 > --- a/fs/proc/base.c
 > +++ b/fs/proc/base.c
 > @@ -297,16 +297,20 @@ static int proc_fd_link(struct inode *in
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
 > @@ -1523,7 +1527,12 @@ static struct dentry *proc_lookupfd(stru
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
 > @@ -1531,7 +1540,7 @@ static struct dentry *proc_lookupfd(stru
 >  		inode->i_mode |= S_IRUSR | S_IXUSR;
 >  	if (file->f_mode & 2)
 >  		inode->i_mode |= S_IWUSR | S_IXUSR;
 > -	rcu_read_unlock();
 > +	spin_unlock(&files->file_lock);
 >  	put_files_struct(files);
 >  	inode->i_op = &proc_pid_link_inode_operations;
 >  	inode->i_size = 64;
 > @@ -1541,7 +1550,7 @@ static struct dentry *proc_lookupfd(stru
 >  	return NULL;
 >  
 >  out_unlock2:
 > -	rcu_read_unlock();
 > +	spin_unlock(&files->file_lock);
 >  	put_files_struct(files);
 >  out_unlock:
 >  	iput(inode);
 > -
