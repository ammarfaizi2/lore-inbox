Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbTIDJUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTIDJUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:20:03 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:7118 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264869AbTIDJRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:17:43 -0400
Date: Thu, 4 Sep 2003 10:17:41 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [BK-PATCH-2.6-test] Minor NTFS update
Message-ID: <Pine.SOL.4.56.0309041016200.28204@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.6

Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |  175 +++++++++++++++++++++----------------
 fs/Kconfig                         |  101 +++++++++++++--------
 fs/ntfs/layout.h                   |    4
 3 files changed, 171 insertions(+), 109 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (03/07/22 1.1046.549.1)
   Adrian Bunk: Postfix an NTFS constant that is too big for an int with ULL.

<vinsci@floss.(none)> (03/07/30 1.1046.564.2)
   Kconfig:
     Update NTFS-related options and help.

<aia21@cantab.net> (03/08/07 1.1119.5.6)
   NTFS: Update documentation for Linux kernel 2.6.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Thu Sep  4 10:07:30 2003
+++ b/Documentation/filesystems/ntfs.txt	Thu Sep  4 10:07:30 2003
@@ -6,8 +6,9 @@
 =================

 - Overview
-- Supported mount options
+- Web site
 - Features
+- Supported mount options
 - Known bugs and (mis-)features
 - Using Software RAID with NTFS
 - Limitiations when using the MD driver
@@ -17,13 +18,59 @@
 Overview
 ========

-To mount an NTFS 1.2/3.x (Windows NT4/2000/XP) volume, use the filesystem
-type 'ntfs'. The driver currently works only in read-only mode, with no
-fault-tolerance or journalling supported.
-
-For fault tolerance and raid support (i.e. volume and stripe sets), you can use
-the kernel's Software RAID / MD driver. See section "Using Software RAID with
-NTFS" for details.
+Linux-NTFS comes with a number of user-space programs known as ntfsprogs.
+These include mkntfs, a full-featured ntfs file system format utility,
+ntfsundelete used for recovering files that were unintentionally deleted
+from an NTFS volume and ntfsresize which is used to resize an NTFS partition.
+See the web site for more information.
+
+To mount an NTFS 1.2/3.x (Windows NT4/2000/XP/2003) volume, use the file
+system type 'ntfs'.  The driver currently supports read-only mode (with no
+fault-tolerance, encryption or journalling) and very limited, but safe, write
+support.
+
+For fault tolerance and raid support (i.e. volume and stripe sets), you can
+use the kernel's Software RAID / MD driver. See section "Using Software RAID
+with NTFS" for details.
+
+
+Web site
+========
+
+There is plenty of additional information on the linux-ntfs web site
+at http://linux-ntfs.sourceforge.net/
+
+The web site has a lot of additional information, such as a comprehensive
+FAQ, documentation on the NTFS on-disk format, informaiton on the Linux-NTFS
+userspace utilities, etc.
+
+
+Features
+========
+
+- This is a complete rewrite of the NTFS driver that used to be in the kernel.
+  This new driver implements NTFS read support and is functionally equivalent
+  to the old ntfs driver.
+- The new driver has full support for sparse files on NTFS 3.x volumes which
+  the old driver isn't happy with.
+- The new driver supports execution of binaries due to mmap() now being
+  supported.
+- The new driver supports loopback mounting of files on NTFS which is used by
+  some Linux distributions to enable the user to run Linux from an NTFS
+  partition by creating a large file while in Windows and then loopback
+  mounting the file while in Linux and creating a Linux filesystem on it that
+  is used to install Linux on it.
+- A comparison of the two drivers using:
+	time find . -type f -exec md5sum "{}" \;
+  run three times in sequence with each driver (after a reboot) on a 1.4GiB
+  NTFS partition, showed the new driver to be 20% faster in total time elapsed
+  (from 9:43 minutes on average down to 7:53). The time spent in user space
+  was unchanged but the time spent in the kernel was decreased by a factor of
+  2.5 (from 85 CPU seconds down to 33).
+- The driver does not support short file names in general. For backwards
+  compatibility, we implement access to files using their short file names if
+  they exist. The driver will not create short file names however, and a rename
+  will discard any existing short file name.


 Supported mount options
