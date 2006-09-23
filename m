Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWIWWtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWIWWtw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIWWtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:49:52 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:63434 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750893AbWIWWtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:49:51 -0400
Subject: Re: [PATCH -mm 0/6] swsusp: Add support for swap files
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200609240018.47017.rjw@sisk.pl>
References: <200609202120.58082.rjw@sisk.pl>
	 <200609221328.58504.rjw@sisk.pl>
	 <1158963526.5106.42.camel@nigel.suspend2.net>
	 <200609240018.47017.rjw@sisk.pl>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 08:49:47 +1000
Message-Id: <1159051787.7324.11.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2006-09-24 at 00:18 +0200, Rafael J. Wysocki wrote:
> > > We could use a regular (non-swap) file like this but that would require us to
> > > use some dangerous code (ie. one that writes directly to blocks belonging to
> > > certain file bypassing the filesystem).  IMHO this isn't worth it, provided
> > > the kernel's swap-handling code can do this for us and is known to work. ;-)
> > 
> > It's not that dangerous once you debug it.
> 
> Certainly.  Still, let me repeat: if there is some code that does pretty much
> the same and has _already_ been debugged, I prefer using it to writing some
> new code, debugging it etc.

Look at Suspend2 then. I know you won't want it in exactly that form,
but it's there and have been tested and debugged.

> > This is what Suspend2 does - 
> > all I/O is done using bmapping and bios with direct sector numbers,
> > regardless of where you're reading from/writing to. The main difficulty
> > I saw was with XFS, where the device block size and filesystem block
> > size can differ, but even then, it's just a matter of making sure you
> > get the right one in the right place.
> > 
> > I would encourage you in this direction because it also adds way more
> > flexibility. If swap is a thing of the past, the only reason for people
> > to have swap space now is to suspend to disk. If you can write to a swap
> > file, they don't need a swap partition and more.
> 
> Obviously.  That's what the patches are for. :-)
> 
> > If you can write to an 
> > ordinary file, they can know that even if they are in a low memory
> > situation and swap is being used, there's no race condition between
> > freeing up memory to meet the conditions for suspending to disk, and
> > allocating storage for writing the actual image.
> 
> Well, I wouldn't call that a race condition.

You want to write the image to swap (any kind) but you need to use swap
to free up enough memory so that you can make the image and write it.
But wait, in freeing enough memory, you reduced the amount of swap
available for your image, so now you need to free more...

> By using an ordinary file to save the suspend image, you effectively divide
> the whole storage needed for suspending in two independent parts.  Still
> the sum of these two parts has to be sufficient to save the total amount of
> data that cannot be discarded residing in memory before the suspend.  IMO
> it doesn't really matter if this storage is divided or not, because to total
> size of it has to be sufficient regardless.

You're forgetting, I think, that for Suspend2, we're not usually
swapping anything out. It would only be under very unusual memory load
that we'd be swapping memory out, and that would only be after caches
were discarded, which would probably address the situation itself.
There's therefore no division of the image.

Regards,

Nigel

