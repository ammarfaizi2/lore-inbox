Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWJGGGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWJGGGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 02:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWJGGGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 02:06:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932622AbWJGGGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 02:06:16 -0400
Date: Fri, 6 Oct 2006 23:06:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix IO error reporting on fsync()
Message-Id: <20061006230609.c04e78bc.akpm@osdl.org>
In-Reply-To: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 13:49:47 +0200
Jan Kara <jack@suse.cz> wrote:

>   current code in buffer.c has two pitfalls that cause problems with IO
> error reporting of filesystems using mapping->private_list for their
> metadata buffers (e.g. ext2).
>   The first problem is that end_io_async_write() does not mark IO error
> in the buffer flags, only in the page flags. Hence fsync_buffers_list()
> does not find out that some IO error has occured and will not report it.
>   The second problem is that buffers from private_list can be freed
> (e.g. under memory pressure) and if fsync_buffer_list() is called after
> that moment, IO error is lost - note that metadata buffers mark AS_EIO
> on the *device mapping* not on the inode mapping.
>   Following series of three patches tries to fix these problems. The
> approach I took (after some discussions with Andrew) is introducing
> dummy buffer_head in the mapping instead of private_list. This dummy
> buffer head serves as a head of metadata buffer list and also collects
> IO errors from other buffers on the list (see the third patch for more
> details). This is kind of compromise between introducing a pointer to
> inode's address_space into each buffer and between using list_head
> instead of buffer_head and playing some dirty tricks to recognize that
> one particular list_head is actually from address_space and not from
> buffer_head. Any suggestions for improvements welcome.

This is really complex, and enlarges the inode by quite a lot, which hurts.

What about putting an address_space* into the buffer_head?  Transfer the
EIO state into the address_space within, say, __remove_assoc_queue()?
