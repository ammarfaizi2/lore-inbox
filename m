Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTFINi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbTFINi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:38:27 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:47646 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261874AbTFINiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:38:16 -0400
Date: Mon, 9 Jun 2003 06:51:41 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030609065141.A9781@google.com>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030603165438.A24791@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030603165438.A24791@google.com>; from fcusack@fcusack.com on Tue, Jun 03, 2003 at 04:54:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OK, I've studied this a lot more and think I've figured it out.  I think
calling it a race is incorrect, but I don't know how to succintly describe
the problem otherwise.

Let's look at the first attachment, a test case which shows the problem.
When run against a Solaris NFS server, the readdir()/unlink() loop returns
".", "..", "foo", NULL, and the rmdir fails.  I suspect a Linux NFS
server does the same.  But when run against a netapp, it returns
".", "..", "foo", ".nfs...", NULL, ie it picks up the sillyrenamed
file immediately, and this allows the rmdir to succeed.

When foo is unlinked, nfs_unlink() does a sillyrename, this puts the
dentry on nfs_delete_queue, and (in the VFS) unhashes it from the dcache.
This causes a problem, because dentry->d_parent->d_inode is now guaranteed
to remain stale.  (OK, I'm not really sure about this last part.)

Then readdir() returns the new .nfs file, this creates a NEW dentry
(we just moved the first one to nfs_delete_queue and did not create a
negative dentry) which now has d_count==1 so instead of sillyrename we
just remove it (but note, we actually have this file open).  Then rmdir
succeeeds.

Now, we have a dentry on nfs_delete_queue which a) has already been
unlinked and b) whose dentry->d_parent DNE and dentry->d_parent->d_inode
DNE.  Of course this will cause confusion later!

Note that if a process does a drive by on the .nfs file (another round
of unlinked-but-open) before we unlink it, we would sillyrename it again.
We'd now have two different dentry's on the delete queue for the same
file.  (One of them would just leak, I think--possible local DoS?)

Also note that in vfs_unlink(), we do a d_delete() after the
i_op->unlink(), I think this guarantees that no call to sillyrename will
ever be passed a dentry with the DCACHE_NFSFS_RENAMED flag set (it gets
set in sillyrename, but then unhashed; the next time through vfs_unlink()
we have a new dentry with no flags set).  The DCACHE_NFSFS_RENAMED bit
looks to be a holdover from 2.2, where the dentry doesn't get unhashed.

I have 3 proposals for fixes, I've implemented 2 of them and patches
are attached against both 2.4.21-rc7 and 2.5.70.

1) Don't unhash the dentry after silly-renaming.  In 2.2, each fs is
   responsible for doing a d_delete(), in 2.4 it happens in the VFS and
   I think it was just an oversight that the 2.4 VFS doesn't consider
   sillyrename (considering the code and comments that are cruft).

   This preserves the unlinked-but-open semantic, but breaks rmdir.  So
   it's not a clear winner from a semantics POV.  dentry->d_count is
   always correct, which sounds like a plus.

   The patch to make this work is utterly simple, which is a big plus.

2a) In nfs_unlink(), if not sillyrenaming, look for the file on
    nfs_delete_queue.  If present, remove it (since it's now extra).

    This has the advantage of preserving the 'rm -rf' semantic, but
    breaks unlinked-but-open since the parent dir can go away, and
    dentry->d_count is not guaranteed to be correct.

    I've implemented but not included this.

2b) Since this is really only a problem when the parent dir goes away,
    do the same as above but only scan the queue in nfs_rmdir(), and
    mark any entries whose d_parent is "us".

    I've included this in favor of (2a) because it's simpler and should
    give better performance in the common case.

3) In nfs_complete_unlink(), do a d_lookup() before waking the rpc task.
   If an entry is found, go head and schedule the rpc.  If no entry is
   found, or a negative entry is found, just remove from the queue.

   I couldn't get this to work.

