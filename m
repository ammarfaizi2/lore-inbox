Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbUBKTsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUBKTsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:48:47 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:41663 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265734AbUBKTsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:48:25 -0500
Subject: Re: ATARAID userspace configuration tool
From: Christophe Saout <christophe@saout.de>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <402A39B2.1010207@backtobasicsmgmt.com>
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>
	 <1076425115.23946.18.camel@leto.cs.pocnet.net>
	 <40292246.2030902@backtobasicsmgmt.com>
	 <1076440714.27328.8.camel@leto.cs.pocnet.net>
	 <20040211013551.GB2153@kroah.com>  <4029892C.2070009@backtobasicsmgmt.com>
	 <1076499258.5253.1.camel@leto.cs.pocnet.net>
	 <402A39B2.1010207@backtobasicsmgmt.com>
Content-Type: multipart/mixed; boundary="=-495nIckRHU2o+gmS7ZE8"
Message-Id: <1076528895.21067.20.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 20:48:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-495nIckRHU2o+gmS7ZE8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Mi, den 11.02.2004 schrieb Kevin P. Fleming um 15:18:

> > Aren't the disks the ATARAID is made of usually on the same controller?
> > Then you only have to scan that one.
> 
> Yes, that would be a simple optimization for this case. I was 
> envisioning the future tools to handle existing MD and LVM autodetection 
> and that would require looking at all potential block devices.

I've been prototyping something as a shell script.

