Return-Path: <linux-kernel-owner+w=401wt.eu-S1753026AbWLORwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbWLORwW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbWLORwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:52:21 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:55482 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026AbWLORwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:52:21 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] struct vfsmount : keep mnt_count & mnt_expiry_mark away from mnt_flags
Date: Fri, 15 Dec 2006 18:51:58 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612150823.kBF8NV2u011171@shell0.pdx.osdl.net> <20061215083112.GB10687@elte.hu> <20061215081138.4c51e7c5.akpm@osdl.org>
In-Reply-To: <20061215081138.4c51e7c5.akpm@osdl.org>
MIME-Version: 1.0
Message-Id: <200612151851.58741.dada1@cosmosbay.com>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+CugFmiIRjUXkKj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_+CugFmiIRjUXkKj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I noticed cache misses in touch_atime() that can be avoided if we keep 
mnt_count & mnt_expiry_mark in a different cache line than mnt_flags (mostly 
read)

mnt_count & mnt_expiry_mark are modified each time a file is opened/closed in 
a file system.

touch_atime() is called each time a file is read, and generally needs to read 
mnt_flags.

Other fields of struct vfsmount are mostly read so I chose to move mnt_count & 
mnt_expiry_mark at the end of struct vfsmount. And adding a comment so that 
nobody tries to re-arrange fields to fill the holes :)

On 64bits platforms, the new offsetof(mnt_count) is 0xC0
On 32bits platforms, it is 0x60, so I didnot add a 
____cacheline_aligned_in_smp because it would have a too big impact on the 
size of this object (in particular if CONFIG_X86_L1_CACHE_SHIFT=7)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--Boundary-00=_+CugFmiIRjUXkKj
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vfsmount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vfsmount.patch"

--- linux-2.6.20-rc1-mm1/include/linux/mount.h	2006-12-14 02:14:23.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/include/linux/mount.h	2006-12-15 19:30:54.000000000 +0100
@@ -43,9 +43,8 @@ struct vfsmount {
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
-	atomic_t mnt_count;
 	int mnt_flags;
-	int mnt_expiry_mark;		/* true if marked for expiry */
+	/* 4 bytes hole on 64bits arches */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
@@ -54,6 +53,13 @@ struct vfsmount {
 	struct list_head mnt_slave;	/* slave list entry */
 	struct vfsmount *mnt_master;	/* slave is on master->mnt_slave_list */
 	struct mnt_namespace *mnt_ns;	/* containing namespace */
+	/*
+	 * We put mnt_count & mnt_expiry_mark at the end of struct vfsmount
+	 * to let these frequently modified fields in a separate cache line
+	 * (so that reads of mnt_flags wont ping-pong on SMP machines)
+	 */
+	atomic_t mnt_count;
+	int mnt_expiry_mark;		/* true if marked for expiry */
 	int mnt_pinned;
 };
 

--Boundary-00=_+CugFmiIRjUXkKj--
