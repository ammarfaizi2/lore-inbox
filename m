Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266493AbUHBMO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUHBMO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUHBMO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:14:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34464 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266493AbUHBMOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:14:20 -0400
Date: Mon, 2 Aug 2004 08:13:36 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp030.home.surriel.com
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch for review] BSD accounting IO stats
In-Reply-To: <410E26FC.208@bull.net>
Message-ID: <Pine.LNX.4.58.0408020811540.13053@dhcp030.home.surriel.com>
References: <410E26FC.208@bull.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY=------------090602090500060908070107
Content-ID: <Pine.LNX.4.58.0408020811541.13053@dhcp030.home.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------090602090500060908070107
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.58.0408020811542.13053@dhcp030.home.surriel.com>

On Mon, 2 Aug 2004, Guillaume Thouvenin wrote:

>  Modifications are:
>     - It adds four counters in the task_struct (chars read, chars
>       written, blocks read and blocks written). I think it's interesting to
>       separate read and write even if this difference is not made in the
>       BSD accounting.

Nice.  One question though:

> @@ -295,6 +298,9 @@ asmlinkage ssize_t sys_write(unsigned in
>                 fput_light(file, fput_needed);
>         }
>                                                     
> +       if (ret > 0)
> +               current->wchar++;
> +
>         return ret;
>  }
                                                                                
Shouldn't that be   "current->wchar += ret"  ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
--------------090602090500060908070107
Content-Type: TEXT/PLAIN; NAME="patch-2.6.8-rc2+BSDacct_IO"
Content-ID: <Pine.LNX.4.58.0408020811543.13053@dhcp030.home.surriel.com>
Content-Description: 
Content-Disposition: INLINE; FILENAME="patch-2.6.8-rc2+BSDacct_IO"

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
