Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUCSXvk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUCSXvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:51:40 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16815 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263171AbUCSXvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:51:31 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 00:59:22 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com>
In-Reply-To: <405B2127.8090705@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403200059.22234.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 of March 2004 17:34, Jeff Garzik wrote:
> Jens Axboe wrote:
> > Cosmetic stuff that will get ironed out. You can find the patches here:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.5-rc1
> >-mm2/
> >
> > ide-barrier-2.6.5-rc1-mm2-1
> > 	ide/core part

Jens, am I right that you didn't do any changes/cleanups I asked you to do?
Here they are once again (probably some new items added as a bonus). ;-)

- do not use hwgroup->wrq (die!) and do not add drive->special_buf,
  just do what PM code does and other special commands do - use taskfile
  (yes, dirty stack allocation)

- SCSI -> IDE transform should die, please use something like REQ_FLUSH
  and let subsystems deal with it

- ide_get_error_location() is cool but clean other places doing same thing
  as you are duplicating existing code
  (please use u64 not sector_t - you are getting raw info from the disk)

- why does blkdev_issue_flush() add REQ_BLOCK_PC to rq->flags?

- why are we doing pre-flush?

> WRT ATA and flush-cache...  before the IDE pieces of this patch are
> merged, IMO it is a requirement that the entire flush-cache stuff gets a
> review.  ide_get_error_location() is one of the important pieces
> (great!).  Another important piece is to make sure that a drive's
> flush-cache capability is correctly deduced and set up from the
> identify-device.  The steps look like

Yep.

> - check identify-device word 83, bits 12 (flush cache) and 13 (flush
> cache ext)
> - issue set-features command to get flush-cache into proper state
> (enabled or disabled, as the user desires), if identify-device word 86
> indicates it is not already in the state you seek.
> - re-read identify [packet] device page from device, make sure
> flush-cache[-ext] is enabled.  A slacker could just make sure the
> set-features command completed successfully, but to be 100% correct you
> need to re-read the identify-device page.  :/

The fact that spec says "supported" not "enabled" in description of word86
makes me wonder - can they be disabled? (FLUSH CACHE is mandatory for General
feature set and FLUSH CACHE EXT is mandatory if 48-bit LBA is supported)

Jeff, please note that these bits were introduced by ATA-6 spec
and take a look at ATA-5 spec:

...
FLUSH CACHE
General feature set
- Mandatory for all devices
...

and ATA-4 spec:

...
FLUSH CACHE
General feature set
- Optional for all devices
...

IMO to test if FLUSH CACHE works we should just issue it during disk setup
and check result.  This way we can use FLUSH CACHE also on < ATA-6 devices
(there is a lot of them).

Cheers,
Bartlomiej

