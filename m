Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSG1Suh>; Sun, 28 Jul 2002 14:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSG1Sug>; Sun, 28 Jul 2002 14:50:36 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:31711 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317189AbSG1SuY>; Sun, 28 Jul 2002 14:50:24 -0400
Message-Id: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 28 Jul 2002 19:54:03 +0100
To: ebiederm@xmission.com (Eric W. Biederman)
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of 
  PAGE_{CACHE_,}{MASK,ALIGN}
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m11y9nivrg.fsf@frodo.biederman.org>
References: <3D42D706.9899A4A0@zip.com.au>
 <E17YRp5-0006H6-00@storm.christs.cam.ac.uk>
 <3D42D706.9899A4A0@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:53 28/07/02, Eric W. Biederman wrote:
>Andrew Morton <akpm@zip.com.au> writes:
> > Anton Altaparmakov wrote:
> > >
> > > Linus,
> > >
> > > This patch introduces 64-bit versions of PAGE_{CACHE_,}MASK and
> > > PAGE_{CACHE_,}ALIGN:
> > >         PAGE_{CACHE_,}MASK_LL and PAGE_{CACHE_,}ALIGN_LL.
> > >
> > > These are needed when 64-bit values are worked with on 32-bit
> > > architectures, otherwise the high 32-bits are destroyed.
> > >
> > > ...
> > >  #define PAGE_SIZE      (1UL << PAGE_SHIFT)
> > >  #define PAGE_MASK      (~(PAGE_SIZE-1))
> > > +#define PAGE_MASK_LL   (~(u64)(PAGE_SIZE-1))
> >
> > The problem here is that we've explicitly forced the
> > PAGE_foo type to unsigned long.
> >
> > If we instead take the "UL" out of PAGE_SIZE altogether,
> > the compiler can then promote the type of PAGE_SIZE and PAGE_MASK
> > to the widest type being used in the expression (ie: long long)
> > and everything should work.
> >
> > Which seems to be a much cleaner solution, if it works.
> >
> > Will it work?

I will reply to that point later, I want to do some experiments with gcc 
first... I think it may work due to signextension but that implies the 
value must be signed which is of course implied by leaving out the "UL"... 
I will try it and report results...

>I don't quite see the point of this work.
>
>There is exactly one operation that must be done in 64bit.
>if (my64bitval > max) {
>         return -E2BIG;
>}
>After that the value can be broken into, an index/offset pair.
>Which is how the data is used in the page cache.

Why should I need to bother with index/offset? It is much more natural to 
work with bytes. Also ntfs has to convert back and forth to bytes (internal 
NTFS storage for sizes is s64 in units of bytes in many places), ntfs 
clusters, pages, and buffer heads which are all different sizes so your 
approach would be a complete code mess.

Also the page cache limit of 32-bit index is IMO not good and needs to be 
removed. The code needs to be able to cope with true 64-bits. We already 
have sector_t that can be defined to 64-bit. Once it is used everywhere it 
will be relatively easy to do something simillar for struct page. Of course 
people are going to scream so it will just be a compile time option. Or 
even just an out of tree patch but still I consider 64-bit support on 
32-bit architectures very important in the future and I belive I am not 
alone seeing Matt Domsch (sp?)'s comments for example... I guess it boils 
down to how quickly the 64-bit cpus will become standard comodity hardware 
vs how quick available storage will blow the 32-bit page cache limit...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

