Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWIHRry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWIHRry (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWIHRry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:47:54 -0400
Received: from mout0.freenet.de ([194.97.50.131]:18850 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751003AbWIHRru convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:47:50 -0400
Date: Fri, 08 Sep 2006 19:55:08 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "petero2@telia.com" <petero2@telia.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.tfkmp60biudtyh@master>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

(3th try with fixed inline patch)

This is a patch for the packet writing driver pktcdvd.
It adds a sysfs interface to the driver and a bio write
queue "congestion" handling.

The patch modifies following files of the Linux 2.6.18-rc6
source tree:
    Documentation/cdrom/packet-writing.txt
    Documentation/ABI/testing/sysfs-block-pktcdvd
    include/linux/pktcdvd.h
    drivers/block/pktcdvd.c
    drivers/block/Kconfig
    block/genhd.c

(genhd.c must be changed to export the block_subsys
symbol)

The bio write queue changes are in pktcdvd.c in functions:
    pkt_make_request()
    pkt_bio_finished()

Any comments and improvements are welcomed ;)


Why this patch?
===============
This driver uses an internal bio write queue to store
write requests from the block layer, passed to the driver
over its own make_request function.
I am using Linux 2.6.17 on an Athlon 64 X2, 2G RAM and while
writing huge files (>200M) to a DVDRAM using the pktcdvd driver,
the bio write queue raised >200000 entries! This led to
kernel out of memory Oops! e.g.:

----------------------------------------------------------
Aug 14 17:42:26 master vmunix: pktcdvd: 4473408kB available on disc
Aug 14 17:42:54 master vmunix: pktcdvd: write speed 4155kB/s
Aug 14 17:54:24 master vmunix: oom-killer: gfp_mask=0xd0, order=1
Aug 14 17:54:24 master vmunix:  <c014346f> out_of_memory+0x12f/0x150
<c01452d0> __alloc_pages+0x280/0x2e0
Aug 14 17:54:24 master vmunix:  <c015a52a> cache_alloc_refill+0x2ea/0x500
<c015a7a1> __kmalloc+0x61/0x70
Aug 14 17:54:24 master vmunix:  <c039c0b3> __alloc_skb+0x53/0x110
<c03985b6> sock_alloc_send_skb+0x176/0x1c0
Aug 14 17:54:24 master vmunix:  <c0399c5b> sock_def_readable+0x7b/0x80
<c041262b> unix_stream_sendmsg+0x1cb/0x310
Aug 14 17:54:24 master vmunix:  <c039502b> do_sock_write+0xab/0xc0
<c0395720> sock_aio_write+0x80/0x90
Aug 14 17:54:24 master vmunix:  <c011a609> __wake_up_common+0x39/0x60
<c015d984> do_sync_write+0xc4/0x100
Aug 14 17:54:47 master vmunix: printk: 10 messages suppressed.
Aug 14 17:54:47 master vmunix: oom-killer: gfp_mask=0xd0, order=0
Aug 14 17:54:47 master vmunix:  <c014346f> out_of_memory+0x12f/0x150
<c01452d0> __alloc_pages+0x280/0x2e0
Aug 14 17:54:47 master vmunix:  <c0258de2> __next_cpu+0x12/0x30
<c015a52a> cache_alloc_refill+0x2ea/0x500
Aug 14 17:54:47 master vmunix:  <c015a23a> kmem_cache_alloc+0x4a/0x50
<c03987ea> sk_alloc+0x2a/0x150
Aug 14 17:54:47 master vmunix:  <c03e3f8d> inet_create+0xed/0x320
<c03950a2> sock_alloc_inode+0x12/0x70
Aug 14 17:54:47 master vmunix:  <c017790e> alloc_inode+0xce/0x180
<c03966f3> __sock_create+0x123/0x2f0
Aug 14 17:54:49 master vmunix: Total swap = 2152668kB
Aug 14 17:54:49 master vmunix: Free swap:       2152436kB
Aug 14 17:54:49 master vmunix: 524272 pages of RAM
Aug 14 17:54:49 master vmunix: 294896 pages of HIGHMEM
Aug 14 17:54:49 master vmunix: 5767 reserved pages
Aug 14 17:54:49 master vmunix: 238277 pages shared
Aug 14 17:54:49 master vmunix: 35 pages swap cached
Aug 14 17:54:49 master vmunix: 47682 pages dirty
Aug 14 17:54:49 master vmunix: 157861 pages writeback
Aug 14 17:54:49 master vmunix: 17359 pages mapped
Aug 14 17:54:49 master vmunix: 23835 pages slab
Aug 14 17:54:49 master vmunix: 176 pages pagetables
Aug 14 17:54:59 master vmunix:   <c0145355> __get_free_pages+0x25/0x40
Aug 14 17:55:19 master vmunix: 294896 pages of HIGHM<6>5767 reserved pages
------------------------------------------------------------

It don't know exactly what is wrong in the kernel, but
it seems it must be something with the kernels memory handling.

To be able to use the pktcdvd driver now, i created this patch.
It simply limits the size of the bio write queue of the driver
to save kernel memory. Does not cure the "kernel bug", but the
symptom ;)
If the number of bio write requests would raise the bio
queue size over a high limit (congestion on), the
make_request function waits till the worker thread has
lowered the queue size below the "congestion off" mark.
The wait is similar to the wait in get_request_wait(),
called by the "normal" request function __make_request().

Also there is now a sysfs interface for the driver and the
procfs interface can be switched of by a kernel config
parameter. See the file
    Documentation/ABI/testing/sysfs-block-pktcdvd
in this patch.

-Thomas Maier



---[snip]-----------------------------
diff -urpN linux-2.6.18-rc6/Documentation/ABI/testing/sysfs-block-pktcdvd pktcdvd-patch-2.6.18-rc6/Documentation/ABI/testing/sysfs-block-pktcdvd
--- linux-2.6.18-rc6/Documentation/ABI/testing/sysfs-block-pktcdvd	1970-01-01 01:00:00.000000000 +0100
+++ pktcdvd-patch-2.6.18-rc6/Documentation/ABI/testing/sysfs-block-pktcdvd	2006-09-05 20:29:41.000000000 +0200
@@ -0,0 +1,84 @@
+What:           /sys/block/pktcdvd/
+Date:           Sep. 2006
+KernelVersion:  2.6.18
+Contact:        Thomas Maier <balagi@justmail.de>
+Description:
+
+sysfs interface
+---------------
+
+The pktcdvd module (packet writing driver) creates
+following files in the sysfs:
+
+( <pktdevname> is one of pktcdvd0..pktcdvd7 )
+( <devid> is in format  major:minor )
+
+/sys/block/pktcdvd/
+    add               (w)  Write a block device id to create a
+                           new pktcdvd device and map it to the
+                           block device.
+
+    remove            (w)  Write the pktcdvd device id or the
+                           mapped block device id to it, to
+                           remove the pktcdvd device.
+
+    device_map        (r)  Shows the device mapping in format:
+                           <pktdevname> <pktdevid> <blkdevid>
+
+    packet_buffers    (rw) Number of concurrent packets per
+                           pktcdvd device. Used for new created
+                           devices.
+	
+
+/sys/block/pktcdvd/<pktdevname>/packet/
+    statistic         (r)  Show device statistic. One line with
+                           5 values in following order:
+                              packets-started
+                              packets-end
+                              written in kB
+                              read gather in kB
+                              read in kB
+
+    reset_statistic   (w)  Write any value to it to reset
+                           pktcdvd device statistic values, like
+                           bytes read/written.
+
+    info              (r)  Lots of user readable driver statistics
+                           and infos. Multiple lines!
+
+    write_queue_size  (r)  Contains the size of the bio write
+                           queue.
+
+    write_congestion_off (rw) If bio write queue size is below
+                              this mark, accept new bio requests
+                              from the block layer.
+
+    write_congestion_on  (rw) If bio write queue size is higher
+                              as this mark, do no longer accept
+                              bio write requests from the block
+                              layer and wait till the pktcdvd
+                              device has processed enough bio's
+                              so that bio write queue size is
+                              below congestion off mark.
+
+    mapped_to              Symbolic link to mapped block device
+                           in the /sys/block tree.
+
+
+Example:
+--------
+To use the pktcdvd sysfs interface directly, you can do:
+
+# create a new pktcdvd device mapped to /dev/hdc
+echo "22:0" >/sys/block/pktcdvd/add
+cat /sys/block/pktcdvd/device_map
+# assuming device pktcdvd0 was created, look at stat's
+cat /sys/block/pktcdvd/pktcdvd0/packet/stat
+# print the device id of the mapped block device
+cat /sys/block/pktcdvd/pktcdvd0/packet/mapped_to/dev
+# similar to
+fgrep pktcdvd0 /sys/block/pktcdvd/device_map
+# remove device, using pktcdvd0 device id   253:0
+echo "253:0" >/sys/block/pktcdvd/remove
+# same as using the mapped block device id  22:0
+echo "22:0" >/sys/block/pktcdvd/remove
diff -urpN linux-2.6.18-rc6/Documentation/cdrom/packet-writing.txt pktcdvd-patch-2.6.18-rc6/Documentation/cdrom/packet-writing.txt
--- linux-2.6.18-rc6/Documentation/cdrom/packet-writing.txt	2006-09-04 21:24:20.000000000 +0200
+++ pktcdvd-patch-2.6.18-rc6/Documentation/cdrom/packet-writing.txt	2006-09-05 20:29:41.000000000 +0200
@@ -1,13 +1,15 @@
  Getting started quick
  ---------------------

-- Select packet support in the block device section and UDF support in
-  the file system section.
+- Select packet support in the block device section (and enable
+  the pktcdvd procfs interface) and UDF support in the file
+  system section.

  - Compile and install kernel and modules, reboot.

  - You need the udftools package (pktsetup, mkudffs, cdrwtool).
    Download from http://sourceforge.net/projects/linux-udf/
+  Note: pktsetup needs the pktcdvd procfs interface!

  - Grab a new CD-RW disc and format it (assuming CD-RW is hdc, substitute
    as appropriate):
@@ -90,8 +92,274 @@ Notes
    to create an ext2 filesystem on the disc.


+
+Using the pktcdvd sysfs interface
+---------------------------------
+
+The pktcdvd module has a sysfs interface and can be controlled
+by the tool "pktcdvd" (see attachment) that uses sysfs.
+
+"pktcdvd" works similar to "pktsetup", e.g.:
+
+	# pktcdvd -a dev_name /dev/hdc
+	# mkudffs /dev/pktcdvd/dev_name
+	# mount -t udf -o rw,noatime /dev/pktcdvd/dev_name /dvdram
+	# cp files /dvdram
+	# umount /dvdram
+	# pktcdvd -r dev_name
+
+
+For a description of the sysfs interface look into the file:
+
+  Documentation/ABI/testing/sysfs-block-pktcdvd
+
+
+
+Bio write queue congestion marks
+--------------------------------
+The pktcdvd driver allows now to adjust the behaviour of the
+internal bio write queue.
+This can be done with the two write_congestion_[on|off] marks.
+The driver does only accept up to write_congestion_on bio
+write request from the i/o block layer, and waits till the
+requests are processed by the mapped block device and
+the queue size is below the write_congestion_off mark.
+In previous versions of pktcdvd, the driver accepted all
+incoming bio write request. This led sometimes to kernel
+out of memory oops (maybe some bugs in the linux kernel ;)
+CAUTION: use this options only if you know what you do!
+The default settings for the congestion marks should be ok
+for everyone.
+	
+
  Links
  -----

  See http://fy.chalmers.se/~appro/linux/DVD+RW/ for more information
  about DVD writing.
