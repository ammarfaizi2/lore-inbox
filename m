Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265990AbSKDNJr>; Mon, 4 Nov 2002 08:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265991AbSKDNJr>; Mon, 4 Nov 2002 08:09:47 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:65423 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265990AbSKDNJq>; Mon, 4 Nov 2002 08:09:46 -0500
Subject: Re: swsusp: don't eat ide disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021104094413.GF13587@suse.de>
References: <Pine.LNX.4.44.0211031439330.11657-100000@home.transmeta.com>
	<Pine.LNX.4.44.0211031452380.11657-100000@home.transmeta.com> 
	<20021104094413.GF13587@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 13:37:54 +0000
Message-Id: <1036417074.1113.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 09:44, Jens Axboe wrote:
> It's probably not a good idea to rely on ata drives that also speak
> atapi, to my knowledge only a few old WDC drives ever did that. Since we
> are basically moving to the point where "SCSI" commands is the
> commandset that the block layer uses to make drivers do things for it,
> I had the idea of doing a rq -> taskfile conversion for ide. Just for
> simple things like read/write and sync cache, basically stuff that is
> directly translatable. That would make Linus' example actually work, and
> it would also make the direct read/write programs using SG_IO work on
> IDE drives as well.

Going beyond IDE it might be cleaner to be able to do

	struct bio_command_ops
	{
		eject: idedisk_eject,
		suspend: idedisk_suspend,
		identify: idedisk_identify,
		...
		[maybe even read:/write: in some cases
		 like smart scsi raids]
	}

that way IDE disk and all the other weirdass drives can have -one-
command parser not the twenty differently buggy ones we have now simply
by doing


	if(rq_is_command(rq))
		bio_do_command(rq, &bio_command_ops);

Its also very convenient as we can add fields to the structure and then
to drives without breaking the API and without so much updating

Alan

