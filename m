Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVLTUja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVLTUja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLTUja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:39:30 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:24401 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932084AbVLTUja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:39:30 -0500
Date: Tue, 20 Dec 2005 15:38:50 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
In-reply-to: <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1135111130.16754.23.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051219195014.GA13578@swissdisk.com>
 <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org> <20051220174948.GP3734@suse.de>
 <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 10:08 -0800, Linus Torvalds wrote:
> 
> On Tue, 20 Dec 2005, Jens Axboe wrote:
> > 
> > WRITEs cannot have length 0, and READs cannot as well. Since it's just
> > one bit for direction, those are the rules.
> 
> Jens, your logic doesn't make sense.
> 
> There clearly _are_ commands with a 0 data-length.
> 
> And commands _have_ to be either READ or WRITE. We don't have a choice. 
> ll_rw_block: blk_get_request() even has a BIG_ON() that enforces that.
> 
> So claiming that reads and writes cannot have zere data-length is INSANE.
> 
> So reads and writes HAVE to accept a zero data length. End of story. If 
> there is some path in the SCSI layer that refuses it, that part must be 
> fixed, or you have to add a new "NONE" (and perhaps "BOTH") direction.

I think most of the problem is that once it got down to the scsi layer,
there were some bugs with data direction, and it confused things like
usb-storage and sbp2 on firewire.

Those bugs were fixed. Note, I did not test the ALLOW_MEDIUM_REMOVAL fix
with WRITE commands after going to -rc6 (I used -rc5 for testing), so
those direction fixes may actually make ALLOW_MEDIUM_REMOVAL work.

However, I don't see the issue with using READ. We know this isn't a
write operation, we are sending a single command with no data. I know
you say reads are precious, but 3 requests for something that isn't
going to happen very often doesn't seem that bad.

As for the 0x01, I don't know. The eject -s code does the exact same
thing (AMR, SS:0x01, SS:0x02), so I copied the same mechanism because it
is known to work.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

