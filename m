Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSGIHgD>; Tue, 9 Jul 2002 03:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGIHgD>; Tue, 9 Jul 2002 03:36:03 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:52182 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317327AbSGIHf7>;
	Tue, 9 Jul 2002 03:35:59 -0400
Date: Tue, 9 Jul 2002 17:37:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: IB-Ammer@t-online.de (Dr. Markus Ammer, Ingenieurb)
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel op-locks not in alpha-kernel ?
Message-Id: <20020709173739.2f969cc7.sfr@canb.auug.org.au>
In-Reply-To: <001101c22712$f51d54f0$0700a8c0@ibammer>
References: <001101c22712$f51d54f0$0700a8c0@ibammer>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Tue, 9 Jul 2002 08:36:25 +0200 IB-Ammer@t-online.de (Dr. Markus Ammer, Ingenieurb) wrote:
>
> following has been posted to samba mailing list, but Gerald Carter
> <jerry@samba.org>  answered:
> 
> > You'll probably have to bring this up with the linux-kernel mailing list.
> > Not sure who is maintaining that code in the kernel now.

I am ...

> I have a Compaq Alpha server with Linux 2.4.18 and samba 2.2.4 and
> NT-clients.

Is this an SMP box?

> Problem: After accessing a file from a NT-client this file cannot be
> accessed on the Linux side for a while.
> 
> Example:
> Creating the file on the server (via telnet session):
>      echo test >file
> 
> accessing the file from the NT-client (gives "test"):
>      TYPE file
> 
> try to access it on the server (via telnet session):
>      cat test
>  cat: file: Invalid argument
> 
> After waiting approx. 40 sec. it succeeds.
> 
> This problem does not occur with "kernel oplocks=no" in /etc/smb.conf, but
> file contents are not consistent then.
> 
> The same configuration on an Intel server (2.4.16, samba 2.2.3a) works.

OK, can you try a kernel patch for me?  I have submitted this patch, but
it will (almost certainly) not be in 2.4.19.

This patch is against 2.4.19-pre10, but should apply equally well to
2.4.18.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.19-pre10/fs/locks.c 2.4.19-pre10-leases.2/fs/locks.c
--- 2.4.19-pre10/fs/locks.c	Wed Oct 24 16:12:29 2001
+++ 2.4.19-pre10-leases.2/fs/locks.c	Tue Jun 11 17:18:38 2002
@@ -121,6 +121,7 @@
 #include <linux/init.h>
 #include <linux/capability.h>
 #include <linux/sched.h>
+#include <linux/timer.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -1051,6 +1052,47 @@
 	return -EINVAL;
 }
 
