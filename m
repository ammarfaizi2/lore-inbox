Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUELVG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUELVG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUELVGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:06:37 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56018 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265237AbUELVEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:04:44 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Date: Wed, 12 May 2004 23:05:47 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rene Herman <rene.herman@keyaccess.nl>, Alan Cox <alan@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <fa.jr282gn.1ni2t37@ifi.uio.no> <008201c437e7$b1a35160$6601a8c0@northbrook> <20040512185224.GA2658@bounceswoosh.org>
In-Reply-To: <20040512185224.GA2658@bounceswoosh.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405122305.47874.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Rene, Alan, Arjan, Andrew and Linus added to cc: ]

On Wednesday 12 of May 2004 20:52, Eric D. Mudama wrote:
> On Wed, May 12 at  0:09, Robert Hancock wrote:
> >If this is indeed the case, that those drives don't support the "flush
> > write cache" command, I'd like to see Maxtor's excuse as to why.. I
> > believe that Windows always powers down IDE drives before shutdown, maybe
> > this is because of non-universal support for the "flush write cache"
> > command?
>
> The issue is a bit more subtle, and I'm not making an "excuse" per
> say...
>
> (Not speaking officially for Maxtor, but I'm just trying to help...)
>
>
> As per the email I got from Bart, the drive in question doesn't
> support 48-bit commands.  The wierdness is that it claims to support
> the FLUSH CACHE EXT (0xEA) command.  Obviously, this combination
> doesn't make it safe to issue FLUSH CACHE EXT since the drive will not
> be able to properly report a failing location in the event of a
> failure to flush due to a fatal write fault.  The drive knows a FLUSH
> CACHE EXT command isn't safe, so it aborts that command which is the
> error message you see.
>
> The code that Bart showed me does a '&' on the feature word with the
> required support bits, but uses the result in an 'if' conditional.  I
> believe that means that in C, if either of the bits is set, then the
> 'if' will evaluate to true, which is causing the problem.
>
> The solution (that should work for all drives) would be to test
> properly to make sure the drive reports support for both 48-bit
> commands and FLUSH CACHE EXT, with something like:
>
>   if ((feature & bits) == bits)
>
> then issue that command.  If *either* of these bits is false, then the
> drive should be issued a normal FLUSH CACHE (0xE7) command (which is a
> reasonably standard 28-bit command, and all Maxtor drives support,
> including the models in question.)

Yes, this should work.  Thanks Eric.

The other part of the story is a nasty bug in ide-disk.c driver:

write_cache() is called with (drive->id->cfs_enable_2 & 0x300) as argument
'arg' of type 'int' and then this value is assigned to the 'drive->wcache'
of type 'unsigned char' so drive->wcache == 0 because 0x3000 gets truncated.

This bug has been present since introduction of drive->wcache (2.5.3),
therefore we have never handled cache flush correctly before and never
hit '& 0x2400' problem before.

Linus & Alan, you were almost right after all, drive->wcache was almost
always zero for normal disks before 2.6.6.  It could be forced by user but
only for disks having ATA-6 cache flush bits and was auto-set but only for
removable disks (after Alan's fixes in 2.6.65).  You lucky b*st*rds.  ;-)

Rene, that's why wcache is 0 in /proc/ide/hdX/settings for older kernels
or with my 'bandaid' fixes for 2.6.6.  'hdparm -W1' should work but only on
quite recent drives (having ATA-6 bits).  However I don't know why you get
regression in tiobench, we still need to explain this.

Andrew, I will send some patches to you today/tomorrow.

> Note that this only affects newer drives (last 18 months or so) that
> are <120GB. (Yes, I know that is still a truckload)
>
> There are a gazillion of these in the field (we sell ~60 million
> drives/year?) so I don't believe a firmware "upgrade" or equivalent
> simply is logistically possible, but this inconsistency is going to be
> addressed in future products, I'm making sure of it.

Yep, I don't think firmware 'upgrade' is needed/feasable.

Cheers.

