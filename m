Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVGAXcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVGAXcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVGAXcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:32:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261632AbVGAXb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:31:56 -0400
Date: Fri, 1 Jul 2005 19:31:55 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix up non-NUMA breakage in mmzone.h
Message-ID: <20050701233155.GC10534@redhat.com>
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
 > I was wondering why the rawhide gcc (4.0.0 20050622 (Red Hat 4.0.0-13))
 > blew up whilst trying to compile -rc3 and newer, with this informative
 > error..
 > 
 > include/asm/mmzone.h:154: error: syntax error before numeric constant

If CONFIG_NUMA isn't set, we use the define in <linux/mmzone.h>
for early_pfn_to_nid (which defines it to 0).

Because of this, the prototype needs to move inside the CONFIG_NUMA
too, or anal gcc's get really confused.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/include/asm-i386/mmzone.h~	2005-07-01 18:30:14.000000000 -0400
+++ linux-2.6.12/include/asm-i386/mmzone.h	2005-07-01 18:30:30.000000000 -0400
@@ -37,6 +37,8 @@ static inline void get_memcfg_numa(void)
 	get_memcfg_numa_flat();
 }
 
+extern int early_pfn_to_nid(unsigned long pfn);
+
 #else /* !CONFIG_NUMA */
 #define get_memcfg_numa get_memcfg_numa_flat
 #define get_zholes_size(n) (0)
@@ -149,6 +151,4 @@ static inline int pfn_valid(int pfn)
 
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
 
-extern int early_pfn_to_nid(unsigned long pfn);
-
 #endif /* _ASM_MMZONE_H_ */
