Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269455AbUIZA3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269455AbUIZA3J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUIZA1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:27:12 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:28578 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269451AbUIZAXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:23:47 -0400
Date: Sun, 26 Sep 2004 01:23:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/3] Re: [2.6-BK-URL] NTFS: Final sparse related cleanups.
In-Reply-To: <Pine.LNX.4.60.0409260122490.30504@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409260123110.30504@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409260119140.30504@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409260122170.30504@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409260122490.30504@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 3/3 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/26 1.1991)
   NTFS: Change {const_,}cpu_to_le{16,32}(0) to just 0 as suggested by Al Viro.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-09-26 01:17:32 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-26 01:17:32 +01:00
@@ -54,6 +54,7 @@
 	- Fix a bug found by the new sparse bitwise warnings where the default
 	  upcase table was defined as a pointer to wchar_t rather than ntfschar
 	  in fs/ntfs/ntfs.h and super.c.
+	- Change {const_,}cpu_to_le{16,32}(0) to just 0 as suggested by Al Viro.
 
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-09-26 01:17:32 +01:00
+++ b/fs/ntfs/dir.c	2004-09-26 01:17:32 +01:00
@@ -28,8 +28,7 @@
  * The little endian Unicode string $I30 as a global constant.
  */
 ntfschar I30[5] = { const_cpu_to_le16('$'), const_cpu_to_le16('I'),
-		const_cpu_to_le16('3'),	const_cpu_to_le16('0'),
-		const_cpu_to_le16(0) };
+		const_cpu_to_le16('3'),	const_cpu_to_le16('0'), 0 };
 
 /**
  * ntfs_lookup_inode_by_name - find an inode in a directory given its name
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-26 01:17:32 +01:00
+++ b/fs/ntfs/inode.c	2004-09-26 01:17:32 +01:00
@@ -130,7 +130,7 @@
 		if (!ni->name)
 			return -ENOMEM;
 		memcpy(ni->name, na->name, i);
-		ni->name[i] = cpu_to_le16(0);
+		ni->name[i] = 0;
 	}
 	return 0;
 }
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-09-26 01:17:32 +01:00
+++ b/fs/ntfs/mft.c	2004-09-26 01:17:32 +01:00
@@ -47,11 +47,11 @@
 	*(le16*)((char*)m + ((sizeof(MFT_RECORD) + 1) & ~1)) = cpu_to_le16(1);
 	m->lsn = cpu_to_le64(0LL);
 	m->sequence_number = cpu_to_le16(1);
-	m->link_count = cpu_to_le16(0);
+	m->link_count = 0;
 	/* Aligned to 8-byte boundary. */
 	m->attrs_offset = cpu_to_le16((le16_to_cpu(m->usa_ofs) +
 			(le16_to_cpu(m->usa_count) << 1) + 7) & ~7);
-	m->flags = cpu_to_le16(0);
+	m->flags = 0;
 	/*
 	 * Using attrs_offset plus eight bytes (for the termination attribute),
 	 * aligned to 8-byte boundary.
@@ -60,10 +60,10 @@
 			~7);
 	m->bytes_allocated = cpu_to_le32(size);
 	m->base_mft_record = cpu_to_le64((MFT_REF)0);
-	m->next_attr_instance = cpu_to_le16(0);
+	m->next_attr_instance = 0;
 	a = (ATTR_RECORD*)((char*)m + le16_to_cpu(m->attrs_offset));
 	a->type = AT_END;
-	a->length = cpu_to_le32(0);
+	a->length = 0;
 }
 
 /**
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-26 01:17:32 +01:00
+++ b/fs/ntfs/super.c	2004-09-26 01:17:32 +01:00
@@ -1114,9 +1114,9 @@
 	static const ntfschar Quota[7] = { const_cpu_to_le16('$'),
 			const_cpu_to_le16('Q'), const_cpu_to_le16('u'),
 			const_cpu_to_le16('o'), const_cpu_to_le16('t'),
-			const_cpu_to_le16('a'), const_cpu_to_le16(0) };
+			const_cpu_to_le16('a'), 0 };
 	static ntfschar Q[3] = { const_cpu_to_le16('$'),
-			const_cpu_to_le16('Q'), const_cpu_to_le16(0) };
+			const_cpu_to_le16('Q'), 0 };
 
 	ntfs_debug("Entering.");
 	/*
diff -Nru a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c	2004-09-26 01:17:32 +01:00
+++ b/fs/ntfs/unistr.c	2004-09-26 01:17:32 +01:00
@@ -276,7 +276,7 @@
 				} /* else (wc_len < 0) */
 				goto conversion_err;
 			}
-			ucs[o] = cpu_to_le16(0);
+			ucs[o] = 0;
 			*outs = ucs;
 			return o;
 		} /* else (!ucs) */
