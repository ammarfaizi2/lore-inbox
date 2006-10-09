Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWJILlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWJILlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWJILlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:41:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58296 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932498AbWJILlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:41:08 -0400
Date: Mon, 9 Oct 2006 13:40:41 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix IO error reporting on fsync()
Message-ID: <20061009114040.GI17620@atrey.karlin.mff.cuni.cz>
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz> <20061006230609.c04e78bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006230609.c04e78bc.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 6 Oct 2006 13:49:47 +0200
> Jan Kara <jack@suse.cz> wrote:
> 
> >   current code in buffer.c has two pitfalls that cause problems with IO
> > error reporting of filesystems using mapping->private_list for their
> > metadata buffers (e.g. ext2).
> >   The first problem is that end_io_async_write() does not mark IO error
> > in the buffer flags, only in the page flags. Hence fsync_buffers_list()
> > does not find out that some IO error has occured and will not report it.
> >   The second problem is that buffers from private_list can be freed
> > (e.g. under memory pressure) and if fsync_buffer_list() is called after
> > that moment, IO error is lost - note that metadata buffers mark AS_EIO
> > on the *device mapping* not on the inode mapping.
> >   Following series of three patches tries to fix these problems. The
> > approach I took (after some discussions with Andrew) is introducing
> > dummy buffer_head in the mapping instead of private_list. This dummy
> > buffer head serves as a head of metadata buffer list and also collects
> > IO errors from other buffers on the list (see the third patch for more
> > details). This is kind of compromise between introducing a pointer to
> > inode's address_space into each buffer and between using list_head
> > instead of buffer_head and playing some dirty tricks to recognize that
> > one particular list_head is actually from address_space and not from
> > buffer_head. Any suggestions for improvements welcome.
> 
> This is really complex, and enlarges the inode by quite a lot, which hurts.
  I agree (at least with the second part ;). I can write a patch which
keeps the inode size but the code will be uglier... Another possibility
is to put there just a buffer_head pointer and allocate buffer head
dynamically. That has an advantage that only filesystems using metadata_list
has to bear the memory cost...

> What about putting an address_space* into the buffer_head?  Transfer the
> EIO state into the address_space within, say, __remove_assoc_queue()?
  Yes, that's of course possible. But it enlarges each buffer head by 4
bytes (or 8 on 64-bit arch). Hmm, but you are right that on the systems
I've looked at this would actually be less memory. OK, I'll write this
version of the patch.
								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
