Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSFONgT>; Sat, 15 Jun 2002 09:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSFONgS>; Sat, 15 Jun 2002 09:36:18 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:15186 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S315370AbSFONgG>; Sat, 15 Jun 2002 09:36:06 -0400
Date: Sat, 15 Jun 2002 15:36:06 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>,
        Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: /proc/scsi/map
Message-ID: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: multipart/mixed; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi SCSI users,

from people using SCSI devices, there's one question that turns up again=20
and again: How can one assign stable device names to SCSI devices in
case there are devices that may or may not be switched on or connected.

There are a couple of ways to address this problem:
(a) mount by uuid
(b) userspace programs that collect information to create
    alternative and persistent names / device nodes, such
    as Eric Youngdale's scsidev[1], Doug Gilbert's sg_map[2], scsimon[3],
    or Mike Sullivan's scsiname/devnaming[4]
(c) devfs

[1] http://www.garloff.de/kurt/linux/scsidev/
[2] http://www.torque.net/sg/
[3] http://www.torque.net/scsi/scsimon.html
[4] http://oss.software.ibm.com/devreg/

Unfortunately, those approaches all have some deficiencies.
Ad (a): Does only work for ext2 filesystems. For locating
        / one needs additional initrd work.
Ad (b): A considerable amount of work needs to be done in userspace:
        - For all devices types you need to probe possible devices
	- You need to do SCSI_IOCTL_GET_IDLUN to get controller,bus,
	  target and unit number
	The problem is that the collection of this information is=20
	not always successful. If a medium is not inserted, the
	open() fails for some device types, despite O_NONBLOCK.
	Assumptions about the order of devices OTOH are not safe,
	as remove-single-device/add-single-device may result in a
	non-straightforward ordering.
Ad (c): devfs is currently not (yet?) an option for distributions
        due to security and stability considerations.

Life would be easier if the scsi subsystem would just report which SCSI
device (uniquely identified by the controller,bus,target,unit tuple) belongs
to which high-level device. The information is available in the kernel.

Attached patch does this:
garloff@pckurt:/raid5/Kernel/src $ cat /proc/scsi/map=20
# C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
0,0,00,00       0x05    1       sg0     c:15:00 sr0     b:0b:00
1,0,01,00       0x05    1       sg1     c:15:01 sr1     b:0b:01
1,0,02,00       0x01    1       sg2     c:15:02 osst0   c:ce:00
1,0,03,00       0x05    1       sg3     c:15:03 sr2     b:0b:02
1,0,05,00       0x00    1       sg4     c:15:04 sda     b:08:00
1,0,09,00       0x00    1       sg5     c:15:05 sdb     b:08:10
2,0,01,00       0x05    1       sg6     c:15:06 sr3     b:0b:03
2,0,02,00       0x01    1       sg7     c:15:07 osst1   c:ce:01
2,0,03,00       0x05    1       sg8     c:15:08 sr4     b:0b:04
2,0,05,00       0x00    1       sg9     c:15:09 sdc     b:08:20
2,0,09,00       0x00    1       sg10    c:15:0a sdd     b:08:30
3,0,10,00       0x00    1       sg11    c:15:0b sde     b:08:40
3,0,12,00       0x00    1       sg12    c:15:0c sdf     b:08:50

This allows a simple script to parse the map and create device nodes as
needed.

The patch does work the following way.
- Add a find_kdev() function pointer to the high-level driver template
  structure. The function takes a Scsi_Device pointer (points to a=20
  low-level device) and returns a name and a kdev_t if the device
  is attached to this high-level driver.
- Implement the function for sg, sd, sr, st, osst
- Make scsi/scsi_proc iterate over all devices and calls the high-level
  drivers find_kdev() to find out about it.

Obviously, it can only report the assignment of high-level drivers,
if they are loaded, otherwise the last two columns will stay empty.
(sg is handled especially, as we know it supports all devices.)
If we attach a third high-level device driver, two more columns would show=
=20
up.=20
(Is this variable column number format a problem?)

The patch also includes a simple shell script that does assign
/dev/scsi/sdc2b0t9u0 type names to those devices and making a device nodes
(or optionally symlinks to the old name devices) with this name.

