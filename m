Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269117AbUIHL30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269117AbUIHL30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269120AbUIHL30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:29:26 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:12475 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S269117AbUIHL3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:29:20 -0400
Date: Wed, 8 Sep 2004 13:29:09 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Jay Lan <jlan@engr.sgi.com>
Subject: [patch 2.6.8.1] BSD accounting: update chars transferred value
Message-ID: <20040908112909.GA10036@frec.bull.fr>
Mime-Version: 1.0
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2004 13:34:44,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2004 13:34:51,
	Serialize complete at 08/09/2004 13:34:51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  The goal of this patch is to improve BSD accounting by using what
is done in the CSA into BSD accounting. The final goal is to have a
uniform accounting structure.

  This patch updates information given by BSD accounting concerning
bytes read and written. A field is already present in the BSD accounting
structure but it is never updated. We don't add information about blocks
read and written because, as it was discussed in previous email, the
information is inaccurate. Most writes which are flushed delayed would
get accounted to pdflushd. Thus, one solution to get this kind of
information is to add counters when the write back is performed. The
problem is that we don't know how to get information about the PID at
the page level (ie from struct page). So we remove this information for
the moment and it will be provided in another patch.

Changelog:

  - Adds two counters in the task_struct (rchar, wchar)
  - Init fields during the creation of the process (during the fork)
  - File I/O operations are done through sys_read(), sys_write(),
    sys_readv(), sys_writev() and sys_sendfile(). Some file system, like 
    NFS, are using vfs_readv() and if we don't add counters here, we
    will miss something. sys_read() and sys_write() used respectively
    vfs_read() and vfs_write(). Routines sys_readv() and sys_writev()
    are using vfs_readv() and vfs_writev(). Both functions are calling
    do_readv_writev(). Thus we increment counters in vfs_read(), 
    vfs_write(), do_readv_writev() and do_sendfile(). For the
    latter, the incrementation is done in the do_sendfile() because this
    routine is directly called from the return of sys_sendfile(). 


Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

diff -uprN -X dontdiff linux-2.6.8.1-vanilla/fs/read_write.c linux-2.6.8.1-char_IO_acct/fs/read_write.c
--- linux-2.6.8.1-vanilla/fs/read_write.c	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1-char_IO_acct/fs/read_write.c	2004-09-08 13:11:43.832260408 +0200
@@ -216,8 +216,10 @@ ssize_t vfs_read(struct file *file, char
 				ret = file->f_op->read(file, buf, count, pos);
 			else
 				ret = do_sync_read(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_ACCESS);
+				current->rchar += ret;
+			}
 		}
 	}
 
@@ -260,8 +262,10 @@ ssize_t vfs_write(struct file *file, con
 				ret = file->f_op->write(file, buf, count, pos);
 			else
 				ret = do_sync_write(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_MODIFY);
+				current->wchar += ret;
+			}
 		}
 	}
 
@@ -496,6 +500,14 @@ out:
 	if ((ret + (type == READ)) > 0)
 		dnotify_parent(file->f_dentry,
 				(type == READ) ? DN_ACCESS : DN_MODIFY);
+
+	if (ret > 0) {
+		if (type == READ)
+			current->rchar += ret;
+		else /* type == WRITE */
+			current->wchar += ret;
+	}
+
 	return ret;
 }
 
@@ -644,6 +656,11 @@ fput_out:
 fput_in:
 	fput_light(in_file, fput_needed_in);
 out:
+	if (retval > 0) {
+		current->rchar += retval;
+		current->wchar += retval;
+	}
+	
 	return retval;
 }
 
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/linux/sched.h linux-2.6.8.1-char_IO_acct/include/linux/sched.h
--- linux-2.6.8.1-vanilla/include/linux/sched.h	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1-char_IO_acct/include/linux/sched.h	2004-09-08 12:49:35.634177208 +0200
@@ -523,6 +523,9 @@ struct task_struct {
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
 
+/* IO counters: bytes read, bytes written */
+	unsigned long rchar, wchar;
+
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/kernel/acct.c linux-2.6.8.1-char_IO_acct/kernel/acct.c
--- linux-2.6.8.1-vanilla/kernel/acct.c	2004-08-14 12:55:33.000000000 +0200
+++ linux-2.6.8.1-char_IO_acct/kernel/acct.c	2004-09-08 12:50:50.058862936 +0200
@@ -464,8 +464,8 @@ static void do_acct_process(long exitcod
 	}
 	vsize = vsize / 1024;
 	ac.ac_mem = encode_comp_t(vsize);
-	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
-	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
+	ac.ac_io = encode_comp_t(current->rchar + current->wchar);
+	ac.ac_rw = encode_comp_t(0 /* ac.ac_io / 1024 */);
 	ac.ac_minflt = encode_comp_t(current->min_flt);
 	ac.ac_majflt = encode_comp_t(current->maj_flt);
 	ac.ac_swaps = encode_comp_t(0);
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/kernel/fork.c linux-2.6.8.1-char_IO_acct/kernel/fork.c
--- linux-2.6.8.1-vanilla/kernel/fork.c	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1-char_IO_acct/kernel/fork.c	2004-09-08 12:50:07.931267304 +0200
@@ -965,6 +965,7 @@ struct task_struct *copy_process(unsigne
 	p->security = NULL;
 	p->io_context = NULL;
 	p->audit_context = NULL;
+	p->rchar = p->wchar = 0;
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
