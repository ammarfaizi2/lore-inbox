Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbUDBAYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUDBAYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:24:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:54216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262924AbUDBAYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:24:16 -0500
Date: Thu, 1 Apr 2004 16:26:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: r.w.maloy@acm.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible error in fs/buffer.c
Message-Id: <20040401162627.7b3f48c7.akpm@osdl.org>
In-Reply-To: <200404011043.49077.r.w.maloy@acm.org>
References: <200404011043.49077.r.w.maloy@acm.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert W. Maloy" <r.w.maloy@acm.org> wrote:
>
> 	While code surfing I found what appears to be a problem with the 
> following code in fs/buffer.c {function mark_buffer_inode_dirty}: 
> 
>        if (list_empty(&bh->b_assoc_buffers))
>                 buffer_insert_list(&buffer_mapping->private_lock,
>                                 bh, &mapping->private_list);

This is saying "is the buffer is not on any list, then place it on the
mapping's list now.  If the buffer _is_ already on some list then we know
it must already be on mapping->private_list, so we have nothing to do".

Re-dirtying an already-dirty buffer is an extremely common case, and here
we look for an opportunity to avoid dirtying a cacheline or two.

