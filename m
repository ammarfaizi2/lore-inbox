Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbSJ1I7Y>; Mon, 28 Oct 2002 03:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbSJ1I7Y>; Mon, 28 Oct 2002 03:59:24 -0500
Received: from daimi.au.dk ([130.225.16.1]:30117 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S263208AbSJ1I7X>;
	Mon, 28 Oct 2002 03:59:23 -0500
Message-ID: <3DBCFDCE.258AC0FC@daimi.au.dk>
Date: Mon, 28 Oct 2002 10:05:18 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Andreas Haumer <andreas@xss.co.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: rootfs exposure in /proc/mounts
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com> <3DBBBE1B.5050809@xss.co.at> <20021027111856.GA789@alpha.home.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> 
> Hi !
> 
> I remember this discussion too, and am also used to symlink mtab to
> /proc/mounts. But I also remember some people stating that /proc/mounts doesn't
> contain all information (some mount flags, nfs options ...) which may be needed
> for a mount -o remount, while mtab contains them.

There seems to be two types of information in mtab, which is missing in
/proc/mounts. First of all the first field of mtab is not always the name
of a blockdevice. If it is a bindmount, this field will contain the name
of the directory rather than the device, however this confuses some
startupscripts, so having the device here might actually be better.

If the mount was done using the loop option, this field will contain the
name of the backing file rather than the name of the loopback device. In
the output from df, the name of the backing file will be more informative
than the name of the loopback device, so I don't want to change that. But
since a loopback device can also be mounted by manually using the losetup
command, I would prefer another way to get the name of the backing file,
that will work in both cases.

The options available in mtab but not in /proc/mounts, I would like to
add to /proc/mounts. This could just be a string writable by the mount
program. I don't think this should be anything fancy, just that any write
to /proc/mounts should find the coresponding mount and update the string.

> 
> I too agree that it's non-sense to have both mtab and /proc/mounts. If mounts
> isn't usable, why keep it ? At the moment, the only reason why I would abandon
> this symlink would be that mounts be removed from /proc entirely ! And I also
> agree that mtab shouldn't be under /etc (this is the only file that needs to
> be written to). At least, it should be moved to /var/state or something like
> that, provided it's available early in the boot stage, but this issue is not a
> kernel one anyway.

If the /etc/mtab file should exist at all it should at least be on a
ramfs so we won't have to have the root mounted readwrite to update it.
I have moved by mtab file to /etc/mtab.d/mtab and mount a ramfs on
/etc/mtab.d. On boot I first mount /proc and /etc/mtab.d, then I create
the mtab file from /proc/mounts. This is not an optimal solution, but I
think it works better than having mtab on the root fs.

> 
> May be we should just accept this case as a common one, and update tools
> (mount, umount, df, ?) to be able to use both mtab and /proc/mounts, and simply
> ignore any rootfs entry.

The optimal solution of the problem will include an update of the tools,
and probably also the kernel.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
Don't do this at home kids: touch -- -rf
