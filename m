Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVH2RyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVH2RyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVH2RyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:54:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:51871 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751182AbVH2RyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:54:01 -0400
Date: Mon, 29 Aug 2005 19:53:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, holzheu@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 2/10] s390: debug feature changes.
Message-ID: <20050829175356.GB6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/10] s390: debug feature changes.

From: Michael Holzheu <holzheu@de.ibm.com>

debug feature changes/bug fixes:
 - Use get_clock() function instead of private inline assembly.
 - Use 'struct timeval' instead of 'struct timespec' for call
   to tod_to_timeval(). Now the microsecond part of the timestamp
   is correct again.
 - Fix a locking problem: when creating a snapshot of the current
   content of the debug areas, lock the entire debug_info object.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/debug.c |   52 ++++++++++++++++++++++++++++-------------------
 include/asm-s390/debug.h |    2 -
 2 files changed, 32 insertions(+), 22 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/debug.c linux-2.6-patched/arch/s390/kernel/debug.c
--- linux-2.6/arch/s390/kernel/debug.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/debug.c	2005-08-29 19:18:06.000000000 +0200
@@ -62,7 +62,7 @@ typedef struct
 } debug_sprintf_entry_t;
 
 
-extern void tod_to_timeval(uint64_t todval, struct timeval *xtime);
+extern void tod_to_timeval(uint64_t todval, struct timespec *xtime);
 
 /* internal function prototyes */
 
@@ -374,9 +374,24 @@ debug_info_copy(debug_info_t* in, int mo
 {
         int i,j;
         debug_info_t* rc;
+        unsigned long flags;
+
+	/* get a consistent copy of the debug areas */
+	do {
+		rc = debug_info_alloc(in->name, in->pages_per_area,
+			in->nr_areas, in->buf_size, in->level, mode);
+		spin_lock_irqsave(&in->lock, flags);
+		if(!rc)
+			goto out;
+		/* has something changed in the meantime ? */
+		if((rc->pages_per_area == in->pages_per_area) &&
+		   (rc->nr_areas == in->nr_areas)) {
+			break;
+		}
+		spin_unlock_irqrestore(&in->lock, flags);
+		debug_info_free(rc);
+	} while (1);
 
-        rc = debug_info_alloc(in->name, in->pages_per_area, in->nr_areas,
-				in->buf_size, in->level, mode);
         if(!rc || (mode == NO_AREAS))
                 goto out;
 
@@ -386,6 +401,7 @@ debug_info_copy(debug_info_t* in, int mo
 		}
         }
 out:
+        spin_unlock_irqrestore(&in->lock, flags);
         return rc;
 }
 
@@ -593,19 +609,15 @@ debug_open(struct inode *inode, struct f
 	debug_info_t *debug_info, *debug_info_snapshot;
 
 	down(&debug_lock);
-
-	/* find debug log and view */
-	debug_info = debug_area_first;
-	while(debug_info != NULL){
-		for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
-			if (!debug_info->views[i])
-				continue;
-			else if (debug_info->debugfs_entries[i] ==
-				 file->f_dentry) {
-				goto found;	/* found view ! */
-			}
+	debug_info = (struct debug_info*)file->f_dentry->d_inode->u.generic_ip;
+	/* find debug view */
+	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
+		if (!debug_info->views[i])
+			continue;
+		else if (debug_info->debugfs_entries[i] ==
+			 file->f_dentry) {
+			goto found;	/* found view ! */
 		}
-		debug_info = debug_info->next;
 	}
 	/* no entry found */
 	rc = -EINVAL;
@@ -833,7 +845,7 @@ extern inline void
 debug_finish_entry(debug_info_t * id, debug_entry_t* active, int level,
 			int exception)
 {
-	STCK(active->id.stck);
+	active->id.stck = get_clock();
 	active->id.fields.cpuid = smp_processor_id();
 	active->caller = __builtin_return_address(0);
 	active->id.fields.exception = exception;
@@ -1078,7 +1090,7 @@ debug_register_view(debug_info_t * id, s
 	if (view->input_proc)
 		mode |= S_IWUSR;
 	pde = debugfs_create_file(view->name, mode, id->debugfs_root_entry,
-				NULL, &debug_file_ops);
+				id , &debug_file_ops);
 	if (!pde){
 		printk(KERN_WARNING "debug: debugfs_create_file() failed!"\
 			" Cannot register view %s/%s\n", id->name,view->name);
@@ -1432,7 +1444,7 @@ int
 debug_dflt_header_fn(debug_info_t * id, struct debug_view *view,
 			 int area, debug_entry_t * entry, char *out_buf)
 {
-	struct timeval time_val;
+	struct timespec time_spec;
 	unsigned long long time;
 	char *except_str;
 	unsigned long caller;
@@ -1443,7 +1455,7 @@ debug_dflt_header_fn(debug_info_t * id, 
 	time = entry->id.stck;
 	/* adjust todclock to 1970 */
 	time -= 0x8126d60e46000000LL - (0x3c26700LL * 1000000 * 4096);
-	tod_to_timeval(time, &time_val);
+	tod_to_timeval(time, &time_spec);
 
 	if (entry->id.fields.exception)
 		except_str = "*";
@@ -1451,7 +1463,7 @@ debug_dflt_header_fn(debug_info_t * id, 
 		except_str = "-";
 	caller = ((unsigned long) entry->caller) & PSW_ADDR_INSN;
 	rc += sprintf(out_buf, "%02i %011lu:%06lu %1u %1s %02i %p  ",
-		      area, time_val.tv_sec, time_val.tv_usec, level,
+		      area, time_spec.tv_sec, time_spec.tv_nsec / 1000, level,
 		      except_str, entry->id.fields.cpuid, (void *) caller);
 	return rc;
 }
diff -urpN linux-2.6/include/asm-s390/debug.h linux-2.6-patched/include/asm-s390/debug.h
--- linux-2.6/include/asm-s390/debug.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/debug.h	2005-08-29 19:18:06.000000000 +0200
@@ -52,8 +52,6 @@ struct __debug_entry{
 #define DEBUG_DATA(entry) (char*)(entry + 1) /* data is stored behind */
                                              /* the entry information */
 
-#define STCK(x)	asm volatile ("STCK 0(%1)" : "=m" (x) : "a" (&(x)) : "cc")
-
 typedef struct __debug_entry debug_entry_t;
 
 struct debug_view;