+
+
+
+---[snip]-------------------------------------------------
+#!/usr/bin/bash
+###########################################################################
+#                                                                         #
+#   Linux pktcdvd Module Control Script                                   #
+#                                                                         #
+#   Copyright (C) 2006 Thomas Maier <balagi@justmail.de>                  #
+#                                                                         #
+#   May be copied or modified under the terms of the GNU General Public   #
+#   License.                                                              #
+#                                                                         #
+#   This program is free software; you can redistribute it and/or modify  #
+#   it under the terms of the GNU General Public License as published by  #
+#   the Free Software Foundation;                                         #
+#                                                                         #
+#   This program is distributed in the hope that it will be useful,       #
+#   but WITHOUT ANY WARRANTY; without even the implied warranty of        #
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
+#   GNU General Public License for more details.                          #
+###########################################################################
+
+
+PKTCDVD_DIR="/sys/block/pktcdvd"
+PKTDEV_DIR="/dev/pktcdvd"
+
+usage()
+{
+	echo "pktcdvd control script   Version 1.0.0" >&2
+	echo "Copyright (C) 2006 Thomas Maier <balagi@justmail.de>" >&2
+	echo "usage:" >&2
+	echo " # add new packet device for block device" >&2
+	echo " pktcdvd -a pktname blkdev" >&2
+	echo " # remove a packet device" >&2
+	echo " pktcdvd -r pktname|pktmajor:pktminor" >&2
+	echo " # show packet device info" >&2
+	echo " pktcdvd -i pktname|pktmajor:pktminor" >&2
+	echo " # set write congestion marks for packet device" >&2
+	echo " pktcdvd -c pktname|pktmajor:pktminor on [off]" >&2
+	echo " # print write congestion marks for packet device" >&2
+	echo " pktcdvd -C pktname|pktmajor:pktminor" >&2
+	echo " # print device mapping" >&2
+	echo " pktcdvd -m" >&2
+	echo " # set number of concurrent packets for new devices" >&2
+	echo " pktcdvd -p packetbuffers" >&2
+	echo " # print number of concurrent packets" >&2
+	echo " pktcdvd -P" >&2
+}
+
+exiterr()
+{
+	[ -n "$1" ] && echo "error: $1" >&2
+	exit 1
+}
+
+usage_error()
+{
+	usage
+	exiterr
+}
+
+# device file to device id (major:minor)
+dev_to_id()
+{
+	if [[ "$1" == *:* ]] ; then
+		echo "$1"
+		return 0
+	elif [ -b "$1" ] ; then
+		/bin/ls -l "$1" \
+		  | awk '{print $5 ":" $6}' | tr -d ','
+		return 0
+	fi
+	return 1
+}
+
+# device file, device id or pktcdvd device name
+# to packet device id (major:minor)
+to_pktdev_id()
+{
+	typeset name="$1"
+	typeset devid=""
+
+	if [ -d "$PKTCDVD_DIR/$name" ] ; then
+		devid="$(cat "$PKTCDVD_DIR/$name/dev")"
+	elif [ -b "$PKTDEV_DIR/$name" ] ; then
+		devid="$(dev_to_id "$PKTDEV_DIR/$name")"
+	else
+		devid="$(dev_to_id "$name")"
+	fi
+	[ -z "$devid" ] && exiterr "can not get device id for $name"
+	echo "$devid"
+}
+
+to_pkt_name()
+{
+	typeset pktdev="$1"
+	typeset pktdevid
+	pktdevid="$(to_pktdev_id "$pktdev")" || exit 1
+	typeset pktname="$(awk '$2=="'"$pktdevid"'" {print $1}' "$PKTCDVD_DIR/device_map" )"
+	[ -z "$pktname" ] && exiterr "device $pktdev is not an active pktcdvd device"
+	echo "$pktname"
+}
+
+to_pkt_sdir()
+{
+	typeset name
+	name="$(to_pkt_name "$1")" || exit 1
+	echo "$PKTCDVD_DIR/$name/packet"
+}
+
+check_root()
+{
+	[ ! -w "$PKTCDVD_DIR/add" ] && exiterr "permission denied"
+}
+
+
+if [[ $# != 0 && ! -d "$PKTCDVD_DIR" ]] ; then
+	exiterr "pktcdvd module not loaded or no sysfs available"
+fi
+
+case "$1" in
+
+-a)
+	(( "$#" != 3 )) && usage_error
+	pktname="$2"
+	blkdev="$3"
+	blkdevid="$(dev_to_id "$blkdev")" || exiterr "not a block device: $blkdev"
+	pktdev="$PKTDEV_DIR/$pktname"
+
+	m="$(grep " $blkdevid\$" "$PKTCDVD_DIR/device_map")"
+	[ -n "$m" ] && exiterr "device $blkdev already mapped to: $m"
+	
+	check_root
+	echo "$blkdevid" >"$PKTCDVD_DIR/add" || exiterr "unable to add new pktcdvd device"
+	pktdevid="$(awk '$3=="'"$blkdevid"'" {print $2}' "$PKTCDVD_DIR/device_map" )"
+	[ -z "$pktdevid" ] && exiterr "can not add new pktcdvd device"
+	pktsysn="$(awk '$3=="'"$blkdevid"'" {print $1}' "$PKTCDVD_DIR/device_map" )"
+	
+	rm -f "$pktdev" "$PKTDEV_DIR/$pktsysn"
+	mkdir -p "$PKTDEV_DIR" || exiterr
+	major="$(echo "$pktdevid" | cut -f 1 -d ':')"
+	minor="$(echo "$pktdevid" | cut -f 2 -d ':')"
+	mknod "$PKTDEV_DIR/$pktsysn" b "$major" "$minor" \
+		|| exiterr "failed to make device node "$PKTDEV_DIR/$pktsysn" for $major:$minor"
+	chmod 644 "$PKTDEV_DIR/$pktsysn"
+	# create hard link, so dev_to_id() can resolve it!
+	[[ "$pktsysn" != "$pktname" ]] && ln -f "$PKTDEV_DIR/$pktsysn" "$pktdev"
+	
+	echo "ok: $pktdev ($pktsysn [$pktdevid] -> $blkdev [$blkdevid])"
+	;;
+	
+-r)
+	(( "$#" != 2 )) && usage_error
+	pktdev="$2"
+	pktdevid="$(to_pktdev_id "$pktdev")" || exit 1
+
+	pktsysn="$(awk '$2=="'"$pktdevid"'" {print $1}' "$PKTCDVD_DIR/device_map" )"
+	[ -z "$pktsysn" ] && exiterr "device $pktdev is not an active pktcdvd device"
+
+	check_root
+	echo "$pktdevid" >"$PKTCDVD_DIR/remove" \
+		|| exiterr "unable to remove pktcdvd device $pktdev ($pktdevid)"
+	fgrep " $pktdevid " "$PKTCDVD_DIR/device_map" >/dev/null \
+		&& exiterr "unable to remove pktcdvd device $pktdev ($pktdevid) or device busy"
+
+	# use the inode number of $pktsysn to remove all names of the device
+	inode="$(/bin/ls -i1 "$PKTDEV_DIR/$pktsysn" | awk '{print $1}')"
+	find "$PKTDEV_DIR" -follow -inum "$inode" -exec rm {} \;
+	;;
+	
+-i)
+	(( "$#" != 2 )) && usage_error
+	pktdev="$2"
+	pktsdir="$(to_pkt_sdir "$pktdev")" || exit 1
+	cat "$pktsdir/info"
+	exit "$?"
+	;;
+	
+-c)
+	(( "$#" < 3 )) && usage_error
+	pktdev="$2"
+	valon="$3"
+	valoff="$4"
+	sdir="$(to_pkt_sdir "$pktdev")" || exit 1
+	check_root
+	echo "$valon" >"$sdir/write_congestion_on"
+	[ -n "$valoff" ] && echo "$valoff" >"$sdir/write_congestion_off"
+	echo "off=$(cat "$sdir/write_congestion_off") on=$(cat "$sdir/write_congestion_on")"
+	;;
+	
+-C)
+	(( "$#" != 2 )) && usage_error
+	pktdev="$2"
+	sdir="$(to_pkt_sdir "$pktdev")" || exit 1
+	echo "off=$(cat "$sdir/write_congestion_off") on=$(cat "$sdir/write_congestion_on")"
+	;;
+	
+-m)
+	(( "$#" != 1 )) && usage_error
+	cat "$PKTCDVD_DIR/device_map"
+	exit "$?"
+	;;
+	
+-p)
+	(( "$#" != 2 )) && usage_error
+	check_root
+	echo "$2" >"$PKTCDVD_DIR/packet_buffers"
+	ret="$?"
+	cat "$PKTCDVD_DIR/packet_buffers"
+	exit "$ret"
+	;;
+	
+-P)
+	(( "$#" != 1 )) && usage_error
+	cat "$PKTCDVD_DIR/packet_buffers"
+	exit "$?"
+	;;
+	
+*)
+	usage_error
+	;;
+esac
+
+exit 0
diff -urpN linux-2.6.18-rc6/block/genhd.c pktcdvd-patch-2.6.18-rc6/block/genhd.c
--- linux-2.6.18-rc6/block/genhd.c	2006-09-04 21:24:46.000000000 +0200
+++ pktcdvd-patch-2.6.18-rc6/block/genhd.c	2006-09-05 20:29:41.000000000 +0200
@@ -510,6 +510,7 @@ static struct kset_uevent_ops block_ueve
  };

  decl_subsys(block, &ktype_block, &block_uevent_ops);
