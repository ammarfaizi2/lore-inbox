Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132700AbRDIHdh>; Mon, 9 Apr 2001 03:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbRDIHd1>; Mon, 9 Apr 2001 03:33:27 -0400
Received: from [166.70.28.69] ([166.70.28.69]:7508 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132700AbRDIHdN>;
	Mon, 9 Apr 2001 03:33:13 -0400
To: Russell Coker <russell@coker.com.au>
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: struct stat{st_blksize} for /dev entries in 2.4.3
In-Reply-To: <01040823491919.25703@lyta>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Apr 2001 01:32:05 -0600
In-Reply-To: Russell Coker's message of "Sun, 8 Apr 2001 23:49:19 +1000"
Message-ID: <m1puemv896.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Coker <russell@coker.com.au> writes:

> When you stat() the files under /dev the st_blksize is returned as 1024 
> bytes.  Currently cat will look at the input block size and the output block 
> size and use the maximum of them as it's buffer size.  I believe that 
> programs such as cat should never use a buffer size smaller than a page of 
> memory and reported this as a bug in cat.

Hmm. I can't agree with that, at least not all of the way.  I suspect
there are some character devices that do I/O in small chunks for which
a small block size is preferable.  The old latency version bandwidth issue.
Plus this assumes an linux like architecture.  With a different
structure to the code who knows where the tradeoffs fall.

In particular consider where the tradeoffs go if we increase the
internal PAGE_SIZE but not the external one.  So I think we really
need to fix stat!

However it looks like you aren't using ext2 for root.  

Currently looking at 2.4.2 source I see the following things.
1) cp_new_stat is broken, if you don't set st_blksize in your
   filesystem.  It appears to be counting 1K blocks base on filesize.
   st_blocks is always in multiples of 512 bytes.

2) The st_blksize comes out of the inode structure, and it looks 
   currently the device layer doesn't set it so it gets left at
   whatever the filesystem sets this to.  This is PAGE_SIZE for ext2.
   Which filesystem are you runnning?

> 
> Now I would like some comments on the following issues:
> Is this a bug in cat regardless of whether the behaviour of the kernel is 
> right or wrong?  I have attached a patch for cat in case it is determined 
> that cat is buggy.

Unless you can prove that PAGE_SIZE is a determining factor of I/O
efficiency on all possible architectures I don't see a problem with
cat.

> Regardless of whether cat is doing the right thing or not, does it make sense 
> for the st_blksize of /dev/* to be 1024 bytes?  Or should it be
> 4096?

Hmm.  I think we might want to be even smarter than that, but as a
first approximation yes it should be PAGE_SIZE.

> My understanding is that the st_blksize is the recommended IO size (not 
> mandatory).  So it shouldn't break anything if this is set to a minimum of 
> the page size.  But setting it to the page size will hint that applications 
> should use a page as the minimum IO block size and cause some applications to 
> deliver better performance.

Correct.  Changing st_blksize should not break any correct program.

Eric
