Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbQKSBvD>; Sat, 18 Nov 2000 20:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbQKSBux>; Sat, 18 Nov 2000 20:50:53 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:51982 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129234AbQKSBuo>;
	Sat, 18 Nov 2000 20:50:44 -0500
Date: Sat, 18 Nov 2000 17:20:34 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek/llseek allows the negative offset
Message-ID: <20001118172034.A22523@valinux.com>
In-Reply-To: <20001117155913.A26622@valinux.com> <20001117160900.A27010@valinux.com> <20001118192542.B24555@athlon.random> <20001119014512.G26779@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001119014512.G26779@athlon.random>; from andrea@suse.de on Sun, Nov 19, 2000 at 01:45:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 01:45:12AM +0100, Andrea Arcangeli wrote:
> On Sat, Nov 18, 2000 at 07:25:42PM +0100, Andrea Arcangeli wrote:
> > I fixed it this way:
> 
> fix is plain wrong, it's still possible to have lseek return -1 -2 -3 -4
> even when it should return -EINVAL.
> 

Try this again 2.2.18pre21. It works for me.


-- 
H.J. Lu (hjl@valinux.com)
---
--- linux/fs/ext2/file.c.lseek	Sat Nov 18 17:18:49 2000
+++ linux/fs/ext2/file.c	Sat Nov 18 17:19:28 2000
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
