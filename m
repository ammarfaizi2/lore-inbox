Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310756AbSCMQeX>; Wed, 13 Mar 2002 11:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310757AbSCMQeN>; Wed, 13 Mar 2002 11:34:13 -0500
Received: from [198.17.35.35] ([198.17.35.35]:57247 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S310756AbSCMQeC>;
	Wed, 13 Mar 2002 11:34:02 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2CE8@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: proc/stat question
Date: Wed, 13 Mar 2002 08:34:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at the disk_io: field from /proc/stat and I'm seeing
some inconsistencies.  On systems with two scsi disks, everything's
fine.  On systems with 2 IDE disks (hda and hdc) it only shows hda's info.
on systems with the compaq smart array controller, i get nothing.

It looks like the scsi is working fine, the IDE is not working properly,
and kstat doesn't search for /dev/ida devices (actually, that might
not be a bug, the devices are kind of annoying :)

If I understand it right, it does a loop checking all majors from
0 to 16 (DK_MAX_MAJOR, defined in kernel_stat.h) and checks each
disk (0 to 16, once again) on that major.  The problem is that hdc
has major 22 and ida has major 72, so the 0-16 search just misses
everything.

So my main question : is there a way we can just print out for the known
disk devices?  devfs and driverfs know how to tell if a disk is connected,
so I would think the information has to be there somewhere, right?

The relevant code is shown below (from fs/proc/proc_misc.c) :
(2.4.18 shown)

len += sprintf(page + len, "\ndisk_io: ");

for (major = 0; major < DK_MAX_MAJOR; major++) {
    for (disk = 0; disk < DK_MAX_DISK; disk++) {
        int active = kstat.dk_drive[major][disk] +
                     kstat.dk_drive_rblk[major][disk] +
                     kstat.dk_drive_wblk[major][disk];
        if (active)
            len += sprintf(page + len,
                           "(%u,%u):(%u,%u,%u,%u,%u) ",
                           major, disk,
                           kstat.dk_drive[major][disk],
                           kstat.dk_drive_rio[major][disk],
                           kstat.dk_drive_rblk[major][disk],
                           kstat.dk_drive_wio[major][disk],
                           kstat.dk_drive_wblk[major][disk]
                          );
    }
}
