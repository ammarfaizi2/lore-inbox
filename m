Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUB0VVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUB0VVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:21:21 -0500
Received: from mail.gmx.de ([213.165.64.20]:24530 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263126AbUB0VQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:16:42 -0500
X-Authenticated: #7370606
Message-ID: <403FB3B1.7050600@gmx.at>
Date: Fri, 27 Feb 2004 22:16:33 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dm-devel@sistina.com, evms-devel@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: evms plugin for hptraid support <<<pre-alpha>>>
Content-Type: multipart/mixed;
 boundary="------------050003080801070204030600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050003080801070204030600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi,

this is my attempt to add support for the ataraid devices to the 2.6 
kernel. the code is as far as possible from being mature and useable as 
one could imagine (i have not even requested any plugin-ids for the evms 
engine). for now it only detects the HPT370A controller, because of i am 
  checking the pci-ids of the controller to prevent that any non-raid 
disks are stolen by the raid module. this would happen with the current 
ataraid code from the kernel v2.4.

the attached patch applies against evms 2.2.2 and adds a bios module for 
handling the hpt-volumes. after running evms_activate the partitions on 
the raid volumes nodes are created as /dev/evms/hptraidXpY. X is the 
volume index and Y is the partition number. i succeeded in mounting a 
4gb fat partition and tarring up the contents. more testing is still on 
my todo list.

the code is based on the local disk manager plugin and i hope i have got 
all the copyright stuff right.

the current features are:
* supports the HPT370A raid controller
* supports disk striping (raid-0)
* works with kernel 2.6 (tested with 2.6.2)
* the volume is scanned by the segment managers (dos & bsd) to create 
block devices for the partitions

todos:
* access to the last sector (kernel 2.6 only)
* add more controllers
* add mode raid levels
* create "whole disk" volume (currently only under .nodes)
* use sysfs for scanning
* get official evms plugin ids
* more modular design to make it easier to add code for other controllers
* more testing

i am sure i did it *all wrong* so comments are welcome. after all, this 
is the first thing that i ever did with evms. ;)

greetings,
wilfried

PS: can anyone get me a plugin id?

--------------050003080801070204030600
Content-Type: text/plain;
 name="evms-2.2.2-hptraid-0.0.0.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="evms-2.2.2-hptraid-0.0.0.patch"

diff -Nurp evms-2.2.2/aclocal.m4 evms-2.2.2-bios/aclocal.m4
--- evms-2.2.2/aclocal.m4	Tue Oct 21 17:56:25 2003
+++ evms-2.2.2-bios/aclocal.m4	Sun Feb 22 15:25:15 2004
@@ -131,11 +131,16 @@ AC_ARG_ENABLE([rsct],
 			     [Disable the RSCT plugin]),
 	      [build_rsct=3D"$enableval"],
 	      [build_rsct=3D"yes"])
+AC_ARG_ENABLE([bios],
+	      AC_HELP_STRING([--disable-bios],
+			     [Disable the BIOS plugin]),
+	      [build_bios=3D"$enableval"],
+	      [build_bios=3D"yes"])
=20
 # Create the list of plugin directories to build. This is where each plu=
gin
 # can specify its dependencies.
 plugin_dirs=3D""
-plugin_distdirs=3D"aix bbr bbr_seg bsd csm disk dos drivelink ext2 gpt h=
a jfs lvm mac md ogfs os2 reiser replace rsct s390 snapshot sparse swap x=
fs"
+plugin_distdirs=3D"aix bbr bbr_seg bsd csm disk dos drivelink ext2 gpt h=
a jfs lvm mac md ogfs os2 reiser replace rsct s390 snapshot sparse swap x=
fs bios"
=20
 # AIX
 if test "$build_aix" =3D "no"; then
@@ -355,6 +360,14 @@ elif test "$have_uuid" =3D "no"; then
 else
 	plugin_dirs=3D"$plugin_dirs xfs"
 	AC_MSG_NOTICE([     building xfs])
+fi
+
+# bios
+if test "$build_bios" =3D "no"; then
+	AC_MSG_NOTICE([     not building bios ... disabled by user])
+else
+	plugin_dirs=3D"$plugin_dirs bios"
+	AC_MSG_NOTICE([     building bios])
 fi
=20
 AC_SUBST(plugin_dirs)
diff -Nurp evms-2.2.2/configure evms-2.2.2-bios/configure
--- evms-2.2.2/configure	Mon Jan 19 17:48:46 2004
+++ evms-2.2.2-bios/configure	Sun Feb 22 15:27:31 2004
@@ -866,6 +866,7 @@ Optional Features:
   --disable-jfs           Disable the JFS FSIM
   --disable-reiser        Disable the ReiserFS FSIM
   --disable-xfs           Disable the XFS FSIM
+  --disable-bios          Disable the BIOS plugin
   --disable-swap          Disable the Swap FSIM
   --disable-replace       Disable the Replace plugin
   --disable-ha            Disable the HA plugin
@@ -10310,6 +10311,13 @@ if test "${enable_xfs+set}" =3D set; then
 else
   build_xfs=3D"yes"
 fi;
+# Check whether --enable-bios or --disable-bios was given.
+if test "${enable_bios+set}" =3D set; then
+  enableval=3D"$enable_bios"
+  build_bios=3D"$enableval"
+else
+  build_bios=3D"yes"
+fi;
 # Check whether --enable-swap or --disable-swap was given.
 if test "${enable_swap+set}" =3D set; then
   enableval=3D"$enable_swap"
@@ -10342,7 +10350,7 @@ fi;
 # Create the list of plugin directories to build. This is where each plu=
gin
 # can specify its dependencies.
 plugin_dirs=3D""
-plugin_distdirs=3D"aix bbr bbr_seg bsd csm disk dos drivelink ext2 gpt h=
a jfs lvm mac md ogfs os2 reiser replace rsct s390 snapshot sparse swap x=
fs"
+plugin_distdirs=3D"aix bbr bbr_seg bsd csm disk dos drivelink ext2 gpt h=
a jfs lvm mac md ogfs os2 reiser replace rsct s390 snapshot sparse swap x=
fs bios"
=20
 # AIX
 if test "$build_aix" =3D "no"; then
@@ -10626,6 +10634,16 @@ else
 echo "$as_me:      building xfs" >&6;}
 fi