+/* We already had a lease on this file; just change its type */
+static int lease_modify(struct file_lock **before, int arg)
+{
+	struct file_lock *fl = *before;
+	int error = assign_type(fl, arg);
+
+	if (error)
+		return error;
+	locks_wake_up_blocks(fl, 0);
+	if (arg == F_UNLCK) {
+		struct file *filp = fl->fl_file;
+
+		filp->f_owner.pid = 0;
+		filp->f_owner.uid = 0;
+		filp->f_owner.euid = 0;
+		filp->f_owner.signum = 0;
+		locks_delete_lock(before, 0);
+	}
+	return 0;
+}
+
+static void time_out_leases(struct inode *inode)
+{
+	struct file_lock **before;
+	struct file_lock *fl;
+
+	before = &inode->i_flock;
+	while ((fl = *before) && (fl->fl_flags & FL_LEASE)
+			&& (fl->fl_type & F_INPROGRESS)) {
+		if ((fl->fl_break_time == 0)
+				|| time_before(jiffies, fl->fl_break_time)) {
+			before = &fl->fl_next;
+			continue;
+		}
+		printk(KERN_INFO "lease broken - owner pid = %d\n", fl->fl_pid);
+		lease_modify(before, fl->fl_type & ~F_INPROGRESS);
+		if (fl == *before)	/* lease_modify may have freed fl */
+			before = &fl->fl_next;
+	}
+}
+
 /**
  *	__get_lease	-	revoke all outstanding leases on file
  *	@inode: the inode of the file to return
@@ -1067,34 +1109,30 @@
 	struct file_lock *new_fl, *flock;
 	struct file_lock *fl;
 	int alloc_err;
+	unsigned long break_time;
+	int i_have_this_lease = 0;
 
-	alloc_err = lease_alloc(NULL, 0, &new_fl);
+	alloc_err = lease_alloc(NULL, mode & FMODE_WRITE ? F_WRLCK : F_RDLCK,
+			&new_fl);
 
 	lock_kernel();
+
+	time_out_leases(inode);
+
 	flock = inode->i_flock;
-	if (flock->fl_type & F_INPROGRESS) {
-		if ((mode & O_NONBLOCK)
-		    || (flock->fl_owner == current->files)) {
-			error = -EWOULDBLOCK;
-			goto out;
-		}
-		if (alloc_err != 0) {
-			error = alloc_err;
-			goto out;
-		}
-		do {
-			error = locks_block_on(flock, new_fl);
-			if (error != 0)
-				goto out;
-			flock = inode->i_flock;
-			if (!(flock && (flock->fl_flags & FL_LEASE)))
-				goto out;
-		} while (flock->fl_type & F_INPROGRESS);
-	}
+	if ((flock == NULL) || (flock->fl_flags & FL_LEASE) == 0)
+		goto out;
+
+	for (fl = flock; fl && (fl->fl_flags & FL_LEASE); fl = fl->fl_next)
+		if (fl->fl_owner == current->files)
+			i_have_this_lease = 1;
 
 	if (mode & FMODE_WRITE) {
 		/* If we want write access, we have to revoke any lease. */
 		future = F_UNLCK | F_INPROGRESS;
+	} else if (flock->fl_type & F_INPROGRESS) {
+		/* If the lease is already being broken, we just leave it */
+		future = flock->fl_type;
 	} else if (flock->fl_type & F_WRLCK) {
 		/* Downgrade the exclusive lease to a read-only lease. */
 		future = F_RDLCK | F_INPROGRESS;
@@ -1103,38 +1141,49 @@
 		goto out;
 	}
 
