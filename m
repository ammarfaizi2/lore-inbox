Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSLOURj>; Sun, 15 Dec 2002 15:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSLOURj>; Sun, 15 Dec 2002 15:17:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:17864 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262469AbSLOURh>;
	Sun, 15 Dec 2002 15:17:37 -0500
Message-ID: <3DFCE535.3417CEDB@digeo.com>
Date: Sun, 15 Dec 2002 12:25:25 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] ext3 deadlock fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2002 20:25:26.0284 (UTC) FILETIME=[1A3A14C0:01C2A478]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My recent fix for the ext3 data=journal umount data loss problem
has a bug.  The filesystem can deadlock if someone runs `mount -o remount'
while the filesystem is under load.  Everything which writes to that
filesystem gets stuck in `D' state.

This is because:

a) ext3_sync_fs() has to wait until a transaction has finished.

b) a transaction cannot finish when someone else holds lock_super().
   Because lock_super() is used in the block allocator.

The patch ensures that ->sync_fs is never run under lock_super().




 Documentation/filesystems/Locking |    2 ++
 fs/buffer.c                       |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- 24/Documentation/filesystems/Locking~sync_fs-fix	Sun Dec 15 11:12:48 2002
+++ 24-akpm/Documentation/filesystems/Locking	Sun Dec 15 11:16:15 2002
@@ -93,6 +93,7 @@ prototypes:
 	void (*delete_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
 	void (*write_super) (struct super_block *);
+	int (*sync_fs) (struct super_block *);
 	int (*statfs) (struct super_block *, struct statfs *);
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*clear_inode) (struct inode *);
@@ -108,6 +109,7 @@ delete_inode:	no	
 clear_inode:	no	
 put_super:	yes	yes	maybe		(see below)
 write_super:	yes	yes	maybe		(see below)
+write_super:	yes	no	maybe		(see below)
 statfs:		yes	no	no
 remount_fs:	yes	yes	maybe		(see below)
 umount_begin:	yes	no	maybe		(see below)
--- 24/fs/buffer.c~sync_fs-fix	Sun Dec 15 11:12:48 2002
+++ 24-akpm/fs/buffer.c	Sun Dec 15 11:13:13 2002
@@ -327,9 +327,9 @@ int fsync_super(struct super_block *sb)
 	lock_super(sb);
 	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
 		sb->s_op->write_super(sb);
+	unlock_super(sb);
 	if (sb->s_op && sb->s_op->sync_fs)
 		sb->s_op->sync_fs(sb);
-	unlock_super(sb);
 	unlock_kernel();
 
 	return sync_buffers(dev, 1);

_
