Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130834AbRDBRLJ>; Mon, 2 Apr 2001 13:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRDBRLA>; Mon, 2 Apr 2001 13:11:00 -0400
Received: from mfo01.iij.ad.jp ([202.232.2.118]:32773 "EHLO mfo01.iij.ad.jp")
	by vger.kernel.org with ESMTP id <S130834AbRDBRKs>;
	Mon, 2 Apr 2001 13:10:48 -0400
From: okuyamak@dd.iij4u.or.jp
Date: Tue, 03 Apr 2001 02:07:56 +0900 (LMT)
Message-Id: <20010403.020756.107318465.okuyamak@dd.iij4u.or.jp>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: nfsd vfs.c does not seems to fsync() with file overwrite, when it
 have to.
X-Mailer: Mew version 1.95b43 on Emacs 20.4 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Neil,

I think I've found bug in nfsd. Here's patch for fixing.
I'd like to explain what's problem and what's changed, after patch.


diff -urN ./linux.orig/fs/nfsd/vfs.c ./linux/fs/nfsd/vfs.c
--- ./linux.orig/fs/nfsd/vfs.c	Tue Mar 13 11:13:28 2001
+++ ./linux/fs/nfsd/vfs.c	Mon Apr  2 22:08:00 2001
@@ -746,15 +746,14 @@
 				current->state = TASK_RUNNING;
 				dprintk("nfsd: write resume %d\n", current->pid);
 			}
+                }
 
-			if (inode->i_state & I_DIRTY) {
-				dprintk("nfsd: write sync %d\n", current->pid);
-				nfsd_sync(&file);
-			}
+                dprintk("nfsd: write sync %d\n", current->pid);
+                nfsd_sync(&file);
 #if 0
-			wake_up(&inode->i_wait);
+                wake_up(&inode->i_wait);
 #endif
-		}
+
 		last_ino = inode->i_ino;
 		last_dev = inode->i_dev;
 	}


OKEY, here's what's being changed and why.

According to RFC, nfs v2 requires write to sync everytime it
required.  nfs v3 have status given, which takes variable of
UNSTABLE, DATASYNC, and FILESYNC. And when it's DATASYNC or
FILESYNC, it also requires write to be synced.

nfs v2 write should be equivalent to FILESYNC of v3.  FILESYNC
requires "ALL" the metadata and "write" requested data to be
syncronously written to storage. DATASYNC requires file related
metadata and "write" requested data to be syncronously written to
storage.

Currently, Linux does not support FILESYNC. Though it does not
report like so. I think this is reasonable. And if so, we need to
make DATASYNC to work properly.


DATASYNC requires to write data to storage even if file system is
being MOUNTED asyncronously. I mean ext2 can be mounted in 'async'
mode, and yet nfsd must prove file to be fsync()-ed.

Because 

L710:	err = file.f_op->write(&file, buf, cnt, &file.f_pos);

does not store dirty pages to storage in case of async, we need to
call fsync() in case if variable stable is non 0.


Whether we should call nfsd_sync() or not, should not depend on
whether    EX_WGATHER(exp)   is true or not. So,  calling nfsd_sync()
should be outside 

       if ( EX_WGATHER(exp) ) {...}

statement.


Also, it should not depend on whether (inode->i_state & I_DIRTY) is
true or not, because   (inode->i_state & I_DIRTY)  is true only when
inode is being changed ( i.e. when append write is being held ),
while we need to sync written data to filesystem even when we only
over wrote already existing data area.

This means we are required to write ALL the dirty pages and dirty
inodes at this point, if    status    is non 0.


On other hand, with these patches, nfsd + any file system with fsync
functionality will work correctly even with

	       export(sync) + mount(async) 

combination. This is quite useful, for nfs v3 allow UNSTABLE write (
which requires only to recieve write data ) and have COMMIT command
to run fsync() at different timing. To make this work in good
performance, mount is needed to be async mount, so that write()
request will not write any data or metadata to storage.


Wishing my explaint didn't confuse you.

best regards,
---- 
Kenichi Okuyama@Tokyo Research Lab. IBM-Japan, Co.

P.S.  I don't really think we should wait for 10msec At point of
Gathered writes. I don't think this will be of any help.
It's because fsync() have locking of it's own.

While someone have already started storing same file as current code
focuses, to storage, it's not that we should wait for specific
timing. Rather, it's at fsync() timing that reqires mutual storing
and waiting. No one should have right of getting into loop of
calling ll_rw_block() inside fsync(), except for the very first one,
who's waiting for block-write, until it finish.

This mutex functionality SHOULD be what is being supported by
fsync() and if not, we shold simply dive into fsync() for another
write. Even if you over wrote to storage, usually it will not ask
you for extra 10msec.
