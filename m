Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSDDGzy>; Thu, 4 Apr 2002 01:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311239AbSDDGzo>; Thu, 4 Apr 2002 01:55:44 -0500
Received: from fmr02.intel.com ([192.55.52.25]:34022 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S311121AbSDDGz1>; Thu, 4 Apr 2002 01:55:27 -0500
X-Uptime: 3:54pm  up 2 days,  4:55,  2 users,  load average: 0.05, 0.01, 0.00
X-OS: Linux hazuki 2.4.17 #5 SMP Tue Feb 19 12:06:25 JST 2002 i686 unknown
To: linux-kernel@vger.kernel.org
Cc: jt@hpl.hp.com, dhinds@zen.stanford.edu
Subject: [PATCH] 2.5.8-pre1 wavelan_cs
X-Organization: IOS
X-Disclaimer: My opinions do not necessarily represent anything ...err those of my employer
Content-Type: text/plain; charset=US-ASCII
From: flaniganr@intel.co.jp
Date: 04 Apr 2002 15:54:14 +0900
Message-ID: <87vgb8x8bt.fsf@hazuki.jp.intel.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


not sure if i did this right, so if you 
have any suggestions/comments please tell me.

Basically 2.5.8-pre1 fails to compile with:

In file included from wavelan_cs.c:59:
wavelan_cs.p.h:495:33: warning: extra tokens at end of #undef directive
wavelan_cs.c: In function `wv_pcmcia_config':
wavelan_cs.c:4480: structure has no member named `rmem_start'
wavelan_cs.c:4482: structure has no member named `rmem_end'
make[3]: *** [wavelan_cs.o] Error 1

due to the removal of rmem_{start,end} from net_device.
here is the patch [tested]:

diff -ru a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
--- a/drivers/net/wireless/wavelan_cs.c Tue Mar 19 05:37:16 2002
+++ b/drivers/net/wireless/wavelan_cs.c Thu Apr  4 13:17:43 2002
@@ -4383,6 +4383,7 @@
   tuple_t              tuple;
   cisparse_t           parse;
   struct net_device *  dev;
+  struct net_local *   lp;
   int                  i;
   u_char               buf[64];
   win_req_t            req;
@@ -4390,6 +4391,7 @@

   handle = link->handle;
   dev = (device *) link->priv;
+  lp = (net_local *)dev->priv;

 #ifdef DEBUG_CONFIG_TRACE
   printk(KERN_DEBUG "->wv_pcmcia_config(0x%p)\n", link);
@@ -4477,9 +4479,9 @@
          break;
        }

-      dev->rmem_start = dev->mem_start =
+      lp->rmem_start = dev->mem_start =
          (u_long)ioremap(req.Base, req.Size);
-      dev->rmem_end = dev->mem_end = dev->mem_start + req.Size;
+      lp->rmem_end = dev->mem_end = dev->mem_start + req.Size;

       mem.CardOffset = 0; mem.Page = 0;
       i = CardServices(MapMemPage, link->win, &mem);
diff -ru a/drivers/net/wireless/wavelan_cs.p.h b/drivers/net/wireless/wavelan_cs.p.h
--- a/drivers/net/wireless/wavelan_cs.p.h       Tue Mar 19 05:37:09 2002
+++ b/drivers/net/wireless/wavelan_cs.p.h       Thu Apr  4 14:05:43 2002
@@ -638,6 +638,9 @@
   int          rfp;            /* Last DMA machine receive pointer */
   int          overrunning;    /* Receiver overrun flag */

+  unsigned long rmem_start;
+  unsigned long rmem_end;
+
 #ifdef WIRELESS_EXT
   iw_stats     wstats;         /* Wireless specific stats */
 #endif




-- 

----