The design allows for two more things:
* using root=3D/dev/scsi/sdc1b0t9u0p5 without much additional code
  (patch follows in another mail)
* in case we want to support more than 128 scsi disks, the information
  about additional majors can be reported by /proc/scsi/map without further
  change

Patch is against 2.4.19pre10.

I'd like to get it accepted into the kernel.=20
So please give your criticism ...=20
I already got some by Doug Gilbert :-)

A patch for 2.5 should be done as well, if the design is OK, of course.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-map6.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.18.S18.fixed/Documentation/scsi-devs.sh linux-2.4.18.S1=
8.sdmany/Documentation/scsi-devs.sh
--- linux-2.4.18.S18.fixed/Documentation/scsi-devs.sh	Thu Jan  1 01:00:00 1=
970
+++ linux-2.4.18.S18.sdmany/Documentation/scsi-devs.sh	Fri Jun 14 22:37:11 =
2002
@@ -0,0 +1,154 @@
+#!/bin/bash
+# Script to create SCSI device nodes according to their physical
+# address (host controller no,bus/channel,target SCSI ID,unit SCSI LUN)
+# using the /proc/scsi/map introduced in Linux 2.4.20pre/2.5.2x
+# (c) Kurt Garloff <garloff@suse.de>, 2002-06-13
+# License: GNU GPL v2
+
+# Settings
+
+# Target directory for device nodes/links
+TDIR=3D/dev/scsi
+
+# Make symbolic links or create fresh nodes in $TDIR
+# For link mode, the dev nodes will still be made if needed
+MODE=3D
+
+# In link mode, where is the real /dev dir ?
+DEVDIR=3D..
+
+# Ownership and permissions of newly created device nodes
+OWNER=3D"root.disk"
+PERM=3D"0660"
+SDIRPERM=3D"0755"
+
+# Make scsi disk partitions (0 =3D off)
+SDPART=3D15
+
+# End of settings
+
+# Options
+# -f: Remove all old devs
+if test "$1" =3D "-f"; then
+  rm -f $TDIR/*
+  shift
+fi
+# -l: Make links=20
+if test "$1" =3D "-l"; then
+  MODE=3DLINK
+  shift
+fi
+
+# Sanitize environment
+export LANG=3Dposix
+unset IFS
+#umask `printf %o $[0777-$PERM]`
+PATH=3D/bin:/usr/bin:/sbin:/usr/sbin
+
+# Functions
+function exit_fail=20
+{
+  echo $1
+  exit $2
+}
+
+# Build new scsi name based on oldname (prefix) and=20
+# append host,channel,id,lun numbers that are unique
+# and persistent identifiers for the device.
+function builddevnm
+{=20
+  if test "${5:0:2}" =3D "sd"; then
+    NM=3D"sdc$1b$2t${3#0}u${4#0}"
+  else
+    NM=3D"${5%%[0-9]*}c$1b$2t${3#0}u${4#0}"
+  fi
+}
+
+# Make device node
+# Parameters filename type maj(hex) min(hex) minadd(dec)
+function mk_nod
+{
+  rm -f $1
+  mknod -m $PERM $1 $2 $[0x$3] $[0x$4+$5]
+  chown $OWNER $1
+}
+
+# Make device by creating node or symlinking
+# Parameters oldname device(tp:maj:min) newname minadd
+function mk_dev=20
+{
+  IFS=3D":"
+  if test "$MODE" =3D "LINK"; then
+    if test ! -e $TDIR/$DEVDIR/$1; then
+      mk_nod $TDIR/$DEVDIR/$1 $2 $4
+    fi
+    ln -sf $DEVDIR/$1 $TDIR/$3
+  else
+    mk_nod $TDIR/$3 $2 $4
+  fi
+  unset IFS
+}
+
+# Make multiple devices in case we do have sd partitions
+# Parameters oldname device(tp:maj:min) newname
+function mk_devs
+{
+  mk_dev $1 $2 $3 0
+  # Handle partitions
+  if test "${1:0:2}" =3D "sd" -a "$SDPART" !=3D "0"; then
+    #unset IFS
+    for no in `seq 1 $SDPART`; do
+      mk_dev $1$no $2 $3p$no $no
+    done
+  fi
+  # Handle nst/nosst
+  if test "${1:0:2}" =3D "st" -o "${1:0:4}" =3D "osst"; then
+    mk_dev n$1 $2 n$3 128
+  fi
+}
+
+# Main() Script
+if ! test -e /proc/scsi/map; then
+  exit_fail "/proc/scsi/map does not exist" 1
+fi
+if ! test -d $TDIR; then
+  mkdir -m $SDIRMODE $TDIR || exit_fail "Failed to create $TDIR" 2
+  chown $OWNER $TDIR
+fi
+
+# We might have been called by some sort of hotplug event
+# and are only support to add a single device
+# Syntax for this is [-l] add host channel id lun
+if test "$1" =3D "add"; then
+  CMPAGAINST=3D"$2,$3,`printf %02i $4`,`printf %02i $5`"
+else
+  unset CMPAGAINST
+fi
+# The main processing loop
+while read cbtu tp onl sgnm sgdev othnm othdev oothnm oothdev rest; do
+  # Skip comment line(s)
+  if test "${cbtu:0:1}" =3D "#"; then continue; fi
+  # If we're just dealing with one device, do skip the others
+  if test ! -z "$CMPAGAINST" -a "$CMPAGAINST" !=3D "$cbtu"; then continue;=
 fi
+  # now parse line
+  IFS=3D","
+  # Test for validity of sg device
+  if test "$sgnm" !=3D "sg?"; then
+    builddevnm $cbtu $sgnm
+    mk_dev $sgnm $sgdev $NM 0
+  fi
+  # There is possibly a second device
+  if test ! -z "$othnm" -a ! "$othnm" =3D "none"; then
+    IFS=3D","
+    builddevnm $cbtu $othnm
+    mk_devs $othnm $othdev $NM
+    # Maybe even a third one
+    if test ! -z "$oothnm" -a ! "$oothnm" =3D "none"; then
+      IFS=3D","
+      builddevnm $cbtu $oothnm
+      mk_devs $oothnm $oothdev $NM
+    fi
+  fi
+  unset IFS
+done < /proc/scsi/map
+
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/hosts.h linux-2.4.18.S18.sdma=
ny/drivers/scsi/hosts.h
--- linux-2.4.18.S18.fixed/drivers/scsi/hosts.h	Wed Jun 12 11:37:09 2002
+++ linux-2.4.18.S18.sdmany/drivers/scsi/hosts.h	Wed Jun 12 11:53:54 2002
@@ -530,6 +530,7 @@
     void (*detach)(Scsi_Device *);
     int (*init_command)(Scsi_Cmnd *);     /* Used by new queueing code.=20
                                            Selects command for blkdevs */