+EXPORT_SYMBOL(block_subsys);

  /*
   * aggregate disk stat collector.  Uses the same stats that the sysfs
diff -urpN linux-2.6.18-rc6/drivers/block/Kconfig pktcdvd-patch-2.6.18-rc6/drivers/block/Kconfig
--- linux-2.6.18-rc6/drivers/block/Kconfig	2006-09-04 21:25:04.000000000 +0200
+++ pktcdvd-patch-2.6.18-rc6/drivers/block/Kconfig	2006-09-05 20:29:41.000000000 +0200
@@ -428,17 +428,22 @@ config CDROM_PKTCDVD
  	tristate "Packet writing on CD/DVD media"
  	depends on !UML
  	help
-	  If you have a CDROM drive that supports packet writing, say Y to
-	  include preliminary support. It should work with any MMC/Mt Fuji
-	  compliant ATAPI or SCSI drive, which is just about any newer CD
-	  writer.
+	  If you have a CDROM/DVD drive that supports packet writing, say
+	  Y to include preliminary support. It should work with any
+	  MMC/Mt Fuji compliant ATAPI or SCSI drive, which is just about
+	  any newer DVD/CD writer.

-	  Currently only writing to CD-RW, DVD-RW and DVD+RW discs is possible.
+	  Currently only writing to CD-RW, DVD-RW, DVD+RW and DVDRAM discs
+	  is possible.
  	  DVD-RW disks must be in restricted overwrite mode.

  	  To compile this driver as a module, choose M here: the
  	  module will be called pktcdvd.

+	  For further information see the file
+
+	    Documentation/cdrom/packet-writing.txt
+	
  config CDROM_PKTCDVD_BUFFERS
  	int "Free buffers for data gathering"
  	depends on CDROM_PKTCDVD
@@ -458,6 +463,21 @@ config CDROM_PKTCDVD_WCACHE
  	  this option is dangerous unless the CD-RW media is known good, as we
  	  don't do deferred write error handling yet.

+config CDROM_PKTCDVD_PROCINTF
+	bool "Enable procfs interface"
+	depends on CDROM_PKTCDVD
+	default y
+	help
+	  Enable the proc filesystem interface for pktcdvd.
+	  The files can be found as:
+	
+	  /proc/driver/pktcdvd/pktcdvd<idx>
+	
+	  Also a misc device is added with a dynamic minor device id.
+	  See the entry in  /proc/misc  for the minor number.
+	  The misc pktcdvd driver supports ioctl calls, needed
+	  by the pktsetup tool found in udftools package.
+
  source "drivers/s390/block/Kconfig"

  config ATA_OVER_ETH
diff -urpN linux-2.6.18-rc6/drivers/block/pktcdvd.c pktcdvd-patch-2.6.18-rc6/drivers/block/pktcdvd.c
--- linux-2.6.18-rc6/drivers/block/pktcdvd.c	2006-09-04 21:24:59.000000000 +0200
+++ pktcdvd-patch-2.6.18-rc6/drivers/block/pktcdvd.c	2006-09-05 20:29:41.000000000 +0200
@@ -1,6 +1,7 @@
  /*
   * Copyright (C) 2000 Jens Axboe <axboe@suse.de>
   * Copyright (C) 2001-2004 Peter Osterlund <petero2@telia.com>
+ * Copyright (C) 2006 Thomas Maier <balagi@justmail.de>
   *
   * May be copied or modified under the terms of the GNU General Public
   * License.  See linux/COPYING for more information.
@@ -41,8 +42,15 @@
   * gathering to convert the unaligned writes to aligned writes and then feeds
   * them to the packet I/O scheduler.
   *
+ *
+ * 08/19/2006  Thomas Maier <balagi@justmail.de>
+ *	- added support for bio write queue congestion marks
+ * 08/26/2006  Thomas Maier <balagi@justmail.de>
+ *	- added sysfs support
+ *
   *************************************************************************/

+#include <linux/config.h>
  #include <linux/pktcdvd.h>
  #include <linux/module.h>
  #include <linux/types.h>
@@ -56,12 +64,14 @@
  #include <linux/miscdevice.h>
  #include <linux/suspend.h>
  #include <linux/mutex.h>
+#include <linux/sched.h>
  #include <scsi/scsi_cmnd.h>
  #include <scsi/scsi_ioctl.h>
  #include <scsi/scsi.h>

  #include <asm/uaccess.h>

+
  #if PACKET_DEBUG
  #define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
  #else
@@ -78,12 +88,531 @@

  #define ZONE(sector, pd) (((sector) + (pd)->offset) & ~((pd)->settings.size - 1))

+static int pktdev_major = 0; /* default: dynamic major number */
+static int write_congestion_on  = PKT_WRITE_CONGESTION_ON;
+static int write_congestion_off = PKT_WRITE_CONGESTION_OFF;
+static int packet_buffers = PKT_BUFFERS_DEFAULT;
+
  static struct pktcdvd_device *pkt_devs[MAX_WRITERS];
-static struct proc_dir_entry *pkt_proc;
-static int pkt_major;
  static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
  static mempool_t *psd_pool;

