Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269392AbUJSKVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbUJSKVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUJSKSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:18:20 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:22223 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268119AbUJSJso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:48:44 -0400
Date: Tue, 19 Oct 2004 10:48:41 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 37/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191047360.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191047520.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191043500.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044130.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044280.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191044560.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045100.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191045410.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046000.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046160.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046300.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046440.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191046580.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191047120.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191047360.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 37/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/18 1.2061)
   NTFS: Update Documentation/filesystems/ntfs.txt with instructions on how to
         use the Device-Mapper driver with NTFS ftdisk/LDM raid.  This removes
         the linear raid problem with the Software RAID / MD driver when one
         or more of the devices has an odd number of sectors.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton, who is starting to really need a patchbombing script...
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-10-19 10:15:21 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-10-19 10:15:21 +01:00
@@ -10,8 +10,10 @@
 - Features
 - Supported mount options
 - Known bugs and (mis-)features
-- Using Software RAID with NTFS
-- Limitiations when using the MD driver
+- Using NTFS volume and stripe sets
+  - The Device-Mapper driver
+  - The Software RAID / MD driver
+  - Limitiations when using the MD driver
 - ChangeLog
 
 
@@ -199,11 +201,161 @@
 list at sourceforge: linux-ntfs-dev@lists.sourceforge.net
 
 
-Using Software RAID with NTFS
-=============================
+Using NTFS volume and stripe sets
+=================================
 
