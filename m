Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSFYTsi>; Tue, 25 Jun 2002 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSFYTsh>; Tue, 25 Jun 2002 15:48:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313477AbSFYTsh>;
	Tue, 25 Jun 2002 15:48:37 -0400
Message-ID: <3D18C8C8.D35FF1A3@zip.com.au>
Date: Tue, 25 Jun 2002 12:47:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: efficient copy_to_user and copy_from_user routines in Linux Kernel
References: <3D18A26A.73E6DD07@zip.com.au> from "Andrew Morton" at Jun 25, 2 09:15:01 pm <200206251743.VAA00510@sex.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > I changed tcp to use a different copy if either source or dest were
> > not eight-byte aligned, and found that the resulting improvement
> > across a mixed networking load was only 1%.  Your numbers are higher,
> > so perhaps there are different alignments in the mix...
> 
> Did you look at sender or changed both of the functions?

I changed it to use csum_copy_from_user() instead of copy_from_user()
if the source and dest weren't 8-byte aligned.   No other changes
in there.   

> After that accident TCP was changed and it does not use copy_from_user more,
> it does copy_and_csum even when no checksum is required. So, his results
> on sender side (except for strange anomaly at msg size 8K) just confirm
> nil effect of copy_from_user.

Yup.

> What's about copy_to_user, we forgot about this at all,
> worrying mostly about sender side. :-)

We didn't really forget, but we were trying to get a 2.4 kernel out,
so it became a "fix in 2.5" item.  You're right, we should fix it in
2.4.

I wrote a little app to test this - it times a couple of copy algorithms
at all possible alignments.  It may be useful for someone...  http://www.zip.com.au/~akpm/linux/cptimer.tar.gz
I think it covers everything - uncached/cache source/dest,
all possible transfer alignemnts.

The cost of getting it wrong is, iirc, 40% slowdown.  In the
kernel's single most expensive function.

-