+static struct kobject	*kobj_blk_pktcdvd = NULL;
+
+
+/********************************************************
+ * utils
+ *******************************************************/
+
+static struct pktcdvd_device *pkt_find_dev_from_minor(int dev_minor)
+{
+	if (dev_minor >= MAX_WRITERS)
+		return NULL;
+	return pkt_devs[dev_minor];
+}
+
+static struct pktcdvd_device *pkt_find_dev(dev_t devid, int* pidx)
+{
+	int idx;
+	for (idx = 0; idx < MAX_WRITERS; idx++) {
+		struct pktcdvd_device *pd = pkt_devs[idx];
+		if (pd && (pd->pkt_dev == devid)) {
+			if (pidx)
+				*pidx = idx;
+			return pd;
+		}
+	}
+	if (pidx)
+		*pidx = 0;
+	return NULL;
+}
+
+static struct pktcdvd_device *pkt_find_dev_bdev(dev_t bdevid, int* pidx)
+{
+	int idx;
+	for (idx = 0; idx < MAX_WRITERS; idx++) {
+		struct pktcdvd_device *pd = pkt_devs[idx];
+		if (pd && pd->bdev && (pd->bdev->bd_dev == bdevid)) {
+			if (pidx)
+				*pidx = idx;
+			return pd;
+		}
+	}
+	if (pidx)
+		*pidx = 0;
+	return NULL;
+}
+
+static void init_congestion(int* lo, int* hi)
+{
+	if (*hi > 0) {
+		*hi = max(*hi, PKT_WRITE_CONGESTION_MIN);
+		*hi = min(*hi, PKT_WRITE_CONGESTION_MAX);
+		if (*lo <= 0)
+			*lo = *hi - PKT_WRITE_CONGESTION_THRESHOLD;
+		else {
+			*lo = min(*lo, *hi - PKT_WRITE_CONGESTION_THRESHOLD);
+			*lo = max(*lo, PKT_WRITE_CONGESTION_MIN/4);
+		}
+	} else {
+		*hi = -1;
+		*lo = -1;
+	}
+}
+
+static void init_packet_buffers(int *n)
+{
+	if (*n < 1)
+		*n = 1;
+	else if (*n > 128)
+		*n = 128;
+}
+
+static void pkt_count_states(struct pktcdvd_device *pd, int *states)
+{
+	struct packet_data *pkt;
+	int i;
+
+	for (i = 0; i < PACKET_NUM_STATES; i++)
+		states[i] = 0;
+
+	spin_lock(&pd->cdrw.active_list_lock);
+	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+		states[pkt->state]++;
+	}
+	spin_unlock(&pd->cdrw.active_list_lock);
+}
+
+static int pkt_print_info(struct pktcdvd_device *pd, char *buf, int blen)
+{
+	char *msg;
+	char bdev_buf[BDEVNAME_SIZE];
+	int states[PACKET_NUM_STATES];
+	int n = 0;
+
+#define PRINT	n += scnprintf
+#define BC	buf+n, blen-n
+	PRINT(BC, "Writer %s mapped to %s:\n", pd->name,
+		   		bdevname(pd->bdev, bdev_buf));
+
+	PRINT(BC, "\nSettings:\n");
+	PRINT(BC, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
+
+	if (pd->settings.write_type == 0)
+		msg = "Packet";
+	else
+		msg = "Unknown";
+	PRINT(BC, "\twrite type:\t\t%s\n", msg);
+
+	PRINT(BC, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
+	PRINT(BC, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
+
+	PRINT(BC, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
+
+	if (pd->settings.block_mode == PACKET_BLOCK_MODE1)
+		msg = "Mode 1";
+	else if (pd->settings.block_mode == PACKET_BLOCK_MODE2)
+		msg = "Mode 2";
+	else
+		msg = "Unknown";
+	PRINT(BC, "\tblock mode:\t\t%s\n", msg);
+	PRINT(BC, "\tconcurrent packets:\t%d\n", packet_buffers);
+
+	PRINT(BC, "\nStatistics:\n");
+	PRINT(BC, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
+	PRINT(BC, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
+	PRINT(BC, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
+	PRINT(BC, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
+	PRINT(BC, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
+
+	PRINT(BC, "\nMisc:\n");
+	PRINT(BC, "\treference count:\t%d\n", pd->refcnt);
+	PRINT(BC, "\tflags:\t\t\t0x%lx\n", pd->flags);
+	PRINT(BC, "\tread speed:\t\t%ukB/s\n", pd->read_speed);
+	PRINT(BC, "\twrite speed:\t\t%ukB/s\n", pd->write_speed);
+	PRINT(BC, "\tstart offset:\t\t%lu\n", pd->offset);
+	PRINT(BC, "\tmode page offset:\t%u\n", pd->mode_offset);
+
+	PRINT(BC, "\nQueue state:\n");
+	PRINT(BC, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
+	PRINT(BC, "\tbios pending:\t\t%d\n", atomic_read(&pd->cdrw.pending_bios));
+	PRINT(BC, "\tcurrent sector:\t\t0x%llx\n",
+					(unsigned long long)pd->current_sector);
+
+	pkt_count_states(pd, states);
+	PRINT(BC, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
+	      states[0], states[1], states[2], states[3], states[4], states[5]);
+		
+	PRINT(BC, "\twrite congestion marks:\toff=%d on=%d\n",
+			pd->write_congestion_off,
+			pd->write_congestion_on);
+#undef PRINT
+#undef BC
+	buf[blen-1] = 0;
+	return n;
+}
+
+
+
+/**********************************************************
+ *
+ * sysfs interface for pktcdvd
+ * by (C) 2006  Thomas Maier <balagi@justmail.de>
+ *
+ **********************************************************/
+
+#define to_pktdev(_k) container_of(_k, struct pktcdvd_device, kobj)
+
+#define DEF_ATTR(_obj,_name,_mode) \
+	static struct attribute _obj = { \
+		.name = _name, .owner = THIS_MODULE, .mode = _mode }
+
+/* forward declaration */
+static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
+static int pkt_remove_dev(dev_t pkt_dev);
+
+/**********************************************************
+  /sys/block/pktcdvd/pktcdvd?/packet/
+                     mapped_to (symlink)
+                     statistic
+                     reset_statistic
+                     write_congestion_off
+                     write_congestion_on
+ **********************************************************/
+
+DEF_ATTR(kobj_pkt_attr_stat, "statistic", 0444);
+DEF_ATTR(kobj_pkt_attr_reset_stat, "reset_statistic", 0200);
+DEF_ATTR(kobj_pkt_attr_info, "info", 0444);
+DEF_ATTR(kobj_pkt_attr_wqueue_size, "write_queue_size", 0444);
+DEF_ATTR(kobj_pkt_attr_wcong_off, "write_congestion_off", 0644);
+DEF_ATTR(kobj_pkt_attr_wcong_on, "write_congestion_on",  0644);
+
+/* forward declaration of kobject release function */
+static void kobj_pkt_release(struct kobject *kobj);
+
+
+static ssize_t kobj_pkt_show(struct kobject *kobj,
+			struct attribute *attr, char *data)
+{
+	struct pktcdvd_device *pd;
+	int n = 0;
+	int v;
+
+	if (!kobj || !attr || !data)
+		return 0;
+		
+	data[0] = 0;
+	pd = to_pktdev(kobj);
+
+	if (strcmp(attr->name, "statistic") == 0) {
+		n = sprintf(data, "%lu %lu %lu %lu %lu\n",
+			pd->stats.pkt_started,
+			pd->stats.pkt_ended,
+			pd->stats.secs_w >> 1,
+			pd->stats.secs_rg >> 1,
+			pd->stats.secs_r >> 1);
+
+	} else if (strcmp(attr->name, "info") == 0) {
+		n = pkt_print_info(pd, data, PAGE_SIZE-32);
+
+	} else if (strcmp(attr->name, "write_queue_size") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->bio_queue_size;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+		
+	} else if (strcmp(attr->name, "write_congestion_off") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->write_congestion_off;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+
+	} else if (strcmp(attr->name, "write_congestion_on") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->write_congestion_on;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+	}
+	return n;
+}
+
+static ssize_t kobj_pkt_store(struct kobject *kobj,
+			struct attribute *attr,
+			const char *data, size_t len)
+{
+	int val;
+	struct pktcdvd_device *pd;
+	char dbuf[64];
+	int dlen = len;
+
+	if (!kobj || !attr || !data || len < 0)
+		goto out;
+	/* make sure we have a zero terminated string */
+	if (dlen >= sizeof(dbuf))
+		dlen = sizeof(dbuf)-1;	
+	memcpy(dbuf, data, dlen);
+	dbuf[dlen] = 0;
+	
+	pd = to_pktdev(kobj);
+
+	if (strcmp(attr->name, "reset_statistic") == 0 && dlen > 0) {
+		pd->stats.pkt_started = 0;
+		pd->stats.pkt_ended = 0;
+		pd->stats.secs_w = 0;
+		pd->stats.secs_rg = 0;
+		pd->stats.secs_r = 0;
+		
+	} else if (strcmp(attr->name, "write_congestion_off") == 0
+		   && sscanf(dbuf, "%d", &val) == 1) {
+		spin_lock(&pd->lock);
+		pd->write_congestion_off = val;
+		init_congestion(&pd->write_congestion_off, &pd->write_congestion_on);
+		spin_unlock(&pd->lock);
+	} else if (strcmp(attr->name, "write_congestion_on") == 0
+		   && sscanf(dbuf, "%d", &val) == 1) {
+		spin_lock(&pd->lock);
+		pd->write_congestion_on = val;
+		init_congestion(&pd->write_congestion_off, &pd->write_congestion_on);
+		spin_unlock(&pd->lock);
+	}
+out:
+	return len;
+}
+
+static struct attribute *kobj_pkt_attrs[] = {
+	&kobj_pkt_attr_stat,
+	&kobj_pkt_attr_reset_stat,
+	&kobj_pkt_attr_info,
+	&kobj_pkt_attr_wqueue_size,
+	&kobj_pkt_attr_wcong_off,
+	&kobj_pkt_attr_wcong_on,
+	NULL
+};
+static struct sysfs_ops kobj_pkt_ops = {
+	.show = kobj_pkt_show,
+	.store = kobj_pkt_store
+};
+static struct kobj_type kobj_pkt_type = {
+	.release = kobj_pkt_release,
+	.sysfs_ops = &kobj_pkt_ops,
+	.default_attrs = kobj_pkt_attrs
+};
+
+
+
+/********************************************************************
+  /sys/block/pktcdvd/
+                     add            map block device
+                     remove         unmap packet dev
+                     device_map     show mappings
+                     packet_buffers number of packet buffers per dev
+ *******************************************************************/
+
+DEF_ATTR(kobj_blk_pktcdvd_attr_add, "add", 0200);
+DEF_ATTR(kobj_blk_pktcdvd_attr_rm, "remove", 0200);
+DEF_ATTR(kobj_blk_pktcdvd_attr_map, "device_map", 0444);
+DEF_ATTR(kobj_blk_pktcdvd_attr_bufs, "packet_buffers", 0644);
+
+static void kobj_blk_pktcdvd_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static ssize_t kobj_blk_pktcdvd_show(struct kobject *kobj,
+			struct attribute *attr, char *data)
+{
+	int n = 0;
+	
+	/* available size of data is PAGE_SIZE */
+	if (!kobj || !attr || !data)
+		return 0;
+
+	data[0] = 0;
+	
+	if (strcmp(attr->name, "device_map") == 0) {
+		int idx;
+		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+		for (idx = 0; idx < MAX_WRITERS; idx++) {
+			struct pktcdvd_device *pd = pkt_devs[idx];
+			if (!pd)
+				continue;
+			n += sprintf(data+n, "%s %u:%u %u:%u\n",
+				pd->name,
+				MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
+				MAJOR(pd->bdev->bd_dev),
+				MINOR(pd->bdev->bd_dev));
+		}
+		mutex_unlock(&ctl_mutex);
+		
+	} else if (strcmp(attr->name, "packet_buffers") == 0) {
+		n = sprintf(data, "%d\n", packet_buffers);
+	}
+	return n;
+}
+
+static ssize_t kobj_blk_pktcdvd_store(struct kobject *kobj,
+			struct attribute *attr,
+			const char *data, size_t len)
+{
+	unsigned int pkt_major, pkt_minor;
+	unsigned int blk_major, blk_minor;
+	int val;
+	char dbuf[64];
+	int dlen = len;
+	
+	if (!kobj || !attr || !data || len < 0)
+		goto out;
+	/* make sure we have a zero terminated string */
+	if (dlen >= sizeof(dbuf))
+		dlen = sizeof(dbuf)-1;	
+	memcpy(dbuf, data, dlen);
+	dbuf[dlen] = 0;
+	
+	if (strcmp(attr->name, "add") == 0
+	    && sscanf(dbuf, "%u:%u", &blk_major, &blk_minor) == 2) {
+		pkt_setup_dev(MKDEV(blk_major, blk_minor), NULL);
+		
+	} else if (strcmp(attr->name, "remove") == 0
+	    && sscanf(dbuf, "%u:%u", &pkt_major, &pkt_minor) == 2) {
+		pkt_remove_dev(MKDEV(pkt_major, pkt_minor));
+		
+	} else if (strcmp(attr->name, "packet_buffers") == 0
+	    			&& sscanf(dbuf, "%d", &val) == 1) {
+		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+		init_packet_buffers(&val);
+		packet_buffers = val;
+		mutex_unlock(&ctl_mutex);
+	}
+out:
+	return len;
+}
+
+static struct attribute *kobj_blk_pktcdvd_attrs[] = {
+	&kobj_blk_pktcdvd_attr_add,
+	&kobj_blk_pktcdvd_attr_rm,
+	&kobj_blk_pktcdvd_attr_map,
+	&kobj_blk_pktcdvd_attr_bufs,
+	NULL
+};
+static struct sysfs_ops kobj_blk_pktcdvd_ops = {
+	.show = kobj_blk_pktcdvd_show,
+	.store = kobj_blk_pktcdvd_store
+};
+static struct kobj_type kobj_blk_pktcdvd_type = {
+	.release = kobj_blk_pktcdvd_release,
+	.sysfs_ops = &kobj_blk_pktcdvd_ops,
+	.default_attrs = kobj_blk_pktcdvd_attrs
+};
+
+
+#if PKT_USE_OLD_PROC
+/********************************************************
+ *
+ * (old) procfs interface
+ *
+ *******************************************************/
+
+static struct proc_dir_entry *pkt_proc;
+
+
+/* file operations for /proc/driver/pktcdvd/.. files */
+
+static int pkt_seq_show(struct seq_file *m, void *p)
+{
+	struct pktcdvd_device *pd = m->private;
+	char buf[2048];
+	
+	pkt_print_info(pd, buf, sizeof(buf));
+	seq_printf(m, "%s", buf);
+	return 0;
+}
+
+static int pkt_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pkt_seq_show, PDE(inode)->data);
+}
+
+static struct file_operations pkt_proc_fops = {
+	.open	= pkt_seq_open,
+	.read	= seq_read,
+	.llseek	= seq_lseek,
+	.release = single_release
+};
+
+
+/* ioctl call for pktcdvd misc device */
+
+static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
+{
+	struct pktcdvd_device *pd;
+	
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	
+	pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
+	if (pd) {
+		ctrl_cmd->dev = new_encode_dev(pd->bdev->bd_dev);
+		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
+	} else {
+		ctrl_cmd->dev = 0;
+		ctrl_cmd->pkt_dev = 0;
+	}
+	ctrl_cmd->num_devices = MAX_WRITERS;
+	
+	mutex_unlock(&ctl_mutex);
+}
+
+static int pkt_ctl_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct pkt_ctrl_command ctrl_cmd;
+	int ret = 0;
+	dev_t pkt_dev;
+
+	if (cmd != PACKET_CTRL_CMD)
+		return -ENOTTY;
+
+	if (copy_from_user(&ctrl_cmd, argp, sizeof(struct pkt_ctrl_command)))
+		return -EFAULT;
+
+	switch (ctrl_cmd.command) {
+	case PKT_CTRL_CMD_SETUP:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		ret = pkt_setup_dev(new_decode_dev(ctrl_cmd.dev), &pkt_dev);
+		ctrl_cmd.pkt_dev = new_encode_dev(pkt_dev);
+		break;
+	case PKT_CTRL_CMD_TEARDOWN:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		ret = pkt_remove_dev(new_decode_dev(ctrl_cmd.pkt_dev));
+		break;
+	case PKT_CTRL_CMD_STATUS:
+		pkt_get_status(&ctrl_cmd);
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	if (copy_to_user(argp, &ctrl_cmd, sizeof(struct pkt_ctrl_command)))
+		return -EFAULT;
+	return ret;
+}
+
+static struct file_operations pkt_ctl_fops = {
+	.ioctl	 = pkt_ctl_ioctl,
+	.owner	 = THIS_MODULE,
+};
+static struct miscdevice pkt_misc = {
+	.minor 		= MISC_DYNAMIC_MINOR,
+	.name  		= "pktcdvd",
+	.fops  		= &pkt_ctl_fops
+};
+
+#endif /* PKT_USE_OLD_PROC */
+
+
+/****************************************************************/
+

  static void pkt_bio_finished(struct pktcdvd_device *pd)
  {
@@ -891,6 +1420,7 @@ static int pkt_handle_queue(struct pktcd
  	sector_t zone = 0; /* Suppress gcc warning */
  	struct pkt_rb_node *node, *first_node;
  	struct rb_node *n;
+	int wakeup;

  	VPRINTK("handle_queue\n");

@@ -963,7 +1493,14 @@ try_next_bio:
  		pkt->write_size += bio->bi_size / CD_FRAMESIZE;
  		spin_unlock(&pkt->lock);
  	}
+	/* check write congestion marks, and if bio_queue_size is
+	   below, wake up any waiters */
+	wakeup = (pd->write_congestion_on > 0
+	 		&& pd->bio_queue_size <= pd->write_congestion_off
+			&& waitqueue_active(&pd->write_congestion_wqueue));
  	spin_unlock(&pd->lock);
+	if (wakeup)
+		wake_up(&pd->write_congestion_wqueue);

  	pkt->sleep_time = max(PACKET_WAIT_TIME, 1);
  	pkt_set_state(pkt, PACKET_WAITING_STATE);
@@ -1165,21 +1702,6 @@ static void pkt_handle_packets(struct pk
  	spin_unlock(&pd->cdrw.active_list_lock);
  }

-static void pkt_count_states(struct pktcdvd_device *pd, int *states)
-{
-	struct packet_data *pkt;
-	int i;
-
-	for (i = 0; i < PACKET_NUM_STATES; i++)
-		states[i] = 0;
-
-	spin_lock(&pd->cdrw.active_list_lock);
-	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
-		states[pkt->state]++;
-	}
-	spin_unlock(&pd->cdrw.active_list_lock);
-}
-
  /*
   * kcdrwd is woken up when writes have been queued for one of our
   * registered devices
@@ -1907,26 +2429,226 @@ static int pkt_open_write(struct pktcdvd
  	return 0;
  }

-/*
- * called at open time.
- */
-static int pkt_open_dev(struct pktcdvd_device *pd, int write)
+
+static int pkt_end_io_read_cloned(struct bio *bio, unsigned int bytes_done, int err)
  {
-	int ret;
-	long lba;
-	request_queue_t *q;
+	struct packet_stacked_data *psd = bio->bi_private;
+	struct pktcdvd_device *pd = psd->pd;

-	/*
-	 * We need to re-open the cdrom device without O_NONBLOCK to be able
-	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
-	 * so bdget() can't fail.
-	 */
-	bdget(pd->bdev->bd_dev);
-	if ((ret = blkdev_get(pd->bdev, FMODE_READ, O_RDONLY)))
-		goto out;
+	if (bio->bi_size)
+		return 1;

-	if ((ret = bd_claim(pd->bdev, pd)))
-		goto out_putdev;
+	bio_put(bio);
+	bio_endio(psd->bio, psd->bio->bi_size, err);
+	mempool_free(psd, psd_pool);
+	pkt_bio_finished(pd);
+	return 0;
+}
+
+/*
+ * callback from block layer.
+ * process the bio request from the block layer.
+ */
+static int pkt_make_request(request_queue_t *q, struct bio *bio)
+{
+	struct pktcdvd_device *pd;
+	char b[BDEVNAME_SIZE];
+	sector_t zone;
+	struct packet_data *pkt;
+	int was_empty, blocked_bio;
+	struct pkt_rb_node *node;
+
+	pd = q->queuedata;
+	if (!pd) {
+		printk("pktcdvd: %s incorrect request queue\n", bdevname(bio->bi_bdev, b));
+		goto end_io;
+	}
+
+	/*
+	 * Clone READ bios so we can have our own bi_end_io callback.
+	 */
+	if (bio_data_dir(bio) == READ) {
+		struct bio *cloned_bio = bio_clone(bio, GFP_NOIO);
+		struct packet_stacked_data *psd = mempool_alloc(psd_pool, GFP_NOIO);
+
+		psd->pd = pd;
+		psd->bio = bio;
+		cloned_bio->bi_bdev = pd->bdev;
+		cloned_bio->bi_private = psd;
+		cloned_bio->bi_end_io = pkt_end_io_read_cloned;
+		pd->stats.secs_r += bio->bi_size >> 9;
+		pkt_queue_bio(pd, cloned_bio);
+		return 0;
+	}
+
+	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
+		printk("pktcdvd: WRITE for ro device %s (%llu)\n",
+			pd->name, (unsigned long long)bio->bi_sector);
+		goto end_io;
+	}
+
+	if (!bio->bi_size || (bio->bi_size % CD_FRAMESIZE)) {
+		printk("pktcdvd: wrong bio size\n");
+		goto end_io;
+	}
+
+	blk_queue_bounce(q, &bio);
+
+	zone = ZONE(bio->bi_sector, pd);
+	VPRINTK("pkt_make_request: start = %6llx stop = %6llx\n",
+		(unsigned long long)bio->bi_sector,
+		(unsigned long long)(bio->bi_sector + bio_sectors(bio)));
+
+	/* Check if we have to split the bio */
+	{
+		struct bio_pair *bp;
+		sector_t last_zone;
+		int first_sectors;
+
+		last_zone = ZONE(bio->bi_sector + bio_sectors(bio) - 1, pd);
+		if (last_zone != zone) {
+			BUG_ON(last_zone != zone + pd->settings.size);
+			first_sectors = last_zone - bio->bi_sector;
+			bp = bio_split(bio, bio_split_pool, first_sectors);
+			BUG_ON(!bp);
+			pkt_make_request(q, &bp->bio1);
+			pkt_make_request(q, &bp->bio2);
+			bio_pair_release(bp);
+			return 0;
+		}
+	}
+
+	/*
+	 * If we find a matching packet in state WAITING or READ_WAIT, we can
+	 * just append this bio to that packet.
+	 */
+	spin_lock(&pd->cdrw.active_list_lock);
+	blocked_bio = 0;
+	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+		if (pkt->sector == zone) {
+			spin_lock(&pkt->lock);
+			if ((pkt->state == PACKET_WAITING_STATE) ||
+			    (pkt->state == PACKET_READ_WAIT_STATE)) {
+				pkt_add_list_last(bio, &pkt->orig_bios,
+						  &pkt->orig_bios_tail);
+				pkt->write_size += bio->bi_size / CD_FRAMESIZE;
+				if ((pkt->write_size >= pkt->frames) &&
+				    (pkt->state == PACKET_WAITING_STATE)) {
+					atomic_inc(&pkt->run_sm);
+					wake_up(&pd->wqueue);
+				}
+				spin_unlock(&pkt->lock);
+				spin_unlock(&pd->cdrw.active_list_lock);
+				return 0;
+			} else {
+				blocked_bio = 1;
+			}
+			spin_unlock(&pkt->lock);
+		}
+	}
+	spin_unlock(&pd->cdrw.active_list_lock);
+
+	/*
+	 * Test if there is enough room left in the bio work queue
+	 * (queue size >= congestion on mark).
+	 * If not, wait till the work queue size is below the congestion off mark.
+	 * This is similar to the get_request_wait() call made in the block
+	 * layer function __make_request() used for normal block i/o request
+	 * handling.
+	 */
+	spin_lock(&pd->lock);
+	if (pd->write_congestion_on > 0
+	     && pd->bio_queue_size >= pd->write_congestion_on) {
+		DEFINE_WAIT(wait);
+		/* wait till number of bio requests is low enough */
+		do {
+			spin_unlock(&pd->lock);
+			prepare_to_wait_exclusive(&pd->write_congestion_wqueue,
+					&wait, TASK_UNINTERRUPTIBLE);
+			io_schedule();
+			/* if we are here, bio_queue_size should be below
+			   congestion_off, but be sure and do a test */
+			spin_lock(&pd->lock);
+		} while(pd->bio_queue_size > pd->write_congestion_off);
+		finish_wait(&pd->write_congestion_wqueue, &wait);
+	}
+	spin_unlock(&pd->lock);
+
+	/*
+	 * No matching packet found. Store the bio in the work queue.
+	 */
+	node = mempool_alloc(pd->rb_pool, GFP_NOIO);
+	node->bio = bio;
+	spin_lock(&pd->lock);
+	BUG_ON(pd->bio_queue_size < 0);
+	was_empty = (pd->bio_queue_size == 0);
+	pkt_rbtree_insert(pd, node);
+	spin_unlock(&pd->lock);
+
+	/*
+	 * Wake up the worker thread.
+	 */
+	atomic_set(&pd->scan_queue, 1);
+	if (was_empty) {
+		/* This wake_up is required for correct operation */
+		wake_up(&pd->wqueue);
+	} else if (!list_empty(&pd->cdrw.pkt_free_list) && !blocked_bio) {
+		/*
+		 * This wake up is not required for correct operation,
+		 * but improves performance in some cases.
+		 */
+		wake_up(&pd->wqueue);
+	}
+	return 0;
+end_io:
+	bio_io_error(bio, bio->bi_size);
+	return 0;
+}
+
+/*
+ * callback from block layer
+ */
+static int pkt_merge_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *bvec)
+{
+	struct pktcdvd_device *pd = q->queuedata;
+	sector_t zone = ZONE(bio->bi_sector, pd);
+	int used = ((bio->bi_sector - zone) << 9) + bio->bi_size;
+	int remaining = (pd->settings.size << 9) - used;
+	int remaining2;
+
+	/*
+	 * A bio <= PAGE_SIZE must be allowed. If it crosses a packet
+	 * boundary, pkt_make_request() will split the bio.
+	 */
+	remaining2 = PAGE_SIZE - bio->bi_size;
+	remaining = max(remaining, remaining2);
+
+	BUG_ON(remaining < 0);
+	return remaining;
+}
+
+
+
+/*
+ * called at open time.
+ */
+static int pkt_open_dev(struct pktcdvd_device *pd, int write)
+{
+	int ret;
+	long lba;
+	request_queue_t *q;
+
+	/*
+	 * We need to re-open the cdrom device without O_NONBLOCK to be able
+	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
+	 * so bdget() can't fail.
+	 */
+	bdget(pd->bdev->bd_dev);
+	if ((ret = blkdev_get(pd->bdev, FMODE_READ, O_RDONLY)))
+		goto out;
+
+	if ((ret = bd_claim(pd->bdev, pd)))
+		goto out_putdev;

  	if ((ret = pkt_get_last_written(pd, &lba))) {
  		printk("pktcdvd: pkt_get_last_written failed\n");
@@ -1958,7 +2680,7 @@ static int pkt_open_dev(struct pktcdvd_d
  		goto out_unclaim;

  	if (write) {
-		if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
+		if (!pkt_grow_pktlist(pd, packet_buffers)) {
  			printk("pktcdvd: not enough memory for buffers\n");
  			ret = -ENOMEM;
  			goto out_unclaim;
@@ -1994,12 +2716,13 @@ static void pkt_release_dev(struct pktcd
  	pkt_shrink_pktlist(pd);
  }

-static struct pktcdvd_device *pkt_find_dev_from_minor(int dev_minor)
-{
-	if (dev_minor >= MAX_WRITERS)
-		return NULL;
-	return pkt_devs[dev_minor];
-}
+
+
+/******************************************************************
+ *
+ * pktcdvd block device operations
+ *
+ *****************************************************************/

  static int pkt_open(struct inode *inode, struct file *file)
  {
@@ -2061,174 +2784,74 @@ static int pkt_close(struct inode *inode
  	return ret;
  }

-
-static int pkt_end_io_read_cloned(struct bio *bio, unsigned int bytes_done, int err)
-{
-	struct packet_stacked_data *psd = bio->bi_private;
-	struct pktcdvd_device *pd = psd->pd;
-
-	if (bio->bi_size)
-		return 1;
-
-	bio_put(bio);
-	bio_endio(psd->bio, psd->bio->bi_size, err);
-	mempool_free(psd, psd_pool);
-	pkt_bio_finished(pd);
-	return 0;
-}
-
-static int pkt_make_request(request_queue_t *q, struct bio *bio)
+static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
  {
-	struct pktcdvd_device *pd;
-	char b[BDEVNAME_SIZE];
-	sector_t zone;
-	struct packet_data *pkt;
-	int was_empty, blocked_bio;
-	struct pkt_rb_node *node;
-
-	pd = q->queuedata;
-	if (!pd) {
-		printk("pktcdvd: %s incorrect request queue\n", bdevname(bio->bi_bdev, b));
-		goto end_io;
-	}
-
-	/*
-	 * Clone READ bios so we can have our own bi_end_io callback.
-	 */
-	if (bio_data_dir(bio) == READ) {
-		struct bio *cloned_bio = bio_clone(bio, GFP_NOIO);
-		struct packet_stacked_data *psd = mempool_alloc(psd_pool, GFP_NOIO);
-
-		psd->pd = pd;
-		psd->bio = bio;
-		cloned_bio->bi_bdev = pd->bdev;
-		cloned_bio->bi_private = psd;
-		cloned_bio->bi_end_io = pkt_end_io_read_cloned;
-		pd->stats.secs_r += bio->bi_size >> 9;
-		pkt_queue_bio(pd, cloned_bio);
-		return 0;
-	}
-
-	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
-		printk("pktcdvd: WRITE for ro device %s (%llu)\n",
-			pd->name, (unsigned long long)bio->bi_sector);
-		goto end_io;
-	}
-
-	if (!bio->bi_size || (bio->bi_size % CD_FRAMESIZE)) {
-		printk("pktcdvd: wrong bio size\n");
-		goto end_io;
-	}
-
-	blk_queue_bounce(q, &bio);
-
-	zone = ZONE(bio->bi_sector, pd);
-	VPRINTK("pkt_make_request: start = %6llx stop = %6llx\n",
-		(unsigned long long)bio->bi_sector,
-		(unsigned long long)(bio->bi_sector + bio_sectors(bio)));
-
-	/* Check if we have to split the bio */
-	{
-		struct bio_pair *bp;
-		sector_t last_zone;
-		int first_sectors;
-
-		last_zone = ZONE(bio->bi_sector + bio_sectors(bio) - 1, pd);
-		if (last_zone != zone) {
-			BUG_ON(last_zone != zone + pd->settings.size);
-			first_sectors = last_zone - bio->bi_sector;
-			bp = bio_split(bio, bio_split_pool, first_sectors);
-			BUG_ON(!bp);
-			pkt_make_request(q, &bp->bio1);
-			pkt_make_request(q, &bp->bio2);
-			bio_pair_release(bp);
-			return 0;
-		}
-	}
+	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;

-	/*
-	 * If we find a matching packet in state WAITING or READ_WAIT, we can
-	 * just append this bio to that packet.
-	 */
-	spin_lock(&pd->cdrw.active_list_lock);
-	blocked_bio = 0;
-	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
-		if (pkt->sector == zone) {
-			spin_lock(&pkt->lock);
-			if ((pkt->state == PACKET_WAITING_STATE) ||
-			    (pkt->state == PACKET_READ_WAIT_STATE)) {
-				pkt_add_list_last(bio, &pkt->orig_bios,
-						  &pkt->orig_bios_tail);
-				pkt->write_size += bio->bi_size / CD_FRAMESIZE;
-				if ((pkt->write_size >= pkt->frames) &&
-				    (pkt->state == PACKET_WAITING_STATE)) {
-					atomic_inc(&pkt->run_sm);
-					wake_up(&pd->wqueue);
-				}
-				spin_unlock(&pkt->lock);
-				spin_unlock(&pd->cdrw.active_list_lock);
-				return 0;
-			} else {
-				blocked_bio = 1;
-			}
-			spin_unlock(&pkt->lock);
-		}
-	}
-	spin_unlock(&pd->cdrw.active_list_lock);
+	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));

+	switch (cmd) {
  	/*
-	 * No matching packet found. Store the bio in the work queue.
+	 * forward selected CDROM ioctls to CD-ROM, for UDF
  	 */
-	node = mempool_alloc(pd->rb_pool, GFP_NOIO);
-	node->bio = bio;
-	spin_lock(&pd->lock);
-	BUG_ON(pd->bio_queue_size < 0);
-	was_empty = (pd->bio_queue_size == 0);
-	pkt_rbtree_insert(pd, node);
-	spin_unlock(&pd->lock);
+	case CDROMMULTISESSION:
+	case CDROMREADTOCENTRY:
+	case CDROM_LAST_WRITTEN:
+	case CDROM_SEND_PACKET:
+	case SCSI_IOCTL_SEND_COMMAND:
+		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);

-	/*
-	 * Wake up the worker thread.
-	 */
-	atomic_set(&pd->scan_queue, 1);
-	if (was_empty) {
-		/* This wake_up is required for correct operation */
-		wake_up(&pd->wqueue);
-	} else if (!list_empty(&pd->cdrw.pkt_free_list) && !blocked_bio) {
+	case CDROMEJECT:
  		/*
-		 * This wake up is not required for correct operation,
-		 * but improves performance in some cases.
+		 * The door gets locked when the device is opened, so we
+		 * have to unlock it or else the eject command fails.
  		 */
-		wake_up(&pd->wqueue);
+		if (pd->refcnt == 1)
+			pkt_lock_door(pd, 0);
+		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
+
+	default:
+		VPRINTK("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
+		return -ENOTTY;
  	}
-	return 0;
-end_io:
-	bio_io_error(bio, bio->bi_size);
+
  	return 0;
  }

+static int pkt_media_changed(struct gendisk *disk)
+{
+	struct pktcdvd_device *pd = disk->private_data;
+	struct gendisk *attached_disk;

+	if (!pd)
+		return 0;
+	if (!pd->bdev)
+		return 0;
+	attached_disk = pd->bdev->bd_disk;
+	if (!attached_disk)
+		return 0;
+	return attached_disk->fops->media_changed(attached_disk);
+}

-static int pkt_merge_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *bvec)
-{
-	struct pktcdvd_device *pd = q->queuedata;
-	sector_t zone = ZONE(bio->bi_sector, pd);
-	int used = ((bio->bi_sector - zone) << 9) + bio->bi_size;
-	int remaining = (pd->settings.size << 9) - used;
-	int remaining2;
+static struct block_device_operations pktcdvd_ops = {
+	.owner =		THIS_MODULE,
+	.open =			pkt_open,
+	.release =		pkt_close,
+	.ioctl =		pkt_ioctl,
+	.media_changed =	pkt_media_changed,
+};

-	/*
-	 * A bio <= PAGE_SIZE must be allowed. If it crosses a packet
-	 * boundary, pkt_make_request() will split the bio.
-	 */
-	remaining2 = PAGE_SIZE - bio->bi_size;
-	remaining = max(remaining, remaining2);

-	BUG_ON(remaining < 0);
-	return remaining;
-}
+/***********************************************************************
+ *
+ * packet device setup and removal
+ *
+ **********************************************************************/

-static void pkt_init_queue(struct pktcdvd_device *pd)
+/*
+ * helper for pkt_new_dev()
+ */
+ static void pkt_init_queue(struct pktcdvd_device *pd)
  {
  	request_queue_t *q = pd->disk->queue;

@@ -2238,84 +2861,14 @@ static void pkt_init_queue(struct pktcdv
  	blk_queue_merge_bvec(q, pkt_merge_bvec);
  	q->queuedata = pd;
  }
-
-static int pkt_seq_show(struct seq_file *m, void *p)
-{
-	struct pktcdvd_device *pd = m->private;
-	char *msg;
-	char bdev_buf[BDEVNAME_SIZE];
-	int states[PACKET_NUM_STATES];
-
-	seq_printf(m, "Writer %s mapped to %s:\n", pd->name,
-		   bdevname(pd->bdev, bdev_buf));
-
-	seq_printf(m, "\nSettings:\n");
-	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
-
-	if (pd->settings.write_type == 0)
-		msg = "Packet";
-	else
-		msg = "Unknown";
-	seq_printf(m, "\twrite type:\t\t%s\n", msg);
-
-	seq_printf(m, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
-	seq_printf(m, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
-
-	seq_printf(m, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
-
-	if (pd->settings.block_mode == PACKET_BLOCK_MODE1)
-		msg = "Mode 1";
-	else if (pd->settings.block_mode == PACKET_BLOCK_MODE2)
-		msg = "Mode 2";
-	else
-		msg = "Unknown";
-	seq_printf(m, "\tblock mode:\t\t%s\n", msg);
-
-	seq_printf(m, "\nStatistics:\n");
-	seq_printf(m, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
-	seq_printf(m, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
-	seq_printf(m, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
-	seq_printf(m, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
-	seq_printf(m, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
-
-	seq_printf(m, "\nMisc:\n");
-	seq_printf(m, "\treference count:\t%d\n", pd->refcnt);
-	seq_printf(m, "\tflags:\t\t\t0x%lx\n", pd->flags);
-	seq_printf(m, "\tread speed:\t\t%ukB/s\n", pd->read_speed);
-	seq_printf(m, "\twrite speed:\t\t%ukB/s\n", pd->write_speed);
-	seq_printf(m, "\tstart offset:\t\t%lu\n", pd->offset);
-	seq_printf(m, "\tmode page offset:\t%u\n", pd->mode_offset);
-
-	seq_printf(m, "\nQueue state:\n");
-	seq_printf(m, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
-	seq_printf(m, "\tbios pending:\t\t%d\n", atomic_read(&pd->cdrw.pending_bios));
-	seq_printf(m, "\tcurrent sector:\t\t0x%llx\n", (unsigned long long)pd->current_sector);
-
-	pkt_count_states(pd, states);
-	seq_printf(m, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
-		   states[0], states[1], states[2], states[3], states[4], states[5]);
-
-	return 0;
-}
-
-static int pkt_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pkt_seq_show, PDE(inode)->data);
-}
-
-static struct file_operations pkt_proc_fops = {
-	.open	= pkt_seq_open,
-	.read	= seq_read,
-	.llseek	= seq_lseek,
-	.release = single_release
-};
-
+/*
+ * helper for pkt_setup_dev()
+ */
  static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
  {
  	int i;
  	int ret = 0;
  	char b[BDEVNAME_SIZE];
-	struct proc_dir_entry *proc;
  	struct block_device *bdev;

  	if (pd->pkt_dev == dev) {
@@ -2342,10 +2895,19 @@ static int pkt_new_dev(struct pktcdvd_de
  	ret = blkdev_get(bdev, FMODE_READ, O_RDONLY | O_NONBLOCK);
  	if (ret)
  		return ret;
-
+	
  	/* This is safe, since we have a reference from open(). */
  	__module_get(THIS_MODULE);

+	/* the block device must have a queue ! else many of the
+	   pktcdvd code breaks. */
+	if (!bdev_get_queue(bdev)) {
+		printk("pktcdvd: block device %s has no request queue, aborting\n",
+			bdevname(bdev, b));
+		ret = -ENXIO;
+		goto out_mem;
+	}
+
  	pd->bdev = bdev;
  	set_blocksize(bdev, CD_FRAMESIZE);

@@ -2359,11 +2921,16 @@ static int pkt_new_dev(struct pktcdvd_de
  		goto out_mem;
  	}

-	proc = create_proc_entry(pd->name, 0, pkt_proc);
-	if (proc) {
-		proc->data = pd;
-		proc->proc_fops = &pkt_proc_fops;
+#if PKT_USE_OLD_PROC
+	{
+		struct proc_dir_entry *proc = create_proc_entry(pd->name, 0, pkt_proc);
+		if (proc) {
+			proc->data = pd;
+			proc->proc_fops = &pkt_proc_fops;
+		}
  	}
+#endif
+
  	DPRINTK("pktcdvd: writer %s mapped to %s\n", pd->name, bdevname(bdev, b));
  	return 0;

@@ -2374,96 +2941,36 @@ out_mem:
  	return ret;
  }

-static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;
-
-	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));
-
-	switch (cmd) {
-	/*
-	 * forward selected CDROM ioctls to CD-ROM, for UDF
-	 */
-	case CDROMMULTISESSION:
-	case CDROMREADTOCENTRY:
-	case CDROM_LAST_WRITTEN:
-	case CDROM_SEND_PACKET:
-	case SCSI_IOCTL_SEND_COMMAND:
-		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
-
-	case CDROMEJECT:
-		/*
-		 * The door gets locked when the device is opened, so we
-		 * have to unlock it or else the eject command fails.
-		 */
-		if (pd->refcnt == 1)
-			pkt_lock_door(pd, 0);
-		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
-
-	default:
-		VPRINTK("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
-		return -ENOTTY;
-	}
-
-	return 0;
-}
-
-static int pkt_media_changed(struct gendisk *disk)
-{
-	struct pktcdvd_device *pd = disk->private_data;
-	struct gendisk *attached_disk;
-
-	if (!pd)
-		return 0;
-	if (!pd->bdev)
-		return 0;
-	attached_disk = pd->bdev->bd_disk;
-	if (!attached_disk)
-		return 0;
-	return attached_disk->fops->media_changed(attached_disk);
-}
-
-static struct block_device_operations pktcdvd_ops = {
-	.owner =		THIS_MODULE,
-	.open =			pkt_open,
-	.release =		pkt_close,
-	.ioctl =		pkt_ioctl,
-	.media_changed =	pkt_media_changed,
-};
-
  /*
   * Set up mapping from pktcdvd device to CD-ROM device.
   */
-static int pkt_setup_dev(struct pkt_ctrl_command *ctrl_cmd)
+static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
  {
  	int idx;
  	int ret = -ENOMEM;
  	struct pktcdvd_device *pd;
  	struct gendisk *disk;
-	dev_t dev = new_decode_dev(ctrl_cmd->dev);
+	
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);

  	for (idx = 0; idx < MAX_WRITERS; idx++)
  		if (!pkt_devs[idx])
  			break;
  	if (idx == MAX_WRITERS) {
  		printk("pktcdvd: max %d writers supported\n", MAX_WRITERS);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_mutex;
  	}

  	pd = kzalloc(sizeof(struct pktcdvd_device), GFP_KERNEL);
  	if (!pd)
-		return ret;
-
+		goto out_mutex;
+	
  	pd->rb_pool = mempool_create_kmalloc_pool(PKT_RB_POOL_SIZE,
  						  sizeof(struct pkt_rb_node));
  	if (!pd->rb_pool)
  		goto out_mem;
-
-	disk = alloc_disk(1);
-	if (!disk)
-		goto out_mem;
-	pd->disk = disk;
-
+	
  	INIT_LIST_HEAD(&pd->cdrw.pkt_free_list);
  	INIT_LIST_HEAD(&pd->cdrw.pkt_active_list);
  	spin_lock_init(&pd->cdrw.active_list_lock);
@@ -2474,7 +2981,15 @@ static int pkt_setup_dev(struct pkt_ctrl
  	init_waitqueue_head(&pd->wqueue);
  	pd->bio_queue = RB_ROOT;

-	disk->major = pkt_major;
+	init_waitqueue_head(&pd->write_congestion_wqueue);
+	pd->write_congestion_on  = write_congestion_on;
+	pd->write_congestion_off = write_congestion_off;
+
+	disk = alloc_disk(1);
+	if (!disk)
+		goto out_mem;
+	pd->disk = disk;
+	disk->major = pktdev_major;
  	disk->first_minor = idx;
  	disk->fops = &pktcdvd_ops;
  	disk->flags = GENHD_FL_REMOVABLE;
@@ -2489,11 +3004,41 @@ static int pkt_setup_dev(struct pkt_ctrl
  	if (ret)
  		goto out_new_dev;

+	/* move disk kobject to a child of the pktcdvd node
+	   in /sys/block, so that the disk is now available as
+	
+	     /sys/block/pktcdvd/<diskname>
+	 */
+	disk->kobj.parent = kobj_blk_pktcdvd;
+
  	add_disk(disk);
+	
+	/*
+	 * setup kernel object after add_disk(), because
+	 * we are a child of the disk's kobject!
+	 */
+	strlcpy(pd->kobj.name, "packet", KOBJ_NAME_LEN);
+	pd->kobj.parent = &disk->kobj;
+	pd->kobj.ktype = &kobj_pkt_type;
+	if (kobject_register(&pd->kobj) != 0) {
+		printk("pktcdvd: failed to register block pktcdvd "
+		       "kernel object\n");
+		goto out_disk;
+	}
+	if (pd->bdev->bd_disk)
+		sysfs_create_link(&pd->kobj, &pd->bdev->bd_disk->kobj,
+				"mapped_to");
+
  	pkt_devs[idx] = pd;
-	ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
+	if (pkt_dev)
+		*pkt_dev = pd->pkt_dev;
+	
+	mutex_unlock(&ctl_mutex);
  	return 0;

+out_disk:
+	blkdev_put(pd->bdev);
+	del_gendisk(pd->disk);
  out_new_dev:
  	blk_cleanup_queue(disk->queue);
  out_mem2:
@@ -2502,149 +3047,144 @@ out_mem:
  	if (pd->rb_pool)
  		mempool_destroy(pd->rb_pool);
  	kfree(pd);
+out_mutex:	
+	mutex_unlock(&ctl_mutex);
+	printk("pktcdvd: setup of pktcdvd device failed\n");
  	return ret;
  }

  /*
   * Tear down mapping from pktcdvd device to CD-ROM device.
   */
-static int pkt_remove_dev(struct pkt_ctrl_command *ctrl_cmd)
+static int pkt_remove_dev(dev_t pkt_dev)
  {
  	struct pktcdvd_device *pd;
  	int idx;
-	dev_t pkt_dev = new_decode_dev(ctrl_cmd->pkt_dev);
+	int ret = 0;
+	
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);

-	for (idx = 0; idx < MAX_WRITERS; idx++) {
-		pd = pkt_devs[idx];
-		if (pd && (pd->pkt_dev == pkt_dev))
-			break;
-	}
-	if (idx == MAX_WRITERS) {
-		DPRINTK("pktcdvd: dev not setup\n");
-		return -ENXIO;
+	pd = pkt_find_dev(pkt_dev, &idx);
+	if (!pd) {
+		/* maybe pkt_dev is the mapped block device id */
+		pd = pkt_find_dev_bdev(pkt_dev, &idx);
+		if (!pd) {
+			DPRINTK("pktcdvd: dev not setup\n");
+			ret = -ENXIO;
+			goto out;
+		}
  	}

-	if (pd->refcnt > 0)
-		return -EBUSY;
-
+	if (pd->refcnt > 0) {
+		ret = -EBUSY;
+		goto out;
+	}
  	if (!IS_ERR(pd->cdrw.thread))
  		kthread_stop(pd->cdrw.thread);
+	
+	pkt_devs[idx] = NULL;
+	
+	/* calls kobj_pkt_release() if last user of the kobject */
+	sysfs_remove_link(&pd->kobj, "mapped_to");
+	kobject_unregister(&pd->kobj);
+out:
+	mutex_unlock(&ctl_mutex);
+	return ret;
+}

+static void kobj_pkt_release(struct kobject *kobj)
+{
+	struct pktcdvd_device *pd = to_pktdev(kobj);
+	
  	blkdev_put(pd->bdev);

+#if PKT_USE_OLD_PROC
  	remove_proc_entry(pd->name, pkt_proc);
+#endif
  	DPRINTK("pktcdvd: writer %s unmapped\n", pd->name);

  	del_gendisk(pd->disk);
  	blk_cleanup_queue(pd->disk->queue);
  	put_disk(pd->disk);

-	pkt_devs[idx] = NULL;
  	mempool_destroy(pd->rb_pool);
  	kfree(pd);

  	/* This is safe: open() is still holding a reference. */
  	module_put(THIS_MODULE);
-	return 0;
-}
-
-static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
-{
-	struct pktcdvd_device *pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
-	if (pd) {
-		ctrl_cmd->dev = new_encode_dev(pd->bdev->bd_dev);
-		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
-	} else {
-		ctrl_cmd->dev = 0;
-		ctrl_cmd->pkt_dev = 0;
-	}
-	ctrl_cmd->num_devices = MAX_WRITERS;
-}
-
-static int pkt_ctl_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	struct pkt_ctrl_command ctrl_cmd;
-	int ret = 0;
-
-	if (cmd != PACKET_CTRL_CMD)
-		return -ENOTTY;
-
-	if (copy_from_user(&ctrl_cmd, argp, sizeof(struct pkt_ctrl_command)))
-		return -EFAULT;
-
-	switch (ctrl_cmd.command) {
-	case PKT_CTRL_CMD_SETUP:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-		ret = pkt_setup_dev(&ctrl_cmd);
-		mutex_unlock(&ctl_mutex);
-		break;
-	case PKT_CTRL_CMD_TEARDOWN:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-		ret = pkt_remove_dev(&ctrl_cmd);
-		mutex_unlock(&ctl_mutex);
-		break;
-	case PKT_CTRL_CMD_STATUS:
-		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-		pkt_get_status(&ctrl_cmd);
-		mutex_unlock(&ctl_mutex);
-		break;
-	default:
-		return -ENOTTY;
-	}
-
-	if (copy_to_user(argp, &ctrl_cmd, sizeof(struct pkt_ctrl_command)))
-		return -EFAULT;
-	return ret;
  }


-static struct file_operations pkt_ctl_fops = {
-	.ioctl	 = pkt_ctl_ioctl,
-	.owner	 = THIS_MODULE,
-};

-static struct miscdevice pkt_misc = {
-	.minor 		= MISC_DYNAMIC_MINOR,
-	.name  		= "pktcdvd",
-	.fops  		= &pkt_ctl_fops
-};
+/********************************************************
+ *
+ * module init and exit
+ *
+ *******************************************************/

  static int __init pkt_init(void)
  {
  	int ret;

+	/* check module parameters */
+	init_congestion(&write_congestion_off, &write_congestion_on);
+	init_packet_buffers(&packet_buffers);
+
+	mutex_init(&ctl_mutex);
+
  	psd_pool = mempool_create_kmalloc_pool(PSD_POOL_SIZE,
  					sizeof(struct packet_stacked_data));
  	if (!psd_pool)
  		return -ENOMEM;

-	ret = register_blkdev(pkt_major, "pktcdvd");
+	ret = register_blkdev(pktdev_major, "pktcdvd");
  	if (ret < 0) {
  		printk("pktcdvd: Unable to register block device\n");
  		goto out2;
  	}
-	if (!pkt_major)
-		pkt_major = ret;
+	if (!pktdev_major)
+		pktdev_major = ret;

+	/*
+	 * create control files in sysfs
+	 * /sys/block/pktcdvd/...
+	 */
+	kobj_blk_pktcdvd = kzalloc(sizeof(*kobj_blk_pktcdvd), GFP_KERNEL);
+	if (!kobj_blk_pktcdvd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	strlcpy(kobj_blk_pktcdvd->name, "pktcdvd", KOBJ_NAME_LEN);
+	kobj_blk_pktcdvd->parent = &block_subsys.kset.kobj;
+	kobj_blk_pktcdvd->ktype = &kobj_blk_pktcdvd_type;
+	ret = kobject_register(kobj_blk_pktcdvd);
+	if (ret) {
+		printk("pktcdvd: failed to register"
+		       " pktcdvd kernel object\n");
+		kfree(kobj_blk_pktcdvd);
+		kobj_blk_pktcdvd = NULL;
+		goto out;
+	}
+	
+#if PKT_USE_OLD_PROC
  	ret = misc_register(&pkt_misc);
  	if (ret) {
  		printk("pktcdvd: Unable to register misc device\n");
-		goto out;
+		goto out_misc;
  	}
-
-	mutex_init(&ctl_mutex);
-
  	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
-
+#endif	
  	return 0;

+
+#if PKT_USE_OLD_PROC
+out_misc:
+	kobject_unregister(kobj_blk_pktcdvd);
+	kobj_blk_pktcdvd = NULL;
+#endif
+	
  out:
-	unregister_blkdev(pkt_major, "pktcdvd");
+	unregister_blkdev(pktdev_major, "pktcdvd");
  out2:
  	mempool_destroy(psd_pool);
  	return ret;
@@ -2652,15 +3192,31 @@ out2:

  static void __exit pkt_exit(void)
  {
+	if (kobj_blk_pktcdvd)
+		kobject_unregister(kobj_blk_pktcdvd);
+	kobj_blk_pktcdvd = NULL;
+	
+#if PKT_USE_OLD_PROC
  	remove_proc_entry("pktcdvd", proc_root_driver);
  	misc_deregister(&pkt_misc);
-	unregister_blkdev(pkt_major, "pktcdvd");
+#endif
+	unregister_blkdev(pktdev_major, "pktcdvd");
  	mempool_destroy(psd_pool);
  }

+/***************************************************************
+ * module declaration
+ **************************************************************/
+
  MODULE_DESCRIPTION("Packet writing layer for CD/DVD drives");
-MODULE_AUTHOR("Jens Axboe <axboe@suse.de>");
+MODULE_AUTHOR("Jens Axboe <axboe@suse.de>,Peter Osterlund <petero2@telia.com>,Thomas Maier <balagi@justmail.de>");
  MODULE_LICENSE("GPL");

  module_init(pkt_init);
  module_exit(pkt_exit);
+
+module_param(pktdev_major, int, 0);
+module_param(write_congestion_on, int, 0);
+module_param(write_congestion_off, int, 0);
+module_param(packet_buffers, int, 0);
+
diff -urpN linux-2.6.18-rc6/include/linux/pktcdvd.h pktcdvd-patch-2.6.18-rc6/include/linux/pktcdvd.h
--- linux-2.6.18-rc6/include/linux/pktcdvd.h	2006-09-04 21:24:36.000000000 +0200
+++ pktcdvd-patch-2.6.18-rc6/include/linux/pktcdvd.h	2006-09-05 20:29:41.000000000 +0200
@@ -1,6 +1,7 @@
  /*
   * Copyright (C) 2000 Jens Axboe <axboe@suse.de>
   * Copyright (C) 2001-2004 Peter Osterlund <petero2@telia.com>
+ * Copyright (C) 2006 Thomas Maier <balagi@justmail.de>
   *
   * May be copied or modified under the terms of the GNU General Public
   * License.  See linux/COPYING for more information.
@@ -8,12 +9,51 @@
   * Packet writing layer for ATAPI and SCSI CD-R, CD-RW, DVD-R, and
   * DVD-RW devices.
   *
+ *
+ * 08/19/2006  Thomas Maier <balagi@justmail.de>
+ *	- added support for bio write queue congestion marks
+ * 08/26/2006  Thomas Maier <balagi@justmail.de>
+ *	- added sysfs support
+ *
   */
  #ifndef __PKTCDVD_H
  #define __PKTCDVD_H

  #include <linux/types.h>

+
+#define PKT_CTRL_CMD_SETUP	0
+#define PKT_CTRL_CMD_TEARDOWN	1
+#define PKT_CTRL_CMD_STATUS	2
+
+struct pkt_ctrl_command {
+	__u32 command;		/* in: Setup, teardown, status */
+	__u32 dev_index;	/* in/out: Device index */
+	__u32 dev;		/* in/out: Device nr for cdrw device */
+	__u32 pkt_dev;		/* in/out: Device nr for packet device */
+	__u32 num_devices;	/* out: Largest device index + 1 */
+	__u32 padding;		/* Not used */
+};
+
+/*
+ * packet ioctls
+ */
+#define PACKET_IOCTL_MAGIC	('X')
+#define PACKET_CTRL_CMD		_IOWR(PACKET_IOCTL_MAGIC, 1, struct pkt_ctrl_command)
+
+
+
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/blkdev.h>
+#include <linux/completion.h>
+#include <linux/cdrom.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
+
  /*
   * 1 for normal debug messages, 2 is very verbose. 0 to turn it off.
   */
@@ -23,25 +63,33 @@

  #define PKT_RB_POOL_SIZE	512

-/*
- * How long we should hold a non-full packet before starting data gathering.
- */
-#define PACKET_WAIT_TIME	(HZ * 5 / 1000)

-/*
- * use drive write caching -- we need deferred error handling to be
- * able to sucessfully recover with this option (drive will return good
- * status as soon as the cdb is validated).
- */
-#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
-#define USE_WCACHING		1
+/* use (old) procfs interface? */
+#ifdef CONFIG_CDROM_PKTCDVD_PROCINTF
+#define PKT_USE_OLD_PROC  1
  #else
-#define USE_WCACHING		0
+#define PKT_USE_OLD_PROC  0
  #endif

+/* use concurrent packets per device */
+#ifdef CONFIG_CDROM_PKTCDVD_BUFFERS
+#define PKT_BUFFERS_DEFAULT CONFIG_CDROM_PKTCDVD_BUFFERS
+#else
+#define PKT_BUFFERS_DEFAULT 8
+#endif
+
+/* default bio write queue congestion marks */
+#define PKT_WRITE_CONGESTION_ON 5000
+#define PKT_WRITE_CONGESTION_OFF 4500
+#define PKT_WRITE_CONGESTION_MAX (1024*1024)
+#define PKT_WRITE_CONGESTION_MIN 100
+#define PKT_WRITE_CONGESTION_THRESHOLD 25
+
+
  /*
- * No user-servicable parts beyond this point ->
+ * How long we should hold a non-full packet before starting data gathering.
   */
+#define PACKET_WAIT_TIME	(HZ * 5 / 1000)

  /*
   * device types
@@ -88,29 +136,19 @@

  #undef PACKET_USE_LS

-#define PKT_CTRL_CMD_SETUP	0
-#define PKT_CTRL_CMD_TEARDOWN	1
-#define PKT_CTRL_CMD_STATUS	2

-struct pkt_ctrl_command {
-	__u32 command;				/* in: Setup, teardown, status */
-	__u32 dev_index;			/* in/out: Device index */
-	__u32 dev;				/* in/out: Device nr for cdrw device */
-	__u32 pkt_dev;				/* in/out: Device nr for packet device */
-	__u32 num_devices;			/* out: Largest device index + 1 */
-	__u32 padding;				/* Not used */
-};

  /*
- * packet ioctls
+ * use drive write caching -- we need deferred error handling to be
+ * able to sucessfully recover with this option (drive will return good
+ * status as soon as the cdb is validated).
   */
-#define PACKET_IOCTL_MAGIC	('X')
-#define PACKET_CTRL_CMD		_IOWR(PACKET_IOCTL_MAGIC, 1, struct pkt_ctrl_command)
+#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
+#define USE_WCACHING		1
+#else
+#define USE_WCACHING		0
+#endif

-#ifdef __KERNEL__
-#include <linux/blkdev.h>
-#include <linux/completion.h>
-#include <linux/cdrom.h>

  struct packet_settings
  {
@@ -243,6 +281,8 @@ struct packet_stacked_data

  struct pktcdvd_device
  {
+	struct kobject		kobj;		/* kernel object for this dev */
+
  	struct block_device	*bdev;		/* dev attached */
  	dev_t			pkt_dev;	/* our dev */
  	char			name[20];
@@ -271,8 +311,15 @@ struct pktcdvd_device

  	struct packet_iosched   iosched;
  	struct gendisk		*disk;
+	
+	wait_queue_head_t	write_congestion_wqueue;
+	int			write_congestion_off;
+	int			write_congestion_on;
  };

+extern struct subsystem block_subsys;
+
+
  #endif /* __KERNEL__ */

  #endif /* __PKTCDVD_H */
