Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129095AbQKDSOV>; Sat, 4 Nov 2000 13:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbQKDSOL>; Sat, 4 Nov 2000 13:14:11 -0500
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:64200 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S129095AbQKDSN6>; Sat, 4 Nov 2000 13:13:58 -0500
Message-ID: <3A045234.8395F94@pp.inet.fi>
Date: Sat, 04 Nov 2000 20:15:16 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Patch for O_SYNC/ENOSPC bug (on Ted's TODO list)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch (against 2.4.0-test10) fixes the O_SYNC/ENOSPC bug. Alan Cox
included a fix for this same bug in 2.2.18pre7 and David Weinehall in
2.0.39final. This bug is listed on Ted's "Linux 2.4 Status / TODO page" as
"Fix Exists But Isnt Merged", "Writing past end of removeable device can
cause data corruption bugs in the future".

More information and source code for small test program here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=96879269024716&w=2

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

--- linux-2.4.0-test10/fs/block_dev.c	Wed Oct  4 01:03:11 2000
+++ linux/fs/block_dev.c	Sat Nov  4 17:14:19 2000
@@ -30,7 +30,7 @@
 	ssize_t block, blocks;
 	loff_t offset;
 	ssize_t chars;
-	ssize_t written;
+	ssize_t written, retval;
 	struct buffer_head * bhlist[NBUF];
 	size_t size;
 	kdev_t dev = inode->i_rdev;
@@ -40,7 +40,7 @@
 	if (is_read_only(dev))
 		return -EPERM;
 
-	written = write_error = buffercount = 0;
+	retval = written = write_error = buffercount = 0;
 	blocksize = BLOCK_SIZE;
 	if (blksize_size[MAJOR(dev)] && blksize_size[MAJOR(dev)][MINOR(dev)])
 		blocksize = blksize_size[MAJOR(dev)][MINOR(dev)];
@@ -60,8 +60,10 @@
 	else
 		size = INT_MAX;
 	while (count>0) {
-		if (block >= size)
-			return written ? written : -ENOSPC;
+		if (block >= size) {
+			retval = -ENOSPC;
+			goto cleanup;
+		}
 		chars = blocksize - offset;
 		if (chars > count)
 			chars=count;
@@ -73,15 +75,19 @@
 			if (chars != blocksize)
 				fn = bread;
 			bh = fn(dev, block, blocksize);
-			if (!bh)
-				return written ? written : -EIO;
+			if (!bh) {
+				retval = -EIO;
+				goto cleanup;
+			}
 			if (!buffer_uptodate(bh))
 				wait_on_buffer(bh);
 		}
 #else
 		bh = getblk(dev, block, blocksize);
-		if (!bh)
-			return written ? written : -EIO;
+		if (!bh) {
+			retval = -EIO;
+			goto cleanup;
+		}
 
 		if (!buffer_uptodate(bh))
 		{
@@ -105,7 +111,8 @@
 		        if (!bhlist[i])
 			{
 			  while(i >= 0) brelse(bhlist[i--]);
-			  return written ? written : -EIO;
+			  retval = -EIO;
+			  goto cleanup;
 		        }
 		      }
 		    }
@@ -114,7 +121,8 @@
 		    wait_on_buffer(bh);
 		    if (!buffer_uptodate(bh)) {
 			  brelse(bh);
-			  return written ? written : -EIO;
+			  retval = -EIO;
+			  goto cleanup;
 		    }
 		  };
 		};
@@ -148,6 +156,7 @@
 		if (write_error)
 			break;
 	}
+	cleanup:
 	if ( buffercount ){
 		ll_rw_block(WRITE, buffercount, bufferlist);
 		for(i=0; i<buffercount; i++){
@@ -157,10 +166,11 @@
 			brelse(bufferlist[i]);
 		}
 	}		
-	filp->f_reada = 1;
+	if(!retval)
+		filp->f_reada = 1;
 	if(write_error)
 		return -EIO;
-	return written;
+	return written ? written : retval;
 }
 
 ssize_t block_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
