Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFXMYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFXMYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 08:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFXMYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 08:24:09 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:51793 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261171AbVFXMX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 08:23:56 -0400
Message-ID: <42BBFB55.3040008@tls.msk.ru>
Date: Fri, 24 Jun 2005 16:23:49 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
References: <20050624081808.GA26174@kroah.com>
In-Reply-To: <20050624081808.GA26174@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Now I just know I'm going to regret this somehow...

Why?

Well.  I've read several endless discussions about devfs/udev/dev etc.
I've a question still, which has been raised by several other people
too.  The question is this: "what is a naming policy?"

Kernel already have some "naming scheme", used internally.  Think
about /proc/partitions, /sys nodenames (/sys/block/sda etc), think
about dmesg output (serial: registered device tttS0) etc.
This is just because devices *have* to be named *somehow*.
And, IMHO, there should be a way for the user (or whomever),
when he sees that dmesg/partitions/whatever, to access that
device in /dev.

That same device can have other names too, like
/dev/MyYellowCDBurner or /dev/MyPhotoCamera.  I think
*that* is a policy.  And there's an internal (in-kernel)
naming scheme.  Which has been here for ages, with alot
or programs expected to see "standard" names in /dev
(think how lilo or, worse, mdadm, fails when it can't
find a device listed in /proc/partitions because the
node has been created with different name according
to "policy").

More, with dynamic (or semi-dynamic) /dev, like devfs
or udev provides, the directory isn't cluttered with
alot of unused files anymore (before udev, i was trying
to move grouops of devices into subdirs in /dev, like
moving all scsi disks (sd) to /dev/sd/, with the only
reason: to have less entries in /dev, some of which
can be useful in some future...), it isn't really
that matters if it will have flat namespace.  Ok
ok, with 20K scsi devices, it may be problematic
somehow.. i dunno really, a machine with 20K
disks usually have apropriate amount of RAM too).

So, to summarize all that.  A dynamic /dev, which
creates/removes nodes using in-kernel naming scheme
(which is here for ages) automatically, and calls
external program to help create "policy"-based
naming -- i don't think it's a bad idea anyway.

> Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
> tiny:
> $ size fs/ndevfs/inode.o 
>    text    data     bss     dec     hex filename
>    1571     200       8    1779     6f3 fs/ndevfs/inode.o
> replacement for devfs for those embedded users who just can't live
> without the damm thing.  It doesn't allow subdirectories, and only uses
> LSB compliant names.  But it works, and should be enough for people to
> use, if they just can't wean themselves off of the idea of an in-kernel
> fs to provide device nodes.
> 
> Now, with this, is there still anyone out there who just can't live
> without devfs in their kernel?
> 
> Damm, the depths I've sunk to these days, I'm such a people pleaser...
> 
> Comments?  Questions?  Criticisms?

A question.  I can't apply this to 2.6.12, it fails in
drivers/base/class.c -- the main portion i think.  What's
this patch against?

I'd love to see how it works but.. can't compile it ;)

And another question.  Why it isn't possible to use
plain tmpfs for this sort of things?  Why to create
another filesystem, instead of just using current
tmpfs and call mknod/unlink on it as appropriate?
This same tmpfs can be used by udev too (to create
that "policy"-based names), and it gives us all
the directories and other stuff...

Thanks.

/mjt
