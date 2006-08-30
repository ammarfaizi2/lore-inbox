Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWH3X7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWH3X7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWH3X73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:59:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751441AbWH3X72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:59:28 -0400
Date: Wed, 30 Aug 2006 16:59:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Gorka Guardiola" <paurealkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buffer head async write
Message-Id: <20060830165924.2955d8d1.akpm@osdl.org>
In-Reply-To: <dc081bb90608300935h1d5346fbj742920754f4b4680@mail.gmail.com>
References: <dc081bb90608300935h1d5346fbj742920754f4b4680@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 11:35:44 -0500
"Gorka Guardiola" <paurealkml@gmail.com> wrote:

> I am trying to 	mark a buffer for async write, but I am  having a race condition
> to unlock the buffer. I am doing.
> 
>         bh = getbmapst(bdev, nsect); //this function calls bread
> 	if (!bh) {
> 		printk(KERN_ALERT "I/O error, bitmap cannot be trusted\n");
> 		return -1;
> 	}
> 	
> 	lock_buffer(bh);	
> 
> 	byte = bh->b_data + byteoffset;
> 	*byte |= 1 << bitoffset;
> 	lock_page(bh->b_page);
> 	mark_page_accessed(bh->b_page);
> 	__set_page_dirty_nobuffers(bh->b_page);
> 	unlock_page(bh->b_page);
> 	set_buffer_uptodate(bh);
> 	mark_buffer_dirty(bh);
> 	mark_buffer_async_write(bh);
> 	unlock_buffer(bh);
> 	brelse(bh);

There are rather a lot of mistakes in there.

More like this:

	lock_page(bh->b_page);
	lock_buffer(bh);
	byte = bh->b_data + byteoffset;
	*byte |= 1 << bitoffset;
	mark_buffer_dirty(bh);
	unlock_buffer(bh);
	flush_dcache_page(page);
	unlock_page(page);
	put_bh(bh);

now, the buffer is dirty and will be written back by pdflush, sync, etc.

If you really want to start async IO against that buffer now, do

	ll_rw_block(WRITE, 1, &bh);

just before the final put_bh().

	
