Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUAYOAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 09:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUAYOAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 09:00:42 -0500
Received: from mx.sz.bfs.de ([194.94.69.70]:26321 "EHLO mx.sz.bfs.de")
	by vger.kernel.org with ESMTP id S264257AbUAYOAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 09:00:40 -0500
Date: Sun, 25 Jan 2004 15:02:24 +0100
Illegal-Object: Syntax error in Message-ID: value found on vger.kernel.org:
	Message-ID:	=?ISO-8859-1?Q?=20<vines.sxdD+dlw=B2?= =?ISO-8859-1?Q?+A@SZKOM.BFS.DE>
				^		  ^-illegal end of message identification
			 \-Extraneous program text, illegal start of message identification
X-Priority: 3 (Normal)
To: <kernel-janitors@lists.osdl.org>
Cc: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: mm/slab.c: linux 2.6.1 fix 2 unguarded kmalloc and a PAGE_SHIFT
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
X-Amavis-Alert: BAD HEADER Non-encoded 8-bit data (char B2 hex) in message header 'Message-ID'
  Message-ID: <vines.sxdD+dlw\262+A@SZKOM.BFS.DE>\n
                             ^
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S264257AbUAYOAm/20040125140042Z+37462@vger.kernel.org>

Hi list,
this fixes catches 2 unguarded kmallocs() and changes a statement so that PAGE_SHIFT >20 causes a warning. 
At least sparc64 is prepared for a  PAGE_SHIFT >20.

hope that helps,
walter


--- mm/slab.c.org       2004-01-25 08:18:25.243165360 +0100
+++ mm/slab.c   2004-01-25 08:33:05.135401408 +0100
@@ -666,7 +666,7 @@
         * Fragmentation resistance on low memory - only use bigger
         * page orders on machines with more than 32MB of memory.
         */
-       if (num_physpages > (32 << 20) >> PAGE_SHIFT)
+       if (num_physpages > (32 << (20-PAGE_SHIFT) )
                slab_break_gfp_order = BREAK_GFP_ORDER_HI;
 
 
@@ -737,6 +737,10 @@
                void * ptr;
 
                ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+
+               if (!ptr)
+                 BUG();
+
                local_irq_disable();
                BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
                memcpy(ptr, ac_data(&cache_cache), sizeof(struct arraycache_init
));
@@ -744,6 +748,10 @@
                local_irq_enable();
 
                ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+
+               if (!ptr)
+                 BUG();
+
                local_irq_disable();
                BUG_ON(ac_data(malloc_sizes[0].cs_cachep) != &initarray_generic.
cache);
                memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep),

