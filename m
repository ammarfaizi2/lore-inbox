Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUHBLgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUHBLgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 07:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUHBLfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 07:35:55 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:38385 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S266458AbUHBLf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 07:35:28 -0400
Message-ID: <410E26FC.208@bull.net>
Date: Mon, 02 Aug 2004 13:35:24 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [Patch for review] BSD accounting IO stats
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/08/2004 13:40:11,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/08/2004 13:40:14,
	Serialize complete at 02/08/2004 13:40:14
Content-Type: multipart/mixed;
 boundary="------------090602090500060908070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090602090500060908070107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

  Here is a small patch for 2.6.8-rc2 that updates information about 
bytes and blocks read and written. Fields are already in the BSD 
accounting files but they are never updated. The patch is based on the 
CSA accounting patch and it doesn't interfere with Tim Schmielau changes 
(BSD process accounting version 3).

 Modifications are:
    - It adds four counters in the task_struct (chars read, chars
      written, blocks read and blocks written). I think it's interesting to
      separate read and write even if this difference is not made in the
      BSD accounting.

    - Those fields are updated in:
        fs/read_write.c for bytes
                 [in sys_read(), sys_readv(), sys_write() and sys_writev]
        drivers/block/ll_rw_blk.c for blocks
                 [in drive_stat_acct()]

 
Hope This Help
Guillaume


--------------090602090500060908070107
Content-Type: text/plain;
 name="patch-2.6.8-rc2+BSDacct_IO"
Content-Disposition: inline;
 filename="patch-2.6.8-rc2+BSDacct_IO"
Content-Transfer-Encoding: 7bit

diff -uprN -X dontdiff linux-2.6.8-rc2/drivers/block/ll_rw_blk.c linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c
--- linux-2.6.8-rc2/drivers/block/ll_rw_blk.c	2004-07-18 06:57:42.000000000 +0200
+++ linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c	2004-07-27 09:17:33.149321480 +0200
@@ -1949,10 +1949,12 @@ void drive_stat_acct(struct request *rq,
 
 	if (rw == READ) {
 		disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
+		current->rblk += nr_sectors;
 		if (!new_io)
 			disk_stat_inc(rq->rq_disk, read_merges);
 	} else if (rw == WRITE) {
 		disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
+		current->wblk += nr_sectors;
 		if (!new_io)
 			disk_stat_inc(rq->rq_disk, write_merges);
 	}
diff -uprN -X dontdiff linux-2.6.8-rc2/fs/read_write.c linux-2.6.8-rc2+BSDacct_IO/fs/read_write.c
--- linux-2.6.8-rc2/fs/read_write.c	2004-07-18 06:58:50.000000000 +0200
+++ linux-2.6.8-rc2+BSDacct_IO/fs/read_write.c	2004-07-27 09:20:11.872191936 +0200
@@ -279,6 +279,9 @@ asmlinkage ssize_t sys_read(unsigned int
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->rchar++;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sys_read);
@@ -295,6 +298,9 @@ asmlinkage ssize_t sys_write(unsigned in
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->wchar++;
+
 	return ret;
 }
 
@@ -517,6 +523,9 @@ sys_readv(unsigned long fd, const struct
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->rchar++;
+
 	return ret;
 }
 
@@ -533,6 +542,9 @@ sys_writev(unsigned long fd, const struc
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->wchar++;
+
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.8-rc2/include/linux/sched.h linux-2.6.8-rc2+BSDacct_IO/include/linux/sched.h
--- linux-2.6.8-rc2/include/linux/sched.h	2004-07-18 06:57:42.000000000 +0200
+++ linux-2.6.8-rc2+BSDacct_IO/include/linux/sched.h	2004-07-27 09:21:08.567572928 +0200
@@ -465,6 +465,8 @@ struct task_struct {
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
+/* I/O info: chars read/written, blocks read/written */
+	unsigned long rchar, wchar, rblk, wblk;
 /* ipc stuff */
 	struct sysv_sem sysvsem;
 /* CPU-specific state of this task */
diff -uprN -X dontdiff linux-2.6.8-rc2/kernel/acct.c linux-2.6.8-rc2+BSDacct_IO/kernel/acct.c
--- linux-2.6.8-rc2/kernel/acct.c	2004-07-18 06:58:37.000000000 +0200
+++ linux-2.6.8-rc2+BSDacct_IO/kernel/acct.c	2004-07-27 09:22:30.623098592 +0200
@@ -465,8 +465,8 @@ static void do_acct_process(long exitcod
 	}
 	vsize = vsize / 1024;
 	ac.ac_mem = encode_comp_t(vsize);
-	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
-	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
+	ac.ac_io = encode_comp_t(current->rchar + current->wchar);
+	ac.ac_rw = encode_comp_t(current->rblk + current->wblk);
 	ac.ac_minflt = encode_comp_t(current->min_flt);
 	ac.ac_majflt = encode_comp_t(current->maj_flt);
 	ac.ac_swaps = encode_comp_t(0);
diff -uprN -X dontdiff linux-2.6.8-rc2/kernel/fork.c linux-2.6.8-rc2+BSDacct_IO/kernel/fork.c
--- linux-2.6.8-rc2/kernel/fork.c	2004-07-18 06:57:42.000000000 +0200
+++ linux-2.6.8-rc2+BSDacct_IO/kernel/fork.c	2004-07-27 09:23:27.111511048 +0200
@@ -960,6 +960,7 @@ struct task_struct *copy_process(unsigne
 
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+	p->rchar = p->wchar = p->rblk = p->wblk = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;



--------------090602090500060908070107--
