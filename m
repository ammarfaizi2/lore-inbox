Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264493AbUEDTkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUEDTkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbUEDTkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:40:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10439 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264493AbUEDTkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:40:43 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, peter@mysql.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <1083683034.13688.7.camel@localhost.localdomain>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
	 <20040503145922.5a7dee73.akpm@osdl.org> <4096DC89.5020300@yahoo.com.au>
	 <20040503171005.1e63a745.akpm@osdl.org> <4096E1A6.2010506@yahoo.com.au>
	 <1083631804.4544.16.camel@localhost.localdomain>
	 <20040503232928.1b13037c.akpm@osdl.org>
	 <1083683034.13688.7.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-wnqAHvwWw2v7ec8/CNAM"
Organization: 
Message-Id: <1083699554.13688.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2004 12:39:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wnqAHvwWw2v7ec8/CNAM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-05-04 at 08:03, Ram Pai wrote:
> On Mon, 2004-05-03 at 23:29, Andrew Morton wrote:
>  
> > 
> > Putting a semaphore around do_generic_file_read() or maintaining the state
> > as below fixes it up.
> > 
> > I wonder if we should bother fixing this?  I guess as long as the app is
> > using pread() it is a legitimate thing to be doing, so I guess we should...
> > 
> > 
> > 
> Yes this patch makes sense. I have setup sysbench on my lab machine. Let
> me see how much improvement the patch provides.
I ran the following command:

/root/sysbench-0.2.5/sysbench/sysbench --num-threads=256 --test=fileio
--file-total-size=2800M --file-test-mode=rndrw run 



Without the patch:
------------------

Operations performed:  5959 Read, 4041 Write, 10752 Other = 20752 Total
Read 93Mb  Written 63Mb  Total Transferred 156Mb
   7.549Mb/sec  Transferred
  483.89 Requests/sec executed

Test execution Statistics summary:
Time spent for test:  20.6661s

no of times window reset because of hits: 0
no of times window reset because of misses: 7
no of times window was shrunk because of hits: 6716
no of times the page request was non-contiguous: 5880
no of times the page request was contiguous : 19639


With the patch:
--------------

Operations performed:  5960 Read, 4040 Write, 10880 Other = 20880 Total
Read 93Mb  Written 63Mb  Total Transferred 156Mb
   7.985Mb/sec  Transferred
   511.85 Requests/sec executed

Test execution Statistics summary:
Time spent for test:  19.5370s


no of times window got reset because of hits: 0
no of times window got reset because of misses: 0
no of times window was shrunk because of hits: 5844
no of times the page request was non-contiguous: 5830
no of times the page request was contiguous : 20232


I have enclosed the patch that collects the hit/miss related counts.

        In general I am not seeing any major difference with or without
        andrew's ra-copy patch; except for readahead window getting
        closed because of misses when run without the patch.

Would be nice if Alexey tries the patch on his machine and sees any
major difference.

RP





--=-wnqAHvwWw2v7ec8/CNAM
Content-Disposition: attachment; filename=ra_instrumentation.patch
Content-Type: text/x-patch; name=ra_instrumentation.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urNp linux-2.6.6-rc3/include/linux/sysctl.h linux-2.6.6-rc3.new/include/linux/sysctl.h
--- linux-2.6.6-rc3/include/linux/sysctl.h	2004-04-27 18:35:49.000000000 -0700
+++ linux-2.6.6-rc3.new/include/linux/sysctl.h	2004-05-04 18:26:37.911973080 -0700
@@ -643,6 +643,11 @@ enum
 	FS_XFS=17,	/* struct: control xfs parameters */
 	FS_AIO_NR=18,	/* current system-wide number of aio requests */
 	FS_AIO_MAX_NR=19,	/* system-wide maximum number of aio requests */
+	FS_READ_MISS_RESET=20,
+	FS_READ_HIT_RESET=21,
+	FS_CONTIGUOUS_CNT=22,
+	FS_NON_CONTIGUOUS_CNT=22,
+	FS_HIT_COUNT=23,
 };
 
 /* /proc/sys/fs/quota/ */
