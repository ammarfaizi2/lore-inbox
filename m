Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVBVXYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVBVXYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVBVXYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:24:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:2265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261360AbVBVXXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:23:40 -0500
Date: Tue, 22 Feb 2005 15:28:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: zensonic@zensonic.dk, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Help tracking down problem --- endless loop in
 __find_get_block_slow
Message-Id: <20050222152833.75fb79a2.akpm@osdl.org>
In-Reply-To: <421BB65F.7040306@suse.com>
References: <4219BC1A.1060007@zensonic.dk>
	<20050222011821.2a917859.akpm@osdl.org>
	<421BB65F.7040306@suse.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> wrote:
>
> In my experience, the loop is actually outside of
> __find_get_block_slow(), in __getblk_slow(). I've been using xmon to
> interrupt the kernel, and the results vary but are all rooted in the
> for(;;) loop in __getblk_slow. It appears as though grow_buffers is
> finding/creating the page, but then __find_get_block can't locate the
> buffer it needs.

Yes, that'll happen.  Because there are still buffers attached to the page
which have the wrong blocksize.  Say, if someone is trying to read a 2k
buffer_head which is backed by a page which already has 1k buffer_heads
attached to it.

Does your kernel not have that big printk in __find_get_block_slow()?  If
it does, maybe some of the buffers are unmapped.  Try:

--- 25/fs/buffer.c~a	Tue Feb 22 15:27:35 2005
+++ 25-akpm/fs/buffer.c	Tue Feb 22 15:27:41 2005
@@ -456,7 +456,7 @@ __find_get_block_slow(struct block_devic
 	 * file io on the block device and getblk.  It gets dealt with
 	 * elsewhere, don't buffer_error if we had some unmapped buffers
 	 */
-	if (all_mapped) {
+	{
 		printk("__find_get_block_slow() failed. "
 			"block=%llu, b_blocknr=%llu\n",
 			(unsigned long long)block, (unsigned long long)bh->b_blocknr);
_


