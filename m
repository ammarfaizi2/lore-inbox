Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318376AbSGYIjs>; Thu, 25 Jul 2002 04:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318377AbSGYIjs>; Thu, 25 Jul 2002 04:39:48 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:35280 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318376AbSGYIjr>; Thu, 25 Jul 2002 04:39:47 -0400
Message-Id: <5.1.0.14.2.20020725092538.00b0bd30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Jul 2002 09:43:08 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: 2.5.28 and partitions
Cc: Alexander Viro <viro@math.psu.edu>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0207242213540.1231-100000@home.transmeta.com
 >
References: <5.1.0.14.2.20020725030051.02114cb0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:15 25/07/02, Linus Torvalds wrote:
>On Thu, 25 Jul 2002, Anton Altaparmakov wrote:
> >
> > >u64 for sector_t doesn't change anything for 64bit boxen that might be
> > >interested in really large disks and screws 32bit ones that shouldn't
> > >have to pay for that...
> >
> > True. That's why sector_t should be a compile time option in the kernel
> > "Enable large device support > 2TiB:  Y/N". Then I am happy and loads of
> > other people because we can use large raid arrays without having to buy the
> > latest expensive system and other people are happy for having faster 32-bit
> > code... Surely we can write robust enough code which will work with either
> > sector_t size...
>
>Careful. One issue is user-level interfaces to the kernel. I would suggest
>any user level interface should use u64, not "sector_t". So that there is
>zero confusion. Clearly 64-bit sector numbers will be/are really close to
>being an issue for some people.

Of course. We do need a consistent ABI... But I don't see that as a big 
problem. There aren't that many places that take sectors as arguments that 
we need to fix AFAICS.

Both there and for user supplied byte offsets/sizes, we just need to check 
that user supplied values are not being overflowed on 32-bit sector_t 
compiled kernels... something like

         if (sizeof(sector_t) == 4) {
                 if (value & ~(((u64)1 << 32) - 1))
                         return -E2BIG;
         }

should compile out nicely for 64-bit sector_t and provide a simple, highly 
optimized check for 32-bit sector_t... (If gcc optimizes it well I should 
hope it will just do a simple 32-bit compare of the high 32-bits with zero...)

I have to admit that if it was just up to me, I would make sector_t 
unconditionally u64, so there don't need to be checks like the above all 
over the place... But that's just me... (-;

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

