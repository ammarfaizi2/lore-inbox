Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279250AbRKAQ2b>; Thu, 1 Nov 2001 11:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279264AbRKAQ2W>; Thu, 1 Nov 2001 11:28:22 -0500
Received: from femail21.sdc1.sfba.home.com ([24.0.95.146]:34022 "EHLO
	femail21.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279250AbRKAQ2I>; Thu, 1 Nov 2001 11:28:08 -0500
Date: Thu, 1 Nov 2001 11:28:00 -0500
To: linux-kernel@vger.kernel.org
Cc: Chris Tracy <ctracy@adiemus.org>
Subject: Re: 2.4.13-ac2/3/5: Strange cache memory report
Message-ID: <20011101112800.A10230@cy599856-a.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Chris Tracy <ctracy@adiemus.org>
In-Reply-To: <Pine.LNX.4.30.0111010007160.10052-100000@adiemus.org> <20011101092639.A27900@punch.eidetica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011101092639.A27900@punch.eidetica.com>
User-Agent: Mutt/1.3.23i
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.14-pre6 i586 K6-3+
X-Uptime: 11:25:53 up  8:54,  1 user,  load average: 0.00, 0.00, 0.00
From: Josh McKinney <forming@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Thu, Nov 01, 2001 at 09:26:39AM +0100, Alexander Kellett wrote:
> > Hey,
> > 
> > 	I've noticed a strange bug in 2.4.13-ac2, 3, and 5.  (It wasn't
> > there in 2.4.12-ac2)  Namely, shortly after starting X, the reported
> > amount of cached memory spikes to somewhere around 18 hexabytes.
> > Needless to say, I don't have this much memory.  :-)
> 
> Rik posted a patch yesterday to fix this.
> 

Here is the mentioned patch again.




--- linux-2.4.13-ac5/fs/proc/proc_misc.c.blkpg	Wed Oct 31 13:09:51 2001
+++ linux-2.4.13-ac5/fs/proc/proc_misc.c	Wed Oct 31 13:12:27 2001
@@ -140,7 +140,9 @@
 {
 	struct sysinfo i;
 	int len;
-	int pg_size;
+	unsigned int cached;
+
+	cached = atomic_read(&page_cache_size) - atomic_read(&shmem_nrpages);

 /*
  * display in kilobytes.
@@ -149,14 +151,12 @@
 #define B(x) ((unsigned long long)(x) << PAGE_SHIFT)
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	pg_size = atomic_read(&page_cache_size) - i.bufferram ;
-
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
@@ -184,7 +184,7 @@
 		K(i.freeram),
 		K(i.sharedram),
 		K(i.bufferram),
-		K(pg_size - swapper_space.nrpages),
+		K(cached - swapper_space.nrpages),
 		K(swapper_space.nrpages),
 		K(nr_active_pages),
 		K(nr_inactive_dirty_pages),

-- 
Linux, the choice                | <doogie> Thinking is dangerous.  It leads
of a GNU generation       -o)    | to ideas.  -- Seen on #Debian 
Kernel 2.4.14-pre6         /\    | 
on a i586                 _\_v   | 
                                 | 