-For support of volume and stripe sets, use the kernel's Software RAID / MD
-driver and set up your /etc/raidtab appropriately (see man 5 raidtab).
+For support of volume and stripe sets, you can either use the kernel's
+Device-Mapper driver or the kernel's Software RAID / MD driver.  The former is
+the recommended one to use for linear raid.  But the latter is required for
+raid level 5.  For striping and mirroring, either driver should work fine.
+
+
+The Device-Mapper driver
+------------------------
+
+You will need to create a table of the components of the volume/stripe set and
+how they fit together and load this into the kernel using the dmsetup utility
+(see man 8 dmsetup).
+
+Linear volume sets, i.e. linear raid, has been tested and works fine.  Even
+though untested, there is no reason why stripe sets, i.e. raid level 0, and
+mirrors, i.e. raid level 1 should not work, too.  Stripes with parity, i.e.
+raid level 5, unfortunately cannot work yet because the current version of the
+Device-Mapper driver does not support raid level 5.  You may be able to use the
+Software RAID / MD driver for raid level 5, see the next section for details.
+
+To create the table describing your volume you will need to know each of its
+components and their sizes in sectors, i.e. multiples of 512-byte blocks.
+
+For NT4 fault tolerant volumes you can obtain the sizes using fdisk.  So for
+example if one of your partitions is /dev/hda2 you would do:
+
+$ fdisk -ul /dev/hda
+
+Disk /dev/hda: 81.9 GB, 81964302336 bytes
+255 heads, 63 sectors/track, 9964 cylinders, total 160086528 sectors
+Units = sectors of 1 * 512 = 512 bytes
+
+   Device Boot      Start         End      Blocks   Id  System
+   /dev/hda1   *          63     4209029     2104483+  83  Linux
+   /dev/hda2         4209030    37768814    16779892+  86  NTFS
+   /dev/hda3        37768815    46170809     4200997+  83  Linux
+
+And you would know that /dev/hda2 has a size of 37768814 - 4209030 + 1 =
+33559785 sectors.
+
+For Win2k and later dynamic disks, you can for example use the ldminfo utility
+which is part of the Linux LDM tools (the latest version at the time of
+writing is linux-ldm-0.0.8.tar.bz2).  You can download it from:
+	http://linux-ntfs.sourceforge.net/downloads.html
+Simply extract the downloaded archive (tar xvjf linux-ldm-0.0.8.tar.bz2), go
+into it (cd linux-ldm-0.0.8) and change to the test directory (cd test).  You
+will find the precompiled (i386) ldminfo utility there.  NOTE: You will not be
+able to compile this yourself easily so use the binary version!
+
+Then you would use ldminfo in dump mode to obtain the necessary information:
+
+$ ./ldminfo --dump /dev/hda
+
+This would dump the LDM database found on /dev/hda which describes all of your
+dinamic disks and all the volumes on them.  At the bottom you will see the
+VOLUME DEFINITIONS section which is all you really need.  You may need to look
+further above to determine which of the disks in the volume definitions is
+which device in Linux.  Hint: Run ldminfo on each of your dinamic disks and
+look at the Disk Id close to the top of the output for each (the PRIVATE HEADER
+section).  You can then find these Disk Ids in the VBLK DATABASE section in the
+<Disk> components where you will get the LDM Name for the disk that is found in
+the VOLUME DEFINITIONS section.
+
+Note you will also need to enable the LDM driver in the Linux kernel.  If your
+distribution did not enable it, you will need to recompile the kernel with it
+enabled.  This will create the LDM partitions on each device at boot time.  You
+would then use those devices (for /dev/hda they would be /dev/hda1, 2, 3, etc)
+in the Device-Mapper table.
+
+You can also bypass using the LDM driver by using the main device (e.g.
+/dev/hda) and then using the offsets of the LDM partitions into this device as
+the "Start sector of device" when creating the table.  Once again ldminfo would
+give you the correct information to do this.
+
+Assuming you know all your devices and their sizes things are easy.
+
+For a linear raid the table would look like this (note all values are in
+512-byte sectors):
+
+--- cut here ---
+# Offset into	Size of this	Raid type	Device		Start sector
+# volume	device						of device
+0		1028161		linear		/dev/hda1	0
+1028161		3903762		linear		/dev/hdb2	0
+4931923		2103211		linear		/dev/hdc1	0
+--- cut here ---
+
+For a striped volume, i.e. raid level 0, you will need to know the chunk size
+you used when creating the volume.  Windows uses 64kiB as the default, so it
+will probably be this unless you changes the defaults when creating the array.
+
+For a raid level 0 the table would look like this (note all values are in
+512-byte sectors):
+
+--- cut here ---
+# Offset   Size	    Raid     Number   Chunk  1st        Start	2nd	  Start
+# into     of the   type     of	      size   Device	in	Device	  in
+# volume   volume	     stripes			device		  device
+0	   2056320  striped  2	      128    /dev/hda1	0	/dev/hdb1 0
+--- cut here ---
+
+If there are more than two devices, just add each of them to the end of the
+line.
+
+Finally, for a mirrored volume, i.e. raid level 1, the table would look like
+this (note all values are in 512-byte sectors):
+
+--- cut here ---
+# Ofs Size   Raid   Log  Number Region Should Number Source  Start Taget  Start
+# in  of the type   type of log size   sync?  of     Device  in    Device in
+# vol volume		 params		     mirrors	     Device	  Device
+0    2056320 mirror core 2	16     nosync 2	   /dev/hda1 0   /dev/hdb1 0
+--- cut here ---
+
+If you are mirroring to multiple devices you can specify further targets at the
+end of the line.
+
+Note the "Should sync?" parameter "nosync" means that the two mirrors are
+already in sync which will be the case on a clean shutdown of Windows.  If the
+mirrors are not clean, you can specify the "sync" option instead of "nosync"
+and the Device-Mapper driver will then copy the entirey of the "Source Device"
+to the "Target Device" or if you specified multipled target devices to all of
+them.
+
+Once you have your table, save it in a file somewhere (e.g. /etc/ntfsvolume1),
+and hand it over to dmsetup to work with, like so:
+
+$ dmsetup create myvolume1 /etc/ntfsvolume1
+
+You can obviously replace "myvolume1" with whatever name you like.
+
+If it all worked, you will now have the device /dev/device-mapper/myvolume1
+which you can then just use as an argument to the mount command as usual to
+mount the ntfs volume.  For example:
+
+$ mount -t ntfs -o ro /dev/device-mapper/myvolume1 /mnt/myvol1
+
+(You need to create the directory /mnt/myvol1 first and of course you can use
+anything you like instead of /mnt/myvol1 as long as it is an existing
+directory.)
+
+It is advisable to do the mount read-only to see if the volume has been setup
+correctly to avoid the possibility of causing damage to the data on the ntfs
+volume.
+
+
+The Software RAID / MD driver
+-----------------------------
+
+An alternative to using the Device-Mapper driver is to use the kernel's
+Software RAID / MD driver.  For which you need to set up your /etc/raidtab
+appropriately (see man 5 raidtab).
 
 Linear volume sets, i.e. linear raid, as well as stripe sets, i.e. raid level
 0, have been tested and work fine (though see section "Limitiations when using
@@ -258,8 +410,8 @@
 ntfs volume.
 
 
-Limitiations when using the MD driver
-=====================================
+Limitiations when using the Software RAID / MD driver
+-----------------------------------------------------
 
 Using the md driver will not work properly if any of your NTFS partitions have
 an odd number of sectors.  This is especially important for linear raid as all
@@ -271,6 +423,9 @@
 So when using linear raid, make sure that all your partitions have an even
 number of sectors BEFORE attempting to use it.  You have been warned!
 
+Even better is to simply use the Device-Mapper for linear raid and then you do
+not have this problem with odd numbers of sectors.
+
 
 ChangeLog
 =========
@@ -281,6 +436,8 @@
 	- Fix several race conditions and various other bugs.
 	- Many internal cleanups, code reorganization, optimizations, and mft
 	  and index record writing code rewritten to fit in with the changes.
+	- Update Documentation/filesystems/ntfs.txt with instructions on how to
+	  use the Device-Mapper driver with NTFS ftdisk/LDM raid.
 2.1.20:
 	- Fix two stupid bugs introduced in 2.1.18 release.
 2.1.19:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-19 10:15:21 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:15:21 +01:00
@@ -138,6 +138,10 @@
 	  record sequence number if it is specified (i.e. not zero).
 	- Add fs/ntfs/mft.[hc]::ntfs_mft_record_alloc() and various helper
 	  functions used by it.
+	- Update Documentation/filesystems/ntfs.txt with instructions on how to
+	  use the Device-Mapper driver with NTFS ftdisk/LDM raid.  This removes
+	  the linear raid problem with the Software RAID / MD driver when one
+	  or more of the devices has an odd number of sectors.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