=20
+# BIOS
+if test "$build_bios" =3D "no"; then
+	{ echo "$as_me:$LINENO:      not building bios ... disabled by user" >&=
5
+echo "$as_me:      not building bios ... disabled by user" >&6;}
+else
+	plugin_dirs=3D"$plugin_dirs bios"
+	{ echo "$as_me:$LINENO:      building bios" >&5
+echo "$as_me:      building bios" >&6;}
+fi
+
=20
=20
=20
@@ -10751,7 +10769,7 @@ fi
=20
=20
=20
-                                                                        =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                              ac_config_files=3D"$ac_conf=
ig_files make.rules Makefile lib/Makefile lib/dlist/Makefile engine/Makef=
ile plugins/Makefile plugins/aix/Makefile plugins/bbr/Makefile plugins/bb=
r_seg/Makefile plugins/bsd/Makefile plugins/csm/Makefile plugins/disk/Mak=
efile plugins/dos/Makefile plugins/drivelink/Makefile plugins/ext2/Makefi=
le plugins/gpt/Makefile plugins/ha/Makefile plugins/jfs/Makefile plugins/=
lvm/Makefile plugins/mac/Makefile plugins/md/Makefile plugins/ogfs/Makefi=
le plugins/os2/Makefile plugins/reiser/Makefile plugins/replace/Makefile =
plugins/rsct/Makefile plugins/s390/Makefile plugins/snapshot/Makefile plu=
gins/sparse/Makefile plugins/swap/Makefile plugins/xfs/Makefile ui/Makefi=
le ui/cli/Makefile ui/gtk/Makefile ui/ncurses/Makefile ui/ncurses2/Makefi=
le ui/utils/Makefile include/Makefile doc/Makefile doc/man/Makefile tests=
/Makefile"
+                                                                        =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                              ac_config_files=3D"$ac_conf=
ig_files make.rules Makefile lib/Makefile lib/dlist/Makefile engine/Makef=
ile plugins/Makefile plugins/aix/Makefile plugins/bbr/Makefile plugins/bb=
r_seg/Makefile plugins/bsd/Makefile plugins/csm/Makefile plugins/disk/Mak=
efile plugins/dos/Makefile plugins/drivelink/Makefile plugins/ext2/Makefi=
le plugins/gpt/Makefile plugins/ha/Makefile plugins/jfs/Makefile plugins/=
lvm/Makefile plugins/mac/Makefile plugins/md/Makefile plugins/ogfs/Makefi=
le plugins/os2/Makefile plugins/reiser/Makefile plugins/replace/Makefile =
plugins/rsct/Makefile plugins/s390/Makefile plugins/snapshot/Makefile plu=
gins/sparse/Makefile plugins/swap/Makefile plugins/xfs/Makefile plugins/b=
ios/Makefile ui/Makefile ui/cli/Makefile ui/gtk/Makefile ui/ncurses/Makef=
ile ui/ncurses2/Makefile ui/utils/Makefile include/Makefile doc/Makefile =
doc/man/Makefile tests/Makefile"
=20
=20
 cat >confcache <<\_ACEOF
@@ -11335,6 +11353,7 @@ do
   "plugins/sparse/Makefile" ) CONFIG_FILES=3D"$CONFIG_FILES plugins/spar=
se/Makefile" ;;
   "plugins/swap/Makefile" ) CONFIG_FILES=3D"$CONFIG_FILES plugins/swap/M=
akefile" ;;
   "plugins/xfs/Makefile" ) CONFIG_FILES=3D"$CONFIG_FILES plugins/xfs/Mak=
efile" ;;
+  "plugins/bios/Makefile" ) CONFIG_FILES=3D"$CONFIG_FILES plugins/bios/M=
akefile" ;;
   "ui/Makefile" ) CONFIG_FILES=3D"$CONFIG_FILES ui/Makefile" ;;
   "ui/cli/Makefile" ) CONFIG_FILES=3D"$CONFIG_FILES ui/cli/Makefile" ;;
   "ui/gtk/Makefile" ) CONFIG_FILES=3D"$CONFIG_FILES ui/gtk/Makefile" ;;