The shell script needs to be run from hotplug (/etc/hotplug.d/defaults/
symlink) and udev (as first in udev.rules: PROGRAM="/path/to/bdev.sh %k
%M:%m", NAME="").

adding devices is caught through udev, removing through hotplug (udev
doesn't call programs when devices get removed).

The udev part could be dropped but I thought that someone should tell
udev if either the device should be created as usual (unhandled), not be
created or created under a different name. Unfortunately the ignore rule
in udev is currently broken and I found out that returning an empty
string from the program makes udev try to mknod /dev and chmod /dev (and
sets it to 666, argh) instead of ignoring the device creation. Hmm.

Well, the script maintains a stupid database:

/dev/.bdev/of/<devname> for devices that have been recognized by the
script. The contents of the file is the major:minor pair and a list of
compound devices that use the device.

and

/dev/.bdev/to/<major>:<minor> for created compound devices (or
partitions). It contains the type of the device, the assigned name and
some private data.

/dev/.bdev/uptodate is created when all devices were scanned.

BTW: I added some dumb locking (which is needed) using a package called
dotlockfile.

What happens?

When the script is started it scans /dev/block/* for all devices and
creates all /dev/.bdev/of/ files and touches uptodate. If uptodate
already existed, it registers only the new device.

Partitions detected by the kernel are completely ignored (and it tries
to tell udev not to create the device nodes, currently broken).

Then it calls the add_dev function. Here all checking should be done
(ataraid, other raid, whatever) and as a last resort partition
detection. It currently tries to do partition detection.

It creates a temporary device node, calls sfdisk on it to dump the
partition information, assigns the partition devices a name (the one
sfdisk chooses), calls dmsetup to create the mapped device and registers
the device in the /dev/.bdev/to/<major>:<minor> database and lists it in
the original /dev/.bdev/of/<oldname> file.

Now the kernel will call udev again with the dm device, bdev.sh will be
called, register the device and see that a /dev/.bdev/to/<major>:<minor>
exists for it. It will then create the device node with the name it
registered in the database (and try to tell udev to not care).

When a device is removed everything is done in reverse order.

When a device is removed that has partitions a function notify_dev kicks
in which probably wants to remove the mappings (partitions, etc...).

With tail -f /tmp/log you can watch the debug messages.

I've tried it using a LVM device which has a partition table on it.

lvchange -a y /dev/vg/test

The kernel will send a notify that a dm-2 254:2 was created. bdev.sh
will find a partition table, call dmsetup to create a "part-dm-2p1" dm
device and create a /dev/.bdev/to/254:3 with dm-2p1 as name. The kernel
will call bdev.sh again with dm-3 254:3, bdev.sh sees the
/dev/.bdev/to/254:3 and create the device node /dev/dm-2p1

dmsetup remove part-dm-2p1

will remove the device node and the database will be updated
accordingly.

Well, it's hard to explain my thoughts here because it's somewhat
complicated... perhaps someone understands what I'm trying to prove
here. :/


--=-495nIckRHU2o+gmS7ZE8
Content-Disposition: attachment; filename=bdev.sh
Content-Type: text/x-sh; name=bdev.sh; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#!/bin/sh
DATABASE=/dev/.bdev

mk_dev() {
	NAME=$1-${2/\//-}
	(
		/sbin/dmsetup -v create $NAME || \
		/sbin/dmsetup remove $NAME &> /dev/null
	) | \
	sed -e '/minor:/!d;s/^[^0-9]*\([0-9]*\),[^0-9]*\([0-9]*\).*$/\1:\2/'
}

rm_dev() {
	NAME=$1-${2/\//-}
	/sbin/dmsetup remove $NAME &> /dev/null
}

mk_nod() {
	/bin/mknod /dev/$1 b ${2%:[0-9]*} ${2#[0-9]*:}
} 

rm_nod() {
	rm -f /dev/$1
}

####################################################################

mk_part() {
	echo part $1 $2 $3 $4 >> /tmp/log
	NDEV=$(echo "0 $3 linear $4 $2" | mk_dev part $1 $4)
	if [ -z "$NDEV" ]; then
		return 1
	fi
	OF=$DATABASE/of/$5
	TO=$DATABASE/to/$NDEV
	echo TYPE=part > $TO
	echo NAME=$1 >> $TO
	echo "LIST=\"\$LIST $NDEV\"" >> $OF
}

get_parts() {
	/sbin/sfdisk -dfqL /dev/$1 2> /dev/null | \
	sed -s '/start=/!d;s/[=,]/ /g;s/^\/dev\/tmp-//' | \
	awk '{ print $1 " " $4 " " $6 }'
}

check_parts() {
	get_parts $4 | \
	while read PART START SIZE; do
		if [ "$SIZE" -gt 0 ]; then
			mk_part $PART $START $SIZE $3 $2
		fi
	done
}

rm_part() {
	rm_dev part $1
}

##################################################################

register_dev() {
	echo register $1 $2 >> /tmp/log
	echo DEV=$2 > $DATABASE/of/$1
}

unregister_dev() {
	echo unregister $1 $2 >> /tmp/log
	rm -f $DATABASE/of/$1
}

add_dev() {
	if [ -f $DATABASE/to/$2 ]; then
		source $DATABASE/to/$2
	else
		NAME=$1
		RET=1
	fi
	echo add "$NAME $2" >> /tmp/log
	TMP=tmp-$NAME
	mk_nod $TMP $2
	check_parts $1 $NAME $2 $TMP
	rm_nod $TMP
}

notify_dev() {
	echo notify $TYPE $1 $2 >> /tmp/log
	case $TYPE in
	    part)
		rm_part $1 $2
		;;
	esac
}

remove_dev() {
	if [ -f $DATABASE/to/$2 ]; then
		source $DATABASE/to/$2
		rm -f $DATABASE/to/$2
	else
		NAME=$1
		RET=1
	fi
	echo remove $NAME $2 >> /tmp/log
	for i in $LIST; do
		if [ -e $DATABASE/to/$i ]; then
			source $DATABASE/to/$i
			notify_dev $NAME $i
		fi
	done
}

##################################################################

if [ ${DEVPATH} == ${DEVPATH#/block} ]; then
	exit 1
fi

if [ -n "$2" ]; then
	ACTION=add
	KERNEL=$1
	DEV=$2
	if [ ! -f /sys/block/$KERNEL/dev ]; then
		exit 0
	fi
else
	if [ "$ACTION" != remove ]; then
		exit 0
	fi
	KERNEL=${DEVPATH##*/}
fi

dotlockfile -r3 -p $DATABASE/lock || exit 1

RET=0
NAME=""

echo action $ACTION >> /tmp/log
case "$ACTION" in
    add)
	if [ ! -f $DATABASE/uptodate ]; then
		rm -Rf $DATABASE/of $DATABASE/to
		mkdir -p $DATABASE/of $DATABASE/to
		for i in /sys/block/*; do
			register_dev ${i#/sys/block/} $(<$i/dev)
		done
		touch $DATABASE/uptodate
		if [ -e $DATABASE/of/$KERNEL ]; then
			add_dev $KERNEL $DEV
		fi
	else
		if [ ! -e $DATABASE/of/$KERNEL ]; then
			register_dev $KERNEL $DEV
			if [ -e $DATABASE/of/$KERNEL ]; then
				add_dev $KERNEL $DEV
			fi
		fi
	fi

	;;
    remove)
	if [ -e $DATABASE/of/$KERNEL ]; then
		LIST=""
		source $DATABASE/of/$KERNEL
		remove_dev $KERNEL $DEV
		unregister_dev $KERNEL $DEV
	fi
	;;
esac
	
dotlockfile -u $DATABASE/lock
if [ $RET -gt 0 ]; then
	exit 1
else
	if [ -n "$NAME" ]; then
		echo result $NAME >> /tmp/log
		case $ACTION in
		    add)
			mk_nod $NAME $DEV
			;;
		    remove)
			rm_nod $NAME
		esac
	else
		echo ignore >> /tmp/log
	fi
	exit 0
fi

--=-495nIckRHU2o+gmS7ZE8--

