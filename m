Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVKSMUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVKSMUc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVKSMUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:20:32 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:15811 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751287AbVKSMUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:20:31 -0500
Subject: Re: [PATCH 3/5] slab: extract slabinfo header printing to separate
	function
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
In-Reply-To: <437F165F.80203@colorfullife.com>
References: <iq5uuc.zmsv6.a6p8qowodnwx9kaa8jonhv8n3.beaver@cs.helsinki.fi>
	 <437F165F.80203@colorfullife.com>
Date: Sat, 19 Nov 2005 14:20:29 +0200
Message-Id: <1132402829.17963.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-19 at 13:11 +0100, Manfred Spraul wrote:
> Why inline? I try to avoid adding inline wherever possible. inline is 
> actually always_inline force_inline 

Agreed.

[PATCH] slab: extract slabinfo header printing to separate function

This patch extracts slabinfo header printing to a separate function
print_slabinfo_header() to make s_start() more readable.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c |   45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -3369,32 +3369,37 @@ next:
 
 #ifdef CONFIG_PROC_FS
 
-static void *s_start(struct seq_file *m, loff_t *pos)
+static void print_slabinfo_header(struct seq_file *m)
 {
-	loff_t n = *pos;
-	struct list_head *p;
-
-	down(&cache_chain_sem);
-	if (!n) {
-		/*
-		 * Output format version, so at least we can change it
-		 * without _too_ many complaints.
-		 */
+	/*
+	 * Output format version, so at least we can change it
+	 * without _too_ many complaints.
+	 */
 #if STATS
-		seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
+	seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
 #else
-		seq_puts(m, "slabinfo - version: 2.1\n");
+	seq_puts(m, "slabinfo - version: 2.1\n");
 #endif
-		seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
-		seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
-		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
+	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> "
+		 "<objperslab> <pagesperslab>");
+	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
+	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
-		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped>"
-				" <error> <maxfreeable> <nodeallocs> <remotefrees>");
-		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
+	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> "
+		 "<error> <maxfreeable> <nodeallocs> <remotefrees>");
+	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
-		seq_putc(m, '\n');
-	}
+	seq_putc(m, '\n');
+}
+
+static void *s_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t n = *pos;
+	struct list_head *p;
+
+	down(&cache_chain_sem);
+	if (!n)
+		print_slabinfo_header(m);
 	p = cache_chain.next;
 	while (n--) {
 		p = p->next;


