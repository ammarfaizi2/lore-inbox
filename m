Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVALCAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVALCAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVALCAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:00:46 -0500
Received: from colin2.muc.de ([193.149.48.15]:64782 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263001AbVALCA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:00:27 -0500
Date: 12 Jan 2005 03:00:23 +0100
Date: Wed, 12 Jan 2005 03:00:23 +0100
From: Andi Kleen <ak@muc.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: node_online_map patch kills x86_64
Message-ID: <20050112020023.GB74675@muc.de>
References: <20050111151656.A24171@build.pdx.osdl.net> <m1d5wb4jni.fsf@muc.de> <20050111163025.T469@build.pdx.osdl.net> <20050112013805.GA74675@muc.de> <20050111175313.E24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111175313.E24171@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SRAT: PXM 0 -> APIC 0 -> Node 1
> SRAT: PXM 1 -> APIC 1 -> Node 2
> SRAT: Node 1 PXM 0 0-9ffff
> SRAT: Node 1 PXM 0 0-3fffffff
> SRAT: Node 2 PXM 1 40000000-7fffffff
> Bootmem setup node 1 0000000000000000-000000003fffffff
> Bootmem setup node 2 0000000040000000-000000007ff5ffff
> No mptable found.
> PANIC: early exception rip ffffffff8078b2e3 error 0 cr2 17c497a67

Can you please test if this patch fixes the problem? 

Thanks, 
-Andi


Fix SRAT NUMA parsing

Fix fallout from the recent nodemask_t changes. The node ids assigned 
in the SRAT parser were off by one.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/mm/srat.c
===================================================================
--- linux.orig/arch/x86_64/mm/srat.c	2005-01-09 18:19:17.%N +0100
+++ linux/arch/x86_64/mm/srat.c	2005-01-12 02:43:54.%N +0100
@@ -29,8 +29,8 @@
 	if (pxm2node[pxm] == 0xff) {
 		if (num_online_nodes() >= MAX_NUMNODES)
 			return -1;
-		pxm2node[pxm] = num_online_nodes();
-		node_set_online(num_online_nodes());
+		pxm2node[pxm] = num_online_nodes() - 1;
+		node_set_online(pxm2node[pxm]);
 	}
 	return pxm2node[pxm];
 }
