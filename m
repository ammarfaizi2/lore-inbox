Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTJQQHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 12:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTJQQHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 12:07:12 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:51208 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S263435AbTJQQHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 12:07:10 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB2DD@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: "'Greg Stark'" <gsstark@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ide write barrier support
Date: Fri, 17 Oct 2003 10:07:09 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jens Axboe [mailto:axboe@suse.de]
>
> Yes that would be very nice, but unfortunately I think FUA in ATA got
> defined as not implying ordering (the FUA write would typically go
> straight to disk, ahead of any in-cache dirty data). Which 
> makes it less
> useful, imo.

None of the TCQ/FUA components of the spec mention ordering.  According to
the "letter" of the specification, if you issue two queued writes for the
same LBA, the drive has the choice of which one to do first and which one to
put on the media first, which is totally broken in common sense land.

Luckilly, us drive guys are a bit smarter (if only a bit)...

If you issue a FUA write for data already in cache, and you put the FUA
write onto the media, there's no problem if you discard the cached data that
you were going to write.

In drives with a unified cache, they'll always be consistent provided the
overlapping interface transfers happen in the same order they were
issued.... this is common sense.

However, you're right in that non-overlapping cached write data may stay in
cache a long time, which potentially gives you a very large time hole in
which your FUA'd data is on the media and your user data is still hangin' in
the breeze prior to a flush on a very busy drive.
