Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVFWIxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVFWIxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVFWIt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:49:58 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:22532 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S262684AbVFWIjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:39:10 -0400
Subject: [PATCH][RESEND] ReiserFS file.c several bug-fix - modified version
From: fs <fs@ercist.iscas.ac.cn>
To: Hans Reiser <reiser@namesys.com>
Cc: zhiming@admin.iscas.ac.cn, qufuping@ercist.iscas.ac.cn,
       madsys@ercist.iscas.ac.cn, xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Vladimir Saveliev <vs@namesys.com>
Content-Type: multipart/mixed; boundary="=-Q1L8WruaB3hWtURsZIPn"
Organization: iscas
Message-Id: <1119555533.3026.104.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Jun 2005 15:38:53 -0400
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q1L8WruaB3hWtURsZIPn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

hi, all, in the previous patch, i accidentally typed several 
'dd(vim)'

Sorry

> Related FS:
>     ReiserFS
> 
> Related Files:
>     fs/reiserfs/file.c
> 
> Bug description:
>     Make a ReiserFS partition in USB storage HDD, create a test file
> with enough size.
>     Write a program, do: open(O_SYNC/O_DSYNC) - read - close. After
> each
> operation, pause for a while, such as 3s. Between open and read, unlug
> the USB wire. open returns zero-filled buffer, no error returns.
> 
> Bug analysis:
>     reiserfs_file_write will claim some blocks, commit the I/O
> request,
> if O_SYNC and O_DSYNC is used, it will
>     if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
>         res = generic_osync_inode(inode, file->f_mapping,
>                                   OSYNC_METADATA|OSYNC_DATA);
> The question is, if I/O error occurs,       
>         res = reiserfs_allocate_blocks_for_region fails with -EIO, so
> it will exit the loop, no I/O request, no page marked as dirty.
> If run generic_osync_inode, it returns 0(no dirty page), res will be
> overwritten from -EIO to 0, thus no error report.
> 
> Also,  reiserfs_file_write contains a serious bug, see here
>         blocks_to_allocate = reiserfs_prepare_file_region_for_write
>                 (inode, pos, num_pages, write_bytes, prepared_pages);
> Here blocks_to_allocate is defined as size_t, i.e. unsigned int, but
> reiserfs_prepare_file_region_for_write is declared as int, so
> sometimes
> it will return -EIO, -ENOENT, etc, take a look at this line
>         if ( blocks_to_allocate < 0 ) { <- This will never happen
>             res = blocks_to_allocate;
>             reiserfs_release_claimed_blocks(inode->i_sb, 
>                 num_pages << (PAGE_CACHE_SHIFT - inode->i_blkbits));
>             break;
>         }
> 
> Way around:
> 1) if already_written is zero, don't do generic_osync_inode
> 2) tell the result of reiserfs_prepare_file_region_for_write with
> IS_ERR
>    macro or cast it to size_t
> 
> Signed-off-by: Qu Fuping<fs@ercist.iscas.ac.cn>
> 
> Patch:
> diff -uNp linux-2.6.12/fs/reiserfs/file.c
> linux-2.6.12-new/fs/reiserfs/file.c
> 



--=-Q1L8WruaB3hWtURsZIPn
Content-Disposition: attachment; filename=reiserfs_write.diff
Content-Type: text/x-patch; name=reiserfs_write.diff; charset=gb2312
Content-Transfer-Encoding: 7bit

--- linux-2.6.12/fs/reiserfs/file.c	2005-06-23 14:59:27.000000000 -0400
+++ linux-2.6.12-new/fs/reiserfs/file.c	2005-06-23 15:34:49.000000000 -0400
@@ -1306,7 +1306,7 @@ static ssize_t reiserfs_file_write( stru
 	   so that nobody else can access these until we are done.
 	   We get number of actual blocks needed as a result.*/
 	blocks_to_allocate = reiserfs_prepare_file_region_for_write(inode, pos, num_pages, write_bytes, prepared_pages);
-	if ( blocks_to_allocate < 0 ) {
+	if ( IS_ERROR((const void *)blocks_to_allocate) ) {
 	    res = blocks_to_allocate;
 	    reiserfs_release_claimed_blocks(inode->i_sb, num_pages << (PAGE_CACHE_SHIFT - inode->i_blkbits));
 	    break;
@@ -1363,6 +1363,10 @@ static ssize_t reiserfs_file_write( stru
         }
     }
 
+    /* If nothing is written, no need(actually, mustn't) to sync pages, just return res */
+    if( already_written == 0 )
+	    goto out;
+    
     if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
 	res = generic_osync_inode(inode, file->f_mapping, OSYNC_METADATA|OSYNC_DATA);
 

--=-Q1L8WruaB3hWtURsZIPn--


