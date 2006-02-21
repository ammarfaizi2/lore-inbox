Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWBUXtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWBUXtB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbWBUXtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:49:01 -0500
Received: from gold.veritas.com ([143.127.12.110]:26020 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030222AbWBUXs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:48:59 -0500
X-IronPort-AV: i="4.02,135,1139212800"; 
   d="scan'208"; a="55824217:sNHT32900172"
Date: Tue, 21 Feb 2006 23:49:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>, Brent Casavant <bcasavan@sgi.com>,
       Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs: fix mount mpol nodelist parsing
Message-ID: <Pine.LNX.4.61.0602212341160.5390@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Feb 2006 23:48:59.0370 (UTC) FILETIME=[62A01CA0:01C63741]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been dissatisfied with the mpol_nodelist mount option which was
added to tmpfs earlier in -rc.  Replace it by mpol=policy:nodelist.

And it was broken: a nodelist is a comma-separated list of numbers and
ranges; the mount options are a comma-separated list of token=values.
Whoops, blindly strsep'ing on commas doesn't work so well: since we've
no numeric tokens, and unlikely to add them, use that to distinguish.

Move the mpol= parsing to shmem_parse_mpol under CONFIG_NUMA, reject
all its options as invalid if not NUMA.  /proc shows MPOL_PREFERRED
as "prefer", so use that name for the policy instead of "preferred".

Enforce that mpol=default has no nodelist; that mpol=prefer has one
node only; that mpol=bind has a nodelist; but let mpol=interleave use
node_online_map if no nodelist given.  Describe this in tmpfs.txt.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: Robin Holt <holt@sgi.com>
---

 Documentation/filesystems/tmpfs.txt |   23 +++++-----
 mm/shmem.c                          |   81 ++++++++++++++++++++++++++++++------
 2 files changed, 82 insertions(+), 22 deletions(-)

--- 2.6.16-rc4/Documentation/filesystems/tmpfs.txt	2006-02-18 12:27:18.000000000 +0000
+++ linux/Documentation/filesystems/tmpfs.txt	2006-02-19 19:49:36.000000000 +0000
@@ -79,15 +79,18 @@ that instance in a system with many cpus
 
 
 tmpfs has a mount option to set the NUMA memory allocation policy for
-all files in that instance:
-mpol=interleave		prefers to allocate memory from each node in turn
-mpol=default		prefers to allocate memory from the local node
-mpol=bind		prefers to allocate from mpol_nodelist
-mpol=preferred		prefers to allocate from first node in mpol_nodelist
-
-The following mount option is used in conjunction with mpol=interleave,
-mpol=bind or mpol=preferred:
-mpol_nodelist:	nodelist suitable for parsing with nodelist_parse.
+all files in that instance (if CONFIG_NUMA is enabled) - which can be
+adjusted on the fly via 'mount -o remount ...'
+
+mpol=default             prefers to allocate memory from the local node
+mpol=prefer:Node         prefers to allocate memory from the given Node
+mpol=bind:NodeList       allocates memory only from nodes in NodeList
+mpol=interleave          prefers to allocate from each node in turn
+mpol=interleave:NodeList allocates from each node of NodeList in turn
+
+NodeList format is a comma-separated list of decimal numbers and ranges,
+a range being two hyphen-separated decimal numbers, the smallest and
+largest node numbers in the range.  For example, mpol=bind:0-3,5,7,9-15
 
 
 To specify the initial root directory you can use the following mount
@@ -109,4 +112,4 @@ RAM/SWAP in 10240 inodes and it is only 
 Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
 Updated:
-   Hugh Dickins <hugh@veritas.com>, 13 March 2005
+   Hugh Dickins <hugh@veritas.com>, 19 February 2006
--- 2.6.16-rc4/mm/shmem.c	2006-02-18 12:28:19.000000000 +0000
+++ linux/mm/shmem.c	2006-02-19 19:49:36.000000000 +0000
@@ -45,6 +45,7 @@
 #include <linux/swapops.h>
 #include <linux/mempolicy.h>
 #include <linux/namei.h>
+#include <linux/ctype.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <asm/pgtable.h>
@@ -874,6 +875,51 @@ redirty:
 }
 
 #ifdef CONFIG_NUMA
