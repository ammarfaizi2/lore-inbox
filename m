Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTHaTGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 15:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbTHaTGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 15:06:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:62637 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261651AbTHaTGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 15:06:48 -0400
Date: Sun, 31 Aug 2003 12:06:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.0-testX and InnoDB (was: Re: 2.6.0-test2-mm3 and mysql)
Message-Id: <20030831120648.7c5eed6e.akpm@osdl.org>
In-Reply-To: <200308311437.51942.rathamahata@php4.ru>
References: <1059871132.2302.33.camel@mars.goatskin.org>
	<20030828125010.7b45407d.akpm@osdl.org>
	<200308291212.39238.rathamahata@php4.ru>
	<200308311437.51942.rathamahata@php4.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
>
> fsx-linux hasn't been producing any error messages or logs since Friday.
>  But I've got an oops. Here it is.
> 
>  ksymoops 2.4.9 on i686 2.6.0-test4.  Options used
>       -V (default)
>       -K (specified)
>       -l /proc/modules (default)
>       -o /lib/modules/2.6.0-test4/ (default)
>       -m /proc/kallsyms (specified)
> 
>  No modules in ksyms, skipping objects
>  No ksyms, skipping lsmod
>  3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
>  0000:00:0c.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xb800. Vers LK1.1.19
>  kernel BUG at mm/filemap.c:336!
>  invalid operand: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<c01324f0>]    Not tainted
>  Using defaults from ksymoops -t elf32-i386 -a i386
>  EFLAGS: 00010246
>  eax: 00000000   ebx: c1577e70   ecx: 00000016   edx: 00000001
>  esi: c1a00448   edi: d5f3e820   ebp: e7147858   esp: c1bbbd34
>  ds: 007b   es: 007b   ss: 0068
>  Stack: c1577e70 00000286 00000000 c0191a4e c1577e70 eb14fde0 d5f3e850 c1577e70 
>         00000000 00000000 00000000 e7147904 c1577e70 c1bbbe64 e71478e4 c013c294 
>         c1577e70 c1bbbdac c1bba000 c1bba000 c1bba000 c1bba000 c1bba000 c1bba000 
>  Call Trace:
>   [<c0191a4e>] reiserfs_write_full_page+0xee/0x3a0
>   [<c013c294>] shrink_list+0x394/0x5f0
>   [<c013afe8>] __pagevec_release+0x28/0x40
>   [<c013c6a7>] shrink_cache+0x1b7/0x350
>   [<c013d267>] balance_pgdat+0x187/0x220
>   [<c013d443>] kswapd+0x143/0x150
>   [<c01183b0>] autoremove_wake_function+0x0/0x50
>   [<c0109232>] ret_from_fork+0x6/0x14
>   [<c01183b0>] autoremove_wake_function+0x0/0x50
>   [<c013d300>] kswapd+0x0/0x150

You need this:

diff -puN fs/reiserfs/inode.c~reiserfs-writepage-fix fs/reiserfs/inode.c
--- 25/fs/reiserfs/inode.c~reiserfs-writepage-fix	2003-08-26 10:12:14.000000000 -0700
+++ 25-akpm/fs/reiserfs/inode.c	2003-08-26 10:12:14.000000000 -0700
@@ -2048,8 +2048,8 @@ static int reiserfs_write_full_page(stru
         last_offset = inode->i_size & (PAGE_CACHE_SIZE - 1) ;
 	/* no file contents in this page */
 	if (page->index >= end_index + 1 || !last_offset) {
-	    error = 0 ;
-	    goto done ;
+    	    unlock_page(page);
+	    return 0;
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset(kaddr + last_offset, 0, PAGE_CACHE_SIZE-last_offset) ;

_


