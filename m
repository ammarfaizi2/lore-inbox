Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266977AbUBMM5B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 07:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266983AbUBMM5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 07:57:01 -0500
Received: from CPE-65-28-18-238.kc.rr.com ([65.28.18.238]:33964 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S266977AbUBMM45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 07:56:57 -0500
Message-ID: <54072.192.168.1.12.1076677017.squirrel@mail.2thebatcave.com>
In-Reply-To: <Pine.LNX.4.58.0402131338510.163@neptune.local>
References: <1oAMR-6St-13@gated-at.bofh.it>
    <E1ArSm1-0003ei-Pv@localhost><52496.192.168.1.12.1076639642.squirrel@mail.2thebatcave.com>
    <Pine.LNX.4.58.0402131338510.163@neptune.local>
Date: Fri, 13 Feb 2004 06:56:57 -0600 (CST)
Subject: Re: getting usb mass storage to finish before running init?
From: "Nick Bartos" <spam99@2thebatcave.com>
To: der.eremit@email.de
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realized that in my config only the flash disk has 2 partitions (the
rest will only ever have one), so what I will do is keep looking every
second in /proc/partitions for a disk that has a second partitions, then
if I find any, I will go through and use tune2fs to check the label on it
and make sure it matches the one I am looking for (just in case for some
reason there is another disk in there with a second partition).  If I
don't find a match by a certain timeout period, I will exit with a
critical error.  Since I don't think that any of these systems will have
more than one disk I will need to run tune2fs on, I won't keep track of
scanned devices.  If that changes I can always tweek the code.

This isn't as elegant as I wanted, but it should be reliable since I would
be waiting on something that directly tells me that the flash device is
ready to go, instead of only waiting an arbitrary amount of time.



> On Thu, 12 Feb 2004, Nick Bartos wrote:
>
>> well, the root filesystem is an initrd, so I can't do that.
>
> Then I mean look for the filesystem you want to mount.
>
>> I suppose I could compile in the extra info for /proc/partitions and see
>> if that gives me anything I can keep looking for (don't know if it puts
>> file system labels in there, but that is probably what I would have to
>> go
>> on since that is really the only thing that is constant on all systems).
>
> Well, if you know what filesystem type is wanted you could just attempt
> to mount all the partitions from /proc/partitions with that type
> (read-only) and look for a unique file - if it's there, keep the fs
> mounted, otherwise umount and try next candidate.
>
> That's basically what I do in an initrd I wrote for CD-ROM booting, I'm
> just trying to mount iso9660 filesystems and look for /etc/rc.d/rc.cdrom
> when it succeeds. Better ways to identifiy a block device exist, I'm
> sure, but the approach works for me. I'm narrowing down the search by
> scanning the dmesg buffer for ATAPI and SCSI CD-ROM detection messages,
> but that approach doesn't work for your problem (and is also fragile
> when using it across several kernel versions).
>
>> Is there a quick/clean way to query a device and get the label?
>
> findfs from the e2fsprogs package, maybe.
>
>> I suppose
>> I could use tune2fs or something, but I didn't know if there is anything
>> better/simpler.  I don't know if I like the idea of running tune2fs on
>> each partition again and again.  I guess I could keep a list in memory
>> and
>> only check each one once, but that is getting a bit more complicated &
>> time consuming.
>
> Well, it's read-only access, so I don't see a problem even with running
> it multiple times on the same device. Keeping a list of already tried
> devices isn't black magic, though.
>
> --
> Ciao,
> Pascal
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

