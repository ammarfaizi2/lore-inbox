Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUGBLg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUGBLg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 07:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUGBLg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 07:36:27 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:58546 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263095AbUGBLgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 07:36:21 -0400
Message-ID: <40E5481F.5070201@bull.net>
Date: Fri, 02 Jul 2004 13:33:51 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mvw@planets.elm.net, tdyas@eden.rutgers.edu,
       jlan@engr.sgi.com
Subject: [PATCH 2.6.7] BSD accounting + IO stats
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/07/2004 13:37:59,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/07/2004 13:40:28,
	Serialize complete at 02/07/2004 13:40:28
Content-Type: multipart/mixed;
 boundary="------------040209050703000702040901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040209050703000702040901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

    I made a small patch to add information about bytes and blocks read
and written. Fields was already in the BSD accounting but they were
never updated. The patch is based on the CSA accounting patch.

    - It adds four counters in the task_struct (chars read, chars 
written, blocks read and blocks written). I think it's intresting to 
separate read and write even if this difference is not made in the BSD 
accounting.

    - Those fields are updated in:
        fs/read_write.c for bytes [in sys_read(), sys_readv(),
                                      sys_write() and sys_writev]
        drivers/block/ll_rw_blk.c for blocks  [in drive_stat_acct()]

    - Modifications are:

    drivers/block/ll_rw_blk.c |    2 ++
    fs/read_write.c           |   12 ++++++++++++
    include/linux/sched.h     |    2 ++
    kernel/acct.c             |    4 ++--
    kernel/fork.c             |    1 +
    5 files changed, 19 insertions(+), 2 deletions(-)


I attach the patch to this email, if there is some problem to read it, 
it's also available on sourceforge at:
http://sourceforge.net/project/showfiles.php?group_id=105806&package_id=122778&release_id=250321

Hope this help,
Best,

Guillaume

--------------040209050703000702040901
Content-Type: text/plain;
 name="patch-2.6.7-BSDacct-IOstat"
Content-Disposition: inline;
 filename="patch-2.6.7-BSDacct-IOstat"
Content-Transfer-Encoding: 7bit

diff -uprN -X dontdiff linux-2.6.7-vanilla/drivers/block/ll_rw_blk.c linux-2.6.7/drivers/block/ll_rw_blk.c
--- linux-2.6.7-vanilla/drivers/block/ll_rw_blk.c	2004-06-16 07:18:58.000000000 +0200
+++ linux-2.6.7/drivers/block/ll_rw_blk.c	2004-07-02 10:40:46.499028784 +0200
@@ -1895,10 +1895,12 @@ void drive_stat_acct(struct request *rq,
 
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
diff -uprN -X dontdiff linux-2.6.7-vanilla/fs/read_write.c linux-2.6.7/fs/read_write.c
--- linux-2.6.7-vanilla/fs/read_write.c	2004-06-16 07:19:37.000000000 +0200
+++ linux-2.6.7/fs/read_write.c	2004-07-02 10:34:34.475584944 +0200
@@ -281,6 +281,9 @@ asmlinkage ssize_t sys_read(unsigned int
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0) 
+		current->rchar++;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sys_read);
@@ -297,6 +300,9 @@ asmlinkage ssize_t sys_write(unsigned in
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0) 
+		current->wchar++;
+
 	return ret;
 }
 
@@ -519,6 +525,9 @@ sys_readv(unsigned long fd, const struct
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0) 
+		current->rchar++;
+
 	return ret;
 }
 
@@ -535,6 +544,9 @@ sys_writev(unsigned long fd, const struc
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0) 
+		current->wchar++;
+
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.7-vanilla/include/linux/sched.h linux-2.6.7/include/linux/sched.h
--- linux-2.6.7-vanilla/include/linux/sched.h	2004-06-16 07:18:57.000000000 +0200
+++ linux-2.6.7/include/linux/sched.h	2004-07-02 10:22:02.329928464 +0200
@@ -459,6 +459,8 @@ struct task_struct {
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
+/* I/O info: chars read/written, blocks read/written */
+	unsigned long rchar, wchar, rblk, wblk;
 /* ipc stuff */
 	struct sysv_sem sysvsem;
 /* CPU-specific state of this task */
diff -uprN -X dontdiff linux-2.6.7-vanilla/kernel/acct.c linux-2.6.7/kernel/acct.c
--- linux-2.6.7-vanilla/kernel/acct.c	2004-06-16 07:19:35.000000000 +0200
+++ linux-2.6.7/kernel/acct.c	2004-07-02 10:42:45.136993072 +0200
@@ -376,8 +376,8 @@ static void do_acct_process(long exitcod
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
diff -uprN -X dontdiff linux-2.6.7-vanilla/kernel/fork.c linux-2.6.7/kernel/fork.c
--- linux-2.6.7-vanilla/kernel/fork.c	2004-06-16 07:18:57.000000000 +0200
+++ linux-2.6.7/kernel/fork.c	2004-07-02 10:28:03.661997640 +0200
@@ -960,6 +960,7 @@ struct task_struct *copy_process(unsigne
 
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+	p->rchar = p->wchar = p->rblk = p->wblk = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;



--------------040209050703000702040901--

