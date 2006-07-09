Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWGIOEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWGIOEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWGIOEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:04:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:18910 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161010AbWGIOEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:04:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mcxN0CERX+HX2rAISf0FsnRogBlnKAyXr+Jmmr9t5P9NtD/wuP6DNpz4XJFXdMH5MANOa2zwE81mhnEY55tAaYProler2k87HnLYlptX+m/6z/3T2ZO1UwH2HvehAaPVF4pg++zbFmNG1yjzD36cRUhgQe0K0/i23KEOJZ1Z8IQ=
Message-ID: <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
Date: Sun, 9 Jul 2006 10:04:05 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Albert Cahalan" <acahalan@gmail.com>, "Greg KH" <greg@kroah.com>
Subject: Re: Opinions on removing /proc/tty?
Cc: rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Albert Cahalan <acahalan@gmail.com> wrote:
> Jon Smirl writes:
> > On 7/8/06, Mike Galbraith <efault@gmx.de> wrote:
> >> On Fri, 2006-07-07 at 22:56 -0400, Jon Smirl wrote:
>
> >>> Does anyone use the info in /proc/tty? The hard coded device
> >>> names aren't compatible with udev's ability to rename things.
> >>>
> >>> There also doesn't appear to be any useful info in the drivers
> >>> portion that isn't already available in sysfs. I can add some code
> >>> to make a list of registered line disciplines appear in sysfs.
> >>>
> >>> Does anyone have a problem with deleting /proc/tty if
> >>> ldisc enum support is added to sysfs?
> >>
> >> ps uses /proc/tty/drivers, so some coordination would be needed.
> >
> > Greg, I just looked at the source for ps and it has a bunch
> > of fixed code for turning major/minor into /dev/name.  Isn't
> > that something udevinfo should be doing? But looking at the
> > help for udevinfo I don't see any way to turn a major/minor
> > into /dev/name. The altermative seems to be search /dev
> > looking for the right device node.
>
> By far, the best thing for procps (ps, top, etc.) would
> be /proc/*/tty links. Code that, give everybody a year
> to upgrade, and then... maybe.
>
> There is no way I'm going to have the procps run a "udevinfo"
> program, and I very much dislike relying on oddball libraries.
> Reliability and performance matter; this isn't some GNOME/KDE
> thing that can break just because 1 of 200 libraries changed.
>
> In order, the procps code tries:
>
> 1. /proc/*/tty symlink (effectively commented out)
Doesn't existing the the current kernel.

> 2. /proc/tty/drivers
This info can be wrong due to udev renames.  For example tty1 vs tty/1
The info in /proc/tty/drivers describes hardware not processes, it
belongs in sysfs, not /proc.

> 3. /proc/*/fd/2 symlink
Working in the current kernel

> 4. hard-coded guess
This will be wrong because of udev renames. For example tty1 vs tty/1

> 5. /proc/*/fd/255 symlink
Working in the current kernel

> 6. "?"
Always good

> Long ago, procps would search /dev for the mapping. This was
> too slow to be done directly when ps ran, so a binary file in
> /etc was used to cache the data. Keeping that file updated
> was a major problem.

This is what udev does, it maintains the mapping between devices and
names. Udevinfo is how you query the database. /etc/udev is where you
control how the device numbers are mapped into names.

Now we have a good example of the impact of pushing something (udev)
into user space and not shipping the binary as part of the kernel
tree. What is the API for converting a device node number to a name?


>
> BTW, cruft gets ripped out some time after Debian-obsolete no
> longer supports the old kernels.
>


-- 
Jon Smirl
jonsmirl@gmail.com
