Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280262AbRJaPQQ>; Wed, 31 Oct 2001 10:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280264AbRJaPQG>; Wed, 31 Oct 2001 10:16:06 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:34062 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280263AbRJaPQD>;
	Wed, 31 Oct 2001 10:16:03 -0500
Date: Wed, 31 Oct 2001 13:16:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] correct cached statistics
Message-ID: <Pine.LNX.4.33L.0110311314270.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems a small change from the blockdev-in-pagecache changes
has crept into 2.4.13-ac, the following patch backs out that
change and should make the cached stats correct again.

Please apply for the next one.

thanks,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/


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

