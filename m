Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSGDIcO>; Thu, 4 Jul 2002 04:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317374AbSGDIcN>; Thu, 4 Jul 2002 04:32:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317373AbSGDIcL>;
	Thu, 4 Jul 2002 04:32:11 -0400
Message-ID: <3D2409FA.44E88C1D@zip.com.au>
Date: Thu, 04 Jul 2002 01:40:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.org>
CC: Neil Brown <neilb@cse.unsw.edu.au>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de> <20020703120124.GB615@fib011235813.fsnet.co.uk> <20020703121024.GC21568@suse.de> <15651.54044.557070.109158@notabene.cse.unsw.edu.au> <20020704075830.GQ21568@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> ...
> > We just want ext3/jbd to make sure that it only calls bh2jh on
> > an unlocked buffer... is that easy?
> 
> That's the question indeed, someone with a good grasp of jbd should make
> that call. If that is the only 'violator' (depending on your point of
> view), then yes lets just fix that up and say that the above is pb
> private is valid.

We really don't want to do this, please.  Changing things so
that we can only run bh2jh() and, particularly, journal_add_journal_head()
on a locked buffer would involve fairly unpleasant surgery against
parts of ext3 which are already prone to exploding.  Like
do_get_write_access().

If it was needed for 2.5 then hmm, maybe.  But as this is only a
2.4 problem then I really don't think we should risk breaking
or slowing down the filesystem for this.

Look, it's easy: delete buffer_head.b_inode (which is only used as 
a boolean), move its function to a b_state bit.  Add a new
buffer_head.ext3_hack and we can use that for pointing at the journal_head.

<insert "stable kernel" mantra here ;)>

-