@@ -33,31 +80,31 @@
 mount command (man 8 mount, also see man 5 fstab), the NTFS driver supports the
 following mount options:

-iocharset=name		Deprecated option. Still supported but please use
-			nls=name in the future. See description for nls=name.
+iocharset=name		Deprecated option.  Still supported but please use
+			nls=name in the future.  See description for nls=name.

 nls=name		Character set to use when returning file names.
 			Unlike VFAT, NTFS suppresses names that contain
-			unconvertible characters. Note that most character
+			unconvertible characters.  Note that most character
 			sets contain insufficient characters to represent all
-			possible Unicode characters that can exist on NTFS. To
-			be sure you are not missing any files, you are advised
-			to use nls=utf8 which is capable of representing all
-			Unicode characters.
+			possible Unicode characters that can exist on NTFS.
+			To be sure you are not missing any files, you are
+			advised to use nls=utf8 which is capable of
+			representing all Unicode characters.

-utf8=<bool>		Option no longer supported. Currently mapped to
+utf8=<bool>		Option no longer supported.  Currently mapped to
 			nls=utf8 but please use nls=utf8 in the future and
 			make sure utf8 is compiled either as module or into
-			the kernel. See description for nls=name.
+			the kernel.  See description for nls=name.

 uid=
 gid=
 umask=			Provide default owner, group, and access mode mask.
-			These options work as documented in mount(8). By
+			These options work as documented in mount(8).  By
 			default, the files/directories are owned by root and
 			he/she has read and write permissions, as well as
-			browse permission for directories. No one else has any
-			access permissions. I.e. the mode on all files is by
+			browse permission for directories.  No one else has any
+			access permissions.  I.e. the mode on all files is by
 			default rw------- and for directories rwx------, a
 			consequence of the default fmask=0177 and dmask=0077.
 			Using a umask of zero will grant all permissions to
@@ -74,7 +121,7 @@
 			any unknown options are found.

 show_sys_files=<BOOL>	If show_sys_files is specified, show the system files
-			in directory listings. Otherwise the default behaviour
+			in directory listings.  Otherwise the default behaviour
 			is to hide the system files.
 			Note that even when show_sys_files is specified, "$MFT"
 			will not be visible due to bugs/mis-features in glibc.
@@ -85,15 +132,15 @@

 case_sensitive=<BOOL>	If case_sensitive is specified, treat all file names as
 			case sensitive and create file names in the POSIX
-			namespace. Otherwise the default behaviour is to treat
+			namespace.  Otherwise the default behaviour is to treat
 			file names as case insensitive and to create file names
-			in the WIN32/LONG name space. Note, the Linux NTFS
+			in the WIN32/LONG name space.  Note, the Linux NTFS
 			driver will never create short file names and will
 			remove them on rename/delete of the corresponding long
 			file name.
 			Note that files remain accessible via their short file
-			name, if it exists. If case_sensitive, you will need to
-			provide the correct case of the short file name.
+			name, if it exists.  If case_sensitive, you will need
+			to provide the correct case of the short file name.

 errors=opt		What to do when critical file system errors are found.
 			Following values can be used for "opt":
@@ -102,27 +149,27 @@
 				    bad so it is no longer accessed, and then
 				    continue.
 			  recover:  At present only supported is recovery of
-				    the boot sector from the backup copy. If a
-				    read-only mount, the recovery is done in
-				    memory only and not written to disk.
+				    the boot sector from the backup copy.
+				    If read-only mount, the recovery is done
+				    in memory only and not written to disk.
 			Note that the options are additive, i.e. specifying:
 			   errors=continue,errors=recover
-			This means the driver will attempt to recover and if
-			that fails it will clean-up as much as possible and
+			means the driver will attempt to recover and if that
+			fails it will clean-up as much as possible and
 			continue.

 mft_zone_multiplier=	Set the MFT zone multiplier for the volume (this
 			setting is not persistent across mounts and can be
 			changed from mount to mount but cannot be changed on
-			remount). Values of 1 to 4 are allowed, 1 being the
-			default. The MFT zone multiplier determines how much
-			space is reserved for the MFT on the volume. If all
+			remount).  Values of 1 to 4 are allowed, 1 being the
+			default.  The MFT zone multiplier determines how much
+			space is reserved for the MFT on the volume.  If all
 			other space is used up, then the MFT zone will be
 			shrunk dynamically, so this has no impact on the
