Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRKNUla>; Wed, 14 Nov 2001 15:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKNUlU>; Wed, 14 Nov 2001 15:41:20 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:10767 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S277435AbRKNUlN>;
	Wed, 14 Nov 2001 15:41:13 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111142041.fAEKfBN15594@oboe.it.uc3m.es>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
In-Reply-To: <3BF23D01.F7E879E8@evision-ventures.com> from "Martin Dalecki" at
 "Nov 14, 2001 10:44:33 am"
To: dalecki@evision.ag
Date: Wed, 14 Nov 2001 21:41:11 +0100 (MET)
Cc: ptb@it.uc3m.es, "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Dalecki wrote:"
> "Peter T. Breuer" wrote:
> > 
> > Let me put it more plainly.  Martin Daleki + rumour assures me that the
> > blk_size array nowadays measure in blocks not KB, yet to me it seems that
> 
> sectors = 512 per default
> blocks = 1024 per default.

I know that! But it's irrelevant. What I need to know is if blk_size is
still counting in KB, or if it has switched to blocks.

> Never said anything else.

Err .. you said that blk_size is now measured in blocks, not KB. You
said thet the rumour is true.

  "A month of sundays ago Martin Dalecki wrote:"
  > "Peter T. Breuer" wrote:
  > > Is blk_size[][] supposed to contain the size in KB or blocks?
  > There is no rumor it's in blocks.

Maybe I misinterpret what you write. I interpret it as meaning "the
rumour is not a rumour but a fact. It is in blocks".

> Look at the initialization point for the arrays. They all use constants
> which you can look up in the kernel headers.

I _know_ that. It's irrelevant.

The point is that if blk_size counts in KB, then the size of a device
cannot reach more that 2^32 * 2^10 = 2^42 = 4TB.  I'd personally say
2TB, becuase the int blk_size number is signed.

That's rumoured not to be the case, and the max size of a device is
supposed to be about 8 to 16TB. Let's suppose the rumour is true ..

So we deduce that one has to assign a different meaning for the blk_size
array. "count in blocks" is how the rumour goes. That way you can get
4 times higher sizes .. all the way to 8 or 16TB per device. And this
is what is rumoured to be the case.

Is it or is it not so? A straight answer from the list would be nice!

> ./linux/fs.h:#define BLOCK_SIZE_BITS 10
> ./linux/fs.h:#define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)

These are _defaults_ for _blksize_. Sure you can change it as you like,
but according to the "blk_size is in KB" hypothesis, this matters not one
iota to the size limit on devices.  Change blksize  and size does not
change. But according to the "blk_size is in blocks" hypothesis, yes
changing blksize will change the size of the device. Testing shows
that scenario "blk_size is in KB" is true.

Am I making plain the difference between blk_size and blksize?

blk_size is the number of blocks or KB (which?) in a device. blksize is
the size of the blocks. Is blk_size in KB or blocks?

It should be in blocks if the size of a device is to reach 8 or 16TB.
If it is in KB, we are limited to 2 or 4TB.

> Which means 1024 bytes for blk_size as default value.

But so what? That doesn't answer the question of whether blk_size
is in blocks or not.


> > it doesn't.  Look at this code from ll_rw_blk.c in 2.4.[14]:

Look at it:

  if (blk_size[major])
     minorsize = blk_size[major][MINOR(bh->b_rdev)];
     if (minorsize) {
        unsigned long maxsector = (minorsize << 1) + 1;

This clearly hardcodes blk_size as measuring in units of 2 sectors, no
matter what we set for blksize.  It should be, in my view

  unsigned long maxsector =
     minorsize * blksize_size[major][MINOR(bh->b_rdev] + 1;

or no device can be larger than 4TB. And neither can a filesystem, and
neither can a file ...

Now, I know I can write my own generic_make_request() code, but I have
no intention of maintaining it through different kernel versions just 
to get the right size measurement. Besides, it's everyone's problem.

Persuade me that this is not a bug, and an important one at that :-)
Hellloooooo everybody! Linux cannot manage partitions greater than
4TB, ha ha ha hhhhhaaaa! ;-)

I at least am getting up to devicesizes at the 8TB range.

Best wishes!
 
Peter
