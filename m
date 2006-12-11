Return-Path: <linux-kernel-owner+w=401wt.eu-S1762588AbWLKGll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762588AbWLKGll (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 01:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762587AbWLKGll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 01:41:41 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:40875 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762588AbWLKGlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 01:41:40 -0500
Date: Mon, 11 Dec 2006 15:44:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       clameter@engr.sgi.com, apw@shadowen.org, akpm@osdl.org,
       bob.picco@hp.com
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [2/4] generic
 virtual mem_map on sparsemem
Message-Id: <20061211154423.74536db4.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061209221700.6feb2e5d.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160454.33fedd3f.kamezawa.hiroyu@jp.fujitsu.com>
	<20061209120547.GB10380@osiris.ibm.com>
	<20061209221700.6feb2e5d.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 22:17:00 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> I'll renew this in the next week.
> 

Hi, this is a fix patch. Sorry for my carelessness.

I'll post next add-on patch against the next -mm which will be shipped.
What I have now are
- pfn_valid() optimization
- memory hotplug support

then, performance comparison stage will come.

(*)robust memory hot add patch (we are planning) may use this vmem_map for
   avoiding allocating hot-added-memory's mem_map from existing memory.

Thanks,
-Kame

== patch from here ===

Fixes #error condition.

This check's meaning is:
--for 32bits--
4 (struct page's alignment) * PAGES_PER_SECTION % PAGE_SIZE == 0
--for 64bits--
8 (struct page's alignment) * PAGES_PER_SECTION % PAGE_SIZE == 0

Then, vmem_map is aligned per section.

This check may be removed if I (or someone) can write clean patch
for not aligned vmem_map.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: devel-2.6.19/include/linux/mmzone.h
===================================================================
--- devel-2.6.19.orig/include/linux/mmzone.h	2006-12-09 13:46:35.000000000 +0900
+++ devel-2.6.19/include/linux/mmzone.h	2006-12-11 15:22:19.000000000 +0900
@@ -615,7 +615,7 @@
 #define SECTION_NID_SHIFT	2
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-#if (((BITS_PER_LONG/4) * PAGES_PER_SECTION) % PAGE_SIZE) != 0
+#if (((BITS_PER_LONG/8) * PAGES_PER_SECTION) % PAGE_SIZE) != 0
 #error "PAGE_SIZE/SECTION_SIZE relationship is not suitable for vmem_map"
 #endif
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_STATIC


