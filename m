Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVEPQZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVEPQZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVEPQZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:25:22 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:50360 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S261734AbVEPQZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:25:08 -0400
Date: Mon, 16 May 2005 18:25:06 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: XFS lstat() _very_ slow on SMP
Message-ID: <20050516162506.GB19415@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

	I have a big XFS volume on my fileserver, and I have noticed that
making an incremental backup of this volume is _very_ slow. The incremental
backup essentially checks mtime of all files on this volume, and it
takes ~4ms of _system_ time (i.e. no iowait or what) to do a lstat().

	The server is quad opteron with 26GB of RAM, 2.6.11.x kernel.
The volume in question is this big:

$ df -i /export/home
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/array-vg/home   2147502080 7917653 2139584427    1% /export/home
$ df -k /export/home
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/array-vg/home   2147371008 558965100 1588405908  27% /export/home

	As you can see it has ~8 milion of files. At 4ms per file it takes
almost 9 hours of system time just to select the files to back up.

	I've tried to narrow this problem in the following way: I've created a
new logical volume, put an empty XFS filesystem on it, and created
16.7M files in the three-level directory structure (256 subdirs at each
level, 256 files in each leaf directory). It took about a day of
_system_ time to create this structure, and another day to run
"find /mnt1 -type f -mtime +1000 -print" on it. I did a strace -c
of this find command, and it looks like this:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.97 68713.490033        4048  16974597           lstat
[...]

	So the find(1) spent almost all of its time in lstat() syscall,
and each call took about 4ms of system time. Real time was almost the
same as the system time, so disk subsystem was not a bottleneck here.

	When I tried to umount this test volume, the umount(8) did not
finish even after 5 minutes, and it was cycling somewhere in kernel
(according to top(1) it used 25% of CPU time, i.e. one CPU out of 4).
In addition to this, all other filesystem-related processes started to
lock up in kernel, possibly waiting for some lock held by umount command.
I had to reset this server after 5 minutes.

	I tried to run the same test on a single-CPU Athlon FX-51 with
512M RAM, and only 128*128*128 (2M) files, and got the following
numbers:

      create                     find -type f -mtime +1000    cost of lstat()
XFS   10m15s real, 4m22s system  7m30s real, 3m17s system     107us
ext3  1m10s real, 0m30s system   1m26s real, 0m10s system       9us

So XFS lstat() is almost 12-times slower than ext3 one even on single-CPU
x86_64. I've tried to boot a SMP kernel as well, but there was no measurable
difference in speed. So XFS is slow even on this box, but going 4-way SMP
makes the problem two magnitudes worse.

	The problem is definitely in XFS on SMP (or maybe in filling up
the dentry/inode cache, because the cost of lstat() on smaller trees is
not so big).

	I will do more benchmarks if you want (I can test it
on SMP x86 as well, for example).

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
-- Yes. CVS is much denser.                                               --
-- CVS is also total crap. So your point is?             --Linus Torvalds --
