Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVD1AHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVD1AHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 20:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVD1AHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 20:07:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:63388 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262112AbVD1AHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 20:07:22 -0400
Subject: [PATCH] drop_buffers() shouldn't de-ref page->mapping if its NULL
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, skodati@in.ibm.com
In-Reply-To: <1114645113.26913.662.camel@dyn318077bld.beaverton.ibm.com>
References: <1114645113.26913.662.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-3J4TqEkOOIylzGhTNYbH"
Organization: 
Message-Id: <1114646015.26913.668.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Apr 2005 16:53:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3J4TqEkOOIylzGhTNYbH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I answered my own question. It looks like we could have pages
with buffers without page->mapping. In such cases, we shouldn't
de-ref page->mapping in drop_buffers(). Here is the trivial
patch to fix it.

Thanks,
Badari

On Wed, 2005-04-27 at 16:38, Badari Pulavarty wrote:
> Hi Andrew,
> 
> We ran into a panic in drop_buffers() while running some networking
> tests and I am wondering if this a valid case. try_to_free_buffers()
> seems to call drop_buffers() even if the mapping is NULL. drop_buffers()
> seems to de-ref the mapping. This is causing NULL pointer deref.
> 
> But, is "mapping == NULL" still valid case here ? Can we be in the
> code to drop buffers and have mapping NULL ? We would be in this
> code only if PagePrivate() is set. Can we have page private with
> out a valid mapping ?
> 
> Thanks,
> Badari
> 
> int try_to_free_buffers(struct page *page)
> {
>         struct address_space * const mapping = page->mapping;
>         ....
>                                                                                                                        
>         if (mapping == NULL) {          /* can this still happen? */
>                 ret = drop_buffers(page, &buffers_to_free);
>                 goto out;
>         }
> }
> 
> drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
> {
>         ....
>                 if (buffer_write_io_error(bh))
>                         set_bit(AS_EIO, &page->mapping->flags); <<<<<<
> 	...
> }
> 
> 1:mon> e
> cpu 0x1: Vector: 300 (Data Access) at [c00000007ff4b620]
>     pc: c0000000000bd524: .drop_buffers+0x40/0xcc
>     lr: c0000000000bd614: .try_to_free_buffers+0x64/0xf4
>     sp: c00000007ff4b8a0
>    msr: 8000000000009032
>    dar: 60
>  dsisr: 40000000
>   current = 0xc00000000fe7e040
>   paca    = 0xc0000000003da800
>     pid   = 40, comm = kswapd1
> 
> 1:mon> t
> [c00000007ff4b920] c0000000000bd614 .try_to_free_buffers+0x64/0xf4
> [c00000007ff4b9c0] c0000000000baadc .try_to_release_page+0x88/0x9c
> [c00000007ff4ba40] c000000000099418 .shrink_list+0x3a0/0x608
> [c00000007ff4bb90] c000000000099a04 .shrink_cache+0x384/0x610
> [c00000007ff4bcd0] c00000000009a4d4 .shrink_zone+0x104/0x140
> [c00000007ff4bd70] c00000000009aaf0 .balance_pgdat+0x270/0x448
> [c00000007ff4be90] c00000000009ade4 .kswapd+0x11c/0x120
> [c00000007ff4bf90] c000000000018ad0 .kernel_thread+0x4c/0x6c
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--=-3J4TqEkOOIylzGhTNYbH
Content-Disposition: attachment; filename=drop_buffer_fix.patch
Content-Type: text/plain; name=drop_buffer_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux-2.6.12-rc2.org/fs/buffer.c	2005-04-27 07:19:44.000000000 -0700
+++ linux-2.6.12-rc2/fs/buffer.c	2005-04-27 07:20:34.000000000 -0700
@@ -2917,7 +2917,7 @@ drop_buffers(struct page *page, struct b
 
 	bh = head;
 	do {
-		if (buffer_write_io_error(bh))
+		if (buffer_write_io_error(bh) && page->mapping)
 			set_bit(AS_EIO, &page->mapping->flags);
 		if (buffer_busy(bh))
 			goto failed;

--=-3J4TqEkOOIylzGhTNYbH--

