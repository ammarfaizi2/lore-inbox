Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbQL0U71>; Wed, 27 Dec 2000 15:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbQL0U7R>; Wed, 27 Dec 2000 15:59:17 -0500
Received: from hermes.mixx.net ([212.84.196.2]:39437 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130200AbQL0U66>;
	Wed, 27 Dec 2000 15:58:58 -0500
Message-ID: <3A4A505A.3CF8A8BB@innominate.de>
Date: Wed, 27 Dec 2000 21:26:02 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.21.0012221730270.3382-100000@freak.distro.conectiva> <37610000.977878627@coffee>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> Hi guys,
> 
> Here's my latest code, which uses ll_rw_block for anon pages (or
> pages without a writepage func) when flush_dirty_buffers,
> sync_buffers, or fsync_inode_buffers are flushing things.  This
> seems to have fixed my slowdown on 1k buffer sizes, but I
> haven't done extensive benchmarks yet.
> 
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

Hi Chris.  I took your patch for a test drive under dbench and it seems
impressively stable under load, but there are performance problems.

	Test machine: 64 meg, 500 Mhz K6, IDE, Ext2, Blocksize=4K
	Without patch: 9.5 MB/sec, 11 min 6 secs
	With patch: 3.12 MB/sec, 33 min 51 sec

Philosophically, I wonder if it's right for the buffer flush mechanism
to be calling into the filesystem.  It seems like the buffer lists
should stay sitting between the filesystem and the block layer, it
actually does a pretty good job.

What about just bumping the buffers of pages found on the inactive_dirty
list to the front of the buffer LRU list?  Then we can do write
clustering by being selective about the bumping.
 
--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
