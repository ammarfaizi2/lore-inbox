Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbQL0BnV>; Tue, 26 Dec 2000 20:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130530AbQL0BnL>; Tue, 26 Dec 2000 20:43:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:57871 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130552AbQL0Bmy>; Tue, 26 Dec 2000 20:42:54 -0500
Date: Tue, 26 Dec 2000 21:18:19 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, ananth@sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <37610000.977878627@coffee>
Message-ID: <Pine.LNX.4.21.0012262114410.1045-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Dec 2000, Chris Mason wrote:

> 
> Hi guys,
> 
> Here's my latest code, which uses ll_rw_block for anon pages (or
> pages without a writepage func) when flush_dirty_buffers, 
> sync_buffers, or fsync_inode_buffers are flushing things.  This
> seems to have fixed my slowdown on 1k buffer sizes, but I
> haven't done extensive benchmarks yet.

Great.

I'll run some benchmarks around here too and let you know. 

> Other changes:  After freeing a page with buffers, page_launder
> now stops if (!free_shortage()).  This is a mod of the check where 
> page_launder checked free_shortage after freeing a buffer cache 
> page.  Code outside buffer.c can't detect buffer cache pages with 
> this patch, so the old check doesn't apply.  
> 
> My change doesn't seem quite right though, if page_launder wants 
> to stop when there isn't a shortage, it should do that regardless of
> if the page it just freed had buffers.  It looks like this was added
> so bdflush could call page_launder, and get an early out after
> freeing some buffer heads, but I'm not sure.
> 
> In test13-pre4, invalidate_buffers skips buffers on a page
> with a mapping.  I changed that to skip mappings other than the
> anon space mapping.
> 
> Comments and/or suggestions on how to make better use of this stuff
> are more than welcome ;-)

Well, the best use of this patch seems to be the ability to do write
clustering in the ->writepage() operation for normal filesystems.

I'll try to do a lightweight write clustering patch for
block_write_full_page soon.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
