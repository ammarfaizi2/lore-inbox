Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131933AbQKXGpq>; Fri, 24 Nov 2000 01:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131916AbQKXGph>; Fri, 24 Nov 2000 01:45:37 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:47373 "EHLO
        mail.valinux.com") by vger.kernel.org with ESMTP id <S131987AbQKXGp1>;
        Fri, 24 Nov 2000 01:45:27 -0500
Date: Thu, 23 Nov 2000 22:15:24 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: lseek patch for 2.2.18pre23
Message-ID: <20001123221524.A32154@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.18pre23 allows lseek to negative offsets in ext2 and has no checks
for proc. Here is a patch.

BTW, ext2 2.4-test10 is ok. 

-- 
H.J. Lu (hjl@valinux.com)
---
--- linux/fs/ext2/file.c.lseek	Sat Nov 18 17:18:49 2000
+++ linux/fs/ext2/file.c	Thu Nov 23 21:54:58 2000
@@ -120,6 +120,8 @@ static long long ext2_file_lseek(
 		case 1:
 			offset += file->f_pos;
 	}
+	if (offset < 0)
+		return -EINVAL;
 	if (((unsigned long long) offset >> 32) != 0) {
 #if BITS_PER_LONG < 64
 		return -EINVAL;
--- linux/fs/proc/mem.c.lseek	Tue Jan  4 10:12:23 2000
+++ linux/fs/proc/mem.c	Sat Nov 18 17:19:28 2000
@@ -196,14 +196,17 @@ static long long mem_lseek(struct file *
 {
 	switch (orig) {
 		case 0:
-			file->f_pos = offset;
-			return file->f_pos;
+			break;
 		case 1:
-			file->f_pos += offset;
-			return file->f_pos;
+			offset += file->f_pos;
+			break;
 		default:
 			return -EINVAL;
 	}
+	if (offset < 0)
+			return -EINVAL;
+	file->f_pos = offset;
+	return offset;
 }
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
