Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130148AbRBNAV6>; Tue, 13 Feb 2001 19:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbRBNAVs>; Tue, 13 Feb 2001 19:21:48 -0500
Received: from colorfullife.com ([216.156.138.34]:54536 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130148AbRBNAVf>;
	Tue, 13 Feb 2001 19:21:35 -0500
Message-ID: <3A89CF93.A934C473@colorfullife.com>
Date: Wed, 14 Feb 2001 01:21:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Michael E Brown <michael_e_brown@dell.com>
CC: Andries.Brouwer@cwi.nl, Matt_Domsch@exchange.dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <Pine.LNX.4.30.0102131718560.26922-100000@blap.linuxdev.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael E Brown wrote:
> 
> >
> > Anyway, an ioctl just to read the last sector is too silly.
> > An ioctl to change the blocksize is more reasonable.
> 
> That may be better, I don't know. That's why this is an RFC. Are there any
> possible races with that method? It seems to me that you might adversely
> affect io in progress by changing the blocksize. The method demonstrated
> in this patch shouldn't do that.
>
block size changing is dangerous:
if you change the blocksize of a mounted partition you'll disrupt the
filesystem.
some kernels crash hard if you execute

	swapon /dev/<insert your root device>

swapon won't overwrite your root fs: it changes the blocksize to 4kB and
then notices that there is no swap signature.
But the blocksize change is fatal.

> > And I expect that this fixed blocksize will go soon.
>
that's 2.5.

> That may be, I don't know that much about the block layer. All I know is
> that, with the current structure, I cannot read or write to sectors where
> (sector #) > total-disk-blocks - (total-disk-blocks /
> (softblocksize/hardblocksize))
>
I have one additional user space only idea:
have you tried raw-io? bind a raw device to the partition, IIRC raw-io
is always in 512 byte units.

Probably an ioctl is the better idea, but I'd use absolute sector
numbers (not relative to the end), and obviously 64-bit sector numbers -
2 TB isn't that far away.

--
	Manfred