With the #2 patch, I've taken the liberty of cleaning up stale comments.
How annoying they were while trying to understand the code. :-(  I would
have done the same for the #1 patch, but it's so small that I didn't
want to otherwise "pollute" it.  If you decide to go with the #1 patch,
at least do look at the #2 patch for comment fixups.
   
If you need more data to convince yourself of this bug, I'm definitely
able to provide more data, just tell me what you'd like to see.  But I
hope I've adequately described it.

/fc

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfsbug.c"

/*
 * nfsbug.c
 * exercises a bug in Linux 2.4/2.5 client NFS
 * If the parent directory of an unlinked-but-open file goes away,
 * kernel reports "inode mismatch".
 *
 * nfsbug <nfsdir>
 */

#include <stdio.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dirent.h>
#include <unistd.h>

int
main(int argc, char *argv[])
{
    char path[2048];
    char file[2048];
    int fd;
    int v = 1, r;
    struct dirent *d;
    DIR *dir;

    if (argc != 2)
	exit(1);

    /* create a dir "t" under <nfsdir> */
    sprintf(path, "%s/%s", argv[1], "t");
    if (mkdir(path, 0777) < 0)
	exit(1);

    /* create a file "foo" under <nfsdir>/t */
    sprintf(file, "%s/%s", path, "foo");
    if ((fd = open(file, O_CREAT, 0666)) < 0)
	exit(1);

    /*
     * ok, we're now holding the file open, do an rm -rf.
     * We have to readdir() because unlinking <file> over NFS does a rename
     * (otherwise we could just unlink it and then do rmdir).
     * The readdir() returns foo, then the renamed file (which, when unlinked,
     * really gets unlinked, not renamed).
     */
    if ((dir = opendir(path)) == NULL)
	exit(1);
    while (d = readdir(dir)) {
	if (!strcmp(".", d->d_name) || !strcmp("..", d->d_name))
	    continue;
	sprintf(file, "%s/%s", path, d->d_name);
	r = unlink(file);
	if (v && r == 0)
	    printf("unlinked %s\n", file);
	else if (v && r < 0)
	    printf("failed to unlink %s\n", file);
    }
    if (rmdir(path) < 0)
	printf("failed to rmdir %s\n", path);
    else
	printf("rmdir-ed %s\n", path);

    /* exit, which tries to unlink the .nfs file again */
    printf("exit: ");
    fgets((char *)&r, 2, stdin);

    exit(0);
}


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.21-rc7-silly-1.patch"

--- linux-2.4.21-rc7/fs/namei.c	Sun Jun  8 23:57:33 2003
+++ linux-2.4.21-rc7-silly/fs/namei.c	Sun Jun  8 23:59:07 2003
@@ -1482,13 +1482,14 @@ int vfs_unlink(struct inode *dir, struct
 				lock_kernel();
 				error = dir->i_op->unlink(dir, dentry);
 				unlock_kernel();
-				if (!error)
+				if (!error &&
+				    !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
 					d_delete(dentry);
 			}
 		}
 	}
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
 		inode_dir_notify(dir, DN_DELETE);
 	return error;
 }

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.5.70-silly-1.patch"

--- linux-2.5.70/fs/namei.c	Sun Jun  1 23:30:30 2003
+++ linux-2.5.70-silly/fs/namei.c	Sun Jun  8 23:43:28 2003
@@ -1631,7 +1631,9 @@ int vfs_unlink(struct inode *dir, struct
 			error = dir->i_op->unlink(dir, dentry);
 	}
 	up(&dentry->d_inode->i_sem);
-	if (!error) {
+
+	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
+	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
 		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);
 	}

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.21-rc7-silly-3.patch"

diff -uNrp linux-2.4.21-rc7/fs/nfs/dir.c linux-2.4.21-rc7-silly/fs/nfs/dir.c
--- linux-2.4.21-rc7/fs/nfs/dir.c	Sun Jun  8 23:49:21 2003
+++ linux-2.4.21-rc7-silly/fs/nfs/dir.c	Mon Jun  9 05:51:48 2003
@@ -738,8 +738,10 @@ static int nfs_rmdir(struct inode *dir, 
 
 	nfs_zap_caches(dir);
 	error = NFS_PROTO(dir)->rmdir(dir, &dentry->d_name);
-	if (!error)
+	if (!error) {
+		nfs_async_unlink_dequeue(dentry);
 		dentry->d_inode->i_nlink = 0;
+	}
 
 	return error;
 }
@@ -772,8 +774,14 @@ dentry->d_parent->d_name.name, dentry->d
 	 * We don't allow a dentry to be silly-renamed twice.
 	 */
 	error = -EBUSY;
