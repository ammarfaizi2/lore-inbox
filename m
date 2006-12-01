Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031608AbWLAQwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031608AbWLAQwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031614AbWLAQwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:52:05 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:34960 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031607AbWLAQwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:52:01 -0500
Date: Fri, 1 Dec 2006 08:52:27 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without
 permanent inode numbers (via idr)
Message-Id: <20061201085227.2463b185.randy.dunlap@oracle.com>
In-Reply-To: <457040C4.1000002@redhat.com>
References: <457040C4.1000002@redhat.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2006 09:48:36 -0500 Jeff Layton wrote:

> This patch is a proof of concept. It works, but still needs a bit of
> polish before it's ready for submission. First, the problems:
> 
> 
> This patch is a first step at correcting these problems. This adds 2 new
> functions, an idr_register and idr_unregister. Filesystems can call
> idr_register at inode creation time, and then at deletion time, we'll
> automatically unregister them.

s/idr_/iunique_/

> This patch also adds a new s_generation counter to the superblock.
> Because i_ino's can be reused so quickly, we don't want NFS getting
> confused when it happens. When iunique_register is called, we'll assign
> the s_generation value to the i_generation, and then increment it to
> help ensure that we get different filehandles.
> 
> There are some things that need to be cleaned up, of course:
> 
> - error handling for the idr calls
> 
> - recheck all the possible places where the inode should be unhashed
> 
> - don't attempt to remove inodes with values <100

Please explain that one.  (May be obvious to some, but not to me.)

> - convert other filesystems
> 
> - remove the static counter from new_inode and (maybe) eliminate iunique
> 
> Comments and suggestions appreciated.


Better to post patches inline (for review) rather than as attachments.

Some (mostly style) comments on the patch:

+	rv = idr_pre_get(&inode->i_sb->s_inode_ids, GFP_KERNEL);
+	if (! rv)
+		return -ENOMEM;

	if (!rv)

+	rv = idr_get_new_above(&inode->i_sb->s_inode_ids, inode,
+		max_reserved+1, (int *) &inode->i_ino);

		max_reserved + 1,

+}
+
+EXPORT_SYMBOL(iunique_register);

No need for the extra blank line after the function closing
brace.  Just put the EXPORT_SYMBOL immediately on the next line.
(in multiple places)

@@ -1681,6 +1688,8 @@ extern void inode_init_once(struct inode
 extern void iput(struct inode *);
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
+extern int iunique_register(struct inode *, int);
+extern void iunique_unregister(struct inode *);
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
 extern void generic_drop_inode(struct inode *inode);

Some of these have a parameter name, some don't.
Having a (meaningful) parameter name is strongly preferred.

---
~Randy
