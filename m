Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBTXDC>; Tue, 20 Feb 2001 18:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbRBTXCw>; Tue, 20 Feb 2001 18:02:52 -0500
Received: from sub19-210.member.dsl-only.net ([63.105.19.210]:24068 "HELO
	thalvors.miralink.com") by vger.kernel.org with SMTP
	id <S129107AbRBTXCj>; Tue, 20 Feb 2001 18:02:39 -0500
Date: Tue, 20 Feb 2001 15:02:15 -0800 (PST)
From: Tracy Camp <campt@thalvors.miralink.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Assistance in understanding this...?
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE079@orsmsx31.jf.intel.com>
Message-ID: <Pine.LNX.4.21.0102201450440.582-100000@thalvors.miralink.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Tracy-
> 
> There was a recent thread about ext2fs-- it was
> something like doing a format of a large ext2 fs
> could cause the VM to run out of memory.
> The solution is to do a sync() calls every 10 (pick
> a number) writes so that they get flushed to disk
> and that memory can be reused.

So I'm using 2.4.1 now (on advice given by Alan Cox on the lkml related to
the ext2 fs problems talked about in the lkml archive based on the belief
that the vm was fixed in some manner related to these crashes).  The same
code as below and the same problems.  I changed the brelse() call to
bforget() - same deal except that the memory dedicated to buffers remains
constant.  It is my understanding that when calling
wait_on_buffer(bh) this in effect makes sure the operation has been
committed to disk and will give you the same result as performing a
sync().  I can trigger panics during the operation or after
the operation - the fragility seems to remain persistent.  Panic's seem to
quite consistently be 'unable to handle kernel paging request at <some
address>' or of the 'unable to handle kernel NULL pointer dereference at
virtual address <some address>' nature.

Any other suggestions?

t.

> 
> See
> http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-07/0902.html.
> 
> HTH.
> ~Randy_________________________________________
> |NOTE: Any views presented here are mine alone|
> |& may not represent the views of my employer.|
> -----------------------------------------------
> 
> > From: Tracy Camp [mailto:campt@thalvors.miralink.com]
> > 
> > I'm developing a driver that performs some 'formatting' of 
> > sorts on a scsi
> > block device as part of the initialization process.  This involves
> > writting a long series of non-contiguous blocks to a disk device -
> > something akin to:
> > 
> > for(i =0; i < NUM_BLOCKS; i++) {
> > 	bh = getblk(i * offset_size);
> > 	memcpy(bh->b_data,&somestructure,sizeof(struct somestruct));
> > 	mark_buffer_dirty(bh);
> > 	ll_rw_block(bh, WRITE,1);
> > 	wait_on_buffer(bh);
> > 	brelse(bh);
> > 	}
> > 
> > the kernel here I should mention is stock 2.4.0
> > 
> > This all works fine it seems, except that after awhile the 
> > system becomes
> > very fragile and eventually panic's with a NULL pointer 
> > derefrence.  This
> > presumeably occurs because of a resource shortage.  Thing I'm not
> > understand is how doing the above even for a large value of NUM_BLOCKS
> > creates a resource shortage.  I'm obviously missing something here....
> > 
> > This is typically triggered by running any external program, 
> > (ie. vi, top,
> > or gcc seem to work fine for this). and the only noticable 
> > thing is that
> > the memory allocated to buffers grows to be pretty much all 
> > memory except
> > for the last two megs - this seems normal?  I can capture some of the
> > panic/dumps if anyone thinks they might be of interest.  
> > 
> > Ideas?
> > 
> > t.
> > 

Tracy Camp
Product Development
Miralink Corp.PDX
Portland OR
503-223-3140


