Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVKKABj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVKKABj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVKKABj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:01:39 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:65451 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932231AbVKKABi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:01:38 -0500
Message-ID: <4373DF5D.8050106@us.ibm.com>
Date: Thu, 10 Nov 2005 16:01:33 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] Create helper for /proc/slabinfo
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080408060207030700070502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080408060207030700070502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Most of the s_start() function body is just printing out a header for
/proc/slabinfo.  Move it to its own function.

-Matt

--------------080408060207030700070502
Content-Type: text/x-patch;
 name="print_slabinfo_header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="print_slabinfo_header.patch"

In s_start(), if we're at the beginning of printing out /proc/slabinfo, we
print out a header with version info and descriptions of the fields.  This
is indented and takes up a lot of space in an otherwise tiny fuction.

Create a helper, print_slabinfo_header(), that s_start() can call to
print out it's header.  Remove several long lines, and make both functions
more readable.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:43:40.223347016 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:43:42.198046816 -0800
@@ -3378,32 +3378,37 @@ next:
 
 #ifdef CONFIG_PROC_FS
 
-static void *s_start(struct seq_file *m, loff_t *pos)
+static inline void print_slabinfo_header(struct seq_file *m)
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

--------------080408060207030700070502--
