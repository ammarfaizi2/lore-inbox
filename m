Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTKMPWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTKMPWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:22:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:37857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264313AbTKMPWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:22:41 -0500
Date: Thu, 13 Nov 2003 07:22:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Pascal Schmidt <der.eremit@email.de>, Bill Davidsen <davidsen@tmr.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <20031113143521.GK4441@suse.de>
Message-ID: <Pine.LNX.4.44.0311130712120.8093-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Nov 2003, Jens Axboe wrote:

> On Thu, Nov 13 2003, Pascal Schmidt wrote:
> >  
> > My patch from yesterday should handle that situation. 
> > cdrom_get_last_written is allowed to override the capacity from
> > cdrom_read_capacity.
> 
> Yep, that is fine.

Well, there is a good argument for not bothering with the 
"cdrom_get_last_written" at all: the SCSI layer never does anything like 
that as far as I can see, so arguably everybody who ever used ide-scsi 
would only ever have seen the READ_CAPACITY command be used. And nobody 
ever complained about bad capacitites as far as I can remember..

But I might have missed something in the SCSI driver. But I actually see a

		if (cdrom_get_last_written(..)

in sr.c, and it's been #if 0'ed out since before the Bitkeeper tree 
started. And that code definitely does the READ_CAPACITY first.

The "sd.c" code (which is what a MO device would use) obviously doesn't do 
cdrom_get_last_written either - it just does a READ_CAPACITY. (Well, it 
does a READ_CAPACITY_16 if it hits a really big disk, but that only hits 
if the disk has more than 4G sectors, so we can ignore it for CD-ROM's for 
a while.

So I'd argue for just dropping the cdrom_get_last_written() call entirely.

		Linus

