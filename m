Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266494AbUHBM6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUHBM6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUHBM6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:58:52 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:59892 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S266494AbUHBM6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:58:45 -0400
Message-ID: <410E3A75.9020700@bull.net>
Date: Mon, 02 Aug 2004 14:58:29 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch for review] BSD accounting IO stats
References: <410E26FC.208@bull.net> <Pine.LNX.4.58.0408020811540.13053@dhcp030.home.surriel.com>
In-Reply-To: <Pine.LNX.4.58.0408020811540.13053@dhcp030.home.surriel.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/08/2004 15:03:16,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/08/2004 15:03:22,
	Serialize complete at 02/08/2004 15:03:22
Content-Type: multipart/mixed;
 boundary="------------040109010805020502010008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040109010805020502010008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rik van Riel wrote:

> On Mon, 2 Aug 2004, Guillaume Thouvenin wrote:
>
>>  Modifications are:
>>     - It adds four counters in the task_struct (chars read, chars
>>       written, blocks read and blocks written). I think it's 
>> interesting to
>>       separate read and write even if this difference is not made in the
>>       BSD accounting.
>
>
> Nice.  One question though:
>
>> @@ -295,6 +298,9 @@ asmlinkage ssize_t sys_write(unsigned in
>>                 fput_light(file, fput_needed);
>>         }
>>                                                     +       if (ret > 0)
>> +               current->wchar++;
>> +
>>         return ret;
>>  }
>
>    Shouldn't that be   "current->wchar += ret"  ?


Yes you're right. I attach a new patch with those modifications.
Thank you

Guillaume

--------------040109010805020502010008
Content-Type: text/plain;
 name="patch-2.6.8-rc2+BSDacct_IO"
Content-Disposition: inline;
 filename="patch-2.6.8-rc2+BSDacct_IO"
Content-Transfer-Encoding: 7bit

diff -uprN -X dontdiff linux-2.6.8-rc2/drivers/block/ll_rw_blk.c linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c
--- linux-2.6.8-rc2/drivers/block/ll_rw_blk.c	2004-07-18 06:57:42.000000000 +0200
+++ linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c	2004-08-02 14:40:24.406684216 +0200
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
+++ linux-2.6.8-rc2+BSDacct_IO/fs/read_write.c	2004-08-02 14:55:13.119579320 +0200
@@ -279,6 +279,9 @@ asmlinkage ssize_t sys_read(unsigned int
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->rchar += ret;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sys_read);
@@ -295,6 +298,9 @@ asmlinkage ssize_t sys_write(unsigned in
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->wchar += ret;
+
 	return ret;
 }
 
@@ -517,6 +523,9 @@ sys_readv(unsigned long fd, const struct
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->rchar += ret;
+
 	return ret;
 }
 
@@ -533,6 +542,9 @@ sys_writev(unsigned long fd, const struc
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->wchar += ret;
+
 	return ret;
 }
 
@@ -607,6 +619,11 @@ static ssize_t do_sendfile(int out_fd, i
 
 	retval = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);
 
+	if (retval > 0) {
+		current->rchar += retval;
+		current->wchar += retval;
+	}
+	
 	if (*ppos > max)
 		retval = -EOVERFLOW;
 
diff -uprN -X dontdiff linux-2.6.8-rc2/include/linux/sched.h linux-2.6.8-rc2+BSDacct_IO/include/linux/sched.h
--- linux-2.6.8-rc2/include/linux/sched.h	2004-07-18 06:57:42.000000000 +0200
+++ linux-2.6.8-rc2+BSDacct_IO/include/linux/sched.h	2004-08-02 14:32:28.877975568 +0200
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
+++ linux-2.6.8-rc2+BSDacct_IO/kernel/acct.c	2004-08-02 14:33:45.902266096 +0200
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
+++ linux-2.6.8-rc2+BSDacct_IO/kernel/fork.c	2004-08-02 14:33:06.991181480 +0200
@@ -960,6 +960,7 @@ struct task_struct *copy_process(unsigne
 
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+	p->rchar = p->wchar = p->rblk = p->wblk = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;


--------------040109010805020502010008--
