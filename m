Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSFDN6E>; Tue, 4 Jun 2002 09:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSFDN6D>; Tue, 4 Jun 2002 09:58:03 -0400
Received: from [213.237.118.153] ([213.237.118.153]:32385 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S293203AbSFDN6C>;
	Tue, 4 Jun 2002 09:58:02 -0400
From: Allan Sandfeld <linux@sneulv.dk>
To: Kasper Dupont <kasperd@daimi.au.dk>
Subject: Re: RAID-6 support in kernel?
Date: Tue, 4 Jun 2002 15:58:12 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <Pine.LNX.4.33.0206031025400.30424-100000@mail.pronto.tv> <200206041311.03631.linux@sneulv.dk> <3CFCB7D1.5A09615E@daimi.au.dk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206041558.12209.linux@sneulv.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 14:51, Kasper Dupont wrote:
> Allan Sandfeld wrote:
> > On Monday 03 June 2002 10:57, Kasper Dupont wrote:
> > > Roy Sigurd Karlsbakk wrote:
> > > > > > RAID-6 layout: http://www.acnc.com/04_01_06.html
> > > > >
> > > > > If it is supposed to survive two arbitrary disk failures something
> > > > > is wrong with that figure. They store 12 logical sectors in 20
> > > > > physical sectors across 4 drives. With two lost disks there are 10
> > > > > physical sectors left from which we want to reconstruct 12 logical
> > > > > sectors. That is impossible.
> > > >
> > > > Might be the diagram is wrong.
> > >
> > > Could be the case, so until I find another description I will
> > > still not know how RAID-6 works.
> >
> > It's not just the diagram, the theory is wrong. You need to use at least
> > log2 n+1 disks for partition if you want to handle any two lost/borked
> > disks. (16 disks would give 11x diskspace).
>
> But there are other encodings with 2 extra disks that can
> handle 2 lost disks. And in general if you need x disks of
> space and the ability to recover from y lost disks you can
> do the encoding on x+y disks.
>
> Knowing that why do we even consider RAID-6? I guess RAID-6
> is a lot faster, is that true?

I just looked at it. It is possible allright and the diagram looks ok.

If you have 3 disks A,B and C the parity is calculated by dividing the diskw 
into typical lines, in this example I use 3 like they use on the diagram. We 
then have a parity per line and one per disk. You can only regenerate one 
block per parity, but since you have two full independ parities you can 
replace any two. 

  A1 B1 C1 P1 (P1 = A1^B1^C1)
  A2 B2 C2 P2
  A3 B3 C3 P3
  PA PB PC 
 (PA=A1^A2^A3)

As you can see if you wish to chech the parity for one read line(eg.A1-C1), 
you can check directly against the horizontal parity P1. But if you wish to 
check the horizontal parity you need to read the entire diskarray!

In reality I think one would only check the horizontal parity on reads,  
giving you protection against 1 disk-errors, and only use the vertical parity 
in case you need to regenerate a two lost disks. 
The real problem is on each writes you still need to access at least one full 
disk, and possibly all disks. As they write: there are no know commercial 
implementations. I wonder why!
