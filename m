Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbSKQUJR>; Sun, 17 Nov 2002 15:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbSKQUJR>; Sun, 17 Nov 2002 15:09:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58282 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267574AbSKQUJP>;
	Sun, 17 Nov 2002 15:09:15 -0500
Date: Sun, 17 Nov 2002 15:16:13 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Doug Ledford <dledford@redhat.com>
cc: Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up...
In-Reply-To: <Pine.GSO.4.21.0211171457290.23400-100000@steklov.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0211171505540.23400-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Nov 2002, Alexander Viro wrote:

> There is a purpose?  Seriously, "no use of ones object during init" is
> WRONG.  Rusty, remember I've told you that block devices need to be
> able to open() during init?  That's what it is.
> 
> We _might_ eventually kludge around that, but IMO the ->live checks on
> the init side are just plain wrong.

PS: logics in case of block devices is very simple: by the time when you
can handle open and IO on a disk, you are already set up - no point
bailing out after that point; if other disks served by the same driver
do not work, it means that they should be left out, not that driver
should fail init.  IOW, logics of init, regardless of modular/nonmodular
makes that a point where you are past failure exits.

And I'd rather see similar rules for other interfaces.  Yes, it might
require API changes - e.g. old block API was badly b0rken in that respect
since register_blkdev() allowed open() attempts, no matter whether you are
ready or not, so block drivers used to be seriously racy in that area.

Right way is "don't export an object until you are ready to serve it" and
once your API is of that sort, you are pretty much done.  Note that non-modular
case _also_ need that sort of logics, simply because we might get userland
up and running before the initcalls are done.

