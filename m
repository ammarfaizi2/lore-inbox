Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVKUN15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKUN15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVKUN15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:27:57 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:56740 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750738AbVKUN14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:27:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=cvntec/dt/vgcPKXSCaGL3GBi+oTuwJaiadtrsXZNrZNgxCh7O2lQAigMh7EgyoTXRoc6b3KNHq9aQRbNpnMriLdKumtfnV6WGMgXRymDdKKPGep9Js6hAwp5jZucg2I/buRWZri0qgL9Inbh63G+FBbubbnmGiD9lHNM1+w2Mo=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124323.14370.21159.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 10/12] mm: page_state fixes
Date: Mon, 21 Nov 2005 08:27:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

read_page_state and __get_page_state only traverse online CPUs, which will
cause results to fluctuate when CPUs are plugged in or out.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -1140,12 +1140,11 @@ EXPORT_SYMBOL(nr_pagecache);
 DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
 #endif
 
-void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
+static void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
 {
 	int cpu = 0;
 
 	memset(ret, 0, sizeof(*ret));
-	cpus_and(*cpumask, *cpumask, cpu_online_map);
 
 	cpu = first_cpu(*cpumask);
 	while (cpu < NR_CPUS) {
@@ -1198,7 +1197,7 @@ unsigned long read_page_state_offset(uns
 	unsigned long ret = 0;
 	int cpu;
 
-	for_each_online_cpu(cpu) {
+	for_each_cpu(cpu) {
 		unsigned long in;
 
 		in = (unsigned long)&per_cpu(page_states, cpu) + offset;
Send instant messages to your online friends http://au.messenger.yahoo.com 
