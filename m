Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbREVOdn>; Tue, 22 May 2001 10:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbREVOde>; Tue, 22 May 2001 10:33:34 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4619 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261782AbREVOdR>; Tue, 22 May 2001 10:33:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andries.Brouwer@cwi.nl, bcrl@redhat.com, phillips@bonn-fries.net
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
Date: Mon, 21 May 2001 18:08:08 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, viro@math.psu.edu
In-Reply-To: <UTC200105211243.OAA62469.aeb@vlet.cwi.nl>
In-Reply-To: <UTC200105211243.OAA62469.aeb@vlet.cwi.nl>
MIME-Version: 1.0
Message-Id: <01052118080809.05122@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 May 2001 14:43, Andries.Brouwer@cwi.nl wrote:
>     How about:
>
>       # mkpart /dev/sda /dev/mypartition -o size=1024k,type=swap
>       # ls /dev/mypartition
>       base    size    device    type
>
>     Generally, we shouldn't care which order the kernel enumerates
>     devices in or which device number gets assigned internally.  If
> we did need to care, we'd just do:
>
>       # echo 666 >/dev/mypartition/number
>
> Only a single thing is of interest.
> What is the communication between user space and kernel
> that transports device identities?

It doesn't change, the same symbolic names still work.  What's
happening in my example is, we've gotten rid of the
can't-get-there-from-here device naming heirarchy.  It should 
be clear by now that we can't capture 'physical device location'
and 'device function' in one tree.  So instead, 'physical device'
is a property of 'logical device'.  The tree is now optional.

> Note that there is user (human) / user space (programs) / kernel.
>
> This user has interesting machinery in his hands,
> but his programs have only strings (path names, fake or not)
> to give to the kernel in open() and mount() calls.
>
> Now the device path is so complicated that the user is unable to
> describe it using a path name. devfs made an attempt listing
> controller, lun, etc etc but /dev/ide/host0/bus1/target1/lun0/disc is
> not very attractive, and things only get worse.

Yes, we flatten that by making host, bus, target and lun all
properties of /proc/ide/hda.

Our mistake up to now is that we've tried to carry the logical
view and physical view of the device in one name, or equivalently,
in path+name.  Let the physical device be a property of the logical
device and we no longer have our thumb tied to our nose.

> When I go to a bookshop to buy a book, I can do so without specifying
> all of Author, Editors, Title, Publisher, Date, ISBN, nr of pages,
> ... A few items suffice. Often the Title alone will do.
>
> We want an interface where the kernel exports what it has to offer
> and the user can pick. Yes, that Zip drive - never mind the bus.
> But can distinguish - Yes, that USB Zip drive, not the one
> on the parallel port.

100% agreed.  IOW, when the device *does* move we can usually
deduce where it's moved to, so lets update the hda's bus location
automatically whenever we can (log a message!) and only bother
the user about it if it's ambiguous.  For good measure, have a
system setting that says 'on a scale of 0 to 5, this is how interested
I am in being bothered about the fact that a device seems to have
moved'.

> The five minute hack would number devices 1, 2, 3 in order of
> detection, offer the detection message in
> /devices/<nr>/detectionmessage and a corresponding device node in
> /devices/<nr>/devicenode. The sysadmin figures out what is what,
> makes a collection of symlinks with his favorite names, and everybody
> is happy.
>
> Until the next reboot. Or until device removal and addition.
> There must be a way to give permanence to an association
> between name and device. Symlinks into a virtual filesystem
> like /devices are not good enough. Turning the five minute
> hack into a ten minute hack we take the md5sum of the part
> of the bootmessage that is expected to be the same the next time
> we encounter this device and use that as device number.
>
> I think a system somewhat in this style could be made to work well.

Yes, we are advocating the same thing.  I didn't mention that the
device properties are supposed to be persistent, did I?  If you
accept the idea of persistent device properties then the obvious
thing to do is to match them up against the detected devices.

I didn't want to bring up the persistency thing right away because
it begs the question of where you store the persistent data for the 
root device.  Until the namespace issue is resolved this is mainly
a distraction.

--
Daniel

