Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266779AbUFRULV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266779AbUFRULV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUFRUKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:10:11 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:15456 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266779AbUFRUDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:03:14 -0400
Date: Fri, 18 Jun 2004 15:03:00 -0500
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: rusty@rustcorp.com.au, ak@suse.de
Subject: [PATCH] Add kallsyms_lookup() result cache
Message-ID: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6 based systems, the top command utilizes /proc/[pid]/wchan to
determine WCHAN symbol name information.  This information is provided
by the kernel function kallsyms_lookup(), which expands a stem-compressed
list of kernel symbols in order to provide a symbol name.  The decompression
is relatively slow, performing a lot of throw-away work in the form of
strncpy() invocations whose results are overwritten immediately.  On systems
with many processes, this results in the kernel consuming a large amount of
time on top's behalf performing the decompression.  For example, on a
large SGI Altix system with 4500 current tasks, there is approximately
8 seconds worth of work to be done with each top screen update.

The following patch adds a result cache to kallsyms_lookup(), cacheing
previously decompressed symbol names and using them on subsequent
kallsyms_lookup() calls.  With this change, top with a 1 second update
now consumes only about 60% of a CPU on the previously mentioned sytem,
as opposed to the prior 800%.  A trivial test program which repeatedly
opens/reads/closes /proc/1/wchan improves from 160 iterations per second
to 30000.

The cache size of 32 items was chosen experimentally.  16 was too few
to cache all the results on even a small system with approximatley 100
tasks, and 64 was too large for all but the most extreme cases.  Cacheing
was chosen instead of improving the expansion algorithm due to the large
number of strlen() invocations which would have been necessary with that
solution.

Further work obviously needs to be done for top itself to reduce CPU
utilization even further, but this is a large first step.  Some quick
experiments indicate that the slow path has now moved to other areas
of code, which will be addressed in due course.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

--- linux.orig/kernel/kallsyms.c	2004-03-16 14:13:30.000000000 -0600
+++ linux/kernel/kallsyms.c	2004-06-18 14:28:17.000000000 -0500
@@ -56,6 +56,16 @@
 	return module_kallsyms_lookup_name(name);
 }

+/* Cache of uncompressed symbol names from kallsyms_lookup() */
+#define NAMECACHE_SIZE 32
+static int namecache_index;
+static struct {
+	unsigned long addr;
+	unsigned long nextsym;
+	char name[127];
+} namecache[NAMECACHE_SIZE];
+static rwlock_t namecache_lock;
+
 /* Lookup an address.  modname is set to NULL if it's in the kernel. */
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
@@ -74,6 +84,22 @@
 		unsigned long symbol_end;
 		char *name = kallsyms_names;

+		/* Search for a cached response */
+		read_lock(&namecache_lock);
+		for (i = 0; i < NAMECACHE_SIZE; i++) {
+			if (namecache[i].addr &&
+			    namecache[i].addr <= addr &&
+			    addr < namecache[i].nextsym) {
+				strncpy(namebuf, namecache[i].name, 127);
+				*symbolsize = namecache[i].nextsym - namecache[i].addr;
+				*modname = NULL;
+				*offset = addr - namecache[i].addr;
+				read_unlock(&namecache_lock);
+				return namebuf;
+			}
+		}
+		read_unlock(&namecache_lock);
+
 		/* They're sorted, we could be clever here, but who cares? */
 		for (i = 0; i < kallsyms_num_syms; i++) {
 			if (kallsyms_addresses[i] > kallsyms_addresses[best] &&
@@ -99,6 +125,15 @@
 		*symbolsize = symbol_end - kallsyms_addresses[best];
 		*modname = NULL;
 		*offset = addr - kallsyms_addresses[best];
+
+		/* Cache the results */
+		write_lock(&namecache_lock);
+		namecache[namecache_index].addr = kallsyms_addresses[best];
+		namecache[namecache_index].nextsym = symbol_end;
+		strncpy(namecache[namecache_index].name, namebuf, 127);
+		namecache_index = (namecache_index + 1) % NAMECACHE_SIZE;
+		write_unlock(&namecache_lock);
+
 		return namebuf;
 	}


-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
