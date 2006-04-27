Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWD0J2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWD0J2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 05:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWD0J2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 05:28:15 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:27517 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S965021AbWD0J2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 05:28:14 -0400
Date: Thu, 27 Apr 2006 11:28:12 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Mark Lord <lkml@rtr.ca>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in handling medium errors
Message-ID: <20060427092812.GA25867@bitwizard.nl>
References: <200604261627.29419.lkml@rtr.ca> <1146092161.12914.3.camel@mulgrave.il.steeleye.com> <20060426161444.423a8296.akpm@osdl.org> <44500033.3010605@rtr.ca> <20060426163536.6f7bff77.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426163536.6f7bff77.akpm@osdl.org>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 04:35:36PM -0700, Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
> >
> > > That's if we think -stable needs this fixed.
> > 
> > Let's say a bunch of read bio's get coalesced into a single
> > 200+ sector request.  This then fails on one single bad sector
> > out of the 200+.  Without the patch, there is a very good chance
> > that sd.c will simply fail the entire request, all 200+ sectors.
> > 
> > With the patch, it will fail the first block, and then retry
> > the remaining blocks.  And repeat this until something works,
> > or until everything has failed one by one.
> 
> Yowch.  I have the feeling that this'll take our EIO-handling time from
> far-too-long to far-too-long*200.

Whoa! Can't get worse. 

Hmm. OK. Maybe it can. It seems that IDE at least used to do the
"*200" behaviour.

I now issue a read for (1k-)block 1024 on my disk, which has blocks
1024 ... 1536 being bad. Kernel has decided i'm doing linear reads, so
it will issue a readahead for 1024-1536. 

I then don't want to have the kernel continue the 1025-1536 readahead.

Also, if just block 1027 is bad, a normal read of block 1024 will read
the page 1024-1027, and return EIO on 1024 because it couldn't read
the whole page. We've learned to live with this, but if you guys are
going to look into it, keep this in mind, please.... 

> It's moderately hard to test, though.  Easy enough for DVDs and CDs,
> but it's harder to take a marker pen to a hard drive.

I (accidentally) scratched a SCSI drive with a paperclip some weeks
ago. 65 bad blocks. (36 files hurt). I did manage to use the paperclip
to push the metal part that had fallen off the inside of the drive
somewhere to a spot where I could remove it. That metal part was
preventing the head from leaving the parking zone. 

Anyway, I have enough disks with bad blocks that I can make the
following offer: Serious kernel developpers that need a
drive-with-bad-blocks for testing should submit their snail-mail
address. I'll see what I can do. (Specify SCSI or IDE or both). 

	Roger Wolff
	R.E.Wolff@harddisk-recovery.nl

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
