Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbTAEEga>; Sat, 4 Jan 2003 23:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTAEEga>; Sat, 4 Jan 2003 23:36:30 -0500
Received: from enchanter.real-time.com ([208.20.202.11]:36110 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S262813AbTAEEg3>; Sat, 4 Jan 2003 23:36:29 -0500
Date: Sat, 4 Jan 2003 22:45:00 -0600
From: Carl Wilhelm Soderstrom <chrome@real-time.com>
To: linux-kernel@vger.kernel.org
Subject: fs corruption with 2.4.20 IDE+md+LVM
Message-ID: <20030104224455.A18362@real-time.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I observed filesystem corruption on my home workstation recently. I was
running kernel 2.4.20 (built myself with gcc 2.95.4), and ext3 with the
default journaling mode (ordered?).

I was downloading files, and noticed that they weren't being saved. I
immediately did a 'df -h', and it reported my home partition as having 7.3T
used, -64Z free.

I (foolishly) immediately did a 'du -sch ~/*' to see what might be taking up
all the space. after realizing what was going on (du reported filesystem
permission errors on files it shouldn't have), I shut down all programs, and
dropped to runlevel 1. 

I unmounted my LVM'ed partitions (/var /usr /home), and tried to fsck
/dev/sys/home (the /home partition). it couldn't find a good superblock; and
fell back to using another backup superblock. fsck reported that the journal
was corrupt, and discarded it. many of the low-numbered inodes had wrong
refcounts, or wrong modes.

eventually it fixed the filesystem; but everything ended up in many files &
directories under lost+found. (had to pull the home dirs from one or more
dirs each, under lost+found).

after fixing the filesystem, I gratuitously fsck -f'ed all my other
partitions; they came up clean.

fortunately, looks like the only stuff I really lost were some chunks of my
XFree86 source tree, and some linux kernel sources. easily replaceable
stuff.

here's my system architecture:
2x Western Digital 80GB Special Edition IDE drives (hde, hdf)
- / is an ext3 RAID1 /dev/md0 made of hde1 and hdf1
- /dev/md1 is LVM-formatted RAID1, made of hde2 and hdf2. this partition
contains /var, /usr, and /home. 

/home is the only place that I saw this corruption.

I have since reverted back to kernel 2.4.18.

I'm thinking that my reaction *should* have been to power-cycle the box
immediately upon notice of the problem, to prevent further fs corruption,
and bring it back up in single-user read-only mode. shutting down programs
nicely would have written more stuff to disk, worsening the corruption.

I will also point out that kernel 2.4.20-ac1 and 2.4.21-pre6 will not boot
on my machine; they kernel panic when detecting my IDE devices. I have not
tried 2.4.20-ac2 nor 2.4.21-pre2 yet. 2.4.20 and 2.4.18 boot quite happily
tho. I suppose I ought to try the latest versions and set up a serial
console to capture the oops, before reporting a bug on this.

Carl Soderstrom.
-- 
Systems Administrator
Real-Time Enterprises
www.real-time.com
