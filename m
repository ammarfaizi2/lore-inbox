Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131458AbQKTINJ>; Mon, 20 Nov 2000 03:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131454AbQKTINB>; Mon, 20 Nov 2000 03:13:01 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:26103 "HELO rockhopper")
	by vger.kernel.org with SMTP id <S131458AbQKTIMr>;
	Mon, 20 Nov 2000 03:12:47 -0500
From: Christopher Yeoh <cyeoh@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14872.54811.197665.178878@rockhopper.linuxcare.com.au>
Date: Mon, 20 Nov 2000 18:43:23 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 0 byte writes should not seek even with O_APPEND
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Currently when a zero byte write is done on a regular file
opened with O_APPEND the file offset is set to the end of the
file. For POSIX compliant behaviour this shouldn't happen.

The attached patch fixes this.

Chris.

--- mm/filemap.c.orig	Mon Nov 20 14:05:38 2000
+++ mm/filemap.c	Mon Nov 20 18:11:43 2000
@@ -2458,12 +2458,15 @@
 		}
 	}
 
-	status  = 0;
-	if (count) {
-		remove_suid(inode);
-		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-		mark_inode_dirty(inode);
+	if (count == 0) {
+		err = 0;
+		goto out;
 	}
+
+	status  = 0;
+	remove_suid(inode);
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	mark_inode_dirty(inode);
 
 	while (count) {
 		unsigned long bytes, index, offset;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