+static int shmem_parse_mpol(char *value, int *policy, nodemask_t *policy_nodes)
+{
+	char *nodelist = strchr(value, ':');
+	int err = 1;
+
+	if (nodelist) {
+		/* NUL-terminate policy string */
+		*nodelist++ = '\0';
+		if (nodelist_parse(nodelist, *policy_nodes))
+			goto out;
+	}
+	if (!strcmp(value, "default")) {
+		*policy = MPOL_DEFAULT;
+		/* Don't allow a nodelist */
+		if (!nodelist)
+			err = 0;
+	} else if (!strcmp(value, "prefer")) {
+		*policy = MPOL_PREFERRED;
+		/* Insist on a nodelist of one node only */
+		if (nodelist) {
+			char *rest = nodelist;
+			while (isdigit(*rest))
+				rest++;
+			if (!*rest)
+				err = 0;
+		}
+	} else if (!strcmp(value, "bind")) {
+		*policy = MPOL_BIND;
+		/* Insist on a nodelist */
+		if (nodelist)
+			err = 0;
+	} else if (!strcmp(value, "interleave")) {
+		*policy = MPOL_INTERLEAVE;
+		/* Default to nodes online if no nodelist */
+		if (!nodelist)
+			*policy_nodes = node_online_map;
+		err = 0;
+	}
+out:
+	/* Restore string for error message */
+	if (nodelist)
+		*--nodelist = ':';
+	return err;
+}
+
 static struct page *shmem_swapin_async(struct shared_policy *p,
 				       swp_entry_t entry, unsigned long idx)
 {
@@ -926,6 +972,11 @@ shmem_alloc_page(gfp_t gfp, struct shmem
 	return page;
 }
 #else
+static inline int shmem_parse_mpol(char *value, int *policy, nodemask_t *policy_nodes)
+{
+	return 1;
+}
+
 static inline struct page *
 shmem_swapin(struct shmem_inode_info *info,swp_entry_t entry,unsigned long idx)
 {
@@ -1859,7 +1910,23 @@ static int shmem_parse_options(char *opt
 {
 	char *this_char, *value, *rest;
 
-	while ((this_char = strsep(&options, ",")) != NULL) {
+	while (options != NULL) {
+		this_char = options;
+		for (;;) {
+			/*
+			 * NUL-terminate this option: unfortunately,
+			 * mount options form a comma-separated list,
+			 * but mpol's nodelist may also contain commas.
+			 */
+			options = strchr(options, ',');
+			if (options == NULL)
+				break;
+			options++;
+			if (!isdigit(*options)) {
+				options[-1] = '\0';
+				break;
+			}
+		}
 		if (!*this_char)
 			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
@@ -1910,18 +1977,8 @@ static int shmem_parse_options(char *opt
 			if (*rest)
 				goto bad_val;
 		} else if (!strcmp(this_char,"mpol")) {
-			if (!strcmp(value,"default"))
-				*policy = MPOL_DEFAULT;
-			else if (!strcmp(value,"preferred"))
-				*policy = MPOL_PREFERRED;
-			else if (!strcmp(value,"bind"))
-				*policy = MPOL_BIND;
-			else if (!strcmp(value,"interleave"))
-				*policy = MPOL_INTERLEAVE;
-			else
+			if (shmem_parse_mpol(value,policy,policy_nodes))
 				goto bad_val;
-		} else if (!strcmp(this_char,"mpol_nodelist")) {
-			nodelist_parse(value, *policy_nodes);
 		} else {
 			printk(KERN_ERR "tmpfs: Bad mount option %s\n",
 			       this_char);