diff -Nurp evms-2.2.2/plugins/bios/Makefile.in evms-2.2.2-bios/plugins/bi=
os/Makefile.in
--- evms-2.2.2/plugins/bios/Makefile.in	Thu Jan  1 01:00:00 1970
+++ evms-2.2.2-bios/plugins/bios/Makefile.in	Fri Feb 27 21:20:57 2004
@@ -0,0 +1,52 @@
+# Enterprise Volume Management System
+#
+# (C) Copyright IBM Corp. 2003
+#
+# This program is free software;  you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY;  without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+# the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program;  if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
+
+srcdir =3D @srcdir@
+top_srcdir =3D @top_srcdir@
+include @top_srcdir@/make.rules
+
+NAME		=3D bios
+TARGET		=3D $(PLUGIN_TARGET)
+
+MAJOR_VERSION	=3D 0
+MINOR_VERSION	=3D 0
+PATCH_LEVEL	=3D 0
+
+EVMS_DEFS	+=3D -D_FILEOFFSET_BITS=3D64
+
+all: $(TARGET)
+
+$(TARGET): .depend .export $(OBJECTS)
+	$(BUILD_PLUGIN)
+
+install: all
+	$(MKINSTALLDIRS) $(DESTDIR)$(evmspluginsdir)
+	$(INSTALL) -m 755 $(TARGET) $(DESTDIR)$(evmspluginsdir)
+
+uninstall:
+	rm -f $(DESTDIR)$(evmspluginsdir)/$(TARGET)
+
+clean:
+	rm -f .depend .export $(OBJECTS) $(TARGET)
+
+distclean: clean
+	rm -f Makefile
+
+ifeq (.depend, $(wildcard .depend))
+include .depend
+endif
diff -Nurp evms-2.2.2/plugins/bios/bios.c evms-2.2.2-bios/plugins/bios/bi=
os.c
--- evms-2.2.2/plugins/bios/bios.c	Thu Jan  1 01:00:00 1970
+++ evms-2.2.2-bios/plugins/bios/bios.c	Fri Feb 27 21:22:03 2004
@@ -0,0 +1,1355 @@
+/*
+ *   (C) Copyright IBM Corp. 2001, 2003
+ *
+ *   This program is free software;  you can redistribute it and/or modi=
fy
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ *
+ * BIOS Disk Manager plugin.
+ *
+ * Wilfried Weissmann (c) 2004
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <fcntl.h>
+#include <mntent.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <glob.h>
+
+#include <plugin.h>
+#include <ldm_dpc.h>
+#include "bios.h"
+
+engine_functions_t * EngFncs =3D NULL;
+
+char * sysfs_mount_point; /* FIXME: use sysfs */
+
+#define IDEDIR "/proc/ide"
+
+/**
+ * hptdisk
+ *
+ * structure for defining a disk that is attachted to the HPT37x control=
ler
+ **/
+struct hptdisk {
+	char devname[PATH_MAX];	/* define name of the disk */
+	char claimed;		/* set to true if the disk
+				   is attachted to a raid volume */
+	struct highpoint_raid_conf superblock;
+	int hardsector_size;
+	int32_t major;
+	int32_t minor;
+	int block_size;
+
+	struct hptdisk * next;
+};
+
+/**
+ * hptraid
+ *
+ * structure for a hpt-raid volume
+ **/
+struct hptraid {
+	char name[PATH_MAX];	/* device name of volume */
+	unsigned int stride;	/* stripesize */
+	unsigned int disks;	/* number of disks in array */
+	u_int64_t sectors;	/* disksize in sectors */
+        u_int32_t magic_0;
+        u_int32_t magic_1;
+	u_int8_t type;		/* raid level (raid-0, raid-1, ...) */
+	u_int32_t hardsector_size;
+	int block_size;
+
+	enum {setup=3D0, operational, broken} status;
+
+	dm_target_t * dm_target;	/* data structure for the device
+					   mapper */
+=09
+	struct hptdisk * disk[8];	/* pointers to the disks of the
+					   raid volume */
+
+	int fd;				/* filedestriptor for open_dev(),
+					   LD_read/write(), ... */
+
+	struct hptraid * next;
+};
+
+static struct hptdisk * scanlist=3DNULL;	/* linked list of disk attached=
 to
+					   the hpt37x controller */
+
+static struct hptraid * raidlist=3DNULL;	/* linked list of detected raid=

+					   volumes */
+
+/**
+ * isHardDisk
+ * @hd: pathname of HD in proc filesystem
+ *
+ * returns true if the device is a hard disk
+ **/
+static int isHardDisk(const char *hd) {
+	char buffer[50];
+	FILE *fd;
+
+	strncpy(buffer, hd, sizeof(buffer) - 1);
+	strncat(buffer, "/media", sizeof(buffer) - 1);
+=09
+	fd=3Dfopen(buffer, "r");
+
+	if( !fd ) {
+		return 0;
+	}
+
+	fgets(buffer, sizeof(buffer)-1, fd);
+
+	fclose(fd);
+
+	return strcmp(buffer, "disk\n")?0:1;
+}
+
+/**
+ * loadHPTConf
+ * @disk: disk structure of the harddisk
+ *
+ * loads the raid configuration data into the disk parameter structure
+ **/
+static int loadHPTConf(struct hptdisk * disk) {
+	struct stat stat;
+	int fd=3Dopen(disk->devname, O_RDONLY);
+
+	if(fd < 0) {
+		return 0; /* cannot open disk */
+	}
+
+	if(fstat(fd, &stat) =3D=3D -1) goto err;
+
+	disk->minor=3Dminor(stat.st_rdev);
+	disk->major=3Dmajor(stat.st_rdev);
+
+	if(ioctl(fd, BLKSSZGET, &(disk->hardsector_size)) =3D=3D -1) goto err;
+
+	if(ioctl(fd, BLKBSZGET, &(disk->block_size)) =3D=3D -1) goto err;
+
+	if(lseek(fd, CONFIGOFFSET, SEEK_SET) =3D=3D -1) goto err;
+
+	if(read(fd, (void *) &disk->superblock, sizeof(struct highpoint_raid_co=
nf)) !=3D
+			sizeof(struct highpoint_raid_conf)) goto err;
+
+	close(fd);
+	return 1;
+
+err:
+	close(fd);
+	return 0;
+}
+
+/**
+ * addDisk
+ * @name: device node of the harddisk (without heading "/dev/")
+ *
+ * allocates the disk structure and load the raid configuration data
+ **/
+static struct hptdisk * addDisk(const char *name) {
+
+	struct hptdisk * disk=3DEngFncs->engine_alloc(sizeof(struct hptdisk));
+
+	if(!disk) {
+		return NULL; /* Oops: out of memory! */
+	}
+
+	memset(disk, 0, sizeof(struct hptdisk));
+
+	strcpy(disk->devname, "/dev/");
+	strcat(disk->devname, name);
+
+	if(loadHPTConf(disk) && disk->superblock.magic =3D=3D 0x5a7816f0) {
+		disk->next=3Dscanlist;	/* add disk */
+		scanlist=3Ddisk;
+	} else {
+		EngFncs->engine_free(disk);		/* no config block =3D> remove */
+		disk=3DNULL;
+	}
+
+	return disk;
+}
+
+/**
+ * hpt370xScan
+ * @name: path to the controller directory in proc-fs
+ * @vendor: pci vendor id of the ide controller
+ * @device: pci device id of the ide controller
+ *
+ * scans the attached harddisks of the ide controller
+ **/
+static void hpt37xScan(const char *name, int vendor, int device) {
+	DIR *ctrldir;
+	struct dirent *dir;
+	struct hptdisk * current;
+	char buffer[50]=3DIDEDIR "/";
+	char hdpath[50];
+
+	switch(vendor) {	/* FIXME: this only supports the HPT370A */
+		case 0x1103:
+			break;
+		default:
+			return;
+	}
+
+	switch(device) {
+		case 0x0004:
+			break;
+		default:
+			return;
+	}
+
+	strncat(buffer, name, sizeof(buffer) - 1);
+
+	ctrldir=3Dopendir(buffer);
+
+	if( !ctrldir ) {
+		perror(buffer);
+		return;
+	}
+
+	while( (dir =3D readdir(ctrldir)) ) {
+		if( (dir->d_type =3D=3D DT_DIR) &&
+				!(strncmp(dir->d_name, "hd", 2)) ) {
+
+			strncpy(hdpath, buffer, sizeof(buffer) - 1);
+			strncat(hdpath, "/", sizeof(buffer) - 1);
+			strncat(hdpath, dir->d_name, sizeof(buffer) - 1);
+
+			if(isHardDisk(hdpath)) {
+				current=3Dscanlist;
+
+				while(current) {
+					if(!strcmp(current->devname+strlen("/dev/"),
+								dir->d_name)) {
+						break; /* disk is already there */
+					}
+					current=3Dcurrent->next;
+				}
+
+				/* add disk to scan list if disk is new*/
+				if(!current) {
+					addDisk(dir->d_name);
+				}
+			}
+		}
+	}
+
+
+	closedir(ctrldir);
+}
+
+/**
+ * findIDECtrl
+ *
+ * scan for supported IDE controllers and datafill the scanlist with
+ * the attached harddisks
+ **/
+static int findIDECtrl() {
+	DIR *idedir;
+	struct dirent * dir;
+
+	idedir =3D opendir( IDEDIR );
+
+	if( ! idedir ) {
+		perror(IDEDIR);
+		return -1;
+	}
+
+	while( (dir =3D readdir(idedir)) ) {
+		if( (dir->d_type =3D=3D DT_DIR) &&
+				!(strncmp(dir->d_name, "ide", 3)) ) {
+
+			char config[50]=3DIDEDIR "/";
+			FILE *fd;
+			int vendor, device;
+
+			strncat(config, dir->d_name, sizeof(config)-1);
+			strncat(config, "/config", sizeof(config)-1);
+
+			fd=3Dfopen(config, "r");
+
+			if( !fd ) {
+				perror(config);
+				continue;
+			}
+
+			if( fscanf(fd, "pci bus %*i device %*i vendor %x device %x",
+				&vendor, &device) =3D=3D 2) {
+
+				hpt37xScan(dir->d_name, vendor, device);
+			}
+
+			fclose(fd);
+		}
+	}
+
+	closedir(idedir);
+	return 0;
+}
+
+/**
+ * round_down
+ * @value:	Value (in sectors) to be rounded down.
+ * @boundary:	Boundary (in bytes) to round-down to.
+ *
+ * Given a value, round it down to be a multiple of the specified bounda=
ry size.
+ **/
+static inline sector_count_t round_down(sector_count_t value,
+					u_int32_t boundary)
+{
+	sector_count_t boundary_in_vsectors =3D ((sector_count_t)boundary) >>
+					      EVMS_VSECTOR_SIZE_SHIFT;
+	return (boundary > EVMS_VSECTOR_SIZE) ?
+	       (value & ~(boundary_in_vsectors - 1)) : value;
+}
+
+/**
+ * round_up
+ * @value:	Value (in sectors) to be rounded up.
+ * @boundary:	Boundary (in bytes) to round-up to.
+ *
+ * Given a value, round it up to be a multiple of the specified boundary=
 size.
+ **/
+static inline sector_count_t round_up(sector_count_t value,
+				      u_int32_t boundary)
+{
+	sector_count_t boundary_in_vsectors =3D ((sector_count_t)boundary) >>
+					      EVMS_VSECTOR_SIZE_SHIFT;
+	sector_count_t temp_value =3D value + boundary_in_vsectors - 1;
+	return (boundary > EVMS_VSECTOR_SIZE) ?
+	       (temp_value & ~(boundary_in_vsectors - 1)) : value;
+}
+
+/**
+ * where_is_sysfs
+ *
+ * Is sysfs mounted. If so, return the mount point. The caller must free=
 the
+ * returned string.
+ **/
+static boolean where_is_sysfs(char ** mount_name)
+{
+	boolean result =3D FALSE;
+	FILE * mount_records;
+	struct mntent * mount_entry;
+
+	LOG_ENTRY();
+
+	if (mount_name) {
+		*mount_name =3D NULL;
+	}
+
+	mount_records =3D setmntent(MOUNTED, "r");
+	if (mount_records =3D=3D NULL) {
+		mount_records =3D setmntent("/proc/mounts", "r");
+	}
+	if (mount_records =3D=3D NULL) {
+		LOG_ERROR("Could not get list of mounted devices.\n");
+		goto out;
+	}
+
+	while (!result && (mount_entry =3D getmntent(mount_records)) !=3D NULL)=
 {
+		if (strcmp(mount_entry->mnt_type, "sysfs") =3D=3D 0) {
+			result =3D TRUE;
+			if (mount_name) {
+				*mount_name =3D strdup(mount_entry->mnt_dir);
+			}
+		}
+	}
+
+	endmntent(mount_records);
+
+out:
+	LOG_EXIT_BOOL(result);
+	return result;
+}
+
+static int LD_setup(engine_functions_t * engine_function_table)
+{
+	/* save info we get from the engine */
+	EngFncs =3D engine_function_table;
+
+	LOG_ENTRY();
+
+	where_is_sysfs(&sysfs_mount_point);
+
+	LOG_EXIT_INT(0);
+	return 0;
+}
+
+/**
+ * open_dev
+ *
+ * Open the specified disk. Use O_DIRECT to avoid caching. Use O_SYNC in=
 case
+ * the kernel does not honor O_DIRECT. Use the Engine's service so we
+ * automatically get a dev-node in the /dev/evms/.nodes/ tree. Record th=
e
+ * file handle in the disk's private data.
+ **/
+static int open_dev(storage_object_t * disk)
+{
+	int rc =3D 0;
+	int * fd =3D &((struct hptraid *)disk->private_data)->fd;
+
+	LOG_ENTRY();
+
+	if (*fd <=3D 0) {
+		*fd =3D EngFncs->open_object(disk, O_RDWR | O_DIRECT | O_SYNC);
+		if (*fd < 0) {
+			rc =3D -*fd;
+			LOG_DEBUG("Error opening disk %s: %d: %s\n",
+				  disk->name, rc, strerror(rc));
+		}
+	}
+
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * close_dev
+ *
+ * Close the disk and clear the file handle.
+ **/
+static void close_dev(storage_object_t * disk)
+{
+	int * fd =3D &((struct hptraid *)disk->private_data)->fd;
+	int rc;
+
+	LOG_ENTRY();
+
+	if (*fd >=3D 0) {
+		rc =3D EngFncs->close_object(disk, *fd);
+		if (!rc) {
+			*fd =3D -1;
+		}
+	}
+
+	LOG_EXIT_VOID();
+}
+
+/**
+ * LD_cleanup
+ *
+ * Find any disks and close the device that was opended during discovery=
=2E
+ **/
+static void LD_cleanup(void)
+{
+	int rc;
+	dlist_t disk_list;
+	storage_object_t * disk;
+	struct hptraid * raid;
+
+	LOG_ENTRY();
+
+	/* Get a list of disks that are managed by this plug-in. */
+	rc =3D EngFncs->get_object_list(DISK, 0, my_plugin_record,
+				      NULL, 0, &disk_list);
+	if (!rc) {
+		/* Close any dev handles that might be open. */
+		DLIST_FOR_EACH(disk, disk_list, rc) {
+			raid =3D (struct hptraid *)disk->private_data;
+			if(raid->status =3D=3D operational) {
+				EngFncs->dm_deactivate(disk);
+				EngFncs->dm_deallocate_targets(raid->dm_target);
+				close_dev(disk);
+			}
+			EngFncs->engine_free(disk->private_data);
+		}
+		DestroyList(&disk_list, FALSE);
+	}
+
+	if (sysfs_mount_point) {
+		free(sysfs_mount_point);
+		sysfs_mount_point =3D NULL;
+	}
+
+	LOG_EXIT_VOID();
+}
+
+/**
+ * get_block_size
+ *
+ * Use the BLKBSZGET ioctl to get the block-size for the specified disk.=

+ **/
+static int get_block_size(storage_object_t * disk)
+{
+	int fd =3D ((struct hptraid *)disk->private_data)->fd;
+	int rc, block_size;
+
+	LOG_ENTRY();
+
+	rc =3D ioctl(fd, BLKBSZGET, &block_size);
+	if (rc) {
+		rc =3D errno;
+		LOG_ERROR("Error getting block size for disk %s: %d: %s.\n",
+			  disk->name, rc, strerror(rc));
+	} else {
+		LOG_DEBUG("Disk %s has block-size %d.\n",
+			  disk->name, block_size);
+		disk->geometry.block_size =3D block_size;
+	}
+
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * set_block_size
+ *
+ * Use the BLKBSZSET ioctl to set the disk's block-size.
+ **/
+static int set_block_size(storage_object_t * disk, int block_size)
+{
+	int rc;
+	int fd =3D ((struct hptraid *)disk->private_data)->fd;
+
+	LOG_ENTRY();
+
+	rc =3D ioctl(fd, BLKBSZSET, &block_size);
+	if (rc) {
+		rc =3D errno;
+		LOG_ERROR("Error setting block size (%d) for disk %s: %d: "
+			  "%s.\n", block_size, disk->name, rc, strerror(rc));
+	} else {
+		LOG_DEBUG("Setting disk %s block-size to %d.\n",
+			  disk->name, block_size);
+		disk->geometry.block_size =3D block_size;
+	}
+
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * create_logical_disk
+ *
+ * Allocate a new disk and initialize all fields.
+ **/
+static storage_object_t * create_logical_disk(struct hptraid * raid)
+{
+	storage_object_t * disk =3D NULL;
+	int rc;
+
+	LOG_ENTRY();
+
+	rc =3D EngFncs->allocate_logical_disk(raid->name, &disk);
+	if (rc) {
+		LOG_SERIOUS("Error allocating new disk object for disk %s: %d: "
+			    "%s.\n", raid->name, rc, EngFncs->strerror(rc));
+		goto out;
+	}
+
+	disk->data_type =3D DATA_TYPE;
+	disk->private_data =3D raid;
+	disk->plugin			=3D my_plugin_record;
+	disk->size=3Draid->sectors;
+	disk->geometry.cylinders=3Draid->sectors / ( 255 * 63 );
+	disk->geometry.heads=3D255;
+	disk->geometry.sectors_per_track=3D63;
+	disk->geometry.block_size=3Draid->block_size;
+	disk->geometry.bytes_per_sector=3Draid->hardsector_size;
+
+out:
+	LOG_EXIT_PTR(disk);
+	return disk;
+}
+
+/**
+ * hptRAIDScan
+ * @index: index number of the raid volume
+ *
+ * scans the "scanlist" of harddisks to detect hpt-raid volumes. return =
the
+ * allocated and datafilled hptraid structure and adds it to the raidlis=
t.
+ * when no more volumes were found then NULL is returned. this function =
also
+ * detects "non-operatinal" volumes (e.g.: volumes with too less disks t=
o
+ * become active).
+ **/
+static struct hptraid * hptRAIDScan(int index) {
+	struct hptdisk * current;
+	struct hptraid * raid=3DEngFncs->engine_alloc(sizeof(struct hptraid));
+
+	if(!raid) {
+		return NULL;
+	}
+
+	memset(raid, 0, sizeof(struct hptraid));
+
+	sprintf(raid->name, "hptraid%ip", index);
+
+	/* walk the scanlist of attached harddisks */
+	for(current=3Dscanlist; current; current=3Dcurrent->next) {
+
+		if(current->claimed) continue;
+
+		/* unclaimed disk =3D> scan */
+
+		if(raid->disks) {
+			/* raid is not empty =3D> check magic cookie */
+			if(raid->magic_0 !=3D current->superblock.magic_0) {
+				continue;
+			}
+		}
+		else {
+			/* raid is empty =3D> accept any magic cookie */
+			raid->magic_0 =3D current->superblock.magic_0;
+		}
+
+			/* check for known raid types */
+		switch(current->superblock.type) {
+			case HPT_T_RAID_0:
+				break;
+			default:
+				continue;
+		}
+
+		if(current->superblock.disk_number > 8) {
+			continue;
+		}
+
+			/* add disk to raid volume */
+		raid->disk[current->superblock.disk_number]=3Dcurrent;
+			/* shift in sectors */
+		raid->stride=3D1<<current->superblock.raid0_shift;
+		raid->disks=3Dcurrent->superblock.raid_disks;
+			/* superblock contains size in sectors - 1 */
+		raid->sectors=3Dcurrent->superblock.total_secs;
+		raid->magic_1 =3D current->superblock.magic_1;
+		raid->hardsector_size=3Dcurrent->hardsector_size;
+		raid->block_size=3Dcurrent->block_size;
+
+		/*
+		 * FIXME: re-enable to access the last sector
+		 *
+		 * the device mapper is only happy if
+		 * (volume size)%(number of disks) =3D=3D 0
+		 *
+		 * maybe we can lie to the device mapper and tell it
+		 * that the volume is bigger so that the expression from above
+		 * is true. then use the true values for the evms engine to get
+		 * the correct volume sizes.
+		 */
+#if 0
+		if (EngFncs->is_2_4_kernel()) {
+				/* round down to 1024 bytes boundary */
+#endif
+			raid->sectors +=3D raid->sectors&1?1:0;
+#if 0
+		}
+		else {
+			raid->sectors++;
+		}
+#endif
+
+		current->claimed=3D1;
+	}
+
+	if(raid->disks =3D=3D 0) {
+		EngFncs->engine_free(raid);
+		return NULL;
+	}
+
+	raid->next=3Draidlist;	/* add to raid list */
+	raidlist=3Draid;
+
+	return raid;
+}
+
+/**
+ * hptRAIDInit
+ * @raid: raid volume to be activated
+ * @output_list: output list for LD_discover()
+ *
+ * activate the raid volume and add is the the volume output_list
+ **/
+static int hptRAIDInit(struct hptraid * raid, dlist_t output_list) {
+	int disks=3D0, count;
+	storage_object_t * object;
+	void * handle;
+
+		/* raid is already running */
+	if(raid->status =3D=3D operational) {
+		return 0;
+	}
+
+	for(count=3D0; count < 8; count++) {
+		if(raid->disk[count]) {
+			disks++;
+		}
+	}
+
+	if(raid->disks !=3D disks) {	/* missing disks */
+		LOG_SERIOUS("Missing disks in %s (%i of %i).\n", raid->name, disks, ra=
id->disks);
+		goto err;
+	}
+
+		/* datafill device mapper structures */
+	raid->dm_target =3D EngFncs->dm_allocate_target(DM_TARGET_STRIPE, 0,
+			raid->sectors, raid->disks);
+
+	raid->dm_target->data.stripe->chunk_size=3Draid->stride;
+	raid->dm_target->data.stripe->num_stripes=3Draid->disks;
+	for(count=3D0; count < raid->disks; count++) {
+		struct dm_device * dm_device=3Draid->dm_target->data.stripe->devices+c=
ount;
+		struct hptdisk * hptdisk=3Draid->disk[count];
+		dm_device->major=3Dhptdisk->major;
+		dm_device->minor=3Dhptdisk->minor;
+		dm_device->start=3Dcount?10:0;
+	}
+
+	object=3Dcreate_logical_disk(raid);
+	if(!object) {
+		LOG_SERIOUS("Failed to create %s.\n", raid->name);
+		goto err1;
+	}
+
+	if( EngFncs->dm_activate(object, raid->dm_target) ) {
+		LOG_SERIOUS("Failed to activate %s.\n", object->name);
+		goto err2;
+	}
+
+	LOG_DETAILS("New Logical Disk:\n");
+	LOG_DETAILS("  name:          %s\n", object->name);
+	LOG_DETAILS("  size:          %"PRIu64"\n", object->size);
+	LOG_DETAILS("  device-number: %x:%x\n", object->dev_major, object->dev_=
minor);
+	LOG_DETAILS("  geometry:\n");
+	LOG_DETAILS("    cylinders:   %"PRIu64"\n", object->geometry.cylinders)=
;
+	LOG_DETAILS("    heads:       %d\n", object->geometry.heads);
+	LOG_DETAILS("    sectors:     %d\n", object->geometry.sectors_per_track=
);
+	LOG_DETAILS("    sector size: %d (bytes)\n", object->geometry.bytes_per=
_sector);
+	LOG_DETAILS("    block size:  %"PRIu64" (bytes)\n", object->geometry.bl=
ock_size);
+
+	open_dev(object);
+
+	/* Insert the new disk into ouput list. */
+	if( InsertObject(output_list, object, DISK_TAG, NULL,
+			  AppendToList, TRUE, &handle) ) {
+		LOG_SERIOUS("Error adding new disk %s to output list. "
+			    "Deleting the disk.\n", object->name);
+		EngFncs->engine_free(object->private_data);
+		EngFncs->free_logical_disk(object);
+		goto err;
+	}
+
+	raid->status=3Doperational;
+	return 1;
+
+err2:
+	EngFncs->free_logical_disk(object);
+err1:
+	EngFncs->dm_deallocate_targets(raid->dm_target);
+err:
+	raid->status=3Dbroken;
+	return 0;
+}
+
+/**
+ * LD_discover
+ **/
+static int LD_discover(dlist_t input_list,
+		       dlist_t output_list,
+		       boolean final_call)
+{
+	int i;
+	struct hptraid * raid;
+
+	LOG_ENTRY();
+
+	findIDECtrl();	/* get list of scan devices */
+
+	for(i=3D0; (raid=3DhptRAIDScan(i)); i++) {
+		hptRAIDInit(raid, output_list);
+	}
+
+	GetListSize(output_list, &i);
+	LOG_DEBUG("Discovered %d disks.\n", i);
+	LOG_EXIT_INT(0);
+	return 0;
+}
+
+/**
+ * get_alignment_size
+ *
+ * Return the size (in bytes) of the alignment restrictions for O_DIRECT=
=2E On
+ * 2.5 kernels, this will be the disk's hard-sector-size. On 2.4 kernels=
, this
+ * will be the disk's block-size. Since block-size can change at run-tim=
e,
+ * always check the current block-size. Also, since we want access to as=
 much
+ * of the disk as possible, try to set the block-size to 1k if it isn't
+ * already.
+ **/
+static int get_alignment_size(storage_object_t * disk)
+{
+	int size;
+	int min_block_size =3D max(disk->geometry.bytes_per_sector, 1024);
+
+	LOG_ENTRY();
+
+	if (EngFncs->is_2_4_kernel()) {
+		get_block_size(disk);
+		size =3D disk->geometry.block_size;
+		if (size > min_block_size) {
+			set_block_size(disk, min_block_size);
+			size =3D disk->geometry.block_size;
+		}
+	} else {
+		size =3D disk->geometry.bytes_per_sector;
+	}
+
+	LOG_EXIT_INT(size);
+	return size;
+}
+
+/**
+ * get_aligned_buffer
+ * @offset:	Starting offset (in sectors) of engine I/O request.
+ * @count:	Size (in sectors) of engine I/O request.
+ * @align_size:	Size (in bytes) that the I/O must be aligned on.
+ * @local_offset:	Aligned starting offset (in sectors).
+ * @local_count:	Aligned I/O size (in sectors).
+ * @local_buffer:	New data buffer. Not aligned, but need to return this
+ *			pointer so it can be freed after using.
+ * @local_buffer_aligned:	Aligned data buffer. This points somewhere
+ *				within local_buffer.
+ *
+ * To use O_DIRECT, the buffer passed to read() or write() must be align=
ed on
+ * the device's block/sector size. The size and starting offset of the I=
/O must
+ * also be a multiple of the block/sector size.
+ **/
+static int get_aligned_buffer(lsn_t offset,
+			      sector_count_t count,
+			      int align_size,
+			      lsn_t * local_offset,
+			      sector_count_t * local_count,
+			      void ** local_buffer,
+			      void ** local_buffer_aligned)
+{
+	u_int32_t offset_diff, offset_diff_bytes;
+	u_int32_t local_buffer_bytes;
+	u_int32_t alignment_base, alignment_diff;
+	int rc =3D 0;
+
+	LOG_ENTRY();
+
+	/* Round down starting offset to the alignment size. */
+	*local_offset =3D round_down(offset, align_size);
+
+	/* Difference between real offset and local offset. */
+	offset_diff =3D offset - *local_offset;
+	offset_diff_bytes =3D offset_diff << EVMS_VSECTOR_SIZE_SHIFT;
+
+	/* Round up total count of sectors to alignment size. */
+	*local_count =3D round_up(count + offset_diff, align_size);
+
+	/* Allocate the buffer that will actually perform the I/O. This needs
+	 * to allocate enough extra to compensate for the alignment that will
+	 * occur next.
+	 */
+	local_buffer_bytes =3D *local_count << EVMS_VSECTOR_SIZE_SHIFT;
+	*local_buffer =3D EngFncs->engine_alloc(local_buffer_bytes +
+					      align_size - 1);
+	if (!*local_buffer) {
+		rc =3D ENOMEM;
+		goto out;
+	}
+
+	/* Align the buffer on hard-sector-size. */
+	alignment_base =3D (unsigned long)(*local_buffer) & (align_size - 1);
+	alignment_diff =3D (alignment_base + align_size - 1) & ~(align_size - 1=
);
+	alignment_diff -=3D alignment_base;
+	*local_buffer_aligned =3D *local_buffer + alignment_diff;
+
+	/* Sanity check */
+	if (((unsigned long)(*local_buffer_aligned) % align_size) !=3D 0) {
+		LOG_ERROR("BUFFER NOT ALIGNED!!: buf: %p, size: %u\n",
+			  *local_buffer_aligned, align_size);
+	}
+
+out:
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * LD_read
+ **/
+static int LD_read(storage_object_t * disk,
+		   lsn_t offset,
+		   sector_count_t count,
+		   void * buffer)
+{
+	void * local_buffer =3D NULL, * local_buffer_aligned;
+	lsn_t local_offset;
+	sector_count_t local_count;
+	int fd =3D ((struct hptraid *)disk->private_data)->fd;
+	int rc, align_size;
+
+	LOG_ENTRY();
+	LOG_DEBUG("Read disk:%s offset:%"PRIu64" count:%"PRIu64"\n",
+		  disk->name, offset, count);
+
+        if (offset + count > disk->size) {
+		LOG_ERROR("Read request past end of disk.\n");
+		rc =3D EINVAL;
+		goto out;
+	}
+
+	/* Make sure the disk is open. */
+	rc =3D open_dev(disk);
+	if (rc) {
+		goto out;
+	}
+
+	/* Get the alignment restriction for O_DIRECT. */
+	align_size =3D get_alignment_size(disk);
+
+	/* Get a data buffer aligned with this restriction. */
+	rc =3D get_aligned_buffer(offset, count, align_size,
+				&local_offset, &local_count,
+				&local_buffer, &local_buffer_aligned);
+	if (rc) {
+		goto out;
+	}
+
+	/* Send the read to the engine. */
+	rc =3D EngFncs->read_object(disk, fd, local_buffer_aligned,
+				  local_count << EVMS_VSECTOR_SIZE_SHIFT,
+				  local_offset << EVMS_VSECTOR_SIZE_SHIFT);
+	if (rc < 0) {
+		rc =3D -rc;
+		goto out;
+	}
+
+	/* Copy the data back to the caller's buffer. */
+	memcpy(buffer, local_buffer_aligned +
+		       ((offset - local_offset) << EVMS_VSECTOR_SIZE_SHIFT),
+	       count << EVMS_VSECTOR_SIZE_SHIFT);
+
+	rc =3D 0;
+
+out:
+	EngFncs->engine_free(local_buffer);
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * LD_write
+ **/
+static int LD_write(storage_object_t * disk,
+		    lsn_t offset,
+		    sector_count_t count,
+		    void * buffer)
+{
+	void * local_buffer =3D NULL, * local_buffer_aligned;
+	lsn_t local_offset;
+	sector_count_t local_count;
+	int fd =3D ((struct hptraid *)disk->private_data)->fd;
+	int rc, align_size;
+
+	LOG_ENTRY();
+	LOG_DEBUG("Write disk:%s offset:%"PRIu64" count:%"PRIu64"\n",
+		  disk->name, offset, count);
+
+	if (offset + count > disk->size) {
+		LOG_ERROR("Write request past end of disk.\n");
+		rc =3D EINVAL;
+		goto out;
+	}
+
+	/* Make sure the disk is open. */
+	rc =3D open_dev(disk);
+	if (rc) {
+		goto out;
+	}
+
+	/* Get the alignment restriction for O_DIRECT. */
+	align_size =3D get_alignment_size(disk);
+
+	/* Get a data buffer aligned with this restriction. */
+	rc =3D get_aligned_buffer(offset, count, align_size,
+				&local_offset, &local_count,
+				&local_buffer, &local_buffer_aligned);
+	if (rc) {
+		goto out;
+	}
+
+	if (local_count !=3D count) {
+		rc =3D EngFncs->read_object(disk, fd, local_buffer_aligned,
+					  local_count << EVMS_VSECTOR_SIZE_SHIFT,
+					  local_offset << EVMS_VSECTOR_SIZE_SHIFT);
+		if (rc < 0) {
+			rc =3D -rc;
+			goto out;
+		}
+	}
+=09
+	/* Put user data at the right place in the buffer */
+	memcpy(local_buffer_aligned +
+	       ((offset - local_offset) << EVMS_VSECTOR_SIZE_SHIFT),
+	       buffer, count << EVMS_VSECTOR_SIZE_SHIFT);
+=09
+	/* Send the write to the engine. */
+	rc =3D EngFncs->write_object(disk, fd, local_buffer_aligned,
+				   local_count << EVMS_VSECTOR_SIZE_SHIFT,
+				   local_offset << EVMS_VSECTOR_SIZE_SHIFT);
+	if (rc < 0) {
+		rc =3D -rc;
+		goto out;
+	}
+
+	rc =3D 0;
+
+out:
+	EngFncs->engine_free(local_buffer);
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * LD_add_sectors_to_kill_list
+ **/
+static int LD_add_sectors_to_kill_list(storage_object_t * disk,
+				       lsn_t lsn,
+				       sector_count_t count)
+{
+	int rc;
+	LOG_ENTRY();
+
+	if (lsn + count > disk->size) {
+		LOG_ERROR("Kill-sectors request past end of disk %s.\n",
+			  disk->name);
+		rc =3D EINVAL;
+	} else {
+		rc =3D EngFncs->add_sectors_to_kill_list(disk, lsn, count);
+	}
+
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * LD_commit_changes
+ *
+ * Disk manager doesn't do anything during commit. Just return success.
+ **/
+static int LD_commit_changes(storage_object_t * disk, commit_phase_t pha=
se)
+{
+	LOG_ENTRY();
+	LOG_EXIT_INT(0);
+	return 0;
+}
+
+/**
+ * LD_get_info
+ *
+ * Returns DISK specific information
+ **/
+static int LD_get_info(storage_object_t * disk,
+		       char * descriptor_name,
+		       extended_info_array_t ** info)
+{
+	extended_info_array_t * Info;
+	uint count =3D 0;
+	int index =3D 0, rc =3D EINVAL;
+
+	LOG_ENTRY();
+
+	if (!info) {
+		goto out;
+	}
+	*info =3D NULL;
+=09
+        if (descriptor_name) {
+		goto out;
+	}
+=09
+	Info =3D EngFncs->engine_alloc(sizeof(extended_info_array_t) +
+				     8 * sizeof(extended_info_t));
+	if (!Info) {
+		rc =3D ENOMEM;
+		goto out;
+	}
+	=09
+	SET_STRING(Info->info[index].name, "Name");
+	SET_STRING(Info->info[index].title, "Name");
+	SET_STRING(Info->info[index].desc, "EVMS name for the DISK storage obje=
ct");
+	Info->info[index].type =3D EVMS_Type_String;
+	SET_STRING(Info->info[index].value.s, disk->name);
+	index++;
+
+	SET_STRING(Info->info[index].name, "Size");
+	SET_STRING(Info->info[index].title, "Size");
+	SET_STRING(Info->info[index].desc, "Size of the disk in sectors");
+	Info->info[index].type =3D EVMS_Type_Unsigned_Int64;
+	Info->info[index].unit =3D EVMS_Unit_Sectors;
+	Info->info[index].flags |=3D EVMS_EINFO_FLAGS_NO_UNIT_CONVERSION;
+	Info->info[index].value.ui64 =3D disk->size;
+	index++;
+
+	SET_STRING(Info->info[index].name, "Cyl");
+	SET_STRING(Info->info[index].title, "Cylinders");
+	SET_STRING(Info->info[index].desc, "Drive geometry -- number of cylinde=
rs");
+	Info->info[index].type =3D EVMS_Type_Unsigned_Int64;
+	Info->info[index].value.ui64 =3D disk->geometry.cylinders;
+	index++;
+
+	SET_STRING(Info->info[index].name, "Heads");
+	SET_STRING(Info->info[index].title, "Heads");
+	SET_STRING(Info->info[index].desc, "Drive geometry -- number of heads")=
;
+	Info->info[index].type =3D EVMS_Type_Unsigned_Int32;
+	Info->info[index].value.ui32 =3D disk->geometry.heads;
+	index++;
+
+	SET_STRING(Info->info[index].name, "Sectors");
+	SET_STRING(Info->info[index].title, "Sectors");
+	SET_STRING(Info->info[index].desc, "Drive geometry -- sectors per track=
");
+	Info->info[index].type =3D EVMS_Type_Unsigned_Int32;
+	Info->info[index].value.ui32 =3D disk->geometry.sectors_per_track;
+	index++;
+
+	SET_STRING(Info->info[index].name, "SectorSize");
+	SET_STRING(Info->info[index].title, "Sector Size");
+	SET_STRING(Info->info[index].desc, "Number of bytes per sector");
+	Info->info[index].type =3D EVMS_Type_Unsigned_Int32;
+	Info->info[index].unit =3D EVMS_Unit_Bytes;
+	Info->info[index].value.ui32 =3D disk->geometry.bytes_per_sector;
+	index++;
+
+	SET_STRING(Info->info[index].name, "BlockSize");
+	SET_STRING(Info->info[index].title, "Block Size");
+	SET_STRING(Info->info[index].desc, "Number of bytes per block");
+	Info->info[index].type =3D EVMS_Type_Unsigned_Int64;
+	Info->info[index].unit =3D EVMS_Unit_Bytes;
+	Info->info[index].value.ui64 =3D disk->geometry.block_size;
+	index++;
+
+	SET_STRING(Info->info[index].name, "BootLimit");
+	SET_STRING(Info->info[index].title, "Boot Cylinder Limit");
+	SET_STRING(Info->info[index].desc, "LBA of the first sector above the b=
oot cylinder limit for this drive");
+	Info->info[index].type =3D EVMS_Type_Unsigned_Int64;
+	Info->info[index].value.ui64 =3D disk->geometry.boot_cylinder_limit;
+	index++;
+
+	GetListSize(disk->parent_objects, &count);
+	SET_STRING(Info->info[index].name, "Segments");
+	SET_STRING(Info->info[index].title, "Segments");
+	SET_STRING(Info->info[index].desc, "Number of segments discovered on th=
e drive (metadata, data, freespace)");
+	Info->info[index].type =3D EVMS_Type_Unsigned_Int32;
+	Info->info[index].value.ui32 =3D count;
+	index++;
+
+	Info->count =3D index;
+	*info =3D Info;
+	rc =3D 0;
+
+out:
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * LD_get_plugin_info
+ *
+ * Returns plug-in specific information
+ **/
+static int LD_get_plugin_info(char * descriptor_name,
+			      extended_info_array_t ** info)
+{
+	int rc =3D EINVAL;
+	extended_info_array_t * Info;
+	char version_string[64];
+	char required_engine_api_version_string[64];
+	char required_plugin_api_version_string[64];
+
+	LOG_ENTRY();
+
+	if (!info) {
+		goto out;
+	}
+	*info =3D NULL;
+
+	if (descriptor_name) {
+		goto out;
+	}
+
+	Info =3D EngFncs->engine_alloc(sizeof(extended_info_array_t) +
+				     6 * sizeof(extended_info_t));
+	if (!Info) {
+		rc =3D ENOMEM;
+		goto out;
+	}
+
+	Info->count =3D 6;
+
+	sprintf(version_string, "%d.%d.%d",
+		MAJOR_VERSION, MINOR_VERSION, PATCH_LEVEL);
+
+	sprintf(required_engine_api_version_string, "%d.%d.%d",
+		my_plugin_record->required_engine_api_version.major,
+		my_plugin_record->required_engine_api_version.minor,
+		my_plugin_record->required_engine_api_version.patchlevel);
+
+	sprintf(required_plugin_api_version_string, "%d.%d.%d",
+		my_plugin_record->required_plugin_api_version.plugin.major,
+		my_plugin_record->required_plugin_api_version.plugin.minor,
+		my_plugin_record->required_plugin_api_version.plugin.patchlevel);
+
+	SET_STRING(Info->info[0].name, "Short Name");
+	SET_STRING(Info->info[0].title, "Short Name");
+	SET_STRING(Info->info[0].desc, "A short name given to this plugin");
+	Info->info[0].type =3D EVMS_Type_String;
+	SET_STRING(Info->info[0].value.s, my_plugin_record->short_name);
+
+	SET_STRING(Info->info[1].name, "Long Name");
+	SET_STRING(Info->info[1].title, "Long Name");
+	SET_STRING(Info->info[1].desc, "A long name given to this plugin");
+	Info->info[1].type =3D EVMS_Type_String;
+	SET_STRING(Info->info[1].value.s, my_plugin_record->long_name);
+
+	SET_STRING(Info->info[2].name, "Type");
+	SET_STRING(Info->info[2].title, "Plug-in Type");
+	SET_STRING(Info->info[2].desc, "There are various types of plugins, eac=
h responsible for some kind of storage object.");
+	Info->info[2].type =3D EVMS_Type_String;
+	SET_STRING(Info->info[2].value.s, "Device Manager");
+
+	SET_STRING(Info->info[3].name, "Version");
+	SET_STRING(Info->info[3].title, "Plugin Version");
+	SET_STRING(Info->info[3].desc, "Version number of this plug-in");
+	Info->info[3].type =3D EVMS_Type_String;
+	SET_STRING(Info->info[3].value.s, version_string);
+
+	SET_STRING(Info->info[4].name, "Required Engine Services Version");
+	SET_STRING(Info->info[4].title, "Required Engine Services Version");
+	SET_STRING(Info->info[4].desc, "Version of the Engine services that thi=
s plug-in requires. It will not run on older versions of the Engine servi=
ces.");
+	Info->info[4].type =3D EVMS_Type_String;
+	SET_STRING(Info->info[4].value.s, required_engine_api_version_string);
+
+	SET_STRING(Info->info[5].name, "Required Plug-in API Version");
+	SET_STRING(Info->info[5].title, "Required Plug-in API Version");
+	SET_STRING(Info->info[5].desc, "Version of the Engine plug-in API that =
this plug-in requires. It will not run on older versions of the Engine pl=
ug-in API.");
+	Info->info[5].type =3D EVMS_Type_String;
+	SET_STRING(Info->info[5].value.s, required_plugin_api_version_string);
+
+	*info =3D Info;
+	rc =3D 0;
+
+out:
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+/**
+ * LD_direct_plugin_communication
+ *
+ * Device-manager-specific commands for starting and stopping the cache,=
 and
+ * opening and closing a disk.
+ **/
+static int LD_direct_plugin_communication(void * object,
+					  boolean target_kernel_plugin,
+					  void * arg)
+{
+	int rc =3D 0;
+	storage_object_t * disk =3D object;
+	ldm_dpc_t * dcp =3D arg;
+
+	LOG_ENTRY();
+	if (disk) {
+		LOG_DEBUG("Action targeted at %s.\n", disk->name);
+	}
+
+	switch (dcp->function) {
+
+	case START_CACHE:
+		LOG_DEBUG("START_CACHE\n");
+		break;
+
+	case STOP_CACHE:
+		LOG_DEBUG("STOP_CACHE\n");
+		break;
+
+       	case LDM_CLOSE_DISK:
+		LOG_DEBUG("LDM_CLOSE_DISK\n");
+		close_dev(disk);
+		break;
+
+	case LDM_OPEN_DISK:
+		LOG_DEBUG("LDM_OPEN_DISK\n");
+		rc =3D open_dev(disk);
+		break;
+
+	default:
+		LOG_ERROR("%d is not a valid function code.\n", dcp->function);
+		rc =3D EINVAL;
+	}
+
+	LOG_EXIT_INT(rc);
+	return rc;
+}
+
+static plugin_functions_t ft_sysfs =3D {
+	.setup_evms_plugin		=3D LD_setup,
+	.cleanup_evms_plugin		=3D LD_cleanup,
+	.discover			=3D LD_discover,
+	.add_sectors_to_kill_list	=3D LD_add_sectors_to_kill_list,
+	.commit_changes			=3D LD_commit_changes,
+	.get_info			=3D LD_get_info,
+	.get_plugin_info		=3D LD_get_plugin_info,
+	.read				=3D LD_read,
+	.write				=3D LD_write,
+	.direct_plugin_communication	=3D LD_direct_plugin_communication
+};
+
+plugin_record_t LD_Plugin =3D {
+		/* FIXME: get official evms ids */
+	.id =3D SetPluginID((EVMS_OEM_IBM+1), EVMS_DEVICE_MANAGER, 4),
+	.version =3D {
+		.major		=3D MAJOR_VERSION,
+		.minor		=3D MINOR_VERSION,
+		.patchlevel	=3D PATCH_LEVEL
+	},
+	.required_engine_api_version =3D {
+		.major		=3D 12,
+		.minor		=3D 0,
+		.patchlevel	=3D 0
+	},
+	.required_plugin_api_version =3D {
+		.plugin =3D {
+			.major		=3D 11,
+			.minor		=3D 0,
+			.patchlevel	=3D 0
+		}
+	},
+	.short_name =3D "BIOSDskMgr",
+	.long_name =3D "BIOS Disk Manager",
+	.oem_name =3D "IBM",
+	.functions =3D {
+		.plugin =3D &ft_sysfs
+	},
+	.container_functions =3D NULL
+};
+
+plugin_record_t * my_plugin_record =3D &LD_Plugin;
+
+plugin_record_t * evms_plugin_records[] =3D { &LD_Plugin,
+					    NULL };
+
diff -Nurp evms-2.2.2/plugins/bios/bios.h evms-2.2.2-bios/plugins/bios/bi=
os.h
--- evms-2.2.2/plugins/bios/bios.h	Thu Jan  1 01:00:00 1970
+++ evms-2.2.2-bios/plugins/bios/bios.h	Sat Feb 14 18:52:54 2004
@@ -0,0 +1,131 @@
+/*
+ *   (C) Copyright IBM Corp. 2001, 2003
+ *
+ *   This program is free software;  you can redistribute it and/or modi=
fy
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ */
+
+#ifndef __BIOS_H__
+#define __BIOS_H__ 1
+
+#ifndef O_DIRECT
+#define O_DIRECT	0
+#endif
+
+#define BLKGETSIZE64	_IOR(0x12,114,size_t)
+#define BLKSSZGET	_IO(0x12,104)
+#define BLKBSZGET	_IOR(0x12,112,size_t)
+#define BLKBSZSET	_IOW(0x12,113,size_t)
+#define HDIO_GETGEO	0x0301
+#define HDIO_GETGEO_BIG	0x0330
+
+struct hd_geometry {
+	unsigned char heads;
+	unsigned char sectors;
+	unsigned short cylinders;
+	unsigned long start;
+};
+
+struct hd_big_geometry {
+	unsigned char heads;
+	unsigned char sectors;
+	unsigned int cylinders;
+	unsigned long start;
+};
+
+extern engine_functions_t *EngFncs;
+extern plugin_record_t    *my_plugin_record;
+
+/*-
+ * Copyright (c) 2000,2001 S=F8ren Schmidt <sos@FreeBSD.org>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification, immediately at the beginning of the file.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ * 3. The name of the author may not be used to endorse or promote produ=
cts
+ *    derived from this software without specific prior written permissi=
on.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR `AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRAN=
TIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIME=
D.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, =
BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY=

+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+                           =20
+struct highpoint_raid_conf
+{
+       int8_t  filler1[32];
+       u_int32_t       magic;
+#define HPT_MAGIC_OK   0x5a7816f0
+#define HPT_MAGIC_BAD  0x5a7816fd =20
+
+       u_int32_t       magic_0;
+       u_int32_t       magic_1;
+       u_int32_t       order; =20
+#define HPT_O_MIRROR   0x01 =20
+#define HPT_O_STRIPE   0x02
+#define HPT_O_OK       0x04
+
+       u_int8_t        raid_disks;
+       u_int8_t        raid0_shift;=20
+       u_int8_t        type;
+#define HPT_T_RAID_0   0x00=20
+#define HPT_T_RAID_1   0x01
+#define HPT_T_RAID_01_RAID_0   0x02
+#define HPT_T_SPAN             0x03
+#define HPT_T_RAID_3           0x04  =20
+#define HPT_T_RAID_5           0x05
+#define HPT_T_SINGLEDISK       0x06
+#define HPT_T_RAID_01_RAID_1   0x07
+
+       u_int8_t        disk_number;
+       u_int32_t       total_secs;=20
+       u_int32_t       disk_mode; =20
+       u_int32_t       boot_mode;
+       u_int8_t        boot_disk;=20
+       u_int8_t        boot_protect;
+       u_int8_t        error_log_entries;
+       u_int8_t        error_log_index; =20
+       struct
+       {
+               u_int32_t       timestamp;
+               u_int8_t        reason;  =20
+#define HPT_R_REMOVED          0xfe     =20
+#define HPT_R_BROKEN           0xff     =20
+
+               u_int8_t        disk;
+               u_int8_t        status;
+               u_int8_t        sectors;
+               u_int32_t       lba;
+       } errorlog[32];
+       u_int8_t        filler[60];
+};
+
+#define CONFIGOFFSET 4608
+
+#endif
+

--------------050003080801070204030600--
