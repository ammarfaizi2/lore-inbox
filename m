Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVCAGXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVCAGXB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVCAGXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:23:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:2245 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261256AbVCAGWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:22:35 -0500
Date: Mon, 28 Feb 2005 22:21:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, kmannth@us.ibm.com, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, ygoto@us.fujitsu.com, apw@shadowen.org
Subject: Re: [PATCH 3/5] abstract discontigmem setup
Message-Id: <20050228222159.0c21a48e.akpm@osdl.org>
In-Reply-To: <E1D5q2Q-0007eV-00@kernel.beaverton.ibm.com>
References: <E1D5q2Q-0007eV-00@kernel.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> memory_present() is how each arch/subarch will tell sparsemem
>  and discontigmem where all of its memory is.  This is what
>  triggers sparse to go out and create its mappings for the memory,
>  as well as allocate the mem_map[].

There are cross-compilers at http://developer.osdl.org/dev/plm/cross_compile/

This also needs runtime testing on ppc64, does it not?


arch/ppc64/mm/numa.c:63: error: redefinition of `memory_present'
include/linux/mmzone.h:285: error: `memory_present' previously defined here
arch/ppc64/mm/numa.c: In function `memory_present':
arch/ppc64/mm/numa.c:65: error: `start' undeclared (first use in this function)
arch/ppc64/mm/numa.c:65: error: (Each undeclared identifier is reported only once
arch/ppc64/mm/numa.c:65: error: for each function it appears in.)
arch/ppc64/mm/numa.c:66: error: `end' undeclared (first use in this function)
arch/ppc64/mm/numa.c:65: warning: unused variable `start_addr'
arch/ppc64/mm/numa.c:66: warning: unused variable `end_addr'


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/Kconfig   |   10 ++++++++++
 25-akpm/arch/ppc64/mm/numa.c |    6 +++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff -puN arch/ppc64/Kconfig~x86-abstract-discontigmem-setup-ppc64-fix arch/ppc64/Kconfig
--- 25/arch/ppc64/Kconfig~x86-abstract-discontigmem-setup-ppc64-fix	2005-03-01 03:58:15.000000000 -0700
+++ 25-akpm/arch/ppc64/Kconfig	2005-03-01 03:58:15.000000000 -0700
@@ -203,6 +203,16 @@ config DISCONTIGMEM
 	bool "Discontiguous Memory Support"
 	depends on SMP && PPC_PSERIES
 
+config HAVE_MEMORY_PRESENT
+	bool
+	depends on DISCONTIGMEM
+	default y
+
+config NEED_NODE_MEMMAP_SIZE
+	bool
+	depends on DISCONTIGMEM
+	default y
+
 config NUMA
 	bool "NUMA support"
 	depends on DISCONTIGMEM
diff -puN arch/ppc64/mm/numa.c~x86-abstract-discontigmem-setup-ppc64-fix arch/ppc64/mm/numa.c
--- 25/arch/ppc64/mm/numa.c~x86-abstract-discontigmem-setup-ppc64-fix	2005-03-01 03:58:37.000000000 -0700
+++ 25-akpm/arch/ppc64/mm/numa.c	2005-03-01 03:59:15.000000000 -0700
@@ -62,10 +62,10 @@ void memory_present(int nid, unsigned lo
 			     unsigned long end_pfn)
 {
 	unsigned long i;
-	unsigned long start_addr = start << PAGE_SHIFT;
-	unsigned long end_addr = end << PAGE_SHIFT;
+	unsigned long start_addr = start_pfn << PAGE_SHIFT;
+	unsigned long end_addr = end_pfn << PAGE_SHIFT;
 
-	for (i = start ; i < end; i += MEMORY_INCREMENT)
+	for (i = start_addr; i < end_addr; i += MEMORY_INCREMENT)
 		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = nid;
 }
 
_