-			amount of free space. However, it can have an impact
+			amount of free space.  However, it can have an impact
 			on performance by affecting fragmentation of the MFT.
-			In general use the default. If you have a lot of small
-			files then use a higher value. The values have the
+			In general use the default.  If you have a lot of small
+			files then use a higher value.  The values have the
 			following meaning:
 			      Value	     MFT zone size (% of volume size)
 				1		12.5%
@@ -132,37 +179,14 @@
 			Note this option is irrelevant for read-only mounts.


-Features
-========
-
-- This is a complete rewrite of the NTFS driver that used to be in the kernel.
-  This new driver implements NTFS read support and is functionally equivalent
-  to the old ntfs driver.
-- The new driver has full support for sparse files on NTFS 3.x volumes which
-  the old driver isn't happy with.
-- The new driver supports execution of binaries due to mmap() now being
-  supported.
-- A comparison of the two drivers using:
-	time find . -type f -exec md5sum "{}" \;
-  run three times in sequence with each driver (after a reboot) on a 1.4GiB
-  NTFS partition, showed the new driver to be 20% faster in total time elapsed
-  (from 9:43 minutes on average down to 7:53). The time spent in user space
-  was unchanged but the time spent in the kernel was decreased by a factor of
-  2.5 (from 85 CPU seconds down to 33).
-- The driver does not support short file names in general. For backwards
-  compatibility, we implement access to files using their short file names if
-  they exist. The driver will not create short file names however, and a rename
-  will discard any existing short file name.
-
-
 Known bugs and (mis-)features
 =============================

 - The link count on each directory inode entry is set to 1, due to Linux not
-  supporting directory hard links. This may well confuse some user space
+  supporting directory hard links.  This may well confuse some user space
   applications, since the directory names will have the same inode numbers.
-  This also speeds up ntfs_read_inode() immensely. And we haven't found any
-  problems with this approach so far. If you find a problem with this, please
+  This also speeds up ntfs_read_inode() immensely.  And we haven't found any
+  problems with this approach so far.  If you find a problem with this, please
   let us know.


@@ -176,11 +200,11 @@
 For support of volume and stripe sets, use the kernel's Software RAID / MD
 driver and set up your /etc/raidtab appropriately (see man 5 raidtab).

