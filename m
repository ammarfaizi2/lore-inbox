Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133055AbRDUXjt>; Sat, 21 Apr 2001 19:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133058AbRDUXj3>; Sat, 21 Apr 2001 19:39:29 -0400
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:39697 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S133056AbRDUXj1>; Sat, 21 Apr 2001 19:39:27 -0400
Date: Sun, 22 Apr 2001 01:37:38 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO-Drive under 2.4.3
Message-ID: <20010422013738.A520@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010414150028.A456@pelks01.extern.uni-tuebingen.de> <E14oR3c-00051v-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <E14oR3c-00051v-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Apr 14, 2001 at 03:29:45PM +0100
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 03:29:45PM +0100, Alan Cox wrote:
> > > This is a bug in the scsi layer. linux-scsi@vger.kernel.org, not that any of
> > > the scsi maintainers seem to care about it right now.
> > 
> > Err..., now I'm confused. Last time this issue popped up, it was my
> > understanding that it's generic_file_{read,write}'s limitation to filesystems
> > with logical_blksize >= hw_blksize that makes MOs fail with VFAT. Now, is
> > this all moot, or is the SCSI thing just an additional problem?
> 
> generic_file_* doesnt handle metadata issues - its too high up

As much as SCSI is too low down, so I still don't see why this should be a
SCSI issue. Assuming requests are no smaller than hw_blksize looks rather sane
for a low-level driver. It's still enforced in ll_rw_blk(). I'd rather blame
the callers when they bypass the check via submit_bh().

More to the topic, FAT in 2.2 contained lots of special code to deal with
bigblocks. In 2.4, this code got removed in favour of the generic
functions in fs/buffer.c, to the effect that operations that happen to not
deref a NULL pointer now request 2k blocks using 512 byte-calculated block
numbers. I see two options:

a) Put in lots of bigblock special case code in FAT;
b) teach submit_bh() or generic_make_request() to transparently reblock 
   bhs < hw_blksize and remove most special cases from FAT. Specifically,
   it ought to stop pretending in sb->s_blocksize to use 2k blocks when
   the fs is really tied to 512 byte blocks.

I tend to favour b), but which one is more likely to be accepted?

Regards,

Daniel.

-- 
	GNU/Linux Audio Mechanics - http://www.glame.de
	      Cutting Edge Office - http://www.c10a02.de
	      GPG Key ID 89BF7E2B - http://www.keyserver.net
