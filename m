Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWIVD1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWIVD1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 23:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWIVD1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 23:27:46 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14039 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932223AbWIVD1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 23:27:45 -0400
Date: Fri, 22 Sep 2006 12:30:45 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kmannth@us.ibm.com, linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
 kernel BUG at mm/slab.c:2698!
Message-Id: <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060921200806.523ce0b2.akpm@osdl.org>
References: <1158884252.5657.38.camel@keithlap>
	<20060921174134.4e0d30f2.akpm@osdl.org>
	<1158888843.5657.44.camel@keithlap>
	<20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
	<20060921200806.523ce0b2.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 20:08:06 -0700
Andrew Morton <akpm@osdl.org> wrote:

> But why did the kmalloc() fail?
> 
> 
from this:

==
#define NOTIFY_DONE             0x0000          /* Don't care */
#define NOTIFY_OK               0x0001          /* Suits me */
#define NOTIFY_STOP_MASK        0x8000          /* Don't call further */
#define NOTIFY_BAD              (NOTIFY_STOP_MASK|0x0002)
==

I gues someone returns NOTIFY_BAD before pageset_cpuup_callback() is called.
When CPU_UP_CANCELED comes, pageset_cpuup_callback() can't know zone_pcp()
is kmalloced or not. Is this ugly ?

-Kame

Before kfree(), we should check zone_pcp() is not boot_pageset[].

Signed-Off-By KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.18/mm/page_alloc.c
===================================================================
--- linux-2.6.18.orig/mm/page_alloc.c	2006-09-20 12:42:06.000000000 +0900
+++ linux-2.6.18/mm/page_alloc.c	2006-09-22 12:22:03.000000000 +0900
@@ -1844,9 +1844,11 @@
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
-
-		zone_pcp(zone, cpu) = NULL;
-		kfree(pset);
+		/* When canceled, zone_pcp still points to boot_pageset[] */
+		if (zone_pcp(zone, cpu) != &boot_pageset[cpu]) {
+			zone_pcp(zone, cpu) = NULL;
+			kfree(pset);
+		}
 	}
 }
 