-Linear volume sets, i.e. linear raid, as well as stripe sets, i.e. raid level 0,
-have been tested and work fine (though see section "Limitiations when using the
-MD driver with NTFS volumes" especially if you want to use linear raid). Even
-though untested, there is no reason why mirrors, i.e. raid level 1, and stripes
-with parity, i.e. raid level 5, should not work, too.
+Linear volume sets, i.e. linear raid, as well as stripe sets, i.e. raid level
+0, have been tested and work fine (though see section "Limitiations when using
+the MD driver with NTFS volumes" especially if you want to use linear raid).
+Even though untested, there is no reason why mirrors, i.e. raid level 1, and
+stripes with parity, i.e. raid level 5, should not work, too.

 You have to use the "persistent-superblock 0" option for each raid-disk in the
 NTFS volume/stripe you are configuring in /etc/raidtab as the persistent
@@ -207,15 +231,16 @@
 mirrors, change it to "raid-level 1", and for stripe sets with parity, change
 it to "raid-level 5".

-Note for stripe sets with parity you will also need to tell the MD driver which
-parity algorithm to use by specifying the option "parity-algorithm which",
-where you need to replace "which" with the name of the algorithm to use (see
-man 5 raidtab for available algorithms) and you will have to try the different
-available algorithms until you find one that works. Make sure you are working
-read-only when playing with this as you may damage your data otherwise. If you
-find which algorithm works please let us know (email the linux-ntfs developers
-list linux-ntfs-dev@lists.sourceforge.net or drop in on IRC in channel #ntfs
-on the irc.openprojects.net network) so we can update this documentation.
+Note for stripe sets with parity you will also need to tell the MD driver
+which parity algorithm to use by specifying the option "parity-algorithm
+which", where you need to replace "which" with the name of the algorithm to
+use (see man 5 raidtab for available algorithms) and you will have to try the
+different available algorithms until you find one that works.  Make sure you
+are working read-only when playing with this as you may damage your data
+otherwise.  If you find which algorithm works please let us know (email the
+linux-ntfs developers list linux-ntfs-dev@lists.sourceforge.net or drop in on
+IRC in channel #ntfs on the irc.freenode.net network) so we can update this
+documentation.

 Once the raidtab is setup, run for example raid0run -a to start all devices or
 raid0run /dev/md0 to start a particular md device, in this case /dev/md0.
@@ -232,14 +257,14 @@
 =====================================

 Using the md driver will not work properly if any of your NTFS partitions have
-an odd number of sectors. This is especially important for linear raid as all
+an odd number of sectors.  This is especially important for linear raid as all
 data after the first partition with an odd number of sectors will be offset by
 one or more sectors so if you mount such a partition with write support you
 will cause massive damage to the data on the volume which will only become
 apparent when you try to use the volume again under Windows.

 So when using linear raid, make sure that all your partitions have an even
-number of sectors BEFORE attempting to use it. You have been warned!
+number of sectors BEFORE attempting to use it.  You have been warned!


 ChangeLog
diff -Nru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	Thu Sep  4 10:07:30 2003
+++ b/fs/Kconfig	Thu Sep  4 10:07:30 2003
@@ -682,18 +682,18 @@
 config NTFS_FS
 	tristate "NTFS file system support"
 	help
-	  NTFS is the file system of Microsoft Windows NT, 2000 and XP.
+	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.

-	  Saying Y or M here enables read support. There is partial, but safe,
-	  write support available. For write support you must also say Y to
-	  "NTFS write support" below.
+	  Saying Y or M here enables read support.  There is partial, but
+	  safe, write support available.  For write support you must also
+	  say Y to "NTFS write support" below.

 	  There are also a number of user-space tools available, called
-	  ntfsprogs. These include ntfsundelete and ntfsresize, that work
+	  ntfsprogs.  These include ntfsundelete and ntfsresize, that work
 	  without NTFS support enabled in the kernel.

 	  This is a rewrite from scratch of Linux NTFS support and replaced
-	  the old NTFS code starting with Linux 2.5.11. A backport to
+	  the old NTFS code starting with Linux 2.5.11.  A backport to
 	  the Linux 2.4 kernel series is separately available as a patch
 	  from the project web site.

@@ -702,23 +702,23 @@

 	  This file system is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called ntfs. If you want to compile it as a
+	  The module will be called ntfs.  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.

-	  If you are not using Windows NT, 2000 or XP in addition to Linux
-	  on your computer it is safe to say N.
+	  If you are not using Windows NT, 2000, XP or 2003 in addition to
+	  Linux on your computer it is safe to say N.

 config NTFS_DEBUG
 	bool "NTFS debugging support"
 	depends on NTFS_FS
 	help
 	  If you are experiencing any problems with the NTFS file system, say
-	  Y here. This will result in additional consistency checks to be
+	  Y here.  This will result in additional consistency checks to be
 	  performed by the driver as well as additional debugging messages to
-	  be written to the system log. Note that debugging messages are
-	  disabled by default. To enable them, supply the option debug_msgs=1
+	  be written to the system log.  Note that debugging messages are
+	  disabled by default.  To enable them, supply the option debug_msgs=1
 	  at the kernel command line when booting the kernel or as an option
-	  to insmod when loading the ntfs module. Once the driver is active,
+	  to insmod when loading the ntfs module.  Once the driver is active,
 	  you can enable debugging messages by doing (as root):
 	  echo 1 > /proc/sys/fs/ntfs-debug
 	  Replacing the "1" with "0" would disable debug messages.
@@ -737,22 +737,24 @@
 	  This enables the partial, but safe, write support in the NTFS driver.

 	  The only supported operation is overwriting existing files, without
-	  changing the file length. No file or directory creation, deletion or
-	  renaming is possible.
+	  changing the file length.  No file or directory creation, deletion or
+	  renaming is possible.  Note only non-resident files can be written to
+	  so you may find that some very small files (<500 bytes or so) cannot
+	  be written to.

 	  While we cannot guarantee that it will not damage any data, we have
-	  so far not received a single report where the driver would have damaged
-	  someones data so we assume it is perfectly safe to use.
+	  so far not received a single report where the driver would have
+	  damaged someones data so we assume it is perfectly safe to use.

-	  Note: While write support is safe in this version (a rewrite from
+	  Note:  While write support is safe in this version (a rewrite from
 	  scratch of the NTFS support), it should be noted that the old NTFS
 	  write support, included in Linux 2.5.10 and before (since 1997),
 	  is not safe.

-	  This is currently useful with Topologi-Linux. Topologi-Linux is run
-	  on top of any DOS/Microsoft Windows system without partitioning
-	  your hard disk. Unlike other Linux distributions Topologi-Linux does
-	  not need its own partition. For more information see
+	  This is currently useful with TopologiLinux.  TopologiLinux is run
+	  on top of any DOS/Microsoft Windows system without partitioning your
+	  hard disk.  Unlike other Linux distributions TopologiLinux does not
+	  need its own partition.  For more information see
 	  <http://topologi-linux.sourceforge.net/>

 	  It is perfectly safe to say N here.
diff -Nru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	Thu Sep  4 10:07:32 2003
+++ b/fs/Kconfig	Thu Sep  4 10:07:32 2003
@@ -680,19 +680,33 @@
 	  module, so saying M could be dangerous.  If unsure, say N.

 config NTFS_FS
-	tristate "NTFS file system support (read only)"
+	tristate "NTFS file system support"
 	help
-	  NTFS is the file system of Microsoft Windows NT/2000/XP. For more
-	  information see <file:Documentation/filesystems/ntfs.txt>. Saying Y
-	  here would allow you to read from NTFS partitions.
+	  NTFS is the file system of Microsoft Windows NT, 2000 and XP.
+
+	  Saying Y or M here enables read support. There is partial, but safe,
+	  write support available. For write support you must also say Y to
+	  "NTFS write support" below.
+
+	  There are also a number of user-space tools available, called
+	  ntfsprogs. These include ntfsundelete and ntfsresize, that work
+	  without NTFS support enabled in the kernel.
+
+	  This is a rewrite from scratch of Linux NTFS support and replaced
+	  the old NTFS code starting with Linux 2.5.11. A backport to
+	  the Linux 2.4 kernel series is separately available as a patch
+	  from the project web site.
+
+	  For more information see <file:Documentation/filesystems/ntfs.txt>
+	  and <http://linux-ntfs.sourceforge.net/>.

 	  This file system is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
 	  The module will be called ntfs. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.

-	  If you are not using Windows NT/2000/XP in addition to Linux on your
-	  computer it is safe to say N.
+	  If you are not using Windows NT, 2000 or XP in addition to Linux
+	  on your computer it is safe to say N.

 config NTFS_DEBUG
 	bool "NTFS debugging support"
@@ -717,16 +731,31 @@
 	  debugging messages while the misbehaviour was occurring.

 config NTFS_RW
-	bool "NTFS write support (DANGEROUS)"
-	depends on NTFS_FS && EXPERIMENTAL
+	bool "NTFS write support"
+	depends on NTFS_FS
 	help
-	  This enables the experimental write support in the NTFS driver.
+	  This enables the partial, but safe, write support in the NTFS driver.

-	  WARNING: Do not use this option unless you are actively developing
-	  NTFS as it is currently guaranteed to be broken and you
-	  may lose all your data!
+	  The only supported operation is overwriting existing files, without
+	  changing the file length. No file or directory creation, deletion or
+	  renaming is possible.
+
+	  While we cannot guarantee that it will not damage any data, we have
+	  so far not received a single report where the driver would have damaged
+	  someones data so we assume it is perfectly safe to use.
+
+	  Note: While write support is safe in this version (a rewrite from
+	  scratch of the NTFS support), it should be noted that the old NTFS
+	  write support, included in Linux 2.5.10 and before (since 1997),
+	  is not safe.
+
+	  This is currently useful with Topologi-Linux. Topologi-Linux is run
+	  on top of any DOS/Microsoft Windows system without partitioning
+	  your hard disk. Unlike other Linux distributions Topologi-Linux does
+	  not need its own partition. For more information see
+	  <http://topologi-linux.sourceforge.net/>

-	  It is strongly recommended and perfectly safe to say N here.
+	  It is perfectly safe to say N here.

 endmenu

diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	Thu Sep  4 10:07:33 2003
+++ b/fs/ntfs/layout.h	Thu Sep  4 10:07:33 2003
@@ -42,8 +42,8 @@
 #define const_cpu_to_le32(x)	__constant_cpu_to_le32(x)
 #define const_cpu_to_le64(x)	__constant_cpu_to_le64(x)

-/* The NTFS oem_id */
-#define magicNTFS	const_cpu_to_le64(0x202020205346544e) /* "NTFS    " */
+/* The NTFS oem_id "NTFS    " */
+#define magicNTFS	const_cpu_to_le64(0x202020205346544eULL)

 /*
  * Location of bootsector on partition:

===================================================================

This BitKeeper patch contains the following changesets:
1.1119.5.6
## Wrapped with gzip_uu ##


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
"

This BitKeeper patch contains the following changesets:
1.1046.564.2
## Wrapped with gzip_uu ##


M'XL( -< 5S\  [57;6_;-A#^;/V*0_NE16U9+Y9E&TV1KEFVHFT:- W:81L&
M6J(LSA(ID%1<%_[QNZ/DN$[:81NZQ(%>2#Z\>^ZYA\Y#N#9<+P9,L"CT'L+/
MRMC%(&/2LJ4ON<57[Y3"5^-2U7SLIHVE+<PH\J<>CEXRFY5PP[59#$(_OGUC
MMPU?#-[]^-/UZ^?O/._D!%Z43*[X%;=P<N)9I6]8E9M39LM*2=]J)DW-+?,S
M5>]NI^ZB((CP-PG3.$BFNW :3-)=%N9AR"8ASX-H,IM./!?6Z2'J8X X2*-9
M,(O3)-TEX3R.O3,(_3"83/UD.O$C".)QD([C ,)@$86+('D2Q(L@@!LA329.
MBTH9XS^22O+'\"2$4>#] -\W@1=>!J\R)0NQ6N MP'63,\OAXOWYU4CS"N]S
M4(T52AI@,H>25XWOO8(DQ.R\RP.YWNA?_GA>P +O&7P63<.KTTK(]M.HGL[6
MOM*K7_=I_KXKS+B/T.44(JW!)([BV2Z:)TF\FR5I6K \7T;)A*=!\37V[H!@
MZ B2(C7S73#!1Z>3PQP2RO<.RV/KIC[-Q8HKJM0WD>)@BK*)DRB8[Z(XGL^<
M:*+9D5C"=!'/_TXLDPA&8?R_R.6?*L3Q^A9&>N,^6/#++RC^#W(YF\YB"+V7
MW65@M3"6(GE H4 A*@YF:RROP;1-H[1]0$L2B&E)"F'J#<"%#<* +?G1$E7
M&Y%I951AX8.0N=H8G#P$)"9P>7V\]+W?".**;85<P2^@-+S!=#4'+MFRX@8T
M9_E^=Q_>NS'<K&':"E8-8=E:,*S@0\+9:('1][.!W3!1$8H/YPA\/+A5+=2M
MP5F548BPQ=VM D+ILC^:_@"6O%*;/MPN"D9_M)B!;.LEUY1QBQ8\,@W+.**I
MRAR"&$+&JHKG!$"NVVBU,BXC@QG)K&IS[@9:F?.*X]Y$$;W0W(C/N-Z6S,)&
MZ;5+5=A28>XNUGU2'6DYPKEJK+F6O+H-&FG##T-*N]P*K;"PF78FC[&_IL8\
M!J00-&\JS,<%3JBJRKM)F<*(43!8"2P>!=1#1'[BAZ$/SV')LK4#LFJ_?#]E
MTH<'R)C@+C3#L:RHOVI[H T8A=Q0C(3@8B88I.]/GB$?? D&L^FSI$+7BC0B
M"Z5K1DV$N!R>DC079RIK:XYG"[T?TZM.K,8=A+[]9)\1"J7]M+2V68S'G5VY
M8:-:G7'$77$ZFL;/?&R'^00B;(=Y@A=<^K)PTB)Q2&51#\3-/?5CE!\OJ4QH
M9\+%B-ISS! &/B*&1H+KIK4H+&$=/2ASFD=BO<"MTRB@K=,HI*V7*+>O2M<;
MY+SA,C>$2^-_G%_18M?YW64OCWW3.8+O==B=#NI%YG;,M<#O#2XFYPYIA.XP
MZWL%]\6*]LN<M7'=%0:W5+B.<(DF_@G]AVY<889[C1-,1K9*0[<N4W&YLJ4/
M%ZI[1DISH5$22F\A0]N@'8;@>HGV4IIP-*98$PYY"-J[('OHI/.A))@-QSZ5
M5+I5BV*4%K7C&@]KL!%5Y:J:LYJMJ$&W>&O9D%:5[(83#!I"P;2;AM%PY"5'
M 9,,$!U[B:C;. .A5#KBL*M;["J"Z+'S#JKF>/@8MPD!;Z@=#"JX5P0266#&
MQ&ZO#?2?/IT+9?EBG]1QX7HIN0+B WWC(X8>'5N#B^#@#K>U[F$>#RD(4[K(
MET[MF*FCZDN7N&?+P[W9.9OZPC"Z,V%)_<7A$1*&'AK.Y^EC9^T8)U%*@=\Q
MM*S56%4B 9,OVJISHO>J495:B9';P;_S3.MT*_MFLZJA#*F<9V^OQO=/K?Y$
MVWNN:PT2%1:5(%RSEDSGJ$"S]N%:5F*-%" /NL\0!_!TQ59RA_J=8'+%C3L6
M,$')B1B+C;&1AXW\;QH;K=M;E=W#.L^Z;U?4GO.NZ^==U[_\AHR<Q;B#V#_\
99Y"5/%NC^DZ*29CDV7SN_05K/MUO<PP

This BitKeeper patch contains the following changesets:
1.1046.549.1
## Wrapped with gzip_uu ##


M'XL( -@ 5S\  \U4WVO;,!!^COZ*HWG96F+?R;(<&S+2'^LV&K:0-L]!M978
MU+&*K;0I^(^?XD##&@9;V<-T0J"[XW3?=Q_JP[S1==)3A>+$^O#5-#;II:JR
MZMZKM'6NF3'.Y>=FK?TNS:_LLAEP3S(7G2J;YO"DZR;ID1>\>NS+HTYZL\]?
MYI/S&6.C$5SFJEKI6VUA-&+6U$^JS)JQLGEI*L_6JFK6VBHO->OV-;7EB-Q9
M2%& H6Q)HHC:E#(B)4AGR,50"E9JFZMR7!;59CMH<L_4JU]K!!B1(!D@4NM*
M"&)70!ZAD%XH8H\  Q\CGW,@3,(@X?P,*4&$#O#XP ><$0R07<"_!7#)4CC/
MZD)5<+&I'A*8NCDLBRTXQ_>[ZUM(3=58UP4XH!:*QKUOX+Y8P=+4NZ3"A9X+
MF\-\,O'8#;AG)+'I@70V^,O%&"IDG^#BIETVW<C]4KV8C?7REN+(,>DLP#B,
M6W07V0X)M9!QJH>24"DZXNZXSGXRG+LJ 44MYQ2'G5;>9NXD\^Y&V!\V(@(D
M'E(X=(TXQUXBP[?2H.BWTN PX/^_-/8L_X!!_=QM-^KI$>'OD,N5"(&S;T*Z
MTS^%NUSO^S-ZO2@R..DN;IW J<_ZF5X6E8:U6A7I+M+K8"S2Q\W"FD6II?B
E6XY["P,A0R&T0_#Q\.FDN4X?FLUZY(8\%&$<LY_X%>"HS@0

