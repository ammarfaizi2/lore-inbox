Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTBSSIk>; Wed, 19 Feb 2003 13:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbTBSSIj>; Wed, 19 Feb 2003 13:08:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:13484 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261581AbTBSSIi>;
	Wed, 19 Feb 2003 13:08:38 -0500
Date: Wed, 19 Feb 2003 10:19:57 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-Id: <20030219101957.05088aa1.akpm@digeo.com>
In-Reply-To: <32720000.1045671824@[10.10.2.4]>
References: <32720000.1045671824@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Feb 2003 18:18:35.0285 (UTC) FILETIME=[50FB4C50:01C2D843]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> I'm comparing 59-mjb6 to 61-mjb1 and notice some strange performance
> differences that I can't explain ... not a big drop, but odd.
>...
> 
> 1562 .text.lock.file_table
> 583 dentry_open
> 551 get_empty_filp

The first one here is fget().  That's causing problems on ppc64 as well - the
machine is spending as long in fget as it is in copy_foo_user() in dbench
runs.

One possibility is that we're calling fget() more often than previously,
although that would be rather odd.  Can you add the below patch, and monitor
/proc/meminfo:nr_fgets?

If not that, then maybe some funny cacheline aliasing thing?


 file_table.c       |    2 ++
 linux/page-flags.h |    1 +
 page_alloc.c       |    1 +
 3 files changed, 4 insertions(+)

diff -puN include/linux/page-flags.h~fget-counter include/linux/page-flags.h
--- 25/include/linux/page-flags.h~fget-counter	2003-02-19 10:14:54.000000000 -0800
+++ 25-akpm/include/linux/page-flags.h	2003-02-19 10:15:26.000000000 -0800
@@ -87,6 +87,7 @@ struct page_state {
 	unsigned long nr_reverse_maps;	/* includes PageDirect */
 	unsigned long nr_mapped;	/* mapped into pagetables */
 	unsigned long nr_slab;		/* In slab */
+	unsigned long nr_fgets;
 #define GET_PAGE_STATE_LAST nr_slab
 
 	/*
diff -puN mm/page_alloc.c~fget-counter mm/page_alloc.c
--- 25/mm/page_alloc.c~fget-counter	2003-02-19 10:15:20.000000000 -0800
+++ 25-akpm/mm/page_alloc.c	2003-02-19 10:15:48.000000000 -0800
@@ -1439,6 +1439,7 @@ static char *vmstat_text[] = {
 	"nr_reverse_maps",
 	"nr_mapped",
 	"nr_slab",
+	"nr_fgets",
 
 	"pgpgin",
 	"pgpgout",
diff -puN fs/file_table.c~fget-counter fs/file_table.c
--- 25/fs/file_table.c~fget-counter	2003-02-19 10:15:55.000000000 -0800
+++ 25-akpm/fs/file_table.c	2003-02-19 10:16:21.000000000 -0800
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/security.h>
 #include <linux/eventpoll.h>
 #include <linux/mount.h>
@@ -156,6 +157,7 @@ struct file * fget(unsigned int fd)
 	struct file * file;
 	struct files_struct *files = current->files;
 
+	inc_page_state(nr_fgets);
 	read_lock(&files->file_lock);
 	file = fcheck(fd);
 	if (file)

_

