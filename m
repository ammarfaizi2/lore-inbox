Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311876AbSCOAUE>; Thu, 14 Mar 2002 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311878AbSCOATz>; Thu, 14 Mar 2002 19:19:55 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:45976 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S311876AbSCOATk>; Thu, 14 Mar 2002 19:19:40 -0500
Message-ID: <3C913DFE.9020306@didntduck.org>
Date: Thu, 14 Mar 2002 19:19:10 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct super_block cleanup - msdos/vfat
In-Reply-To: <3C8FE8E3.2040204@didntduck.org>	<87k7sfoi8c.fsf@devron.myhome.or.jp>	<87bsdrohu3.fsf@devron.myhome.or.jp> <3C90A9C4.4030801@didntduck.org> <874rjjnp5t.fsf@devron.myhome.or.jp>
Content-Type: multipart/mixed;
 boundary="------------010200010708030600060500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010200010708030600060500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

OGAWA Hirofumi wrote:
> Brian Gerst <bgerst@didntduck.org> writes:
> 
> 
>>OGAWA Hirofumi wrote:
>>
>>>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>>>
>>>
>>>>Hi,
>>>>
>>>>Brian Gerst <bgerst@didntduck.org> writes:
>>>>
>>>>
>>>>
>>>>>diff -urN linux-2.5.7-pre1/fs/msdos/namei.c linux/fs/msdos/namei.c
>>>>>--- linux-2.5.7-pre1/fs/msdos/namei.c	Thu Mar  7 21:18:32 2002
>>>>>+++ linux/fs/msdos/namei.c	Wed Mar 13 08:20:12 2002
>>>>>@@ -603,17 +603,14 @@
>>>>>int msdos_fill_super(struct super_block *sb,void *data, int silent)
>>>>>{
>>>>>-	struct super_block *res;
>>>>>+	int res;
>>>>>-	MSDOS_SB(sb)->options.isvfat = 0;
>>>>>-	res = fat_read_super(sb, data, silent, &msdos_dir_inode_operations);
>>>>>-	if (IS_ERR(res))
>>>>>-		return PTR_ERR(res);
>>>>>-	if (res == NULL) {
>>>>>+	res = fat_fill_super(sb, data, silent, &msdos_dir_inode_operations, 0);
>>>>>+	if (res) {
>>>>>		if (!silent)
>>>>>			printk(KERN_INFO "VFS: Can't find a valid"
>>>>>			       " MSDOS filesystem on dev %s.\n", sb->s_id);
>>>>
>>>>If the error is I/O error, I think we shouldn't output this message.
>>>
>>>  ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>If the error is except -EINVAL,
>>>Sorry.
>>>
>>>
>>>>What do you think about this?
>>>
>>Why not?  The statement is true, and other filesystems do complain
>>when there is an I/O error.
> 
> 
> Umm, almost all filesystems doesn't output this message when the I/O error
> occurs, AFAIK.
> 
> I think that this message indicate that a device isn't a FAT
> filesystem.  And, of course, if error is the I/O error,
> fat_full_super() can't detect whether it is FAT filesystem or not.

Patch attached.

-- 

						Brian Gerst

--------------010200010708030600060500
Content-Type: text/plain;
 name="sb-fat-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-fat-2"

diff -urN linux/fs/msdos/namei.c linux2/fs/msdos/namei.c
--- linux/fs/msdos/namei.c	Thu Mar 14 10:53:20 2002
+++ linux2/fs/msdos/namei.c	Thu Mar 14 10:54:53 2002
@@ -607,7 +607,7 @@
 
 	res = fat_fill_super(sb, data, silent, &msdos_dir_inode_operations, 0);
 	if (res) {
-		if (!silent)
+		if (res == -EINVAL && !silent)
 			printk(KERN_INFO "VFS: Can't find a valid"
 			       " MSDOS filesystem on dev %s.\n", sb->s_id);
 		return res;
diff -urN linux/fs/vfat/namei.c linux2/fs/vfat/namei.c
--- linux/fs/vfat/namei.c	Thu Mar 14 10:53:20 2002
+++ linux2/fs/vfat/namei.c	Thu Mar 14 10:55:20 2002
@@ -1290,7 +1290,7 @@
   
 	res = fat_fill_super(sb, data, silent, &vfat_dir_inode_operations, 1);
 	if (res) {
-		if (!silent)
+		if (res == -EINVAL && !silent)
 			printk(KERN_INFO "VFS: Can't find a valid"
 			       " VFAT filesystem on dev %s.\n", sb->s_id);
 		return res;

--------------010200010708030600060500--

