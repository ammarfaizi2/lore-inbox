Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbTAGQbx>; Tue, 7 Jan 2003 11:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbTAGQbx>; Tue, 7 Jan 2003 11:31:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8467 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267417AbTAGQbv>; Tue, 7 Jan 2003 11:31:51 -0500
Date: Tue, 7 Jan 2003 17:40:28 +0100
From: Jan Kara <jack@suse.cz>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 - quota support
Message-ID: <20030107164028.GC6719@atrey.karlin.mff.cuni.cz>
References: <20030106003801.GA522@mail.muni.cz> <3E18E2F0.1F6A47D0@digeo.com> <20030106103656.GA508@mail.muni.cz> <20030106144842.GD24714@atrey.karlin.mff.cuni.cz> <20030106151908.GA640@mail.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20030106151908.GA640@mail.muni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> On Mon, Jan 06, 2003 at 03:48:43PM +0100, Jan Kara wrote:
> >   I seems like quotaon (or better quotactl()) waits on some lock
> > forever... I'll try to reproduce it but in the mean time can you print
> > list of processes, write down a few addresses from the top of the stack
> > of quotaon and try to match it in the system.map to function in which
> > is process stuck?
> 
> according to strace quotaon freezes at
> quotactl(0xff800002, "/dev/hda1", 2
> 
> call trace is: (sysrq-t)
> vfs_permission
> __rwsem_do_wake
> rwsem_down_read_failed
> module_put
> dqinit_needed
> vfs_quota_off
> resolve_dev
> d_free
> deny_write_access
> check_quotactl_valid
> d_free
> scheduling_functions_start_here
> do_quotactl
> system_call
> 
> 
> Btw, freeze on quotaon is not regular. After some time that system is up,
> quotaon reports only no such device and terminates.
> 
> so looks like
> 1) freeze on quotactl
> 2) reports no such device
> 
> in both cases not working.
  Reporting 'No such device' was actually bug which was introduced some
time ago but nobody probably noticed it... It was introduce when quota
code was converted from device numbers to 'bdev' structures.
  I also fixed one bug in quotaon() call however I'm not sure wheter it
could cause the freeze. Anyway patch is attached, try it and tell me
about the changes.

							Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.5.54-1-fix.diff"

diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54/fs/dquot.c linux-2.5.54-1-lockfix/fs/dquot.c
--- linux-2.5.54/fs/dquot.c	Mon Jan  6 21:54:10 2003
+++ linux-2.5.54-1-lockfix/fs/dquot.c	Mon Jan  6 23:49:43 2003
@@ -1157,6 +1157,7 @@
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct quota_format_type *fmt = find_quota_format(format_id);
 	int error;
+	unsigned int oldflags;
 
 	if (!fmt)
 		return -ESRCH;
@@ -1181,10 +1182,11 @@
 		error = -EBUSY;
 		goto out_lock;
 	}
+	oldflags = inode->i_flags;
 	dqopt->files[type] = f;
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
-		goto out_lock;
+		goto out_file_init;
 	/* We don't want quota on quota files */
 	dquot_drop_nolock(inode);
 	inode->i_flags |= S_NOQUOTA;
@@ -1194,7 +1196,7 @@
 	down(&dqopt->dqio_sem);
 	if ((error = dqopt->ops[type]->read_file_info(sb, type)) < 0) {
 		up(&dqopt->dqio_sem);
-		goto out_lock;
+		goto out_file_init;
 	}
 	up(&dqopt->dqio_sem);
 	set_enable_flags(dqopt, type);
@@ -1204,9 +1206,10 @@
 	up_write(&dqopt->dqoff_sem);
 	return 0;
 
-out_lock:
-	inode->i_flags &= ~S_NOQUOTA;
+out_file_init:
+	inode->i_flags = oldflags;
 	dqopt->files[type] = NULL;
+out_lock:
 	up_write(&dqopt->dqoff_sem);
 out_f:
 	filp_close(f, NULL);
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.54/fs/quota.c linux-2.5.54-1-lockfix/fs/quota.c
--- linux-2.5.54/fs/quota.c	Tue Jan  7 00:47:58 2003
+++ linux-2.5.54-1-lockfix/fs/quota.c	Tue Jan  7 00:49:23 2003
@@ -114,7 +114,11 @@
 	ret = user_path_walk(path, &nd);
 	if (ret)
 		goto out;
-
+	ret = bd_acquire(nd.dentry->d_inode);
+	if (ret) {
+		path_release(&nd);
+		goto out;
+	}
 	bdev = nd.dentry->d_inode->i_bdev;
 	mode = nd.dentry->d_inode->i_mode;
 	path_release(&nd);

--rwEMma7ioTxnRzrJ--