-	if (alloc_err && (flock->fl_owner != current->files)) {
+	if (alloc_err && !i_have_this_lease && ((mode & O_NONBLOCK) == 0)) {
 		error = alloc_err;
 		goto out;
 	}
 
-	fl = flock;
-	do {
-		fl->fl_type = future;
-		fl = fl->fl_next;
-	} while (fl != NULL && (fl->fl_flags & FL_LEASE));
+	break_time = 0;
+	if (lease_break_time > 0) {
+		break_time = jiffies + lease_break_time * HZ;
+		if (break_time == 0)
+			break_time++;	/* so that 0 means no break time */
+	}
 
-	kill_fasync(&flock->fl_fasync, SIGIO, POLL_MSG);
+	for (fl = flock; fl && (fl->fl_flags & FL_LEASE); fl = fl->fl_next) {
+		if (fl->fl_type != future) {
+			fl->fl_type = future;
+			fl->fl_break_time = break_time;
+			kill_fasync(&fl->fl_fasync, SIGIO, POLL_MSG);
+		}
+	}
 
-	if ((mode & O_NONBLOCK) || (flock->fl_owner == current->files)) {
+	if (i_have_this_lease || (mode & O_NONBLOCK)) {
 		error = -EWOULDBLOCK;
 		goto out;
 	}
 
-	if (lease_break_time > 0)
-		error = lease_break_time * HZ;
-	else
-		error = 0;
 restart:
-	error = locks_block_on_timeout(flock, new_fl, error);
-	if (error == 0) {
-		/* We timed out.  Unilaterally break the lease. */
-		locks_delete_lock(&inode->i_flock, 0);
-		printk(KERN_WARNING "lease timed out\n");
-	} else if (error > 0) {
-		flock = inode->i_flock;
-		if (flock && (flock->fl_flags & FL_LEASE))
-			goto restart;
+	break_time = flock->fl_break_time;
+	if (break_time != 0) {
+		break_time -= jiffies;
+		if (break_time == 0)
+			break_time++;
+	}
+	error = locks_block_on_timeout(flock, new_fl, break_time);
+	if (error >= 0) {
+		if (error == 0)
+			time_out_leases(inode);
+		/* Wait for the next lease that has not been broken yet */
+		for (flock = inode->i_flock;
+				flock && (flock->fl_flags & FL_LEASE);
+				flock = flock->fl_next) {
+			if (flock->fl_type & F_INPROGRESS)
+				goto restart;
+		}
 		error = 0;
 	}
 
@@ -1166,45 +1215,41 @@
  *	@filp: the file
  *
  *	The value returned by this function will be one of
+ *	(if no lease break is pending):
  *
- *	%F_RDLCK to indicate a read-only (type II) lease is held.
+ *	%F_RDLCK to indicate a shared lease is held.
  *
  *	%F_WRLCK to indicate an exclusive lease is held.
  *
- *	XXX: sfr & i disagree over whether F_INPROGRESS
+ *	%F_UNLCK to indicate no lease is held.
+ *
+ *	(if a lease break is pending):
+ *
+ *	%F_RDLCK to indicate an exclusive lease needs to be
+ *		changed to a shared lease (or removed).
+ *
+ *	%F_UNLCK to indicate the lease needs to be removed.
+ *
+ *	XXX: sfr & willy disagree over whether F_INPROGRESS
  *	should be returned to userspace.
  */
 int fcntl_getlease(struct file *filp)
 {
 	struct file_lock *fl;
-	
-	fl = filp->f_dentry->d_inode->i_flock;
-	if ((fl == NULL) || ((fl->fl_flags & FL_LEASE) == 0))
-		return F_UNLCK;
-	return fl->fl_type & ~F_INPROGRESS;
-}
+	int type = F_UNLCK;
 
-/* We already had a lease on this file; just change its type */
-static int lease_modify(struct file_lock **before, int arg, int fd, struct file *filp)
-{
-	struct file_lock *fl = *before;
-	int error = assign_type(fl, arg);
-	if (error < 0)
-		goto out;
-
-	locks_wake_up_blocks(fl, 0);
-
-	if (arg == F_UNLCK) {
-		filp->f_owner.pid = 0;
-		filp->f_owner.uid = 0;
-		filp->f_owner.euid = 0;
-		filp->f_owner.signum = 0;
-		locks_delete_lock(before, 0);
-		fasync_helper(fd, filp, 0, &fl->fl_fasync);
+	lock_kernel();
+	time_out_leases(filp->f_dentry->d_inode);
+	for (fl = filp->f_dentry->d_inode->i_flock;
+			fl && (fl->fl_flags & FL_LEASE);
+			fl = fl->fl_next) {
+		if (fl->fl_file == filp) {
+			type = fl->fl_type & ~F_INPROGRESS;
+			break;
+		}
 	}
-
-out:
-	return error;
+	unlock_kernel();
+	return type;
 }
 
 /**
@@ -1232,50 +1277,59 @@
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
+	lock_kernel();
+
+	time_out_leases(inode);
+
 	/*
 	 * FIXME: What about F_RDLCK and files open for writing?
 	 */
+	error = -EAGAIN;
 	if ((arg == F_WRLCK)
 	    && ((atomic_read(&dentry->d_count) > 1)
 		|| (atomic_read(&inode->i_count) > 1)))
-		return -EAGAIN;
-
-	before = &inode->i_flock;
-
-	lock_kernel();
+		goto out_unlock;
 
-	while ((fl = *before) != NULL) {
-		if (fl->fl_flags != FL_LEASE)
-			break;
+	/*
+	 * At this point, we know that if there is an exclusive
+	 * lease on this file, then we hold it on this filp
+	 * (otherwise our open of this file would have blocked).
+	 * And if we are trying to acquire an exclusive lease,
+	 * then the file is not open by anyone (including us)
+	 * except for this filp.
+	 */
+	for (before = &inode->i_flock;
+			((fl = *before) != NULL) && (fl->fl_flags & FL_LEASE);
+			before = &fl->fl_next) {
 		if (fl->fl_file == filp)
 			my_before = before;
-		else if (fl->fl_type & F_WRLCK)
+		else if (fl->fl_type == (F_INPROGRESS | F_UNLCK))
+			/*
+			 * Someone is in the process of opening this
+			 * file for writing so we may not take an
+			 * exclusive lease on it.
+			 */
 			wrlease_count++;
 		else
 			rdlease_count++;
-		before = &fl->fl_next;
 	}
 
 	if ((arg == F_RDLCK && (wrlease_count > 0)) ||
-	    (arg == F_WRLCK && ((rdlease_count + wrlease_count) > 0))) {
-		error = -EAGAIN;
+	    (arg == F_WRLCK && ((rdlease_count + wrlease_count) > 0)))
 		goto out_unlock;
-	}
 
 	if (my_before != NULL) {
-		error = lease_modify(my_before, arg, fd, filp);
+		error = lease_modify(my_before, arg);
 		goto out_unlock;
 	}
 
-	if (arg == F_UNLCK) {
-		error = 0;
+	error = 0;
+	if (arg == F_UNLCK)
 		goto out_unlock;
-	}
 
-	if (!leases_enable) {
-		error = -EINVAL;
+	error = -EINVAL;
+	if (!leases_enable)
 		goto out_unlock;
-	}
 
 	error = lease_alloc(filp, arg, &fl);
 	if (error)
@@ -1710,10 +1764,15 @@
 	before = &inode->i_flock;
 
 	while ((fl = *before) != NULL) {
-		if ((fl->fl_flags & (FL_FLOCK|FL_LEASE))
-		    && (fl->fl_file == filp)) {
-			locks_delete_lock(before, 0);
-			continue;
+		if (fl->fl_file == filp) {
+			if (fl->fl_flags & FL_FLOCK) {
+				locks_delete_lock(before, 0);
+				continue;
+			}
+			if (fl->fl_flags & FL_LEASE) {
+				lease_modify(before, F_UNLCK);
+				continue;
+			}
  		}
 		before = &fl->fl_next;
 	}
@@ -1769,7 +1828,13 @@
 #endif
 			out += sprintf(out, "FLOCK  ADVISORY  ");
 	} else if (fl->fl_flags & FL_LEASE) {
-		out += sprintf(out, "LEASE  MANDATORY ");
+		out += sprintf(out, "LEASE  ");
+		if (fl->fl_type & F_INPROGRESS)
+			out += sprintf(out, "BREAKING  ");
+		else if (fl->fl_file)
+			out += sprintf(out, "ACTIVE    ");
+		else
+			out += sprintf(out, "BREAKER   ");
 	} else {
 		out += sprintf(out, "UNKNOWN UNKNOWN  ");
 	}
@@ -1782,7 +1847,9 @@
 	} else
 #endif
 		out += sprintf(out, "%s ",
-			       (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
+			       (fl->fl_type & F_INPROGRESS)
+			       ? (fl->fl_type & F_UNLCK) ? "UNLCK" : "READ "
+			       : (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
 	out += sprintf(out, "%d %s:%ld ",
 		     fl->fl_pid,
 		     inode ? kdevname(inode->i_dev) : "<none>",
diff -ruN 2.4.19-pre10/include/linux/fs.h 2.4.19-pre10-leases.2/include/linux/fs.h
--- 2.4.19-pre10/include/linux/fs.h	Tue Jun  4 13:56:34 2002
+++ 2.4.19-pre10-leases.2/include/linux/fs.h	Tue Jun 11 13:50:05 2002
@@ -595,6 +595,7 @@
 	void (*fl_remove)(struct file_lock *);	/* lock removal callback */
 
 	struct fasync_struct *	fl_fasync; /* for lease break notifications */
+	unsigned long fl_break_time;	/* for nonblocking lease breaks */
 
 	union {
 		struct nfs_lock_info	nfs_fl;
