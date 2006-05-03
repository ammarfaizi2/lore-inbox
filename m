Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWECQo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWECQo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWECQo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:44:26 -0400
Received: from 81-178-109-203.dsl.pipex.com ([81.178.109.203]:10943 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030240AbWECQo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:44:26 -0400
Date: Wed, 3 May 2006 17:44:14 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] root mount failure emit filesystems attempted
Message-ID: <20060503164414.GA2456@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root mount failure emit filesystems attempted

When we fail to mount from a valid root device list out the filesystems
we have tried to mount it with.  This gives the user vital diagnostics
as to what is missing from their kernel.

For example in the fragment below the kernel does not have CRAMFS
compiled into the kernel and yet appears to recognise it at the RAMDISK
detect stage.  Later the mount fails as we don't have the filesystem.

  RAMDISK: cramfs filesystem found at block 0
  RAMDISK: Loading 1604KiB [1 disk] into ram disk... done.
  XFS: bad magic number
  XFS: SB validate failed
  No filesystem could mount root, tried: reiserfs ext3 ext2 msdos vfat
    iso9660 jfs xfs
  Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,1)
  
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 do_mounts.c |    5 +++++
 1 files changed, 5 insertions(+)
diff -upN reference/init/do_mounts.c current/init/do_mounts.c
--- reference/init/do_mounts.c
+++ current/init/do_mounts.c
@@ -310,6 +310,11 @@ retry:
 
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
+
+	printk("No filesystem could mount root, tried: ");
+	for (p = fs_names; *p; p += strlen(p)+1)
+		printk(" %s", p);
+	printk("\n");
 	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
 out:
 	putname(fs_names);
