Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUEWVsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUEWVsb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUEWVsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:48:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:47767 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262954AbUEWVs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:48:26 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [FIX] kernel BUG at fs/locks.c:1723!
Date: Sun, 23 May 2004 23:50:16 +0200
User-Agent: KMail/1.6.2
Cc: Chris Mason <mason@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405232350.16169.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between unshare_files() and the following steal_locks(). As a 
consequence, steal_locks() may steal some additional FL_POSIX locks that 
don't belong to the current thread. This triggers a BUG in 
locks_remove_flock().

In detail, the current thread shares its files struct with other threads. This 
causes unshare_files() to associate the current thread with a copy of its 
files_struct. The copy shares all file objects with the original files 
struct. In the time between unshare_files() and steal_locks(), another thread 
creates a new file and a FL_POSIX lock on it. The current thread gets into 
steal_locks() and takes over all FL_POSIX locks that refer to the previous 
files_struct, including the new lock. We do put_files_struct(original 
files_struct). This causes the file handle to the new file to be closed. We 
get into locks_remove_posix() and miss the lock, because its fl_owner field 
now refers to the new files_struct. Finally we get into locks_remove_flock(), 
and stumble upon the lock.



While looking into this bug report I gathered the following data with a SUSE 
kernel (oops and LKCD dump from Chris):

kernel BUG at fs/locks.c:1736!
invalid operand: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c01844fb>]    Tainted: G  U
EFLAGS: 00010246   (2.6.5-0-testing)
EIP is at locks_remove_flock+0x8b/0x130
eax: f7b89998   ebx: f61df3fc   ecx: f61df354   edx: 00000000
esi: f61df354   edi: f6702b80   ebp: f6179c24   esp: f6179c08
ds: 007b   es: 007b   ss: 0068
Process owcimomd (pid: 1713, threadinfo=f6178000 task=f66d0d60)
Stack: c1e1fdac c1e1fdac f7fe83c0 00000296 f6702b80 f7fe87c0 f61df354 f6179c3c
       c016ce00 f61ddadc f6702b80 00000000 f6703b00 f6179c54 c0168b1f c0000000
       0000026f 00000012 f6703b00 f6179c6c c0124ba7 00000001 f6179e5c f6179d88
Call Trace:
 [<c016ce00>] __fput+0x30/0x120
 [<c0168b1f>] filp_close+0x4f/0x90
 [<c0124ba7>] put_files_struct+0x67/0xc0
 [<c019d285>] load_elf_binary+0x3f5/0x1596
 [<c018a5af>] update_atime+0x9f/0xc0
 [<c01478fd>] __generic_file_aio_read+0x1cd/0x200
 [<c0145060>] file_read_actor+0x0/0xd0
 [<c01784b7>] search_binary_handler+0x97/0x270
 [<c017a072>] do_execve+0x172/0x200
 [<c0105fb2>] sys_execve+0x32/0x70
 [<c0107e21>] sysenter_past_esp+0x52/0x71

Code: 0f 0b c8 06 eb 74 35 c0 eb db b8 00 e0 ff ff 21 e0 8b 10 8b

put_files_struct+0x67 is equivalent to fs/binfmt_elf.c:681 in 2.6.6

current->files == fl->fl_owner
fl->fl_file = 0xf6702b80 (a valid struct file)

current->files =
  max_fds=32
  max_fdset=1024
  next_fd=3



Here's a proposed fix. As a side effect, steal_locks no longer walks the 
global list of locks, but only the locks of all open inodes.

What are the reasons (other than historic ones) for not getting rid of 
fl_owner and using fl_pid instead, by the way? I think that would clean up 
the whole mess with file locks a bit.

Index: linux-2.6.5/fs/locks.c
===================================================================
--- linux-2.6.5.orig/fs/locks.c
+++ linux-2.6.5/fs/locks.c
@@ -1731,6 +1731,9 @@ void locks_remove_flock(struct file *fil
 				lease_modify(before, F_UNLCK);
 				continue;
 			}
+			/* FL_POSIX locks of this process have already been
+			 * removed in filp_close->locks_remove_posix.
+			 */
 			BUG();
  		}
 		before = &fl->fl_next;
@@ -1990,22 +1993,52 @@ int lock_may_write(struct inode *inode, 
 
 EXPORT_SYMBOL(lock_may_write);
 
+static inline void __steal_locks(struct file *file, fl_owner_t from)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct file_lock *fl = inode->i_flock;
+	
+	while (fl) {
+		if (fl->fl_file == file && fl->fl_owner == from)
+			fl->fl_owner = current->files;
+		fl = fl->fl_next;
+	}
+}
+
+/* When getting ready for executing a binary, we make sure that current
+ * has a files_struct on its own. Before dropping the old files_struct,
+ * we take over ownership of all locks for all file descriptors we own.
+ * Note that we may accidentally steal a lock for a file that a sibling
+ * has created since the unshare_files() call.
+ */
 void steal_locks(fl_owner_t from)
 {
-	struct list_head *tmp;
+	struct files_struct *files = current->files;
+	int i, j;
 
-	if (from == current->files)
+	if (from == files)
 		return;
 
 	lock_kernel();
-	list_for_each(tmp, &file_lock_list) {
-		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
-		if (fl->fl_owner == from)
-			fl->fl_owner = current->files;
+	j = 0;
+	for (;;) {
+		unsigned long set;
+		i = j * __NFDBITS;
+		if (i >= files->max_fdset || i >= files->max_fds)
+                        break;
+		set = files->open_fds->fds_bits[j++];
+		while (set) {
+			if (set & 1) {
+				struct file *file = files->fd[i];
+				if (file)
+					__steal_locks(file, from);
+			}
+			i++;
+			set >>= 1;
+		}
 	}
 	unlock_kernel();
 }
-
 EXPORT_SYMBOL(steal_locks);
 
 static int __init filelock_init(void)


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
