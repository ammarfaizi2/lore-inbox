Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSGZF3p>; Fri, 26 Jul 2002 01:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGZF3o>; Fri, 26 Jul 2002 01:29:44 -0400
Received: from dsl-213-023-043-040.arcor-ip.net ([213.23.43.40]:24796 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316845AbSGZF3o>;
	Fri, 26 Jul 2002 01:29:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "David Luyer" <david@luyer.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.18-rc3-ac3: bug with using whole disks as filesystems
Date: Fri, 26 Jul 2002 07:33:59 +0200
X-Mailer: KMail [version 1.3.2]
References: <004a01c233ba$1a764f50$638317d2@pacific.net.au>
In-Reply-To: <004a01c233ba$1a764f50$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Xxjj-0005XT-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 July 2002 11:03, David Luyer wrote:
> Followup to my own post:
> > I attempted to mkfs and use a whole disk rather than a partition
> > with reiserfs.  It failed (not a major problem, I'll just make a
> > partition), but it failed with a "kernel BUG" message, so here 'tis.

It was this BUG no doubt (buffer.c):

2398         /* Size must be within 512 bytes and PAGE_SIZE */
2399         if (size < 512 || size > PAGE_SIZE)
2400                 BUG();

> > Original commands to cause failure:
> >   mkfs -b 8192 /dev/sdb -f
> >   mount /dev/sdb /cache
> 
> Actually looks like the -b 8192 was the problem, the same happened
> on /dev/sdb1.  Had to reboot again after that as mount was hanging
> in the same way as cfdisk had previously.  Similar 'kernel BUG'
> message resulted.

It's Reiserfs's fault all right, for not recognizing the fact that
the kernel can't handle blocksize larger than the hard PAGE_SIZE.
Good thing the BUG is there now, it used to fail silently.

There is no fundamental reason why we can't handled the larger
blocksizes.  It just didn't make it to the top of the list of things
to do for this cycle.  For now, all the mkfs's have to accomodate
this shortcoming.

-- 
Daniel
