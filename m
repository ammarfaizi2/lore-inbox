Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUAaIli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 03:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUAaIli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 03:41:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:14028 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264229AbUAaIlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 03:41:37 -0500
Date: Sat, 31 Jan 2004 00:42:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: s_kieu@hotmail.com
Cc: haiquy@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm1 pppd: page allocation failure (Got it now :-)
Message-Id: <20040131004214.05851d6e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0401311928350.1657@darkstar.example.net>
References: <Pine.LNX.4.53.0401311928350.1657@darkstar.example.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

haiquy@yahoo.com wrote:
>
> Finally I got it happened again and here is the attached dmesg output.
>

Good, thanks.

> 
> pppd: page allocation failure. order:4, mode:0xd0
>  Call Trace:
>   [<c013a140>] __alloc_pages+0x300/0x350
>   [<c013a1af>] __get_free_pages+0x1f/0x50
>   [<c013ccdc>] cache_grow+0x8c/0x250
>   [<c013cfee>] cache_alloc_refill+0x14e/0x210
>   [<c013d334>] __kmalloc+0x74/0x80
>   [<c01fe857>] z_decomp_alloc+0xb7/0x100
>   [<c01fae94>] ppp_set_compress+0x1b4/0x270
>   [<c01f92b1>] ppp_ioctl+0x4e1/0x610
>   [<c0150052>] vfs_write+0xd2/0x130
>   [<c0160cbb>] sys_ioctl+0xdb/0x260
>   [<c02b604f>] syscall_call+0x7/0xb

This should fix it up.


diff -puN drivers/net/ppp_deflate.c~ppp-allocation-fix drivers/net/ppp_deflate.c
--- 25/drivers/net/ppp_deflate.c~ppp-allocation-fix	2004-01-31 00:39:08.000000000 -0800
+++ 25-akpm/drivers/net/ppp_deflate.c	2004-01-31 00:40:21.000000000 -0800
@@ -351,7 +351,7 @@ static void *z_decomp_alloc(unsigned cha
 	state->w_size         = w_size;
 	state->strm.next_out  = NULL;
 	state->strm.workspace = kmalloc(zlib_inflate_workspacesize(),
-					GFP_KERNEL);
+					GFP_KERNEL|__GFP_REPEAT);
 	if (state->strm.workspace == NULL)
 		goto out_free;
 

_

