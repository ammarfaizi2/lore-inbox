Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276897AbRJCHNs>; Wed, 3 Oct 2001 03:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276898AbRJCHNi>; Wed, 3 Oct 2001 03:13:38 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:7686 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S276897AbRJCHNa>; Wed, 3 Oct 2001 03:13:30 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Wed, 3 Oct 2001 17:13:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15290.47777.464647.945975@notabene.cse.unsw.edu.au>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.4.11-pre2 fs/buffer.c: invalidate: busy buffer
In-Reply-To: message from Alexander Viro on Wednesday October 3
In-Reply-To: <15290.46612.877715.135811@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.21.0110030259530.21861-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 3, viro@math.psu.edu wrote:
> 
> 
> On Wed, 3 Oct 2001, Neil Brown wrote:
> 
> > On Wednesday October 3, adilger@turbolabs.com wrote:
> 
> > > 3) Rewrite to do I/O directly via pagecache?
> > 
> > 4) Rewrite to do I/O directly via generic_make_request just like it
> >    does for all other I/O to underlying devices.
> >    It is on my (mental) todo list, but doesn't have a high priority.
> >    At the same time, it would be good to get write_disk_sb to notice
> >    if the write failed.....
> 
> Folks, there's a problem aside of set_blocksize().  You are doing memset
> and memcpy on unlocked buffer returned by getblk().  That's a race -
> if that buffer is currently being read into, we will get a random crap.
> And write it to disk afterwards.
> 
> General rule: don't modify buffer you've got from getblk() unless you've
> locked it and mark it uptodate before you unlock.  We had the same
> bug in ext2, BTW.

What I am saying is "don't use the buffer cache at all" or any cache.
Don't use getblk.
Just:
   bh = kmalloc(sizeof(*bh));
   bh->b_data = rdev->sb; /* it is always one page */
   bh->b_rdev = rdev->dev;
   bh->b_rsector = sb_offset*2;
   bh->b_end_io = md_just_set_a_flag_and_call_wakeup;
   init_wait_queue_head(&bh->b_wait);
   bh->b_flags = 1<<B_Locked;

   generic_make_request(WRITE,bh);
   wait_disk_event((bh->b_flags & (1<<B_Locked)), bh->b_wait);

   err = bh->b_flags & (1<<B_Uptodate);
   kfree(bh);
   return err;


with typos corrected and a fairly obvious definition of
 md_just_set_a_flag_and_call_wakeup
fairly similar to end_buffer_io_sync.

NeilBrown
