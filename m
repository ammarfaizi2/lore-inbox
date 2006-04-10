Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWDJKzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWDJKzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWDJKzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:55:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751136AbWDJKzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:55:05 -0400
Date: Mon, 10 Apr 2006 02:54:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Slow swapon for big (12GB) swap
Message-Id: <20060410025419.65456ca9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0604101218380.31989@alpha.polcom.net>
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
	<20060410004030.5e48be79.akpm@osdl.org>
	<Pine.LNX.4.63.0604101218380.31989@alpha.polcom.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski <kangur@polcom.net> wrote:
>
> On Mon, 10 Apr 2006, Andrew Morton wrote:
> > Grzegorz Kulewski <kangur@polcom.net> wrote:
> >>
> >> I am using big swap here (as a backing for potentially huge tmpfs). And I
> >>  wonder why swapon on such big (like 12GB) swap takes about 7 minutes
> >>  (continuous disk IO).
> >
> > It's a bit quicker here:
> >
> > vmm:/usr/src/25# mkswap /dev/hda6
> > Setting up swapspace version 1, size = 54031826 kB
> > vmm:/usr/src/25# time swapon /dev/hda6
> > swapon /dev/hda6  0.00s user 0.04s system 74% cpu 0.054 total
> >
> >
> >> Is this expected?
> >
> > Nope.
> >
> >> Why it is like that?
> >
> > Are you using a swapfile or a swap partition?
> 
> Swap file.
> 
> 
> > If it's a swapfile then perhaps the filesystem is being inefficient in its
> > bmap() function.  Which filesystem is it?
> 
> Ext3.
> 

OK.  A 12G file is around 3000 indirect blocks.  At 10 milliseconds each
I'd expect it to take 30-odd seconds.  A 14G swapfile here takes 20 second
for swapon.

Maybe your disks are slow, or the fs is already quite full+fragmented.

I guess the only thing I can suggest is that you force the swapfile to put
its indirect blocks close together.  You can do that by writing one byte
at each 4MB interval:

	creat(swapfile);
	for (i = 0; i < swapfile_size / 4MB; i++)
		pwrite(fd, "\0", 1, i * 4MB);

then fill in all the holes:

  dd if=/dev/zero of=swapfile bs=4MB count=swapfile_size/4MB conv=notrunc

rather kludgy, and hopefully ext3 reservations won't defeat it.
