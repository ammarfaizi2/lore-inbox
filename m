Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131740AbRBJTeq>; Sat, 10 Feb 2001 14:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131641AbRBJTeg>; Sat, 10 Feb 2001 14:34:36 -0500
Received: from gear.torque.net ([204.138.244.1]:43786 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S131477AbRBJTe0>;
	Sat, 10 Feb 2001 14:34:26 -0500
Message-ID: <3A8595DC.B33CB0B2@torque.net>
Date: Sat, 10 Feb 2001 14:26:20 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org, ishikawa@yk.rim.or.jp
Subject: Re: devfs: "cd" device not showing up initially. [Fwd: Scan past lun 7 
 in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ishikawa <ishikawa@yk.rim.or.jp> wrote:
>
> I have begun using devfs for about a couple of weeks now and
> thank you for the great addition to linux.
> Now I am happy to see the device names on the
> scsi chain which won't be changed just because
> I add/delete a device.
>
> However, I noticed that there seems to be a subtle interaction of
> devfs (+devfsd) and
> the device names that appear under luns for
> a scsi chain.
>
> Namely the name "generic" or "disc" seem to
> exist from the start (after bootup), but
> the entry "cd" doesn't exist until I do something
> about accessing the CD somehow.
> (It seems that I fail the initial
> attempt to mount due to the missing name.)
>
> [snip, ls on /dev/scsi/* looks correct]
>
> Is it possible that the accessing the CD using the
> compatibility device name /dev/sr* forced
> the creation of the "cd" device name?

Yes, the LOOKUP rule caused 'modprobe sr_mod' to be
executed, then your cd devices will be visible in
devfs and accessible. Under the old /dev system
they were always "visible" but not accessible until
you loaded sr_mod .

> I consider the possibility of module loading. Both SCSI CD and
> SCSI generic (sg) are modules now.
> I checked /etc/devfs/devfs.conf (experimental Debian package
> puts the config file here! ) has the following line:
>
>    LOOKUP  .*              MODLOAD
>
> So the module autoloading ought to work. ("generic" exists
> somehow from the start.)

Chiaki,
The upper level scsi drivers (sd, sr, st, osst and sg) register
and unregister device names with devfs. After the mid level
recognizes a new scsi device it calls the detect() function
in the builtin upper level drivers and those that are currently
loaded as modules. That is your "problem", sr_mod.o is not
loaded until you do something like "ls -l /dev/sr0" (due to
that LOOKUP rule in /etc/devfsd.conf). The lsmod command will
show which modules are loaded (in your case look for sr_mod).

There is no "push" mechanism in the scsi mid level to load
the sr_mod.o module when it sees a device with SCSI type
CDROM. Devfs (specifically devfsd) supplies various "pull"
mechanisms (e.g. LOOKUP) to load that module.

Doug Gilbert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