diff -urNp linux-2.6.6-rc3/kernel/sysctl.c linux-2.6.6-rc3.new/kernel/sysctl.c
--- linux-2.6.6-rc3/kernel/sysctl.c	2004-04-27 18:35:08.000000000 -0700
+++ linux-2.6.6-rc3.new/kernel/sysctl.c	2004-05-04 18:38:58.774344880 -0700
@@ -64,6 +64,13 @@ extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
+extern int printk_ratelimit_burst;
+extern int printk_ratelimit_burst;
+extern atomic_t hit_reset;
+extern atomic_t miss_reset;
+extern atomic_t hit_count;
+extern atomic_t contiguous_cnt;
+extern atomic_t non_contiguous_cnt;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -897,6 +904,46 @@ static ctl_table fs_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= FS_READ_MISS_RESET,
+		.procname	= "read-miss-reset",
+		.data		= &miss_reset,
+		.maxlen		= sizeof(miss_reset),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_READ_HIT_RESET,
+		.procname	= "read-hit-reset",
+		.data		= &hit_reset,
+		.maxlen		= sizeof(hit_reset),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_CONTIGUOUS_CNT,
+		.procname	= "read-contiguous-cnt",
+		.data		= &contiguous_cnt,
+		.maxlen		= sizeof(contiguous_cnt),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_NON_CONTIGUOUS_CNT,
+		.procname	= "read-non-contiguous-cnt",
+		.data		= &non_contiguous_cnt,
+		.maxlen		= sizeof(non_contiguous_cnt),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_HIT_COUNT,
+		.procname	= "read-hit-count",
+		.data		= &hit_count,
+		.maxlen		= sizeof(hit_count),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -urNp linux-2.6.6-rc3/mm/readahead.c linux-2.6.6-rc3.new/mm/readahead.c
--- linux-2.6.6-rc3/mm/readahead.c	2004-04-27 18:35:06.000000000 -0700
+++ linux-2.6.6-rc3.new/mm/readahead.c	2004-05-04 18:37:20.681257296 -0700
@@ -316,6 +316,12 @@ int do_page_cache_readahead(struct addre
 	return 0;
 }
 
+atomic_t hit_reset= ATOMIC_INIT(0);
+atomic_t miss_reset= ATOMIC_INIT(0);
+atomic_t hit_count= ATOMIC_INIT(0);
+atomic_t contiguous_cnt = ATOMIC_INIT(0);
+atomic_t non_contiguous_cnt= ATOMIC_INIT(0);
+
 /*
  * Check how effective readahead is being.  If the amount of started IO is
  * less than expected then the file is partly or fully in pagecache and
@@ -331,11 +337,13 @@ check_ra_success(struct file_ra_state *r
 	if (actual == 0) {
 		if (orig_next_size > 1) {
 			ra->next_size = orig_next_size - 1;
+			atomic_inc(&hit_count);
 			if (ra->ahead_size)
 				ra->ahead_size = ra->next_size;
 		} else {
 			ra->next_size = -1UL;
 			ra->size = 0;
+			atomic_inc(&hit_reset);
 		}
 	}
 }
@@ -406,17 +414,20 @@ page_cache_readahead(struct address_spac
 		 * page beyond the end.  Expand the next readahead size.
 		 */
 		ra->next_size += 2;
+		atomic_inc(&contiguous_cnt);
 	} else {
 		/*
 		 * A miss - lseek, pagefault, pread, etc.  Shrink the readahead
 		 * window.
 		 */
 		ra->next_size -= 2;
+		atomic_inc(&non_contiguous_cnt);
 	}
 
 	if ((long)ra->next_size > (long)max)
 		ra->next_size = max;
 	if ((long)ra->next_size <= 0L) {
+		atomic_inc(&miss_reset);
 		ra->next_size = -1UL;
 		ra->size = 0;
 		goto out;		/* Readahead is off */

--=-wnqAHvwWw2v7ec8/CNAM--

