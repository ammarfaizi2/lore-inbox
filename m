Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271856AbRICXK3>; Mon, 3 Sep 2001 19:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271857AbRICXKV>; Mon, 3 Sep 2001 19:10:21 -0400
Received: from web10407.mail.yahoo.com ([216.136.130.99]:54791 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271856AbRICXKI>; Mon, 3 Sep 2001 19:10:08 -0400
Message-ID: <20010903231027.51629.qmail@web10407.mail.yahoo.com>
Date: Tue, 4 Sep 2001 09:10:27 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: ext3 oops under moderate load
To: Stephen Tweedie <sct@redhat.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010903172323.A20255@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Stephen Tweedie <sct@redhat.com> wrote: > Hi,
> 
> On Fri, Aug 31, 2001 at 07:41:08PM -0700, Andrew
> Morton wrote:
> 
> > > kernel BUG at revoke.c:307!
> > 
> > Yours is the third report of this - it's
> definitely a bug in
> > ext3.  I still need to work out how you managed to
> get a page
> > attached to the inode which has not had its
> buffers fed through
> > journal_dirty_data().  There seem to be several
> ways in which
> > this can happen.
> 
> I've just been able to reproduce it, using large
> symlinks.
> 
> The killer seems to be a situation when you have a
> revoked
> buffer-cache buffer and we then start allocating,

Just want to add another situation. The previous post
about the system hang-up I suspected DRI module
related but it is not. It wont happen when I mount my
/dev/hda6 as ext2 (not ext3). The hang up happen when
I untar a tgz file (about 20Mb) to a loop device, loop
device attached to a 100Mb file in the ext3 partition.
And at the same time I untar the linux kenel from ext2
partition to ext3 partition. And I am playing Timidity
, running Mozilla. It is not swap related problem.

Hope that you may find it useful for your fix :-)

Cheers,

> and deallocating,
> the same buffer from the page cache.  Large symlinks
> work from the
> page cache and satisfy this condition nicely.
> 
> Running a few parallel tasks writing to the end of
> large sparse files
> and truncating them (to create and delete lots of
> indirect blocks,
> populating the buffer cache with revoked data), then
> adding large
> symlink create/delete activity in the same
> directory, I was able to
> reproduce the oops in a few minutes.
> 
> I suspect that the same sort of effect is causing
> the revoke oops
> Peter Braam saw with discretionally journaled files.
> 
> How to fix?  Well, the issue is that whenever we
> create any journaled
> data, we need to cancel all previous indications of
> the revoke, even
> if the old revoke was in the buffer cache but the
> new block is in the
> page cache.  That implies we effectively need the
> same as
> unmap_underlying_metadata, but for our own specific
> piece of metadata.
> Indeed, unmap_underlying_metadata already does the
> required lookup of
> the old cached buffer_head.  If we can pass in the
> page and the
> looked-up alias to an address_space a_ops, then:
> 
> 1) we can piggy-back the revoke cleanup on top of
> the existing
> get_hash_table which unmap_underlying_metadata
> performs; and
> 
> 2) we can detect whether the calling inode is
> journaled, so we know
> whether or not to clear out the revoke status on the
> underlying
> buffer_head (after all, if we're only allocating the
> new page as
> unjournaled data, the old revoke status should stay
> intact.)
> 
> It's now 10pm and the baby is crying, so I guess
> that testing the fix
> can wait until tomorrow. :)
> 
> Cheers,
>  Stephen
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
