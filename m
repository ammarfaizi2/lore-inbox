Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRKMPJX>; Tue, 13 Nov 2001 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279846AbRKMPJP>; Tue, 13 Nov 2001 10:09:15 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:2054 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S279822AbRKMPJC>;
	Tue, 13 Nov 2001 10:09:02 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111131508.fADF8Yi09728@oboe.it.uc3m.es>
Subject: Re: what is teh current meaning of blk_size?
In-Reply-To: From (env: ptb) at "Nov 12, 2001 11:10:44 pm"
To: ptb@it.uc3m.es
Date: Tue, 13 Nov 2001 16:08:34 +0100 (MET)
Cc: dalecki@evision.ag, "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"ptb wrote:"
> "Martin Dalecki wrote:"
> > "Peter T. Breuer" wrote:
> > > Is blk_size[][] supposed to contain the size in KB or blocks?
> > There is no rumor it's in blocks.

Nevertheless, experiments on 2.4.3 appear to show it is still in KB
there.

> Uh, thanks! I was looking at fs/block_dev.c.
> 
>  if (blk_size[MAJOR(dev)])
>   size = ((loff_t) blk_size[MAJOR(dev)][MINOR(dev)] << BLOCK_SIZE_BITS) >> blocksize_bits;
> 
> which sets the size to the entered blk_size << 10 - blksize_bits.
> 
> I missed that BLOCK_SIZE_BITS was constant but blksize_bits is variable.
> Amongst other things.

Thing is, in my driver I have now chenged from setting blk_size to be in KB
and put it in blocks instead (while keeping the blksize the same) and
the result is that using lseek, the device measures to be 1/4 the size
it really is. This is in kernel 2.4.3.

If in look in ll_rw_blk.c, I see, for example:

 if (blk_size[major]) {
   unsigned long maxsector = (blk_size[major][MINOR(bh->b_rdev)] << 1) + 1;
   // (ptb) 1ST SECTOR BEYOND END OF DISK

which implies to me that blk_size is still in KB there. 

BTW, I don't know why there should be a +1 at the end. The code goes on
to say:

      unsigned long sector = bh->b_rsector;   // (ptb) 1ST SECTOR ON DISK
      unsigned int count = bh->b_size >> 9;   // (ptb) SECTORS IN BUFFER

      if (maxsector < count || maxsector - count < sector) {
            bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
            ... good stuff ...

So we look for the nr sectors  in the buffer to be _greater_than_
the number of sectors in the device _plus 1_. It should be
_greater_than_or_equal_to ... _plus_1_. But even so it's meaningless.
What we want is to check to see if the buffer contents will overflow
the disk.

I'm not too sure about the other half of the condition either. This 
is surely what I mentioned above: sector + count > maxsector?

But again it should be >=.  If we are on sector 0 of a 2 sector disk,
and we try and write 3 sectors, then sector=0, count=3, and maxsector=3,
and 0+3 /> 3, so the condition would not trigger, while we want it to.
So it should be >=, not >.

I believe the 1st check is merely a faster calculation and is backed up
by the second check. However, the second check must be right!


> > OK I was to fast to figure it out:
> > 
> > /*
> >  * blk_size contains the size of all block-devices in units of 1024 byte
> >  * sectors:
> 
> But this is not so .. it is the default, not the rule. And it is only
> the default if the block size is the default value.
> 
> > int * blk_size[MAX_BLKDEV];
> > 
> > /*
> >  * blksize_size contains the size of all block-devices:
> 
> Err .... they mean the BLOCK SIZE of all ...

> If you knew if the meaning of blk_size had ever changed, and when in
> terms of kernel version, that would also be very very helpful.


Peter
