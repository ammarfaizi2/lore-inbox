Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUBSQZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUBSQZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:25:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267359AbUBSQZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:25:27 -0500
Date: Thu, 19 Feb 2004 11:25:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Christoph Hellwig <hch@lst.de>
cc: akpm@osdl.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove MAKEDEV scripts from scripts/
In-Reply-To: <20040219161306.GA30620@lst.de>
Message-ID: <Pine.LNX.4.53.0402191119480.520@chaos>
References: <20040219161306.GA30620@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Christoph Hellwig wrote:

> makedev is a userland issue, and the distros already take care of ide
> and sound.  scripts/ OTOH is supposed to hold utils needed for building
> the kernel tree which the above certainly aren't.
>

If that's true, i.e., /scripts contains _only_ utilities for building
the kernel tree, then you make another directory to contain MAKEDEV.ide.
You don't simply delete it because you don't want it there. This
script substitutes for, and works in conjunction with a primary source
of documentation, ../Documentation/ide.txt


>
> --- 1.2/scripts/MAKEDEV.ide	Mon Sep  8 00:49:37 2003
> +++ edited/scripts/MAKEDEV.ide	Thu Feb 19 17:42:30 2004
> @@ -1,49 +0,0 @@
> -#!/bin/sh
> -#
> -# This script creates the proper /dev/ entries for IDE devices
> -# on the primary, secondary, tertiary, and quaternary interfaces.
> -# See ../Documentation/ide.txt for more information.
> -#
> -makedev () {
> -	rm -f /dev/$1
> -	echo mknod /dev/$1 $2 $3 $4
> -	     mknod /dev/$1 $2 $3 $4
> -	chown root:disk /dev/$1
> -	chmod 660 /dev/$1
> -}
> -
> -makedevs () {
> -	rm -f /dev/$1*
> -	makedev $1 b $2 $3
> -	for part in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
> -	do
> -		makedev $1$part b $2 `expr $3 + $part`
> -	done
> -}
> -
> -makedevs hda  3 0
> -makedevs hdb  3 64
> -makedevs hdc 22 0
> -makedevs hdd 22 64
> -makedevs hde 33 0
> -makedevs hdf 33 64
> -makedevs hdg 34 0
> -makedevs hdh 34 64
> -makedevs hdi 56 0
> -makedevs hdj 56 64
> -makedevs hdk 57 0
> -makedevs hdl 57 64
> -makedevs hdm 88 0
> -makedevs hdn 88 64
> -makedevs hdo 89 0
> -makedevs hdp 89 64
> -makedevs hdq 90 0
> -makedevs hdr 90 64
> -makedevs hds 91 0
> -makedevs hdt 91 64
> -
> -for tape in 0 1 2 3 4 5 6 7
> -do
> -	makedev ht$tape c 37 $tape
> -	makedev nht$tape c 37 `expr $tape + 128`
> -done
> --- 1.2/scripts/MAKEDEV.snd	Mon Sep  8 00:49:37 2003
> +++ edited/scripts/MAKEDEV.snd	Thu Feb 19 17:42:32 2004
> @@ -1,161 +0,0 @@
> -#!/bin/bash
> -#
> -# This script creates the proper /dev/ entries for ALSA devices.
> -# See ../Documentation/sound/alsa/ALSA-Configuration.txt for more
> -# information.
> -
> -MAJOR=116
> -OSSMAJOR=14
> -MAX_CARDS=4
> -PERM=666
> -OWNER=root.root
> -
> -if [ "`grep -w -E "^audio" /etc/group`x" != x ]; then
> -  PERM=660
> -  OWNER=root.audio
> -fi
> -
> -function create_odevice () {
> -  rm -f $1
> -  echo -n "Creating $1..."
> -  mknod -m $PERM $1 c $OSSMAJOR $2
> -  chown $OWNER $1
> -  echo " done"
> -}
> -
> -function create_odevices () {
> -  tmp=0
> -  tmp1=0
> -  rm -f $1 $1?
> -  echo -n "Creating $1?..."
> -  while [ $tmp1 -lt $MAX_CARDS ]; do
> -    minor=$[ $2 + $tmp ]
> -    mknod -m $PERM $1$tmp1 c $OSSMAJOR $minor
> -    chown $OWNER $1$tmp1
> -    tmp=$[ $tmp + 16 ]
> -    tmp1=$[ $tmp1 + 1 ]
> -  done
> -  echo " done"
> -}
> -
> -function create_device1 () {
> -  rm -f $1
> -  minor=$2
> -  echo -n "Creating $1..."
> -  mknod -m $PERM $1 c $MAJOR $minor
> -  chown $OWNER $1
> -  echo " done"
> -}
> -
> -function create_devices () {
> -  tmp=0
> -  rm -f $1 $1?
> -  echo -n "Creating $1?..."
> -  while [ $tmp -lt $MAX_CARDS ]; do
> -    minor=$[ $tmp * 32 ]
> -    minor=$[ $2 + $minor ]
> -    mknod -m $PERM "${1}C${tmp}" c $MAJOR $minor
> -    chown $OWNER "${1}C${tmp}"
> -    tmp=$[ $tmp + 1 ]
> -  done
> -  echo " done"
> -}
> -
> -function create_devices2 () {
> -  tmp=0
> -  rm -f $1 $1?
> -  echo -n "Creating $1??..."
> -  while [ $tmp -lt $MAX_CARDS ]; do
> -    tmp1=0
> -    while [ $tmp1 -lt $3 ]; do
> -      minor=$[ $tmp * 32 ]
> -      minor=$[ $2 + $minor + $tmp1 ]
> -      mknod -m $PERM "${1}C${tmp}D${tmp1}" c $MAJOR $minor
> -      chown $OWNER "${1}C${tmp}D${tmp1}"
> -      tmp1=$[ $tmp1 + 1 ]
> -    done
> -    tmp=$[ $tmp + 1 ]
> -  done
> -  echo " done"
> -}
> -
> -function create_devices3 () {
> -  tmp=0
> -  rm -f $1 $1?
> -  echo -n "Creating $1??$4..."
> -  while [ $tmp -lt $MAX_CARDS ]; do
> -    tmp1=0
> -    while [ $tmp1 -lt $3 ]; do
> -      minor=$[ $tmp * 32 ]
> -      minor=$[ $2 + $minor + $tmp1 ]
> -      mknod -m $PERM "${1}C${tmp}D${tmp1}${4}" c $MAJOR $minor
> -      chown $OWNER "${1}C${tmp}D${tmp1}${4}"
> -      tmp1=$[ $tmp1 + 1 ]
> -    done
> -    tmp=$[ $tmp + 1 ]
> -  done
> -  echo " done"
> -}
> -
> -if test "$1" = "-?" || test "$1" = "-h" || test "$1" = "--help"; then
> -  echo "Usage: snddevices [max]"
> -  exit
> -fi
> -
> -if test "$1" = "max"; then
> -  DSP_MINOR=19
> -fi
> -
> -# OSS (Lite) compatible devices...
> -
> -if test $OSSMAJOR -eq 14; then
> -  create_odevices /dev/mixer		0
> -  create_odevice /dev/sequencer		1
> -  create_odevices /dev/midi		2
> -  create_odevices /dev/dsp		3
> -  create_odevices /dev/audio		4
> -  create_odevice /dev/sndstat		6
> -  create_odevice /dev/music		8
> -  create_odevices /dev/dmmidi		9
> -  create_odevices /dev/dmfm		10
> -  create_odevices /dev/amixer		11	# alternate mixer
> -  create_odevices /dev/adsp		12	# alternate dsp
> -  create_odevices /dev/amidi		13	# alternate midi
> -  create_odevices /dev/admmidi		14	# alternate direct midi
> -  # create symlinks
> -  ln -svf /dev/mixer0 /dev/mixer
> -  ln -svf /dev/midi0 /dev/midi
> -  ln -svf /dev/dsp0 /dev/dsp
> -  ln -svf /dev/audio0 /dev/audio
> -  ln -svf /dev/music /dev/sequencer2
> -  ln -svf /dev/adsp0 /dev/adsp
> -  ln -svf /dev/amidi0 /dev/amidi
> -fi
> -
> -# Remove old devices
> -
> -mv -f /dev/sndstat /dev/1sndstat
> -rm -f /dev/snd*
> -mv -f /dev/1sndstat /dev/sndstat
> -if [ -d /dev/snd ]; then
> -  rm -f /dev/snd/*
> -  rmdir /dev/snd
> -fi
> -
> -# Create new ones
> -
> -mkdir -p /dev/snd
> -create_devices  /dev/snd/control	0
> -create_device1  /dev/snd/seq		1
> -create_device1  /dev/snd/timer		33
> -create_devices2 /dev/snd/hw		4	4
> -create_devices2 /dev/snd/midi		8	8
> -create_devices3 /dev/snd/pcm		16	8	p
> -create_devices3 /dev/snd/pcm		24	8	c
> -
> -# Loader devices
> -
> -echo "ALSA loader devices"
> -rm -f /dev/aload*
> -create_devices  /dev/aload		0
> -create_device1  /dev/aloadSEQ		1
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


