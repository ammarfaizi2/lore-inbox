Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUFJXHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUFJXHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 19:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUFJXHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 19:07:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:9177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263227AbUFJXHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 19:07:43 -0400
Date: Thu, 10 Jun 2004 16:10:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: michael@metaparadigm.com, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [STACK] >3k call path in ide
Message-Id: <20040610161021.7997ad9d.akpm@osdl.org>
In-Reply-To: <20040610225938.GF3340@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>
	<40C72B68.1030404@metaparadigm.com>
	<20040609162949.GC29531@wohnheim.fh-wedel.de>
	<20040609122721.0695cf96.akpm@osdl.org>
	<20040610225938.GF3340@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
> read_page_state doesn't exist in 2.6.7-rc3 or 2.6.6-mm5.  How is it
> defined?

It was in 2.6.7-rc3-mm1.



struct page_state is large (148 bytes) and we put them on the stack in awkward
code paths (page reclaim...)

So implement a simple read_page_state() which can be used to pluck out a
single member from the all-cpus page_state accumulators.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/page-flags.h |    4 ++++
 25-akpm/mm/page_alloc.c            |   17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff -puN include/linux/page-flags.h~read_page_state include/linux/page-flags.h
--- 25/include/linux/page-flags.h~read_page_state	Wed Jun  9 17:06:33 2004
+++ 25-akpm/include/linux/page-flags.h	Wed Jun  9 17:06:33 2004
@@ -139,6 +139,10 @@ DECLARE_PER_CPU(struct page_state, page_
 
 extern void get_page_state(struct page_state *ret);
 extern void get_full_page_state(struct page_state *ret);
+extern unsigned long __read_page_state(unsigned offset);
+
+#define read_page_state(member) \
+	__read_page_state(offsetof(struct page_state, member))
 
 #define mod_page_state(member, delta)					\
 	do {								\
diff -puN mm/page_alloc.c~read_page_state mm/page_alloc.c
--- 25/mm/page_alloc.c~read_page_state	Wed Jun  9 17:06:33 2004
+++ 25-akpm/mm/page_alloc.c	Wed Jun  9 17:11:57 2004
@@ -947,6 +947,23 @@ void get_full_page_state(struct page_sta
 	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long));
 }
 
+unsigned long __read_page_state(unsigned offset)
+{
+	unsigned long ret = 0;
+	int cpu;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		unsigned long in;
+
+		if (!cpu_possible(cpu))
+			continue;
+
+		in = (unsigned long)&per_cpu(page_states, cpu) + offset;
+		ret += *((unsigned long *)in);
+	}
+	return ret;
+}
+
 void get_zone_counts(unsigned long *active,
 		unsigned long *inactive, unsigned long *free)
 {
_