+    int (*find_kdev)(Scsi_Device *, char*, kdev_t*);  /* find back dev. */
 };
=20
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/osst.c linux-2.4.18.S18.sdman=
y/drivers/scsi/osst.c
--- linux-2.4.18.S18.fixed/drivers/scsi/osst.c	Fri Dec 21 18:41:55 2001
+++ linux-2.4.18.S18.sdmany/drivers/scsi/osst.c	Wed Jun 12 11:39:47 2002
@@ -156,6 +156,7 @@
 static int osst_attach(Scsi_Device *);
 static int osst_detect(Scsi_Device *);
 static void osst_detach(Scsi_Device *);
+static int osst_find_kdev(Scsi_Device *, char*, kdev_t*);
=20
 struct Scsi_Device_Template osst_template =3D
 {
@@ -166,7 +167,8 @@
        detect:		osst_detect,
        init:		osst_init,
        attach:		osst_attach,
-       detach:		osst_detach
+       detach:		osst_detach,
+       find_kdev:	osst_find_kdev,
 };
=20
 static int osst_int_ioctl(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, unsig=
ned int cmd_in,unsigned long arg);
@@ -5417,6 +5419,24 @@
 	return 0;
 }
=20
+static int osst_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	int i;
+	OS_Scsi_Tape *ostp;
+=09
+	if (sdp && sdp->type =3D=3D TYPE_TAPE && osst_supports(sdp)) {
+		for (ostp =3D os_scsi_tapes[i =3D 0]; i < osst_template.dev_max;
+		     ostp =3D os_scsi_tapes[++i]) {
+			if (ostp && ostp->device =3D=3D sdp) {
+				sprintf (nm, "osst%i", i);
+				*dev =3D MKDEV(OSST_MAJOR, i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static int osst_attach(Scsi_Device * SDp)
 {
 	OS_Scsi_Tape * tpnt;
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/scsi.c linux-2.4.18.S18.sdman=
y/drivers/scsi/scsi.c
--- linux-2.4.18.S18.fixed/drivers/scsi/scsi.c	Wed Jun 12 11:37:07 2002
+++ linux-2.4.18.S18.sdmany/drivers/scsi/scsi.c	Fri Jun 14 12:49:15 2002
@@ -80,6 +80,7 @@
=20
 #ifdef CONFIG_PROC_FS
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int le=
ngth);
+static int scsi_proc_map (char *buffer, char **start, off_t offset, int le=
ngth);
 static void scsi_dump_status(int level);
 #endif
=20
@@ -1554,6 +1555,70 @@
 }
=20
 #ifdef CONFIG_PROC_FS
+/*=20
+ * Output the mapping of physical devices (contorller,channel.id,lun)
+ * to devices (sg and other highlevel drivers) to /proc/scsi/map.
+ * Caveat: No locking is done, so if your scsi config changes during
+ * reading this file, you may read garbled data.	KG, 2002-06-14
+ */
+static int scsi_proc_map(char *buffer, char **start, off_t offset, int len=
gth)
+{
+	Scsi_Device *scd;
+	struct Scsi_Host *HBA_ptr;
+	int size =3D 0, len =3D 0, repeat =3D 0;
+	off_t begin =3D 0;
+	off_t pos =3D 0;
+
+	struct Scsi_Device_Template *sg_t;
+	do {
+		sg_t =3D scsi_devicelist;
+		while (sg_t && !(sg_t->tag && !strcmp(sg_t->tag, "sg")))
+			sg_t =3D sg_t->next;
+#ifdef CONFIG_KMOD
+		if (!repeat && !sg_t)
+			request_module("sg");
+	} while (!repeat++);
+#else
+	} while (0);
+#endif=09
+	/*
+	 * First, see if there are any attached devices or not.
+	 */
+	for (HBA_ptr =3D scsi_hostlist; HBA_ptr; HBA_ptr =3D HBA_ptr->next) {
+		if (HBA_ptr->host_queue !=3D NULL) {
+			break;
+		}
+	}
+	if (!HBA_ptr)
+		goto stop_map_output;
+=09
+	size =3D sprintf(buffer + len, "# C,B,T,U\tType\tonl\tsg_nm\tsg_dev\tnm\t=
dev(hex)\n");
+	len +=3D size;
+	pos =3D begin + len;
+
+	for (HBA_ptr =3D scsi_hostlist; HBA_ptr; HBA_ptr =3D HBA_ptr->next) {
+		for (scd =3D HBA_ptr->host_queue; scd; scd =3D scd->next) {
+			proc_print_scsimap(scd, buffer, &size, len, sg_t);
+			len +=3D size;
+			pos =3D begin + len;
+
+			if (pos < offset) {
+				len =3D 0;
+				begin =3D pos;
+			}
+			if (pos > offset + length)
+				goto stop_map_output;
+		}
+	}
+
+ stop_map_output:
+	*start =3D buffer + (offset - begin);	/* Start of wanted data */
+	len -=3D (offset - begin);	/* Start slop */
+	if (len > length)
+		len =3D length;	/* Ending slop */
+	return (len);
+}
+
 static int scsi_proc_info(char *buffer, char **start, off_t offset, int le=
ngth)
 {
 	Scsi_Device *scd;
@@ -2578,6 +2643,7 @@
 static int __init init_scsi(void)
 {
 	struct proc_dir_entry *generic;
+	struct proc_dir_entry *map;
=20
 	printk(KERN_INFO "SCSI subsystem driver " REVISION "\n");
=20
@@ -2602,6 +2668,13 @@
 		return -ENOMEM;
 	}
 	generic->write_proc =3D proc_scsi_gen_write;
+=09
+	map =3D create_proc_info_entry ("scsi/map", 0, 0, scsi_proc_map);
+	if (!map) {
+		printk (KERN_ERR "cannot init /proc/scsi/map\n");
+		remove_proc_entry("scsi", 0);
+		return -ENOMEM;
+	}
 #endif
=20
         scsi_devfs_handle =3D devfs_mk_dir (NULL, "scsi", NULL);
@@ -2636,6 +2709,7 @@
=20
 #ifdef CONFIG_PROC_FS
 	/* No, we're not here anymore. Don't show the /proc/scsi files. */
+	remove_proc_entry ("scsi/map", 0);
 	remove_proc_entry ("scsi/scsi", 0);
 	remove_proc_entry ("scsi", 0);
 #endif
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/scsi.h linux-2.4.18.S18.sdman=
y/drivers/scsi/scsi.h
--- linux-2.4.18.S18.fixed/drivers/scsi/scsi.h	Wed Jun 12 11:37:07 2002
+++ linux-2.4.18.S18.sdmany/drivers/scsi/scsi.h	Wed Jun 12 11:53:54 2002
@@ -517,6 +517,8 @@
  * Prototypes for functions in scsi_proc.c
  */
 extern void proc_print_scsidevice(Scsi_Device *, char *, int *, int);
+extern void proc_print_scsimap(Scsi_Device *, char *, int *, int,=20
+			       struct Scsi_Device_Template *);
 extern struct proc_dir_entry *proc_scsi;
=20
 /*
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/scsi_proc.c linux-2.4.18.S18.=
sdmany/drivers/scsi/scsi_proc.c
--- linux-2.4.18.S18.fixed/drivers/scsi/scsi_proc.c	Thu Jun 28 02:10:55 2001
+++ linux-2.4.18.S18.sdmany/drivers/scsi/scsi_proc.c	Fri Jun 14 00:30:42 20=
02
@@ -301,11 +301,66 @@
 	return;
 }
=20
+
+
+
+void proc_print_scsimap(Scsi_Device *scd, char *buffer, int *size, int len,
+			struct Scsi_Device_Template *sg_t)
+{
+	int y, err =3D 0;
+	char nm[16];
+	kdev_t kdev;=20
+	int att =3D scd->attached;
+	struct Scsi_Device_Template *sd_t =3D scsi_devicelist;
+
+	y =3D sprintf(buffer + len,
+	     "%i,%i,%02i,%02i\t0x%02x\t%i",
+		    scd->host->host_no, scd->channel, scd->id, scd->lun,
+		    scd->type, scd->online);
+	if (sg_t && sg_t->find_kdev) {
+		err =3D sg_t->find_kdev(scd, nm, &kdev);
+		if (!err) {
+			y +=3D sprintf(buffer + len + y,
+				     "\t%s\tc:%02x:%02x", nm, MAJOR(kdev), MINOR(kdev));
+			--att;
+		} else {
+			printk (KERN_ERR "scsimap: sg device not found?!\n");
+			y +=3D sprintf(buffer + len + y,
+				     "\tsg?\tc:NN:NN");
+		}
+	} else {
+		printk (KERN_INFO "scsimap: need sg support to report sg devices\n");
+		y +=3D sprintf(buffer + len + y,
+			     "\tsg?\tc:NN:NN");
+	}
+	while (att && sd_t) {
+		if (sd_t->scsi_type !=3D 0xff && sd_t->find_kdev) {
+			err =3D sd_t->find_kdev(scd, nm, &kdev);
+			if (!err) {
+				y +=3D sprintf(buffer + len + y,
+					     "\t%s\t%c:%02x:%02x",
+					     nm, (sd_t->blk? 'b': 'c'),
+					     MAJOR(kdev), MINOR(kdev));
+				--att;
+			}
+		}
+		sd_t =3D sd_t->next;
+	}
+
+ map_out:
+	y +=3D sprintf(buffer + len + y, "\n");
+	*size =3D y;
+	return;
+}
+
 #else				/* if !CONFIG_PROC_FS */
=20
 void proc_print_scsidevice(Scsi_Device * scd, char *buffer, int *size, int=
 len)
 {
 }
+void proc_print_scsimap(Scsi_Device *scd, char *buffer, int *size, int len)
+{
+}
=20
 #endif				/* CONFIG_PROC_FS */
=20
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/sd.c linux-2.4.18.S18.sdmany/=
drivers/scsi/sd.c
--- linux-2.4.18.S18.fixed/drivers/scsi/sd.c	Wed Jun 12 11:37:13 2002
+++ linux-2.4.18.S18.sdmany/drivers/scsi/sd.c	Wed Jun 12 11:39:47 2002
@@ -109,6 +109,7 @@
 static int sd_detect(Scsi_Device *);
 static void sd_detach(Scsi_Device *);
 static int sd_init_command(Scsi_Cmnd *);
+static int sd_find_kdev(Scsi_Device*, char*, kdev_t*);
=20
 static struct Scsi_Device_Template sd_template =3D {
 	name:"disk",
@@ -127,6 +128,7 @@
 	attach:sd_attach,
 	detach:sd_detach,
 	init_command:sd_init_command,
+	find_kdev:sd_find_kdev,
 };
=20
=20
@@ -281,6 +283,23 @@
 	}
 }
=20
+static int sd_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	Scsi_Disk *dp;=20
+	int i;
+=09
+	if (sdp && (sdp->type =3D=3D TYPE_DISK || sdp->type =3D=3D TYPE_MOD)) {
+		for (dp =3D rscsi_disks, i =3D 0; i < sd_template.dev_max; ++i, ++dp) {
+			if (dp->device =3D=3D sdp) {
+				sd_devname(i, nm);
+				*dev =3D MKDEV_SD(i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static request_queue_t *sd_find_queue(kdev_t dev)
 {
 	Scsi_Disk *dpnt;
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/sg.c linux-2.4.18.S18.sdmany/=
drivers/scsi/sg.c
--- linux-2.4.18.S18.fixed/drivers/scsi/sg.c	Wed Jun 12 11:37:04 2002
+++ linux-2.4.18.S18.sdmany/drivers/scsi/sg.c	Wed Jun 12 15:27:55 2002
@@ -115,6 +115,7 @@
 static void sg_finish(void);
 static int sg_detect(Scsi_Device *);
 static void sg_detach(Scsi_Device *);
+static int sg_find_kdev(Scsi_Device *, char*, kdev_t*);
=20
 static Scsi_Request * dummy_cmdp;	/* only used for sizeof */
=20
@@ -123,6 +124,7 @@
=20
 static struct Scsi_Device_Template sg_template =3D
 {
+      name:"generic",
       tag:"sg",
       scsi_type:0xff,
       major:SCSI_GENERIC_MAJOR,
@@ -130,7 +132,8 @@
       init:sg_init,
       finish:sg_finish,
       attach:sg_attach,
-      detach:sg_detach
+      detach:sg_detach,
+      find_kdev:sg_find_kdev
 };
=20
=20
@@ -2696,6 +2699,36 @@
 }
=20
 #ifdef CONFIG_PROC_FS
+static int sg_find_kdev(Scsi_Device* sdp, char *nm, kdev_t *dev)
+{
+    unsigned long iflags;
+    int err =3D 1;=20
+
+    if (sdp && sg_dev_arr) {
+	int k;
+	read_lock_irqsave(&sg_dev_arr_lock, iflags);
+	for (k =3D 0; k < sg_template.dev_max; ++k) {
+	    if (sg_dev_arr[k] && sg_dev_arr[k]->device =3D=3D sdp) {
+		sprintf (nm, "sg%i", k);
+	        *dev =3D sg_dev_arr[k]->i_rdev;
+		err =3D 0;
+		break;
+	    }
+	}
+	read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+    }
+    return err;
+}
+#else
+/* Not needed without procfs support */
+static int sg_find_kdev(Scsi_Device* sdp, char *nm, kdev_t *dev)
+{
+    *nm =3D 0; *kdev =3D MKDEV(255,255);
+    return 1;
+}
+#endif
+
+#ifdef CONFIG_PROC_FS
=20
 static struct proc_dir_entry * sg_proc_sgp =3D NULL;
=20
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/sr.c linux-2.4.18.S18.sdmany/=
drivers/scsi/sr.c
--- linux-2.4.18.S18.fixed/drivers/scsi/sr.c	Wed Jun 12 11:37:15 2002
+++ linux-2.4.18.S18.sdmany/drivers/scsi/sr.c	Wed Jun 12 11:39:47 2002
@@ -69,6 +69,8 @@
=20
 static int sr_init_command(Scsi_Cmnd *);
=20
+static int sr_find_kdev(Scsi_Device*, char*, kdev_t*);
+
 static struct Scsi_Device_Template sr_template =3D
 {
 	name:"cdrom",
@@ -81,7 +83,8 @@
 	finish:sr_finish,
 	attach:sr_attach,
 	detach:sr_detach,
-	init_command:sr_init_command
+	init_command:sr_init_command,
+	find_kdev:sr_find_kdev,
 };
=20
 Scsi_CD *scsi_CDs;
@@ -586,6 +589,22 @@
 	return 0;
 }
=20
+static int sr_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	Scsi_CD *srp;
+	int i;
+=09
+	if (sdp && (sdp->type =3D=3D TYPE_ROM || sdp->type =3D=3D TYPE_WORM)) {
+		for (srp =3D scsi_CDs, i =3D 0; i < sr_template.dev_max; ++i, ++srp) {
+			if (srp->device =3D=3D sdp) {
+				sprintf(nm, "sr%i", i);
+				*dev =3D MKDEV(SCSI_CDROM_MAJOR,i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
=20
 void get_sectorsize(int i)
 {
diff -uNr linux-2.4.18.S18.fixed/drivers/scsi/st.c linux-2.4.18.S18.sdmany/=
drivers/scsi/st.c
--- linux-2.4.18.S18.fixed/drivers/scsi/st.c	Mon Feb 25 20:38:04 2002
+++ linux-2.4.18.S18.sdmany/drivers/scsi/st.c	Wed Jun 12 11:39:47 2002
@@ -164,6 +164,7 @@
 static int st_attach(Scsi_Device *);
 static int st_detect(Scsi_Device *);
 static void st_detach(Scsi_Device *);
+static int st_find_kdev(Scsi_Device*, char*, kdev_t*);
=20
 static struct Scsi_Device_Template st_template =3D
 {
@@ -174,7 +175,8 @@
 	detect:st_detect,=20
 	init:st_init,
 	attach:st_attach,=20
-	detach:st_detach
+	detach:st_detach,
+	find_kdev:st_find_kdev,
 };
=20
 static int st_compression(Scsi_Tape *, int);
@@ -3827,6 +3829,23 @@
 	return 1;
 }
=20
+static int st_find_kdev(Scsi_Device * sdp, char* nm, kdev_t *dev)
+{
+	int i;
+	Scsi_Tape *stp;
+=09
+	if (sdp && sdp->type =3D=3D TYPE_TAPE && !st_incompatible(sdp)) {
+		for (stp =3D scsi_tapes[0], i =3D 0; i < st_template.dev_max; stp=3Dscsi=
_tapes[++i]) {
+			if (stp && stp->device =3D=3D sdp) {
+				sprintf(nm, "st%i", i);
+				*dev =3D MKDEV (SCSI_TAPE_MAJOR, i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static int st_registered =3D 0;
=20
 /* Driver initialization (not __init because may be called later) */

--qtZFehHsKgwS5rPz--

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9C0LGxmLh6hyYd04RArBOAKCrYZLPC3dqyNORC8yU2h9mkVEG2gCdHTcx
K4l6PC1bEfdRQ6+b/M69GQM=
=zvCv
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
