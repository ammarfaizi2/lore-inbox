Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWBRRCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWBRRCb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWBRRCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:02:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:63149 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932091AbWBRRC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:02:29 -0500
X-Authenticated: #428038
Date: Sat, 18 Feb 2006 18:02:26 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: axboe@suse.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: 2.6.15.4 ide-cd causes drive complaints from NEC ND-4550A?
Message-ID: <20060218170226.GA9272@merlin.emma.line.org>
Mail-Followup-To: axboe@suse.de, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm resending to -ide@ since on -kernel@ this caused no reaction.

All three of

SUSE Linux kernel 2.6.13-15.7,
SUSE Linux kernel 2.6.13-15.8 (both SUSE Linux 10.0 i586) and
Vanilla    kernel 2.6.15.4

BUT NOT

FreeBSD 6.1-PRERELEASE

cause "local unit communication failure" when running "readcd -c2scan"
on my NEC ND-4550A CD/DVD drive (VIA KT8237, Athlon XP 2500+, 1 GB RAM)
after at most two seconds of reading.

I am aware of three ways to trigger the problem currently:

1. as little as switching to a different tab in GNOME-Terminal.

2. hald-addon-storage's poll with CDROM_MEDIA_CHANGED and
   CDROM_DRIVE_STATUS ioctls cause the same problem (hald-addon-storage
   doesn't do anything else except opening and closing the device and
   sleeping for two seconds).

3. running two readcd -c2scan dev=/dev/hdc commands on the same drive
   triggers the problem, too.  One might argue this isn't very sensible,
   but it shouldn't confuse the drive either.

The problem is invariant to hdparm -d0 (or -d1) /dev/hdc, and hdparm -u0
or -u1 make no difference either.

A Plextor PX-W4824TA (/dev/hdd) on the same cable as the NEC works like
a charm, and with FreeBSD 6-STABLE, both work like a charm with (3.).
(This is a dualboot machine, so it's the very same hardware.)

readcd uses commands like these:

Executing 'read_cd' command on Bus 1 Target 0, Lun 0 timeout 40s
CDB:  BE 00 00 00 02 7D 00 00 31 FA 00 00
ioctl(3, SG_IO, 0xbfa5b2ac)             = 0

In a second run -- I needed to capture the output ;-) -- I get this:

CDB:  BE 00 00 00 00 31 00 00 31 FA 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 04 00 00 00 00 0A 00 00 00 00 08 00 00 00
Sense Key: 0x4 Hardware Error, Segment 0
Sense Code: 0x08 Qual 0x00 (logical unit communication failure) Fru 0x0
Sense flags: Blk 0 (not valid)
resid: 123748
cmd finished after 6.408s timeout 40s
readcd: Success. read_cd: scsi sendcmd: no error

I'd been using "sudo" to run this with ruid == euid == 0 to rule out
command filtering issues. I hope that was the right approach.

What else do you need to debug this? Is there some low-level debugging
output I could enable to see what the kernel sends and gets to/from the
drive?

Some unimportant person suspected (on cdwrite(#)other,debian!org) this
might be a DMA problem, but the problem persists after hdparm -d0
so I wonder if it's really a DMA issue or something else.

-- 
Matthias Andree
