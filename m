Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWANMSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWANMSM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWANMSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:18:12 -0500
Received: from h144-158.u.wavenet.pl ([217.79.144.158]:64135 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751030AbWANMSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:18:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Sat, 14 Jan 2006 13:19:53 +0100
User-Agent: KMail/1.9
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Linux PM <linux-pm@osdl.org>
References: <200601122241.07363.rjw@sisk.pl> <200601141040.00088.rjw@sisk.pl> <20060114112950.GA2571@ucw.cz>
In-Reply-To: <20060114112950.GA2571@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141319.53573.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 14 January 2006 12:29, Pavel Machek wrote:
> > > > > > > It returns the number of pages.  Well, it should be written explicitly,
> > > > > > > so I'll fix that.
> > > > > > 
> > > > > > Please always talk to the kernel in bytes. Pagesize is only a kernel
> > > > > > internal unit. Sth. like off64_t is fine.
> > > > > 
> > > > > These are values returned by the kernel, actually.  Of course I can convert them
> > > > > to bytes before sending to the user space, if that's preferrable.
> > > > > 
> > > > > Pavel, what do you think?
> > > > 
> > > > Bytes, I'd say. It would be nice if preffered image size was in bytes,
> > > > too, for consistency.
> > > 
> > > OK
> > 
> > Having actually tried to do that I see two reasons for keeping the image size
> > in megs.
> > 
> > First, if that was in bytes, I'd have to pass it via a pointer, because
> > unsigned long might overflow on i386.  Then I'd have to use get_user()
> 
> Actually unsigned long is okay. We can't do images > 1.5GB, anyway,
> on i386.

Right.  In fact 1/2 of lowmem is the limit.

> > to read the value.  However, afterwards I'd have to rescale that value
> > to megs for swsusp_shrink_memory().  It's just easier to pass the value
> > in megs using the last argument of ioctl() directly (which is consistent
> > with the /sys/power/image_size thing, BTW).
> 
> Well, I'd be inclined to make image_size in bytes, too. Having
> each ioctl/sys file in different units seems wrong.

I'll add these changes to the userland interface patch, then.  There won't
be too many of them, I think.

> > Second, if that's in bytes, it would suggest that the memory-shrinking
> > mechanism had byte granularity (ie. way off).
> 
> Yep, but it is not that bad.
> 
> > There also is a reason for which SNAPSHOT_AVAIL_SWAP should return
> > the number of pages, IMO.  Namely, if that's in pages, the number is directly
> > comparable with the number of image pages which the suspending
> > utility can read from the image header.  Otherwise it would have to rescale
> > one of these values using PAGE_SIZE, but that's exactly what we'd like
> > to avoid.
> 
> I see.... We could put #bytes into image header (unsigned long) :-).
> 
> Its not too bad one way or another, because uswsusp tools are
> intimately tied to kernel, anyway.

Exactly. :-)

Greetings,
Rafael
