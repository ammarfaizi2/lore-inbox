Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317377AbSGDIhj>; Thu, 4 Jul 2002 04:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317376AbSGDIhi>; Thu, 4 Jul 2002 04:37:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15014 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317377AbSGDIhh>;
	Thu, 4 Jul 2002 04:37:37 -0400
Date: Thu, 4 Jul 2002 10:39:41 +0200
From: Jens Axboe <axboe@kernel.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020704083941.GA6204@suse.de>
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de> <20020703120124.GB615@fib011235813.fsnet.co.uk> <20020703121024.GC21568@suse.de> <15651.54044.557070.109158@notabene.cse.unsw.edu.au> <20020704075830.GQ21568@suse.de> <3D2409FA.44E88C1D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2409FA.44E88C1D@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > ...
> > > We just want ext3/jbd to make sure that it only calls bh2jh on
> > > an unlocked buffer... is that easy?
> > 
> > That's the question indeed, someone with a good grasp of jbd should make
> > that call. If that is the only 'violator' (depending on your point of
> > view), then yes lets just fix that up and say that the above is pb
> > private is valid.
> 
> We really don't want to do this, please.  Changing things so
> that we can only run bh2jh() and, particularly, journal_add_journal_head()
> on a locked buffer would involve fairly unpleasant surgery against
> parts of ext3 which are already prone to exploding.  Like
> do_get_write_access().
> 
> If it was needed for 2.5 then hmm, maybe.  But as this is only a
> 2.4 problem then I really don't think we should risk breaking
> or slowing down the filesystem for this.
> 
> Look, it's easy: delete buffer_head.b_inode (which is only used as 
> a boolean), move its function to a b_state bit.  Add a new
> buffer_head.ext3_hack and we can use that for pointing at the journal_head.

Thank you, this is what I was looking for (if you look further up, I was
advocating this very thing). Slimming down buffer_head and just add the
ext3 hack is perfectly acceptable to me.

Which just means that device mapper needs to do the stacking properly,
EOD.

-- 
Jens Axboe

