Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVKNVcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVKNVcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVKNVcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:32:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:41127 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932149AbVKNVcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:14 -0500
Message-Id: <20051114212525.640003000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:44 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 03/13] Change pid accesses: filesystems.
Content-Disposition: inline; filename=B2-change-pid-tgid-references-fs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: filesystems.
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses for filesystems.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 fs/9p/debug.h                |    4 ++--
 fs/9p/fid.c                  |    5 +++--
 fs/afs/cmservice.c           |    2 +-
 fs/afs/kafsasyncd.c          |    2 +-
 fs/afs/kafstimod.c           |    2 +-
 fs/autofs/root.c             |    2 +-
 fs/autofs4/autofs_i.h        |    2 +-
 fs/autofs4/root.c            |    2 +-
 fs/binfmt_elf.c              |    8 ++++----
 fs/binfmt_elf_fdpic.c        |    2 +-
 fs/binfmt_flat.c             |    2 +-
 fs/cifs/cifssmb.c            |    2 +-
 fs/cifs/connect.c            |    2 +-
 fs/cifs/dir.c                |    2 +-
 fs/cifs/file.c               |    4 ++--
 fs/cifs/misc.c               |    4 ++--
 fs/cifs/transport.c          |    2 +-
 fs/coda/upcall.c             |    2 +-
 fs/compat.c                  |    2 +-
 fs/devfs/base.c              |    2 +-
 fs/dnotify.c                 |    2 +-
 fs/exec.c                    |    8 ++++----
 fs/ext2/inode.c              |    2 +-
 fs/ext3/inode.c              |    2 +-
 fs/fs-writeback.c            |    2 +-
 fs/fuse/dev.c                |    2 +-
 fs/jffs2/background.c        |    2 +-
 fs/jffs2/debug.h             |    8 ++++----
 fs/lockd/clntproc.c          |    2 +-
 fs/lockd/svc.c               |    6 +++---
 fs/locks.c                   |   16 ++++++++--------
 fs/nfs/callback.c            |    2 +-
 fs/nfs/nfs3proc.c            |    2 +-
 fs/nfs/nfs4proc.c            |    2 +-
 fs/nfsd/nfs4state.c          |    8 ++++----
 fs/nfsd/vfs.c                |    6 +++---
 fs/proc/array.c              |   12 +++++++-----
 fs/proc/base.c               |   16 ++++++++--------
 fs/smbfs/proc.c              |    4 ++--
 fs/smbfs/smbiod.c            |    4 ++--
 fs/xfs/linux-2.6/xfs_buf.c   |    2 +-
 fs/xfs/linux-2.6/xfs_linux.h |    2 +-
 fs/xfs/support/debug.c       |    2 +-
 43 files changed, 86 insertions(+), 83 deletions(-)

