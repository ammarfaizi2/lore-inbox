Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268959AbUIHJIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268959AbUIHJIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIHJIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:08:17 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:50102 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268959AbUIHJHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:07:06 -0400
Date: Wed, 8 Sep 2004 11:06:57 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: linux-kernel@vger.kernel.org
Cc: Jay Lan <jlan@engr.sgi.com>
Subject: [patch 2.6.8.1] BSD accounting: update chars transferred value
Message-ID: <20040908090657.GA9879@frec.bull.fr>
Mime-Version: 1.0
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2004 11:12:27,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2004 11:12:30,
	Serialize complete at 08/09/2004 11:12:30
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
problem is that we don't know how to get information about the IID at 
the page level (ie from struct page). So we remove this information for 
the moment and it will be provided in another patch.

Changelog:
  
  - Adds two counters in the task_struct (rchar, wchar)
  - Init fields during the creation of the process (during the fork)
  - File I/O operations are done through sys_read(), sys_write(), 
    sys_readv(), sys_writev() and sys_sendfile(). Thus we increment 
    counters into those functions except with sys_sendfile(). For the
    latter, the incrementation is done in the do_sendfile() because this
    routine be directly called from the return of sys_sendfile().


Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>


diff -uprN -X dontdiff linux-2.6.8.1-vanilla/fs/read_write.c linux-2.6.8.1-char_IO_acct/fs/read_write.c
--- linux-2.6.8.1-vanilla/fs/read_write.c	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1-char_IO_acct/fs/read_write.c	2004-09-08 08:32:29.043438000 +0200
@@ -294,6 +294,9 @@ asmlinkage ssize_t sys_read(unsigned int
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->rchar += ret;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sys_read);
@@ -312,6 +315,9 @@ asmlinkage ssize_t sys_write(unsigned in
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->wchar += ret;
+
 	return ret;
 }
 
@@ -540,6 +546,9 @@ sys_readv(unsigned long fd, const struct
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->rchar += ret;
+
 	return ret;
 }
 
@@ -558,6 +567,9 @@ sys_writev(unsigned long fd, const struc
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->wchar += ret;
+
 	return ret;
 }
 
@@ -639,6 +651,11 @@ static ssize_t do_sendfile(int out_fd, i
 	if (*ppos > max)
 		retval = -EOVERFLOW;
 
+	if (retval > 0) {
+		current->rchar += retval;
+		current->wchar += retval;
+	}
+
 fput_out:
 	fput_light(out_file, fput_needed_out);
 fput_in:
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/linux/sched.h linux-2.6.8.1-char_IO_acct/include/linux/sched.h
--- linux-2.6.8.1-vanilla/include/linux/sched.h	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1-char_IO_acct/include/linux/sched.h	2004-09-08 08:08:47.565535488 +0200
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
+++ linux-2.6.8.1-char_IO_acct/kernel/acct.c	2004-09-08 08:10:04.758800328 +0200
@@ -464,8 +464,8 @@ static void do_acct_process(long exitcod
 	}
 	vsize = vsize / 1024;
 	ac.ac_mem = encode_comp_t(vsize);
-	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
-	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
+	ac.ac_io = encode_comp_t(current->rchar + current->wchar);
+	ac.ac_rw = encode_comp_t(0 /* ac.ac_io / 1024 */);	/* %% */
 	ac.ac_minflt = encode_comp_t(current->min_flt);
 	ac.ac_majflt = encode_comp_t(current->maj_flt);
 	ac.ac_swaps = encode_comp_t(0);
diff -uprN -X dontdiff linux-2.6.8.1-vanilla/kernel/fork.c linux-2.6.8.1-char_IO_acct/kernel/fork.c
--- linux-2.6.8.1-vanilla/kernel/fork.c	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1-char_IO_acct/kernel/fork.c	2004-09-08 08:11:24.308706904 +0200
@@ -965,6 +965,7 @@ struct task_struct *copy_process(unsigne
 	p->security = NULL;
 	p->io_context = NULL;
 	p->audit_context = NULL;
+	p->rchar = p->wchar = 0;
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
