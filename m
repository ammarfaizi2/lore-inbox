Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281360AbRLFCB0>; Wed, 5 Dec 2001 21:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284930AbRLFCBH>; Wed, 5 Dec 2001 21:01:07 -0500
Received: from nat.overture.com ([208.50.18.5]:29632 "EHLO
	tiresias.corp.go2.com") by vger.kernel.org with ESMTP
	id <S281360AbRLFCBA>; Wed, 5 Dec 2001 21:01:00 -0500
Message-ID: <3C0ED156.2F327B0F@overture.com>
Date: Wed, 05 Dec 2001 18:00:54 -0800
From: Xeno <xeno@overture.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4: NFS client race causes data loss when appending
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been observing intermittent data loss when appending to files over
NFS due to a race in the NFS client (losing < 4K a couple times a day). 
Just one process appending to each file.  We're using 2.4.9, but it
looks like the race is present in other 2.4 versions.  Happens most
frequently when nfs_file_write calls nfs_revalidate_inode while there
are lots of writebacks pending.  Here's the sequence of events we're
seeing.

1. getattr request goes out to get file size.  Value will be
   stale compared to inode->i_size, since writes are happening.
2. All writebacks for the inode complete.
3. getattr response returns with stale file size value.
4. __nfs_refresh_inode checks writebacks, finds none,
   overwrites inode->i_size.
5. generic_file_write resets file position (O_APPEND) with
   stale file size, overwriting previously written data.

Race is theoretically present in 2.2 as well, but the delay-based
flushing in 2.2 rarely flushes all writes away, so there are usually
requests on the writeback list.  Only became a problem in 2.4 with
more aggressive flushing clearing out all writebacks.

Here's a patch (2.4.16) that works for us, it eliminates the race in the
most common case.  BKL and NFS_REVALIDATING prevent new writes from
coming in while the getattr is happening, so we just need to check for
writebacks before starting the getattr.  Not a perfect solution, there's
still a potential for races with direct calls to nfs_refresh_inode that
bypass nfs_revalidate_inode.  In practice, we're not triggering those
operations with any frequency.

--- linux/fs/nfs/inode.c	Fri Nov  9 14:28:15 2001
+++ linux-nfsappendrace/fs/nfs/inode.c	Wed Dec  5 17:12:28 2001
@@ -868,8 +868,9 @@
 __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 {
 	int		 status = -ESTALE;
 	struct nfs_fattr fattr;
+	int		 writebacks;
 
 	dfprintk(PAGECACHE, "NFS: revalidating (%x/%Ld)\n",
 		inode->i_dev, (long long)NFS_FILEID(inode));
 
@@ -889,8 +890,9 @@
 		}
 	}
 	NFS_FLAGS(inode) |= NFS_INO_REVALIDATING;
 
+	writebacks = nfs_have_writebacks(inode);
 	status = NFS_PROTO(inode)->getattr(inode, &fattr);
 	if (status) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%x/%Ld) getattr failed, error=%d\n",
 			 inode->i_dev, (long long)NFS_FILEID(inode), status);
@@ -900,8 +902,11 @@
 				remove_inode_hash(inode);
 		}
 		goto out;
 	}
+
+	if ( writebacks && nfs_size_to_loff_t(fattr.size) < inode->i_size )
+		fattr.size = (__u64) inode->i_size;
 
 	status = nfs_refresh_inode(inode, &fattr);
 	if (status) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%x/%Ld) refresh failed, error=%d\n",

Please cc on responses, thanks!

Xeno