Index: linux-2.6.15-rc1/fs/9p/debug.h
===================================================================
--- linux-2.6.15-rc1.orig/fs/9p/debug.h
+++ linux-2.6.15-rc1/fs/9p/debug.h
@@ -39,13 +39,13 @@ extern int v9fs_debug_level;
 do {  \
 	if((v9fs_debug_level & level)==level) \
 		printk(KERN_NOTICE "-- %s (%d): " \
-		format , __FUNCTION__, current->pid , ## arg); \
+		format , __FUNCTION__, task_pid(current) , ## arg); \
 } while(0)
 
 #define eprintk(level, format, arg...) \
 do { \
 	printk(level "v9fs: %s (%d): " \
-		format , __FUNCTION__, current->pid , ## arg); \
+		format , __FUNCTION__, task_pid(current) , ## arg); \
 } while(0)
 
 #if DEBUG_DUMP_PKT
Index: linux-2.6.15-rc1/fs/9p/fid.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/9p/fid.c
+++ linux-2.6.15-rc1/fs/9p/fid.c
@@ -60,7 +60,7 @@ static int v9fs_fid_insert(struct v9fs_f
 	}
 
 	fid->uid = current->uid;
-	fid->pid = current->pid;
+	fid->pid = task_pid(current);
 	list_add(&fid->list, fid_list);
 	return 0;
 }
@@ -242,7 +242,8 @@ struct v9fs_fid *v9fs_fid_get_created(st
 	ret = NULL;
 	if (fid_list) {
 		list_for_each_entry_safe(fid, ftmp, fid_list, list) {
-			if (fid->fidcreate && fid->pid == current->pid) {
+			if (fid->fidcreate && fid->pid ==
+			    task_pid(current)) {
 				list_del(&fid->list);
 				ret = fid;
 				break;
Index: linux-2.6.15-rc1/fs/afs/cmservice.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/afs/cmservice.c
+++ linux-2.6.15-rc1/fs/afs/cmservice.c
@@ -118,7 +118,7 @@ static int kafscmd(void *arg)
 	_SRXAFSCM_xxxx_t func;
 	int die;
 
-	printk("kAFS: Started kafscmd %d\n", current->pid);
+	printk("kAFS: Started kafscmd %d\n", task_pid(current));
 
 	daemonize("kafscmd");
 
Index: linux-2.6.15-rc1/fs/afs/kafsasyncd.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/afs/kafsasyncd.c
+++ linux-2.6.15-rc1/fs/afs/kafsasyncd.c
@@ -92,7 +92,7 @@ static int kafsasyncd(void *arg)
 
 	kafsasyncd_task = current;
 
-	printk("kAFS: Started kafsasyncd %d\n", current->pid);
+	printk("kAFS: Started kafsasyncd %d\n", task_pid(current));
 
 	daemonize("kafsasyncd");
 
Index: linux-2.6.15-rc1/fs/afs/kafstimod.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/afs/kafstimod.c
+++ linux-2.6.15-rc1/fs/afs/kafstimod.c
@@ -69,7 +69,7 @@ static int kafstimod(void *arg)
 
 	DECLARE_WAITQUEUE(myself, current);
 
-	printk("kAFS: Started kafstimod %d\n", current->pid);
+	printk("kAFS: Started kafstimod %d\n", task_pid(current));
 
 	daemonize("kafstimod");
 
Index: linux-2.6.15-rc1/fs/autofs/root.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/autofs/root.c
+++ linux-2.6.15-rc1/fs/autofs/root.c
@@ -213,7 +213,7 @@ static struct dentry *autofs_root_lookup
 
 	oz_mode = autofs_oz_mode(sbi);
 	DPRINTK(("autofs_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, process_group(current), sbi->catatonic, oz_mode));
+		 task_pid(current), process_group(current), sbi->catatonic, oz_mode));
 
 	/*
 	 * Mark the dentry incomplete, but add it. This is needed so
Index: linux-2.6.15-rc1/fs/autofs4/autofs_i.h
===================================================================
--- linux-2.6.15-rc1.orig/fs/autofs4/autofs_i.h
+++ linux-2.6.15-rc1/fs/autofs4/autofs_i.h
@@ -33,7 +33,7 @@
 /* #define DEBUG */
 
 #ifdef DEBUG
-#define DPRINTK(fmt,args...) do { printk(KERN_DEBUG "pid %d: %s: " fmt "\n" , current->pid , __FUNCTION__ , ##args); } while(0)
+#define DPRINTK(fmt,args...) do { printk(KERN_DEBUG "pid %d: %s: " fmt "\n" , task_pid(current) , __FUNCTION__ , ##args); } while(0)
 #else
 #define DPRINTK(fmt,args...) do {} while(0)
 #endif
Index: linux-2.6.15-rc1/fs/autofs4/root.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/autofs4/root.c
+++ linux-2.6.15-rc1/fs/autofs4/root.c
@@ -465,7 +465,7 @@ static struct dentry *autofs4_lookup(str
 
 	oz_mode = autofs4_oz_mode(sbi);
 	DPRINTK("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d",
-		 current->pid, process_group(current), sbi->catatonic, oz_mode);
+		 task_pid(current), process_group(current), sbi->catatonic, oz_mode);
 
 	/*
 	 * Mark the dentry incomplete, but add it. This is needed so
Index: linux-2.6.15-rc1/fs/binfmt_elf.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/binfmt_elf.c
+++ linux-2.6.15-rc1/fs/binfmt_elf.c
@@ -1270,8 +1270,8 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
 	prstatus->pr_sigpend = p->pending.signal.sig[0];
 	prstatus->pr_sighold = p->blocked.sig[0];
-	prstatus->pr_pid = p->pid;
-	prstatus->pr_ppid = p->parent->pid;
+	prstatus->pr_pid = task_pid(p);
+	prstatus->pr_ppid = task_pid(p->parent);
 	prstatus->pr_pgrp = process_group(p);
 	prstatus->pr_sid = p->signal->session;
 	if (thread_group_leader(p)) {
@@ -1316,8 +1316,8 @@ static int fill_psinfo(struct elf_prpsin
 			psinfo->pr_psargs[i] = ' ';
 	psinfo->pr_psargs[len] = 0;
 
-	psinfo->pr_pid = p->pid;
-	psinfo->pr_ppid = p->parent->pid;
+	psinfo->pr_pid = task_pid(p);
+	psinfo->pr_ppid = task_pid(p->parent);
 	psinfo->pr_pgrp = process_group(p);
 	psinfo->pr_sid = p->signal->session;
 
Index: linux-2.6.15-rc1/fs/binfmt_elf_fdpic.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/binfmt_elf_fdpic.c
+++ linux-2.6.15-rc1/fs/binfmt_elf_fdpic.c
@@ -479,7 +479,7 @@ static int create_elf_fdpic_tables(struc
 	 * removed for 2.5
 	 */
 	if (smp_num_siblings > 1)
-		sp = sp - ((current->pid % 64) << 7);
+		sp = sp - ((task_pid(current) % 64) << 7);
 #endif
 
 	sp &= ~7UL;
Index: linux-2.6.15-rc1/fs/binfmt_flat.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/binfmt_flat.c
+++ linux-2.6.15-rc1/fs/binfmt_flat.c
@@ -95,7 +95,7 @@ static struct linux_binfmt flat_format =
 static int flat_core_dump(long signr, struct pt_regs * regs, struct file *file)
 {
 	printk("Process %s:%d received signr %d and should have core dumped\n",
-			current->comm, current->pid, (int) signr);
+			current->comm, task_pid(current), (int) signr);
 	return(1);
 }
 
Index: linux-2.6.15-rc1/fs/cifs/cifssmb.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/cifs/cifssmb.c
+++ linux-2.6.15-rc1/fs/cifs/cifssmb.c
@@ -1247,7 +1247,7 @@ CIFSSMBLock(const int xid, struct cifsTc
 	pSMB->Fid = smb_file_id; /* netfid stays le */
 
 	if((numLock != 0) || (numUnlock != 0)) {
-		pSMB->Locks[0].Pid = cpu_to_le16(current->tgid);
+		pSMB->Locks[0].Pid = cpu_to_le16(task_tgid(current));
 		/* BB where to store pid high? */
 		pSMB->Locks[0].LengthLow = cpu_to_le32((u32)len);
 		pSMB->Locks[0].LengthHigh = cpu_to_le32((u32)(len>>32));
Index: linux-2.6.15-rc1/fs/cifs/connect.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/cifs/connect.c
+++ linux-2.6.15-rc1/fs/cifs/connect.c
@@ -345,7 +345,7 @@ cifs_demultiplex_thread(struct TCP_Serve
 	allow_signal(SIGKILL);
 	current->flags |= PF_MEMALLOC;
 	server->tsk = current;	/* save process info to wake at shutdown */
-	cFYI(1, ("Demultiplex PID: %d", current->pid));
+	cFYI(1, ("Demultiplex PID: %d", task_pid(current)));
 	write_lock(&GlobalSMBSeslock); 
 	atomic_inc(&tcpSesAllocCount);
 	length = tcpSesAllocCount.counter;
Index: linux-2.6.15-rc1/fs/cifs/dir.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/cifs/dir.c
+++ linux-2.6.15-rc1/fs/cifs/dir.c
@@ -255,7 +255,7 @@ cifs_create(struct inode *inode, struct 
 			memset((char *)pCifsFile, 0,
 			       sizeof (struct cifsFileInfo));
 			pCifsFile->netfid = fileHandle;
-			pCifsFile->pid = current->tgid;
+			pCifsFile->pid = task_tgid(current);
 			pCifsFile->pInode = newinode;
 			pCifsFile->invalidHandle = FALSE;
 			pCifsFile->closePend     = FALSE;
Index: linux-2.6.15-rc1/fs/cifs/file.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/cifs/file.c
+++ linux-2.6.15-rc1/fs/cifs/file.c
@@ -45,7 +45,7 @@ static inline struct cifsFileInfo *cifs_
 {
 	memset(private_data, 0, sizeof(struct cifsFileInfo));
 	private_data->netfid = netfid;
-	private_data->pid = current->tgid;	
+	private_data->pid = task_tgid(current);
 	init_MUTEX(&private_data->fh_sem);
 	private_data->pfile = file; /* needed for writepage */
 	private_data->pInode = inode;
@@ -182,7 +182,7 @@ int cifs_open(struct inode *inode, struc
 			pCifsFile = list_entry(tmp, struct cifsFileInfo,
 					       flist);
 			if ((pCifsFile->pfile == NULL) &&
-			    (pCifsFile->pid == current->tgid)) {
+			    (pCifsFile->pid == task_tgid(current))) {
 				/* mode set in cifs_create */
 
 				/* needed for writepage */
Index: linux-2.6.15-rc1/fs/cifs/misc.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/cifs/misc.c
+++ linux-2.6.15-rc1/fs/cifs/misc.c
@@ -308,8 +308,8 @@ header_assemble(struct smb_hdr *buffer, 
 	buffer->Command = smb_command;
 	buffer->Flags = 0x00;	/* case sensitive */
 	buffer->Flags2 = SMBFLG2_KNOWS_LONG_NAMES;
-	buffer->Pid = cpu_to_le16((__u16)current->tgid);
-	buffer->PidHigh = cpu_to_le16((__u16)(current->tgid >> 16));
+	buffer->Pid = cpu_to_le16((__u16)task_tgid(current));
+	buffer->PidHigh = cpu_to_le16((__u16)(task_tgid(current) >> 16));
 	spin_lock(&GlobalMid_Lock);
 	spin_unlock(&GlobalMid_Lock);
 	if (treeCon) {
Index: linux-2.6.15-rc1/fs/cifs/transport.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/cifs/transport.c
+++ linux-2.6.15-rc1/fs/cifs/transport.c
@@ -56,7 +56,7 @@ AllocMidQEntry(struct smb_hdr *smb_buffe
 	else {
 		memset(temp, 0, sizeof (struct mid_q_entry));
 		temp->mid = smb_buffer->Mid;	/* always LE */
-		temp->pid = current->pid;
+		temp->pid = task_pid(current);
 		temp->command = smb_buffer->Command;
 		cFYI(1, ("For smb_command %d", temp->command));
 	/*	do_gettimeofday(&temp->when_sent);*/ /* easier to use jiffies */
Index: linux-2.6.15-rc1/fs/coda/upcall.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/coda/upcall.c
+++ linux-2.6.15-rc1/fs/coda/upcall.c
@@ -52,7 +52,7 @@ static void *alloc_upcall(int opcode, in
 		return ERR_PTR(-ENOMEM);
 
         inp->ih.opcode = opcode;
-	inp->ih.pid = current->pid;
+	inp->ih.pid = task_pid(current);
 	inp->ih.pgid = process_group(current);
 #ifdef CONFIG_CODA_FS_OLD_API
 	memset(&inp->ih.cred, 0, sizeof(struct coda_cred));
Index: linux-2.6.15-rc1/fs/compat.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/compat.c
+++ linux-2.6.15-rc1/fs/compat.c
@@ -332,7 +332,7 @@ static void compat_ioctl_error(struct fi
 		sprintf(buf, "%02x", buf[1]);
 	printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
 			"cmd(%08x){%s} arg(%08x) on %s\n",
-			current->comm, current->pid,
+			current->comm, task_pid(current),
 			(int)fd, (unsigned int)cmd, buf,
 			(unsigned int)arg, fn);
 
Index: linux-2.6.15-rc1/fs/devfs/base.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/devfs/base.c
+++ linux-2.6.15-rc1/fs/devfs/base.c
@@ -2695,7 +2695,7 @@ static int devfsd_ioctl(struct inode *in
 			spin_unlock(&lock);
 			fs_info->devfsd_pgrp =
 			    (process_group(current) ==
-			     current->pid) ? process_group(current) : 0;
+			     task_pid(current)) ? process_group(current) : 0;
 			fs_info->devfsd_file = file;
 			fs_info->devfsd_info =
 			    kmalloc(sizeof *fs_info->devfsd_info, GFP_KERNEL);
Index: linux-2.6.15-rc1/fs/dnotify.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/dnotify.c
+++ linux-2.6.15-rc1/fs/dnotify.c
@@ -92,7 +92,7 @@ int fcntl_dirnotify(int fd, struct file 
 		prev = &odn->dn_next;
 	}
 
-	error = f_setown(filp, current->pid, 0);
+	error = f_setown(filp, task_pid(current), 0);
 	if (error)
 		goto out_free;
 
Index: linux-2.6.15-rc1/fs/exec.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/exec.c
+++ linux-2.6.15-rc1/fs/exec.c
@@ -685,8 +685,8 @@ static inline int de_thread(struct task_
 		proc_dentry2 = proc_pid_unhash(leader);
 		write_lock_irq(&tasklist_lock);
 
-		BUG_ON(leader->tgid != current->tgid);
-		BUG_ON(current->pid == current->tgid);
+		BUG_ON(task_tgid(leader) != task_tgid(current));
+		BUG_ON(task_pid(current) == task_tgid(current));
 		/*
 		 * An exec() starts a new thread group with the
 		 * TGID of the previous thread group. Rehash the
@@ -1292,7 +1292,7 @@ static void format_corename(char *corena
 			case 'p':
 				pid_in_pattern = 1;
 				rc = snprintf(out_ptr, out_end - out_ptr,
-					      "%d", current->tgid);
+					      "%d", task_tgid(current));
 				if (rc > out_end - out_ptr)
 					goto out;
 				out_ptr += rc;
@@ -1364,7 +1364,7 @@ static void format_corename(char *corena
 	if (!pid_in_pattern
             && (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)) {
 		rc = snprintf(out_ptr, out_end - out_ptr,
-			      ".%d", current->tgid);
+			      ".%d", task_tgid(current));
 		if (rc > out_end - out_ptr)
 			goto out;
 		out_ptr += rc;
Index: linux-2.6.15-rc1/fs/ext2/inode.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/ext2/inode.c
+++ linux-2.6.15-rc1/fs/ext2/inode.c
@@ -344,7 +344,7 @@ static unsigned long ext2_find_near(stru
 	 */
 	bg_start = (ei->i_block_group * EXT2_BLOCKS_PER_GROUP(inode->i_sb)) +
 		le32_to_cpu(EXT2_SB(inode->i_sb)->s_es->s_first_data_block);
-	colour = (current->pid % 16) *
+	colour = (task_pid(current) % 16) *
 			(EXT2_BLOCKS_PER_GROUP(inode->i_sb) / 16);
 	return bg_start + colour;
 }
Index: linux-2.6.15-rc1/fs/ext3/inode.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/ext3/inode.c
+++ linux-2.6.15-rc1/fs/ext3/inode.c
@@ -443,7 +443,7 @@ static unsigned long ext3_find_near(stru
 	 */
 	bg_start = (ei->i_block_group * EXT3_BLOCKS_PER_GROUP(inode->i_sb)) +
 		le32_to_cpu(EXT3_SB(inode->i_sb)->s_es->s_first_data_block);
-	colour = (current->pid % 16) *
+	colour = (task_pid(current) % 16) *
 			(EXT3_BLOCKS_PER_GROUP(inode->i_sb) / 16);
 	return bg_start + colour;
 }
Index: linux-2.6.15-rc1/fs/fs-writeback.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/fs-writeback.c
+++ linux-2.6.15-rc1/fs/fs-writeback.c
@@ -89,7 +89,7 @@ void __mark_inode_dirty(struct inode *in
 		if (inode->i_ino || strcmp(inode->i_sb->s_id, "bdev"))
 			printk(KERN_DEBUG
 			       "%s(%d): dirtied inode %lu (%s) on %s\n",
-			       current->comm, current->pid, inode->i_ino,
+			       current->comm, task_pid(current), inode->i_ino,
 			       name, inode->i_sb->s_id);
 	}
 
Index: linux-2.6.15-rc1/fs/fuse/dev.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/fuse/dev.c
+++ linux-2.6.15-rc1/fs/fuse/dev.c
@@ -99,7 +99,7 @@ static struct fuse_req *do_get_request(s
 	req->preallocated = 1;
 	req->in.h.uid = current->fsuid;
 	req->in.h.gid = current->fsgid;
-	req->in.h.pid = current->pid;
+	req->in.h.pid = task_pid(current);
 	return req;
 }
 
Index: linux-2.6.15-rc1/fs/jffs2/background.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/jffs2/background.c
+++ linux-2.6.15-rc1/fs/jffs2/background.c
@@ -60,7 +60,7 @@ void jffs2_stop_garbage_collect_thread(s
 	int wait = 0;
 	spin_lock(&c->erase_completion_lock);
 	if (c->gc_task) {
-		D1(printk(KERN_DEBUG "jffs2: Killing GC task %d\n", c->gc_task->pid));
+		D1(printk(KERN_DEBUG "jffs2: Killing GC task %d\n", c->gc_task_pid(task)));
 		send_sig(SIGKILL, c->gc_task, 1);
 		wait = 1;
 	}
Index: linux-2.6.15-rc1/fs/lockd/clntproc.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/lockd/clntproc.c
+++ linux-2.6.15-rc1/fs/lockd/clntproc.c
@@ -130,7 +130,7 @@ static void nlmclnt_setlockargs(struct n
 	lock->caller  = system_utsname.nodename;
 	lock->oh.data = req->a_owner;
 	lock->oh.len  = sprintf(req->a_owner, "%d@%s",
-				current->pid, system_utsname.nodename);
+				task_pid(current), system_utsname.nodename);
 	locks_copy_lock(&lock->fl, fl);
 }
 
Index: linux-2.6.15-rc1/fs/lockd/svc.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/lockd/svc.c
+++ linux-2.6.15-rc1/fs/lockd/svc.c
@@ -111,7 +111,7 @@ lockd(struct svc_rqst *rqstp)
 	/*
 	 * Let our maker know we're running.
 	 */
-	nlmsvc_pid = current->pid;
+	nlmsvc_pid = task_pid(current);
 	up(&lockd_start);
 
 	daemonize("lockd");
@@ -135,7 +135,7 @@ lockd(struct svc_rqst *rqstp)
 	 * NFS mount or NFS daemon has gone away, and we've been sent a
 	 * signal, or else another process has taken over our job.
 	 */
-	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
+	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == task_pid(current)) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 
 		if (signalled()) {
@@ -182,7 +182,7 @@ lockd(struct svc_rqst *rqstp)
 	 * Check whether there's a new lockd process before
 	 * shutting down the hosts and clearing the slot.
 	 */
-	if (!nlmsvc_pid || current->pid == nlmsvc_pid) {
+	if (!nlmsvc_pid || task_pid(current) == nlmsvc_pid) {
 		if (nlmsvc_ops)
 			nlmsvc_invalidate_all();
 		nlm_shutdown_hosts();
Index: linux-2.6.15-rc1/fs/locks.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/locks.c
+++ linux-2.6.15-rc1/fs/locks.c
@@ -268,7 +268,7 @@ static int flock_make_lock(struct file *
 		return -ENOMEM;
 
 	fl->fl_file = filp;
-	fl->fl_pid = current->tgid;
+	fl->fl_pid = task_tgid(current);
 	fl->fl_flags = FL_FLOCK;
 	fl->fl_type = type;
 	fl->fl_end = OFFSET_MAX;
@@ -334,7 +334,7 @@ static int flock_to_posix_lock(struct fi
 		return -EOVERFLOW;
 	
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->tgid;
+	fl->fl_pid = task_tgid(current);
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_ops = NULL;
@@ -380,7 +380,7 @@ static int flock64_to_posix_lock(struct 
 		return -EOVERFLOW;
 	
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->tgid;
+	fl->fl_pid = task_tgid(current);
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_ops = NULL;
@@ -433,7 +433,7 @@ static struct lock_manager_operations le
 static int lease_init(struct file *filp, int type, struct file_lock *fl)
  {
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->tgid;
+	fl->fl_pid = task_tgid(current);
 
 	fl->fl_file = filp;
 	fl->fl_flags = FL_LEASE;
@@ -1043,7 +1043,7 @@ int locks_mandatory_area(int read_write,
 
 	locks_init_lock(&fl);
 	fl.fl_owner = current->files;
-	fl.fl_pid = current->tgid;
+	fl.fl_pid = task_tgid(current);
 	fl.fl_file = filp;
 	fl.fl_flags = FL_POSIX | FL_ACCESS;
 	if (filp && !(filp->f_flags & O_NONBLOCK))
@@ -1442,7 +1442,7 @@ int fcntl_setlease(unsigned int fd, stru
 		goto out_unlock;
 	}
 
-	error = f_setown(filp, current->pid, 0);
+	error = f_setown(filp, task_pid(current), 0);
 out_unlock:
 	unlock_kernel();
 	return error;
@@ -1861,7 +1861,7 @@ void locks_remove_posix(struct file *fil
 	lock.fl_start = 0;
 	lock.fl_end = OFFSET_MAX;
 	lock.fl_owner = owner;
-	lock.fl_pid = current->tgid;
+	lock.fl_pid = task_tgid(current);
 	lock.fl_file = filp;
 	lock.fl_ops = NULL;
 	lock.fl_lmops = NULL;
@@ -1905,7 +1905,7 @@ void locks_remove_flock(struct file *fil
 
 	if (filp->f_op && filp->f_op->flock) {
 		struct file_lock fl = {
-			.fl_pid = current->tgid,
+			.fl_pid = task_tgid(current),
 			.fl_file = filp,
 			.fl_flags = FL_FLOCK,
 			.fl_type = F_UNLCK,
Index: linux-2.6.15-rc1/fs/nfs/callback.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/nfs/callback.c
+++ linux-2.6.15-rc1/fs/nfs/callback.c
@@ -44,7 +44,7 @@ static void nfs_callback_svc(struct svc_
 	__module_get(THIS_MODULE);
 	lock_kernel();
 
-	nfs_callback_info.pid = current->pid;
+	nfs_callback_info.pid = task_pid(current);
 	daemonize("nfsv4-svc");
 	/* Process request with signals blocked, but allow SIGKILL.  */
 	allow_signal(SIGKILL);
Index: linux-2.6.15-rc1/fs/nfs/nfs3proc.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/nfs/nfs3proc.c
+++ linux-2.6.15-rc1/fs/nfs/nfs3proc.c
@@ -323,7 +323,7 @@ nfs3_proc_create(struct inode *dir, stru
 	if (flags & O_EXCL) {
 		arg.createmode  = NFS3_CREATE_EXCLUSIVE;
 		arg.verifier[0] = jiffies;
-		arg.verifier[1] = current->pid;
+		arg.verifier[1] = task_pid(current);
 	}
 
 	sattr->ia_mode &= ~current->fs->umask;
Index: linux-2.6.15-rc1/fs/nfs/nfs4proc.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/nfs/nfs4proc.c
+++ linux-2.6.15-rc1/fs/nfs/nfs4proc.c
@@ -724,7 +724,7 @@ static int _nfs4_do_open(struct inode *d
 	if (flags & O_EXCL) {
 		u32 *p = (u32 *) o_arg.u.verifier.data;
 		p[0] = jiffies;
-		p[1] = current->pid;
+		p[1] = task_pid(current);
 	} else
 		o_arg.u.attrs = sattr;
 	/* Serialization for the sequence id */
Index: linux-2.6.15-rc1/fs/nfsd/nfs4state.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/nfsd/nfs4state.c
+++ linux-2.6.15-rc1/fs/nfsd/nfs4state.c
@@ -1740,7 +1740,7 @@ nfs4_open_delegation(struct svc_fh *fh, 
 	fl.fl_end = OFFSET_MAX;
 	fl.fl_owner =  (fl_owner_t)dp;
 	fl.fl_file = stp->st_vfs_file;
-	fl.fl_pid = current->tgid;
+	fl.fl_pid = task_tgid(current);
 
 	/* setlease checks to see if delegation should be handed out.
 	 * the lock_manager callbacks fl_mylease and fl_change are used
@@ -2784,7 +2784,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 		goto out;
 	}
 	file_lock.fl_owner = (fl_owner_t)lock_sop;
-	file_lock.fl_pid = current->tgid;
+	file_lock.fl_pid = task_tgid(current);
 	file_lock.fl_file = filp;
 	file_lock.fl_flags = FL_POSIX;
 
@@ -2903,7 +2903,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, stru
 			&lockt->lt_clientid, &lockt->lt_owner);
 	if (lockt->lt_stateowner)
 		file_lock.fl_owner = (fl_owner_t)lockt->lt_stateowner;
-	file_lock.fl_pid = current->tgid;
+	file_lock.fl_pid = task_tgid(current);
 	file_lock.fl_flags = FL_POSIX;
 
 	file_lock.fl_start = lockt->lt_offset;
@@ -2962,7 +2962,7 @@ nfsd4_locku(struct svc_rqst *rqstp, stru
 	locks_init_lock(&file_lock);
 	file_lock.fl_type = F_UNLCK;
 	file_lock.fl_owner = (fl_owner_t) locku->lu_stateowner;
-	file_lock.fl_pid = current->tgid;
+	file_lock.fl_pid = task_tgid(current);
 	file_lock.fl_file = filp;
 	file_lock.fl_flags = FL_POSIX; 
 	file_lock.fl_start = locku->lu_offset;
Index: linux-2.6.15-rc1/fs/nfsd/vfs.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/nfsd/vfs.c
+++ linux-2.6.15-rc1/fs/nfsd/vfs.c
@@ -955,13 +955,13 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 		if (EX_WGATHER(exp)) {
 			if (atomic_read(&inode->i_writecount) > 1
 			    || (last_ino == inode->i_ino && last_dev == inode->i_sb->s_dev)) {
-				dprintk("nfsd: write defer %d\n", current->pid);
+				dprintk("nfsd: write defer %d\n", task_pid(current));
 				msleep(10);
-				dprintk("nfsd: write resume %d\n", current->pid);
+				dprintk("nfsd: write resume %d\n", task_pid(current));
 			}
 
 			if (inode->i_state & I_DIRTY) {
-				dprintk("nfsd: write sync %d\n", current->pid);
+				dprintk("nfsd: write sync %d\n", task_pid(current));
 				nfsd_sync(file);
 			}
 #if 0
Index: linux-2.6.15-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/array.c
+++ linux-2.6.15-rc1/fs/proc/array.c
@@ -174,9 +174,10 @@ static inline char * task_state(struct t
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
-	       	p->tgid,
-		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
-		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
+	       	task_tgid(p),
+		task_pid(p), pid_alive(p) ?
+			task_tgid(p->group_leader->real_parent) : 0,
+		pid_alive(p) && p->ptrace ? task_pid(p->parent) : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);
@@ -388,7 +389,8 @@ static int do_task_stat(struct task_stru
 		}
 		it_real_value = task->signal->it_real_value;
 	}
-	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
+	ppid = pid_alive(task) ?
+		task_tgid(task->group_leader->real_parent) : 0;
 	read_unlock(&tasklist_lock);
 
 	if (!whole || num_threads<2)
@@ -415,7 +417,7 @@ static int do_task_stat(struct task_stru
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
-		task->pid,
+		task_pid(task),
 		tcomm,
 		state,
 		ppid,
Index: linux-2.6.15-rc1/fs/proc/base.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/base.c
+++ linux-2.6.15-rc1/fs/proc/base.c
@@ -1160,7 +1160,7 @@ static int proc_readfd(struct file * fil
 	if (!pid_alive(p))
 		goto out;
 	retval = 0;
-	tid = p->pid;
+	tid = task_pid(p);
 
 	fd = filp->f_pos;
 	switch (fd) {
@@ -1227,7 +1227,7 @@ static int proc_pident_readdir(struct fi
 		goto out;
 
 	ret = 0;
-	pid = proc_task(inode)->pid;
+	pid = task_pid(proc_task(inode));
 	i = filp->f_pos;
 	switch (i) {
 	case 0:
@@ -1312,7 +1312,7 @@ static struct inode *proc_pid_make_inode
 	ei = PROC_I(inode);
 	ei->task = NULL;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->i_ino = fake_ino(task->pid, ino);
+	inode->i_ino = fake_ino(task_pid(task), ino);
 
 	if (!pid_alive(task))
 		goto out_unlock;
@@ -1878,14 +1878,14 @@ static int proc_self_readlink(struct den
 			      int buflen)
 {
 	char tmp[30];
-	sprintf(tmp, "%d", current->tgid);
+	sprintf(tmp, "%d", task_tgid(current));
 	return vfs_readlink(dentry,buffer,buflen,tmp);
 }
 
 static void *proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char tmp[30];
-	sprintf(tmp, "%d", current->tgid);
+	sprintf(tmp, "%d", task_tgid(current));
 	return ERR_PTR(vfs_follow_link(nd,tmp));
 }	
 
@@ -2042,7 +2042,7 @@ static struct dentry *proc_task_lookup(s
 	read_unlock(&tasklist_lock);
 	if (!task)
 		goto out;
-	if (leader->tgid != task->tgid)
+	if (task_tgid(leader) != task_tgid(task))
 		goto out_drop_task;
 
 	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TID_INO);
@@ -2100,7 +2100,7 @@ static int get_tgid_list(int index, unsi
 		p = next_task(&init_task);
 
 	for ( ; p != &init_task; p = next_task(p)) {
-		int tgid = p->pid;
+		int tgid = task_pid(p);
 		if (!pid_alive(p))
 			continue;
 		if (--index >= 0)
@@ -2133,7 +2133,7 @@ static int get_tid_list(int index, unsig
 	 * via next_thread().
 	 */
 	if (pid_alive(task)) do {
-		int tid = task->pid;
+		int tid = task_pid(task);
 
 		if (--index >= 0)
 			continue;
Index: linux-2.6.15-rc1/fs/smbfs/proc.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/smbfs/proc.c
+++ linux-2.6.15-rc1/fs/smbfs/proc.c
@@ -852,7 +852,7 @@ smb_newconn(struct smb_sb_info *server, 
 	struct sock *sk;
 	int error;
 
-	VERBOSE("fd=%d, pid=%d\n", opt->fd, current->pid);
+	VERBOSE("fd=%d, pid=%d\n", opt->fd, task_pid(current));
 
 	smb_lock_server(server);
 
@@ -876,7 +876,7 @@ smb_newconn(struct smb_sb_info *server, 
 		goto out_putf;
 
 	server->sock_file = filp;
-	server->conn_pid = current->pid;
+	server->conn_pid = task_pid(current);
 	server->opt = *opt;
 	server->generation += 1;
 	server->state = CONN_VALID;
Index: linux-2.6.15-rc1/fs/smbfs/smbiod.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/smbfs/smbiod.c
+++ linux-2.6.15-rc1/fs/smbfs/smbiod.c
@@ -294,7 +294,7 @@ static int smbiod(void *unused)
 
 	allow_signal(SIGKILL);
 
-	VERBOSE("SMB Kernel thread starting (%d) ...\n", current->pid);
+	VERBOSE("SMB Kernel thread starting (%d) ...\n", task_pid(current));
 
 	for (;;) {
 		struct smb_sb_info *server;
@@ -336,6 +336,6 @@ static int smbiod(void *unused)
 		spin_unlock(&servers_lock);
 	}
 
-	VERBOSE("SMB Kernel thread exiting (%d) ...\n", current->pid);
+	VERBOSE("SMB Kernel thread exiting (%d) ...\n", task_pid(current));
 	module_put_and_exit(0);
 }
Index: linux-2.6.15-rc1/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/xfs/linux-2.6/xfs_buf.c
+++ linux-2.6.15-rc1/fs/xfs/linux-2.6/xfs_buf.c
@@ -68,7 +68,7 @@ ktrace_t *pagebuf_trace_buf;
 #endif
 
 #ifdef PAGEBUF_LOCK_TRACKING
-# define PB_SET_OWNER(pb)	((pb)->pb_last_holder = current->pid)
+# define PB_SET_OWNER(pb)	((pb)->pb_last_holder = task_pid(current))
 # define PB_CLEAR_OWNER(pb)	((pb)->pb_last_holder = -1)
 # define PB_GET_OWNER(pb)	((pb)->pb_last_holder)
 #else
Index: linux-2.6.15-rc1/fs/xfs/linux-2.6/xfs_linux.h
===================================================================
--- linux-2.6.15-rc1.orig/fs/xfs/linux-2.6/xfs_linux.h
+++ linux-2.6.15-rc1/fs/xfs/linux-2.6/xfs_linux.h
@@ -134,7 +134,7 @@ static inline void set_buffer_unwritten_
 #define raw_smp_processor_id()	smp_processor_id()
 #endif
 #define current_cpu()		raw_smp_processor_id()
-#define current_pid()		(current->pid)
+#define current_pid()		(task_pid(current))
 #define current_fsuid(cred)	(current->fsuid)
 #define current_fsgid(cred)	(current->fsgid)
 
Index: linux-2.6.15-rc1/fs/xfs/support/debug.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/xfs/support/debug.c
+++ linux-2.6.15-rc1/fs/xfs/support/debug.c
@@ -60,7 +60,7 @@ random(void)
 int
 get_thread_id(void)
 {
-	return current->pid;
+	return task_pid(current);
 }
 
 #endif /* DEBUG || INDUCE_IO_ERRROR || !NO_WANT_RANDOM */
Index: linux-2.6.15-rc1/fs/jffs2/debug.h
===================================================================
--- linux-2.6.15-rc1.orig/fs/jffs2/debug.h
+++ linux-2.6.15-rc1/fs/jffs2/debug.h
@@ -81,28 +81,28 @@
 #define JFFS2_ERROR(fmt, ...)						\
 	do {								\
 		printk(JFFS2_ERR_MSG_PREFIX				\
-			" (%d) %s: " fmt, current->pid,			\
+			" (%d) %s: " fmt, task_pid(current),		\
 			__FUNCTION__, ##__VA_ARGS__);			\
 	} while(0)
 
 #define JFFS2_WARNING(fmt, ...)						\
 	do {								\
 		printk(JFFS2_WARN_MSG_PREFIX				\
-			" (%d) %s: " fmt, current->pid,			\
+			" (%d) %s: " fmt, task_pid(current),		\
 			__FUNCTION__, ##__VA_ARGS__);			\
 	} while(0)
 
 #define JFFS2_NOTICE(fmt, ...)						\
 	do {								\
 		printk(JFFS2_NOTICE_MSG_PREFIX				\
-			" (%d) %s: " fmt, current->pid,			\
+			" (%d) %s: " fmt, task_pid(current),		\
 			__FUNCTION__, ##__VA_ARGS__);			\
 	} while(0)
 
 #define JFFS2_DEBUG(fmt, ...)						\
 	do {								\
 		printk(JFFS2_DBG_MSG_PREFIX				\
-			" (%d) %s: " fmt, current->pid,			\
+			" (%d) %s: " fmt, task_pid(current),		\
 			__FUNCTION__, ##__VA_ARGS__);			\
 	} while(0)
 

--

