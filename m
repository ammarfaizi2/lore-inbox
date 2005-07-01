Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVGAXaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVGAXaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVGAXaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:30:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262710AbVGAXaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:30:01 -0400
Date: Fri, 1 Jul 2005 19:30:00 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Clean up numa defines in mmzone.h
Message-ID: <20050701233000.GB10534@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20050701212606.GA2970@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701212606.GA2970@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 05:26:07PM -0400, Dave Jones wrote:

 > this looks just.. wrong.
 > 
 > #if CONFIG_NUMA
 > extern struct pglist_data *node_data[];
 > #define NODE_DATA(nid)  (node_data[nid])
 > 
 > #ifdef CONFIG_NUMA

This patch cleans this stuff up. The compile failure I
saw is fixed in the followup patch.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/include/asm-i386/mmzone.h~	2005-07-01 17:59:22.000000000 -0400
+++ linux-2.6.12/include/asm-i386/mmzone.h	2005-07-01 18:01:44.000000000 -0400
@@ -8,20 +8,15 @@
 
 #include <asm/smp.h>
 
-#if CONFIG_NUMA
+#ifdef CONFIG_NUMA
 extern struct pglist_data *node_data[];
 #define NODE_DATA(nid)	(node_data[nid])
 
-#ifdef CONFIG_NUMA
-	#ifdef CONFIG_X86_NUMAQ
-		#include <asm/numaq.h>
-	#else	/* summit or generic arch */
-		#include <asm/srat.h>
-	#endif
-#else /* !CONFIG_NUMA */
-	#define get_memcfg_numa get_memcfg_numa_flat
-	#define get_zholes_size(n) (0)
-#endif /* CONFIG_NUMA */
+#ifdef CONFIG_X86_NUMAQ
+	#include <asm/numaq.h>
+#else	/* summit or generic arch */
+	#include <asm/srat.h>
+#endif
 
 extern int get_memcfg_numa_flat(void );
 /*
@@ -42,6 +37,9 @@ static inline void get_memcfg_numa(void)
 	get_memcfg_numa_flat();
 }
 
+#else /* !CONFIG_NUMA */
+#define get_memcfg_numa get_memcfg_numa_flat
+#define get_zholes_size(n) (0)
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_DISCONTIGMEM
