Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTJUXW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 19:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTJUXV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 19:21:59 -0400
Received: from [65.172.181.6] ([65.172.181.6]:31872 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263172AbTJUXVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 19:21:09 -0400
Date: Tue, 21 Oct 2003 16:20:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: (4/4) [PATCH] cpuset -- seqfile change
Message-Id: <20031021162034.7665533b.shemminger@osdl.org>
In-Reply-To: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Printing the header in seq_start is not the way other callers to
seq_file interface do it, and it seems like it might be a problem
with seeking and other possibilities.

diff -Nru a/kernel/cpuset.c b/kernel/cpuset.c
--- a/kernel/cpuset.c	Tue Oct 21 15:53:11 2003
+++ b/kernel/cpuset.c	Tue Oct 21 15:53:11 2003
@@ -661,29 +661,33 @@
  */
 #ifdef CONFIG_CPUSETS_PROC
 
+static struct cpuset *proc_cpusets_idx(loff_t n)
+{
+	struct cpuset *set;
+	
+	list_for_each_entry(set, &top_cpuset, list) {
+		if (n-- == 0)
+			return set;
+	}
+	return NULL;
+}
+
 static void *proc_cpusets_start(struct seq_file *m, loff_t *pos)
 {
-        loff_t n = *pos;
-        struct list_head *p;
 
 	read_lock(&cpuset_lock); 
-        if (!n) seq_puts(m, "cpusets info \n");
-        
-	p = &top_cpuset.list;
-        while (n--) {
-                p = p->next;
-                if (p == &top_cpuset.list)
-                        return NULL;
-        }
-        return list_entry(p, struct cpuset, list);
+	return (*pos == 0) ? SEQ_START_TOKEN : proc_cpusets_idx(*pos);
 }
 
 static void *proc_cpusets_next(struct seq_file *m, void *p, loff_t *pos)
 {
-        struct cpuset * cs = p;
+        struct cpuset * cs;
         ++*pos;
-        return cs->list.next == &top_cpuset.list ? NULL
-                : list_entry(cs->list.next, struct cpuset, list);
+
+	cs = (p == SEQ_START_TOKEN) ? top_cpuset.list.next
+		: ((struct cpuset *)p)->list.next;
+
+	return (cs == &top_cpuset.list) ? NULL : cs;
 }
 
 /* How many chars needed to print a long (as a mask) ? */
@@ -713,25 +717,28 @@
 #else
 	char maskbuf[CFL + 1];
 #endif
+	if (p == SEQ_START_TOKEN) 
+		seq_puts(m, "cpusets info \n");
+	else {
+		seq_printf(m, "cpuset %d {\n"
+			   "\tparent = %d\n"
+			   "\tflags = %d\n"
+			   "\tcount = %d\n"
+			   "\thba = %d\n"
+			   "\tuid & suid = %d & %d\n",
+			   cs->id, cs->parent ? cs->parent->id : -1, 
+			   cs->flags, atomic_read(&cs->count), cs->has_been_attached,
+			   cs->uid, cs->suid);
+
+		sprint_mask(maskbuf, cs->cpus_allowed);
+		seq_printf(m,"\tcpus_allowed = %s\n", maskbuf);
+		sprint_mask(maskbuf, cs->cpus_reserved);
+		seq_printf(m,"\tcpus_reserved = %s\n", maskbuf);
+		sprint_mask(maskbuf, cs->cpus_strictly_reserved);
+		seq_printf(m,"\tcpus_strictly_reserved = %s\n", maskbuf);
 
-	seq_printf(m, "cpuset %d {\n"
-		"\tparent = %d\n"
-		"\tflags = %d\n"
-		"\tcount = %d\n"
-		"\thba = %d\n"
-		"\tuid & suid = %d & %d\n",
-		cs->id, cs->parent ? cs->parent->id : -1, 
-		cs->flags, atomic_read(&cs->count), cs->has_been_attached,
-		cs->uid, cs->suid);
-
-	sprint_mask(maskbuf, cs->cpus_allowed);
-	seq_printf(m,"\tcpus_allowed = %s\n", maskbuf);
-	sprint_mask(maskbuf, cs->cpus_reserved);
-	seq_printf(m,"\tcpus_reserved = %s\n", maskbuf);
-	sprint_mask(maskbuf, cs->cpus_strictly_reserved);
-	seq_printf(m,"\tcpus_strictly_reserved = %s\n", maskbuf);
-
-	seq_printf(m, "}\n\n");
+		seq_printf(m, "}\n\n");
+	}
 
 	return 0;
 }
