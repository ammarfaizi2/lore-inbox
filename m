Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284139AbSAAVO1>; Tue, 1 Jan 2002 16:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbSAAVOS>; Tue, 1 Jan 2002 16:14:18 -0500
Received: from colorfullife.com ([216.156.138.34]:61192 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S283938AbSAAVOG>;
	Tue, 1 Jan 2002 16:14:06 -0500
Message-ID: <3C32260E.CEADDF59@colorfullife.com>
Date: Tue, 01 Jan 2002 22:11:42 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.1-dj6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] event cleanup, part 2
Content-Type: multipart/mixed;
 boundary="------------6B56625DEE178D03FD623590"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6B56625DEE178D03FD623590
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus merged the first part of my patches that remove
'event' into 2.5.2-pre3.

Attached is the second patch.

patch 1: remove all event users except readdir().
	Merged.

patch 2: replace 'f_version=++event' with 'f_version=0'
	in fs/*.c
	Attached.

patch 3: change the filesystems one by one.
	s/inode->i_version=++event/inode->i_version++/g
	vfat already uses that code for the revalidate
	handling. For readdir() it's impossible until
	step 2 is merged.

patch 4: remove event entirely.

I'm not yet sure if initializing i_version to 0 should be
done in get_empty_inode() or in the fs that use the
readdir optimization.

--
	Manfred
--------------6B56625DEE178D03FD623590
Content-Type: text/plain; charset=us-ascii;
 name="patch-event-VFS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-event-VFS"

diff -u 2.5/fs/block_dev.c build-2.5/fs/block_dev.c
--- 2.5/fs/block_dev.c	Mon Dec 31 13:41:01 2001
+++ build-2.5/fs/block_dev.c	Tue Jan  1 20:15:27 2002
@@ -181,7 +181,6 @@
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_reada = 0;
-			file->f_version = ++event;
 		}
 		retval = offset;
 	}
diff -u 2.5/fs/file_table.c build-2.5/fs/file_table.c
--- 2.5/fs/file_table.c	Sun Sep 30 16:25:45 2001
+++ build-2.5/fs/file_table.c	Mon Dec 31 16:29:29 2001
@@ -43,7 +43,7 @@
 	new_one:
 		memset(f, 0, sizeof(*f));
 		atomic_set(&f->f_count,1);
-		f->f_version = ++event;
+		f->f_version = 0;
 		f->f_uid = current->fsuid;
 		f->f_gid = current->fsgid;
 		list_add(&f->f_list, &anon_list);
diff -u 2.5/fs/read_write.c build-2.5/fs/read_write.c
--- 2.5/fs/read_write.c	Sat Aug 11 16:15:27 2001
+++ build-2.5/fs/read_write.c	Mon Dec 31 16:29:44 2001
@@ -41,7 +41,6 @@
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_reada = 0;
-			file->f_version = ++event;
 		}
 		retval = offset;
 	}
@@ -69,7 +68,6 @@
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_reada = 0;
-			file->f_version = ++event;
 		}
 		retval = offset;
 	}



--------------6B56625DEE178D03FD623590--


