Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281097AbRKDSew>; Sun, 4 Nov 2001 13:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281086AbRKDSdx>; Sun, 4 Nov 2001 13:33:53 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:43020 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281080AbRKDSce>; Sun, 4 Nov 2001 13:32:34 -0500
Message-ID: <3BE58886.FBCAEDB5@zip.com.au>
Date: Sun, 04 Nov 2001 10:27:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mau <mau@oscar.prima.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.14-pre8: 'free' still reports bogus 'cached' value.
In-Reply-To: <20011104132238.A14511@oscar.dorf.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mau wrote:
> 
> Hi all,
> 
> I just compiled 2.4.14-pre8, did some bonnie++ runs
> and compiled a few kernels to stress test this release.
> 
> Here's the output of 'free':
> 
> [root@tony] free
>              total       used       free     shared    buffers     cached
> Mem:        513336      82124     431212          0      30696 4294958092
> -/+ buffers/cache:      60632     452704
> Swap:       786416       4936     781480
> 

It's a bug in the /proc code.  If buffercache pages exceed
pagecache pages, `pg_size' flips negative.

There doesn't seem to be any reason to subtract buffermem_pages
from page_cache_size - they're independent.



--- linux-2.4.14-pre8/fs/proc/proc_misc.c	Tue Oct 23 23:09:42 2001
+++ linux-akpm/fs/proc/proc_misc.c	Sun Nov  4 10:10:18 2001
@@ -140,7 +140,7 @@ static int meminfo_read_proc(char *page,
 {
 	struct sysinfo i;
 	int len;
-	int pg_size ;
+	unsigned int cached;
 
 /*
  * display in kilobytes.
@@ -149,14 +149,14 @@ static int meminfo_read_proc(char *page,
 #define B(x) ((unsigned long long)(x) << PAGE_SHIFT)
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	pg_size = atomic_read(&page_cache_size) - i.bufferram ;
+	cached = atomic_read(&page_cache_size);
 
 	len = sprintf(page, "        total:    used:    free:  shared: buffers:  cached:\n"
 		"Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
 		"Swap: %8Lu %8Lu %8Lu\n",
 		B(i.totalram), B(i.totalram-i.freeram), B(i.freeram),
 		B(i.sharedram), B(i.bufferram),
-		B(pg_size), B(i.totalswap),
+		B(cached), B(i.totalswap),
 		B(i.totalswap-i.freeswap), B(i.freeswap));
 	/*
 	 * Tagged format, for easy grepping and expansion.
@@ -182,7 +182,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeram),
 		K(i.sharedram),
 		K(i.bufferram),
-		K(pg_size - swapper_space.nrpages),
+		K(cached - swapper_space.nrpages),
 		K(swapper_space.nrpages),
 		K(nr_active_pages),
 		K(nr_inactive_pages),
