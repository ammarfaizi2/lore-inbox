Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWIYMav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWIYMav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWIYMav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:30:51 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:44502 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750975AbWIYMau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:30:50 -0400
Message-ID: <4517CB2C.7020807@aitel.hist.no>
Date: Mon, 25 Sep 2006 14:27:24 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>	 <20060810030602.GA29664@mail>	 <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>	 <44DB2436.6080501@aitel.hist.no> <62b0912f0609240156p21caf564qc20b82b2ee4d8f43@mail.gmail.com>
In-Reply-To: <62b0912f0609240156p21caf564qc20b82b2ee4d8f43@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> I wrote:
>> I have a ~1TB filesystem that failed to mount today, the message is:
>>
>> EXT3-fs error (device loop0): ext3_check_descriptors: Block bitmap for
>> group 2338 not in group (block 1607003381)!
>> EXT3-fs: group descriptors corrupted !
>>
>> Yesterday it worked flawlessly.
>
> Helge Hafting wrote:
>> > And voila, that difficult task of assessing in which order to do
>> > things is out of the hands of distros like Red Hat, and into the
>> > hands of those people who actually make the binaries.
>>
>> Not so easy.  You do not want to shut down md devices because
>> samba is using them. Someone else may run samba on a single
>> harddisk and also have some md-devices that they take down
>> and bring up a lot.  So having samba generally depend on md doesn't
>> work.  Your setup need it, others may have different needs.
>
> I've looked hard at things and just found that maybe it's not the init
> order that's to blame..
>
> It seems that unmounting the filesystem fails with a "device busy" error.
> I'm not sure why there's still open files on the device, but perhaps a
> remote user is copying a file or some such (likely).
That is solvable by shutting down remote operations first.
So stop samba (or nfs or whatever) before attempting to umount.
> Anyway, the system is shutting down, so it should just forcefully
> unmount the device, but it doesn't.
> The halt script tries "umount" three times, which all fail with:
> "device is busy".
> It then actually tries "umount -f" three times, which all fail with
> "Device or resource busy"
> At which point the halt script turns off the machine and the
> filesystem is ruined.
>
> How to fix forceful unmount so it works?
I don't know, other than researching what filesystems support
forced umount and use one of those. Complain to the vendor or maintainer
of your particular filesystem.

However, you can usually find out why some file is open. Try
umount yourself, when it doesn't work, use "lsof" to see
what file is open. Then figure out who or what is keeping it open.
To debug a shutdown problem, consider putting "lsof >> logfile"
in your shutdown script.

Not a solution but a workaround: Run "sync" before shutdown.
(Stick it in some script.)
Now, all data in filesystem caches will be written to disk before power 
is lost.
This isn't perfect, but filesystem damage is greatly minimized and
often avoided completely.  Useful while waiting for a better solution.

The real solution is to set things up so unforced umount works.
This is normally possible to do.


Helge Hafting
