Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271796AbTGROLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271785AbTGROJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:09:00 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:23754 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S271716AbTGROFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:05:35 -0400
Subject: RE: Partitioned loop device..
From: Christophe Saout <christophe@saout.de>
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1B7C89B8DCB084C809A22D7FEB90B3840AB@frodo.avalon.ru>
References: <E1B7C89B8DCB084C809A22D7FEB90B3840AB@frodo.avalon.ru>
Content-Type: multipart/mixed; boundary="=-zFhkVVVgfUFCEL0n0zKV"
Message-Id: <1058538027.19986.3.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 18 Jul 2003 16:20:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zFhkVVVgfUFCEL0n0zKV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Di, 2003-07-15 um 20.32 schrieb Dimitry V. Ketov:

> > You can already use Device-Mapper to create "partitions" on 
> > your loop devices, 
> You're right but I want _partitions_ but not "partitions" ;)
> It should appears like a real hardware disk, not virtual one.

I just hacked up an ugly small shell script, that uses sfdisk and
dmsetup to create the partition devices over any block device.

Just dmsetup-partitions /dev/loop0 or something.

It will then create devices /dev/mapper/loop0p1, etc... just like hda1
and so on. To remove them use "dmsetup remove loop0p1", etc...

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

--=-zFhkVVVgfUFCEL0n0zKV
Content-Disposition: attachment; filename=dmsetup-partitions
Content-Type: text/x-sh; name=dmsetup-partitions; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#!/bin/sh
SFDISK="`which sfdisk`"
DMSETUP="`which dmsetup`"
if test -z "$1"; then
	echo "Syntax: $0 <block device>"
	exit 1
fi
DEVDIR="`dirname \"\$1\"`"
DEVFILE="`basename \"\$1\"`"
if ! echo "$DEVDIR" | grep '^/' &> /dev/null; then
	DEVDIR="`pwd`/$DEVDIR/"
else
	DEVDIR="$DEVDIR/"
fi
while echo "$DEVDIR" | grep '/\./' &> /dev/null; do
	DEVDIR="`echo \"\$DEVDIR\" | sed -e 's/\/\.\//\//g'`"
done
while echo "$DEVDIR" | grep '/[^/][^/]*/\.\./' &> /dev/null; do
	DEVDIR="`echo \"\$DEVDIR\" | sed -e 's/\/[^/][^/]*\/\.\.\//\//g'`"
done
DEVICE="$DEVDIR$DEVFILE"
if ! test -b "$DEVICE" -a -r "$DEVICE"; then
	echo "Error: Block device $1 can't be accessed"
	exit 1
fi
if ! test -n "$SFDISK" -a -x "$SFDISK"; then
	echo "Error: sfdisk utility not found"
	exit 1
fi
if ! test -n "$DMSETUP" -a -x "$DMSETUP"; then
	echo "Error: dmsetup utility not found"
	exit 1
fi

if test -L "$DEVICE"; then
	DEVICE_="`readlink \"\$DEVICE\"`"
	DEVDIR_="`dirname \"\$DEVICE_\"`"
	DEVFILE_="`basename \"\$DEVICE_\"`"
	if ! echo "$DEVDIR_" | grep '^/' &> /dev/null; then
		DEVDIR_="$DEVDIR$DEVDIR_/"
	else
		DEVDIR_="$DEVDIR_/"
	fi
	while echo "$DEVDIR_" | grep '/\./' &> /dev/null; do
		DEVDIR_="`echo \"\$DEVDIR_\" | sed -e 's/\/\.\//\//g'`"
	done
	while echo "$DEVDIR_" | grep '/[^/][^/]*/\.\./' &> /dev/null; do
		DEVDIR_="`echo \"\$DEVDIR_\" | sed -e 's/\/[^/][^/]*\/\.\.\//\//g'`"
	done
	DEVICE_="$DEVDIR_$DEVFILE_"
else
	DEVICE_="$DEVICE"
fi

TMP="/tmp/partscript.$$"
"$SFDISK" -d "$DEVICE" | grep "^ *$DEVDIR" | sed -e 's/[=,]/ /g' | awk '{ print $1 " " $4 " " $6 }' | \
while read DEV START SIZE; do
	DEV="`echo \"\$DEV\" | sed -e 's/^\/dev\///' -e 's/\//-/g'`"
	test "$SIZE" -gt 0 || continue
	echo $DEV $START $SIZE
	echo "0 $SIZE linear $DEVICE_ $START" > $TMP
	"$DMSETUP" create $DEV $TMP
done

--=-zFhkVVVgfUFCEL0n0zKV--

