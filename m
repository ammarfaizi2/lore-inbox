Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316603AbSFGCLO>; Thu, 6 Jun 2002 22:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSFGCLN>; Thu, 6 Jun 2002 22:11:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62984 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316603AbSFGCLM>;
	Thu, 6 Jun 2002 22:11:12 -0400
Message-ID: <3D001717.AE38D980@zip.com.au>
Date: Thu, 06 Jun 2002 19:14:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's 
 bigger than queue could handle
In-Reply-To: <200206062326.QAA00602@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         Here is version 4 of my changes to fs/bio.c (ll_rw_kio) and
> fs/mpage.c.  Andrew, I believe it this accomodates all of your
> requests.  Please let me know if I missed anything.  If it looks
> good, I would apperciate your recommendation on how to proceed with
> getting this into Linus's tree.

mpage stuff looks good.

We need to wake Jens up before going any further.  (The test
for ->max_sectors != 0 look funny).

The main issue is that this code will now permit really
big BIOs.  Up to a megabyte.  That'll work OK on just-a-disk,
but apparently ->max_sectors isn't worth squat for stacked
devices.

Back in March I was told "That's why BIO_MAX_SIZE exists. It's the
size it is due to typical hardware restrictions :-/".  Well,
we see here that your Smart2 RAID controller has just blown that
idea out of the water.

Also this:

:> Actually: what about the case where we're not using any device
:> stacking at all?  Where we're just talking to a plain old
:> disk?  That's a common case, and it's worth optimising for.
:
:That would be doable. Just require stacking drivers to mark the queue as
:such -- so md etc would do something ala blk_queue_stacked(q) and that
:would just set the QUEUE_FLAG_STACKED flag. Then we know that
:q->max_sectors indeed can be trusted completely.

Now this idea would let us assemble large BIOs nicely against
"just a disk".  But we'd still need BIO_MAX_SIZE, and your
RAID controller will still explode when stacked upon.

What you can do short-term is (yech) teach bio_max_iovecs() to
not return a value greater than 64 kbytes.

Longer term, we really need a way of propagating the "max request size"
info up the stack.  At a minimum we need to do this statically.

Ideally we do it dynamically, passing in the starting sector, so
we can calculate the maximum-sized BIO correctly each time and
we never need to get into BIO-splitting horrors.

-
