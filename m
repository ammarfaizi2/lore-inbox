Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132171AbQKSDhZ>; Sat, 18 Nov 2000 22:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132179AbQKSDhP>; Sat, 18 Nov 2000 22:37:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15416 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132171AbQKSDhK>; Sat, 18 Nov 2000 22:37:10 -0500
Date: Sun, 19 Nov 2000 04:07:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H . J . Lu" <hjl@valinux.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek/llseek allows the negative offset
Message-ID: <20001119040704.A31148@athlon.random>
In-Reply-To: <20001117155913.A26622@valinux.com> <20001117160900.A27010@valinux.com> <20001118192542.B24555@athlon.random> <20001119014512.G26779@athlon.random> <20001118172034.A22523@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001118172034.A22523@valinux.com>; from hjl@valinux.com on Sat, Nov 18, 2000 at 05:20:34PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 05:20:34PM -0800, H . J . Lu wrote:
> Try this again 2.2.18pre21. It works for me.
> 
> 
> -- 
> H.J. Lu (hjl@valinux.com)
> ---
> --- linux/fs/ext2/file.c.lseek	Sat Nov 18 17:18:49 2000
> +++ linux/fs/ext2/file.c	Sat Nov 18 17:19:28 2000
> @@ -120,6 +120,8 @@ static long long ext2_file_lseek(
>  		case 1:
>  			offset += file->f_pos;
>  	}
> +	if (offset < 0)
> +		return -EINVAL;
>  	if (((unsigned long long) offset >> 32) != 0) {
>  #if BITS_PER_LONG < 64
>  		return -EINVAL;

It's not enough for 2.2.x (and you left the `>> 32' nosense check).

2.2.x vanilla (so non-lfs) is getting wrong both 32bit and 64bit:

1) 32bit can lseek over 2G and it can return bogus retval

main()
{
        int fd = creat("x", 0600);
        lseek(fd, 0x7fffffff, 1);
        lseek(fd, 0x7fffffff, 1);
}

lseek(3, 2147483647, SEEK_CUR)          = 2147483647
lseek(3, 2147483647, SEEK_CUR)          = -1 ENOENT (No such file or directory)

(this isn't really -ENOENT but it's just trying to return a succesful -2 value)

2) 64bit can lseek over ext2_max_sizes and it can return bogus retvals

main()
{
        int fd = creat("x", 0600);
        lseek(fd, -2, 0);
}

open("x", O_WRONLY|O_CREAT|O_TRUNC, 0600) = 3
lseek(3, 18446744073709551614, SEEK_SET) = -1 ENOENT (No such file or directory)

(this isn't really -ENOENT but it's just trying to return a succesful -2 value)

This will cure 2.2.x vanilla:

--- 2.2.18pre21/fs/ext2/file.c.~1~	Sun Nov 12 00:45:42 2000
+++ 2.2.18pre21/fs/ext2/file.c	Sun Nov 19 03:59:29 2000
@@ -120,14 +120,14 @@
 		case 1:
 			offset += file->f_pos;
 	}
-	if (((unsigned long long) offset >> 32) != 0) {
 #if BITS_PER_LONG < 64
+	if (offset >> 31)
 		return -EINVAL;
 #else
-		if (offset > ext2_max_sizes[EXT2_BLOCK_SIZE_BITS(inode->i_sb)])
-			return -EINVAL;
+	if (offset < 0 ||
+	    offset > ext2_max_sizes[EXT2_BLOCK_SIZE_BITS(inode->i_sb)])
+		return -EINVAL;
 #endif
-	} 
 	if (offset != file->f_pos) {
 		file->f_pos = offset;
 		file->f_reada = 0;

and this will remove the nosense stuff from 2.4.x:

--- 2.4.0-test11-pre6/fs/ext2/file.c.~1~	Thu Nov 16 15:37:32 2000
+++ 2.4.0-test11-pre6/fs/ext2/file.c	Sun Nov 19 04:03:27 2000
@@ -53,12 +53,9 @@
 		case 1:
 			offset += file->f_pos;
 	}
-	if (offset<0)
+	if (offset < 0 ||
+	    offset > ext2_max_sizes[EXT2_BLOCK_SIZE_BITS(inode->i_sb)])
 		return -EINVAL;
-	if (((unsigned long long) offset >> 32) != 0) {
-		if (offset > ext2_max_sizes[EXT2_BLOCK_SIZE_BITS(inode->i_sb)])
-			return -EINVAL;
-	} 
 	if (offset != file->f_pos) {
 		file->f_pos = offset;
 		file->f_reada = 0;

(the above is also ok for 2.2.x-lfs and I'll fix it that way)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
