Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUFHTzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUFHTzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 15:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbUFHTzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 15:55:35 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:2564 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264279AbUFHTzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 15:55:33 -0400
Message-ID: <40C61A20.4000906@kolumbus.fi>
Date: Tue, 08 Jun 2004 22:57:20 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback_inodes can race with unmount
References: <1086722523.10973.157.camel@watt.suse.com>
In-Reply-To: <1086722523.10973.157.camel@watt.suse.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 08.06.2004 22:58:18,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 08.06.2004 22:57:13,
	Serialize complete at 08.06.2004 22:57:13
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>There's a small window where the filesystem can be unmounted during
>writeback_inodes.  The end result is the iput done by sync_sb_inodes
>could be done after the FS put_super and and the super has been removed
>from all lists.
>  
>

Why don't we have the same race in the sync() path as well? Moving the 
locking to sync_sb_inodes() itself would fix it also.

>The fix is to hold the s_umount sem during sync_sb_inodes to make sure
>the FS doesn't get unmounted.
>
>Index: linux.t/fs/fs-writeback.c
>===================================================================
>--- linux.t.orig/fs/fs-writeback.c	2004-06-08 14:45:49.000000000 -0400
>+++ linux.t/fs/fs-writeback.c	2004-06-08 14:47:58.000000000 -0400
>@@ -360,9 +360,18 @@ restart:
> 	sb = sb_entry(super_blocks.prev);
> 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.prev)) {
> 		if (!list_empty(&sb->s_dirty) || !list_empty(&sb->s_io)) {
>+			/* we're making our own get_super here */
> 			sb->s_count++;
> 			spin_unlock(&sb_lock);
>-			sync_sb_inodes(sb, wbc);
>+			/* if we can't get the readlock, there's no sense in
>+			 * waiting around, most of the time the FS is going
>+			 * to be unmounted by the time it is released
>+			 */
>+			if (down_read_trylock(&sb->s_umount)) {
>+				if (sb->s_root)
>+					sync_sb_inodes(sb, wbc);
>+				up_read(&sb->s_umount);
>+			}
> 			spin_lock(&sb_lock);
> 			if (__put_super(sb))
> 				goto restart;
>  
>

--Mika