-	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
+	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
+#ifdef NFS_PARANOIA
+		printk("NFS: silly-rename %s/%s with DCACHE_NFSFS_RENAMED "
+		       "already set?\n",
+		       dentry->d_parent->d_name.name, dentry->d_name.name);
+#endif
 		goto out;
+	}
 
 	sprintf(silly, ".nfs%*.*lx",
 		i_inosize, i_inosize, dentry->d_inode->i_ino);
diff -uNrp linux-2.4.21-rc7/fs/nfs/unlink.c linux-2.4.21-rc7-silly/fs/nfs/unlink.c
--- linux-2.4.21-rc7/fs/nfs/unlink.c	Sun Jun  8 23:49:21 2003
+++ linux-2.4.21-rc7-silly/fs/nfs/unlink.c	Mon Jun  9 05:55:31 2003
@@ -21,6 +21,7 @@ struct nfs_unlinkdata {
 	struct rpc_task	task;
 	struct rpc_cred	*cred;
 	unsigned int	count;
+	int		noaction;	/* really remove? */
 };
 
 static struct nfs_unlinkdata	*nfs_deletes;
@@ -96,7 +97,7 @@ nfs_async_unlink_init(struct rpc_task *t
 	struct rpc_message	msg;
 	int			status = -ENOENT;
 
-	if (!data->name.len)
+	if (!data->name.len || data->noaction)
 		goto out_err;
 
 	memset(&msg, 0, sizeof(msg));
@@ -151,8 +152,7 @@ nfs_async_unlink_release(struct rpc_task
 
 /**
  * nfs_async_unlink - asynchronous unlinking of a file
- * @dir: directory in which the file resides.
- * @name: name of the file to unlink.
+ * @dentry: dentry to unlink
  */
 int
 nfs_async_unlink(struct dentry *dentry)
@@ -168,7 +168,7 @@ nfs_async_unlink(struct dentry *dentry)
 		goto out;
 	memset(data, 0, sizeof(*data));
 
-	data->dir = dget(dir);
+	data->dir = dget(dir);	/* dput() in nfs_async_unlink_done() */
 	data->dentry = dentry;
 
 	data->next = nfs_deletes;
@@ -191,7 +191,7 @@ nfs_async_unlink(struct dentry *dentry)
 }
 
 /**
- * nfs_complete_remove - Initialize completion of the sillydelete
+ * nfs_complete_unlink - Initialize completion of the sillydelete
  * @dentry: dentry to delete
  *
  * Since we're most likely to be called by dentry_iput(), we
@@ -203,16 +203,46 @@ nfs_complete_unlink(struct dentry *dentr
 {
 	struct nfs_unlinkdata	*data;
 
-	for(data = nfs_deletes; data != NULL; data = data->next) {
+	for (data = nfs_deletes; data != NULL; data = data->next) {
 		if (dentry == data->dentry)
 			break;
 	}
 	if (!data)
 		return;
-	data->count++;
 	nfs_copy_dname(dentry, data);
 	dentry->d_flags &= ~DCACHE_NFSFS_RENAMED;
 	if (data->task.tk_rpcwait == &nfs_delete_queue)
 		rpc_wake_up_task(&data->task);
-	nfs_put_unlinkdata(data);
 }
+
+/**
+ * nfs_async_unlink_dequeue - Remove a previously queued async unlink
+ * @dir: parent dir being rmdir'd
+ *
+ * This function removes all dentrys from nfs_delete_queue whose parent
+ * is @dir.
+ *
+ * When a file is sillydeleted, the dentry gets unhashed and placed on
+ * nfs_delete_queue for a future [async] unlink (when d_count goes to 0).
+ * Since the sillyfile can still be found, it may be unlinked independently,
+ * in which case nfs_delete_queue will have stale data.  When the parent
+ * dir goes away, data->dir being stale is a problem.  This is 1 of 2 reasons
+ * this is only called from rmdir.  The other is for performance; we can
+ * either dequeue on every unlink, or just on rmdir's.
+ *
+ * Just calling this on rmdir isn't ideal though, since we can incur a lot
+ * of extra NFS remove's if sillyrenamed files are themselves unlinked, and
+ * the parent dirs stick around.  rmdir seems more likely though; generally,
+ * sillyrenamed files won't be accessed other than for 'rm -rf' operations.
+ */
+void
+nfs_async_unlink_dequeue(struct dentry *dir)
+{
+	struct nfs_unlinkdata *data;
+
+	/* Don't actually try to do anything when d_count goes to 0. */
+	for (data = nfs_deletes; data != NULL; data = data->next)
+		if (data->dir == dir)
+			data->noaction = 1;
+}
+
diff -uNrp linux-2.4.21-rc7/include/linux/nfs_fs.h linux-2.4.21-rc7-silly/include/linux/nfs_fs.h
--- linux-2.4.21-rc7/include/linux/nfs_fs.h	Sun Jun  8 23:52:55 2003
+++ linux-2.4.21-rc7-silly/include/linux/nfs_fs.h	Mon Jun  9 01:50:14 2003
@@ -198,6 +198,7 @@ extern int nfs_lock(struct file *, int, 
  */
 extern int  nfs_async_unlink(struct dentry *);
 extern void nfs_complete_unlink(struct dentry *);
+extern void nfs_async_unlink_dequeue(struct dentry *);
 
 /*
  * linux/fs/nfs/write.c

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.5.70-silly-3.patch"

diff -uNrp linux-2.5.70/fs/nfs/dir.c linux-2.5.70-silly/fs/nfs/dir.c
--- linux-2.5.70/fs/nfs/dir.c	Sun Jun  1 23:30:30 2003
+++ linux-2.5.70-silly/fs/nfs/dir.c	Mon Jun  9 05:38:44 2003
@@ -894,8 +894,10 @@ static int nfs_rmdir(struct inode *dir, 
 	lock_kernel();
 	nfs_zap_caches(dir);
 	error = NFS_PROTO(dir)->rmdir(dir, &dentry->d_name);
-	if (!error)
+	if (!error) {
+		nfs_async_unlink_dequeue(dentry);
 		dentry->d_inode->i_nlink = 0;
+	}
 	unlock_kernel();
 
 	return error;
@@ -925,8 +927,14 @@ dentry->d_parent->d_name.name, dentry->d
 	 * We don't allow a dentry to be silly-renamed twice.
 	 */
 	error = -EBUSY;
-	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
+	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
+#ifdef NFS_PARANOIA
+		printk("NFS: silly-rename %s/%s with DCACHE_NFSFS_RENAMED "
+		       "already set?\n",
+		       dentry->d_parent->d_name.name, dentry->d_name.name);
+#endif
 		goto out;
+	}
 
 	sprintf(silly, ".nfs%*.*lx",
 		i_inosize, i_inosize, dentry->d_inode->i_ino);
@@ -959,7 +967,6 @@ dentry->d_parent->d_name.name, dentry->d
 		nfs_renew_times(dentry);
 		d_move(dentry, sdentry);
 		error = nfs_async_unlink(dentry);
- 		/* If we return 0 we don't unlink */
 	}
 	dput(sdentry);
 out:
@@ -1000,10 +1007,13 @@ out:
 	return error;
 }
 
-/*  We do silly rename. In case sillyrename() returns -EBUSY, the inode
- *  belongs to an active ".nfs..." file and we return -EBUSY.
+/*
+ * We do silly rename if the dentry says there are active users.
+ * Otherwise we unlink.
  *
- *  If sillyrename() returns 0, we do nothing, otherwise we unlink.
+ * Note that the dentry->d_count may lie; once a file is sillyrenamed
+ * it is unhashed and so a future lookup repopulates the dcache and the
+ * new dentry doesn't reflect the previous dentry->d_count.
  */
 static int nfs_unlink(struct inode *dir, struct dentry *dentry)
 {
diff -uNrp linux-2.5.70/fs/nfs/unlink.c linux-2.5.70-silly/fs/nfs/unlink.c
--- linux-2.5.70/fs/nfs/unlink.c	Sun Jun  1 23:28:55 2003
+++ linux-2.5.70-silly/fs/nfs/unlink.c	Mon Jun  9 05:40:56 2003
@@ -21,6 +21,7 @@ struct nfs_unlinkdata {
 	struct rpc_task	task;
 	struct rpc_cred	*cred;
 	unsigned int	count;
+	int		noaction;	/* really remove? */
 };
 
 static struct nfs_unlinkdata	*nfs_deletes;
@@ -98,7 +99,7 @@ nfs_async_unlink_init(struct rpc_task *t
 	};
 	int			status = -ENOENT;
 
-	if (!data->name.len)
+	if (!data->name.len || data->noaction)
 		goto out_err;
 
 	status = NFS_PROTO(dir->d_inode)->unlink_setup(&msg, dir, &data->name);
@@ -150,8 +151,7 @@ nfs_async_unlink_release(struct rpc_task
 
 /**
  * nfs_async_unlink - asynchronous unlinking of a file
- * @dir: directory in which the file resides.
- * @name: name of the file to unlink.
+ * @dentry: dentry to unlink
  */
 int
 nfs_async_unlink(struct dentry *dentry)
@@ -167,7 +167,7 @@ nfs_async_unlink(struct dentry *dentry)
 		goto out;
 	memset(data, 0, sizeof(*data));
 
-	data->dir = dget(dir);
+	data->dir = dget(dir);	/* dput() in nfs_async_unlink_done() */
 	data->dentry = dentry;
 
 	data->next = nfs_deletes;
@@ -190,7 +190,7 @@ nfs_async_unlink(struct dentry *dentry)
 }
 
 /**
- * nfs_complete_remove - Initialize completion of the sillydelete
+ * nfs_complete_unlink - Initialize completion of the sillydelete
  * @dentry: dentry to delete
  *
  * Since we're most likely to be called by dentry_iput(), we
@@ -202,16 +202,46 @@ nfs_complete_unlink(struct dentry *dentr
 {
 	struct nfs_unlinkdata	*data;
 
-	for(data = nfs_deletes; data != NULL; data = data->next) {
+	for (data = nfs_deletes; data != NULL; data = data->next) {
 		if (dentry == data->dentry)
 			break;
 	}
 	if (!data)
 		return;
-	data->count++;
 	nfs_copy_dname(dentry, data);
 	dentry->d_flags &= ~DCACHE_NFSFS_RENAMED;
 	if (data->task.tk_rpcwait == &nfs_delete_queue)
 		rpc_wake_up_task(&data->task);
-	nfs_put_unlinkdata(data);
 }
+
+/**
+ * nfs_async_unlink_dequeue - Remove previously queued async unlinks
+ * @dir: parent directory being rmdir'd
+ *
+ * This function removes all dentrys from nfs_delete_queue whose parent
+ * is @dir.
+ *
+ * When a file is sillydeleted, the dentry gets unhashed and placed on
+ * nfs_delete_queue for a future [async] unlink (when d_count goes to 0).
+ * Since the sillyfile can still be found, it may be unlinked independently,
+ * in which case nfs_delete_queue will have stale data.  When the parent
+ * dir goes away, data->dir being stale is a problem.  This is 1 of 2 reasons
+ * this is only called from rmdir.  The other is for performance; we can
+ * either dequeue on every unlink, or just on rmdir's.
+ *
+ * Just calling this on rmdir isn't ideal though, since we can incur a lot
+ * of extra NFS remove's if sillyrenamed files are themselves unlinked, and
+ * the parent dirs stick around.  rmdir seems more likely though; generally,
+ * sillyrenamed files won't be accessed other than for 'rm -rf' operations.
+ */
+void
+nfs_async_unlink_dequeue(struct dentry *dir)
+{
+	struct nfs_unlinkdata *data;
+
+	/* Don't actually try to do anything when d_count goes to 0. */
+	for (data = nfs_deletes; data != NULL; data = data->next)
+		if (data->dir == dir)
+			data->noaction = 1;
+}
+
diff -uNrp linux-2.5.70/include/linux/nfs_fs.h linux-2.5.70-silly/include/linux/nfs_fs.h
--- linux-2.5.70/include/linux/nfs_fs.h	Sun Jun  1 23:29:17 2003
+++ linux-2.5.70-silly/include/linux/nfs_fs.h	Mon Jun  9 00:02:53 2003
@@ -294,6 +294,7 @@ extern int nfs_lock(struct file *, int, 
  */
 extern int  nfs_async_unlink(struct dentry *);
 extern void nfs_complete_unlink(struct dentry *);
+extern void nfs_async_unlink_dequeue(struct dentry *);
 
 /*
  * linux/fs/nfs/write.c

--GRPZ8SYKNexpdSJ7--
