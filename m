Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVJMLeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVJMLeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 07:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVJMLeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 07:34:15 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:10731 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750734AbVJMLeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 07:34:15 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: [2.6.14-rc4-git HFSPlus BUG] HFSPlus ate my free space!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: zippel@linux-m68k.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 13 Oct 2005 12:34:01 +0100
Message-Id: <1129203241.5293.43.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

I am using hfsplus (journalled) to mount a 10Gb partition on an usb
attached disk.  I then copy a 3.5Gb file to the partition, then umount,
and mount again, and then delete it, but the space occupied by the file
is not freed, and doing that two times in a row ends up filling up the
space and I get an error that there is no space left.  Here are steps to
reproduce:

$ newfs_hfs -J -v BigFiles /dev/sda6
Initialized /dev/sda6 as a 10112 MB HFS Plus volume with a 8192k journal

$ mount -t hfsplus /dev/sda6 /sda6

$ dmesg | tail -1
HFS+: create hidden dir...

$ df -h /sda6
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda6             9.9G   25M  9.9G   1% /sda6

$ cp ~/some-bigfile /sda6/bigfile

$ ls -lh /sda6
total 3.5G
-rw-r--r--  1 root root 3.5G 2005-10-13 12:28 bigfile

$ df -h /sda6
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda6             9.9G  3.5G  6.4G  36% /sda6

$ umount /sda6
$ mount -t hfsplus /dev/sda6 /sda6

$ ls -lh /sda6
total 3.5G
-rw-r--r--  1 root root 3.5G 2005-10-13 12:28 bigfile

$ df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda6             9.9G  3.5G  6.4G  36% /sda6

$ rm /sda6/bigfile

$ ls -lh /sda6
total 0

$ df -h /sda6
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda6             9.9G  3.5G  6.4G  36% /sda6

$ ls -lah /sda6
total 8.1M
drwxr-xr-x   1 root root    5 2005-10-13 12:31 .
drwxr-xr-x  33 root root 4.0K 2005-10-11 14:33 ..
----------   1 root root 8.0M 2005-10-13 12:26 .journal
----------   1 root root 4.0K 2005-10-13 12:26 .journal_info_block

Let me know if you need any more info or you cannot reproduce and want
me to help debug it...  Note this is running on a Pentium 4 so if you
have any endianness bugs that might be it...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

