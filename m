Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUGKEl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUGKEl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 00:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUGKEl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 00:41:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:52939 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266498AbUGKElv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 00:41:51 -0400
Date: Sat, 10 Jul 2004 21:40:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
Message-Id: <20040710214042.1f217a36.akpm@osdl.org>
In-Reply-To: <1089519553.4153.1.camel@mentorng.gurulabs.com>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<1089519553.4153.1.camel@mentorng.gurulabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com> wrote:
>
> On Fri, 2004-07-09 at 00:50, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> 
>  My logs are full of:
> 
>  Debug: sleeping function called from invalid context at include/asm/uaccess.h:471
>  in_atomic():1, irqs_disabled():0
>   [<c01195cf>] __might_sleep+0x9f/0xb0
>   [<c01351a7>] __filemap_copy_from_user_iovec+0x57/0xd0
>   [<c013583f>] generic_file_aio_write_nolock+0x61f/0x9e0
>   [<c027428e>] sock_recvmsg+0xce/0xd0
>   [<c02d3136>] schedule+0x286/0x4f0
>   [<c0273f96>] sockfd_lookup+0x16/0x80
>   [<c0135c5a>] generic_file_write_nolock+0x5a/0x80
>   [<c015f71a>] do_select+0x18a/0x2b0
>   [<c0135e64>] generic_file_writev+0x54/0x80
>   [<c0135e10>] generic_file_writev+0x0/0x80
>   [<c014ed83>] do_readv_writev+0x1e3/0x230
>   [<c014e7e0>] do_sync_write+0x0/0xa0
>   [<c0275e74>] sys_socketcall+0x154/0x250
>   [<c014ee69>] vfs_writev+0x49/0x60

yup, the testing level on that one was pretty bad, sorry.  You'll need this:

--- 25/mm/filemap.c~add-a-few-might_sleep-checks-fix	2004-07-09 02:23:52.447034064 -0700
+++ 25-akpm/mm/filemap.c	2004-07-09 02:23:52.452033304 -0700
@@ -1663,7 +1663,7 @@ __filemap_copy_from_user_iovec(char *vad
 		int copy = min(bytes, iov->iov_len - base);
 
 		base = 0;
-		left = __copy_from_user(vaddr, buf, copy);
+		left = __copy_from_user_inatomic(vaddr, buf, copy);
 		copied += copy;
 		bytes -= copy;
 		vaddr += copy;
_

