Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271913AbRIDIu7>; Tue, 4 Sep 2001 04:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271915AbRIDIut>; Tue, 4 Sep 2001 04:50:49 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:40948 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S271913AbRIDIub>; Tue, 4 Sep 2001 04:50:31 -0400
Date: Mon, 3 Sep 2001 22:14:37 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: mb/ext3@dcs.qmul.ac.uk, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com, ext2-devel@lists.sourceforge.net
Subject: Re: ext3 oops under moderate load
Message-ID: <20010903221437.B9723@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0108301740420.7921-100000@inconnu.isu.edu> <Pine.LNX.4.33.0108310759460.13139-100000@nick.dcs.qmul.ac.uk> <3B904AC4.6A449086@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B904AC4.6A449086@zip.com.au>; from akpm@zip.com.au on Fri, Aug 31, 2001 at 07:41:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 31, 2001 at 07:41:08PM -0700, Andrew Morton wrote:

> > kernel BUG at revoke.c:307!
> 
> Yours is the third report of this - it's definitely a bug in
> ext3.  I still need to work out how you managed to get a page
> attached to the inode which has not had its buffers fed through
> journal_dirty_data().  There seem to be several ways in which
> this can happen.

I've just been able to reproduce it, using large symlinks.

The killer seems to be a situation when you have a revoked
buffer-cache buffer and we then start allocating, and deallocating,
the same buffer from the page cache.  Large symlinks work from the
page cache and satisfy this condition nicely.

Running a few parallel tasks writing to the end of large sparse files
and truncating them (to create and delete lots of indirect blocks,
populating the buffer cache with revoked data), then adding large
symlink create/delete activity in the same directory, I was able to
reproduce the oops in a few minutes.

I suspect that the same sort of effect is causing the revoke oops
Peter Braam saw with discretionally journaled files.

How to fix?  Well, the issue is that whenever we create any journaled
data, we need to cancel all previous indications of the revoke, even
if the old revoke was in the buffer cache but the new block is in the
page cache.  That implies we effectively need the same as
unmap_underlying_metadata, but for our own specific piece of metadata.
Indeed, unmap_underlying_metadata already does the required lookup of
the old cached buffer_head.  If we can pass in the page and the
looked-up alias to an address_space a_ops, then:

1) we can piggy-back the revoke cleanup on top of the existing
get_hash_table which unmap_underlying_metadata performs; and

2) we can detect whether the calling inode is journaled, so we know
whether or not to clear out the revoke status on the underlying
buffer_head (after all, if we're only allocating the new page as
unjournaled data, the old revoke status should stay intact.)

It's now 10pm and the baby is crying, so I guess that testing the fix
can wait until tomorrow. :)

Cheers,
 Stephen
