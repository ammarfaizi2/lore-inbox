Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTEYJCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 05:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbTEYJCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 05:02:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17848 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261661AbTEYJCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 05:02:42 -0400
Date: Sun, 25 May 2003 11:15:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does laptop-mode do?
Message-ID: <20030525091551.GD812@suse.de>
References: <20030524204311.47826.qmail@web40001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="prC3/KjdfqNV7evK"
Content-Disposition: inline
In-Reply-To: <20030524204311.47826.qmail@web40001.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 24 2003, Brad Chapman wrote:
> Mr. Axboe,
> 
> What exactly does your laptop-mode patch for 2.4.21-rc2 do? I've
> read through parts of it and it appears to add logic to the VM
> which causes it to do things at a certain time, as specified by
> userspace. Unfortunately I can't puzzle much else out of it, and
> I can't run it yet.

Several people have asked, here's a first draft of a little text file
explaining how it works. I'm also attaching the script mentioned in that
file.

> You;ve also said that it adds a "non-significant" amount of battery
> time. How much battery time do you mean (10%, 15%, 15min, etc...)

See the doc, it greatly depends on your laptop/drive/workload. If you
are able to keep the disk down for many minutes at the time, it's not
unrealistic to get 10% extra.

-- 
Jens Axboe


--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="laptop-mode.txt"

Laptop mode
===========

This small doc describes the 2.4 laptop mode patch.

Last updated 2003-05-25, Jens Axboe <axboe@suse.de>

Introduction
------------

A few properties of the Linux vm makes it virtually impossible to attempt
to spin down the hard drive in a laptop for a longer period of time (more
than a handful of seconds). This means you are lucky if you can even reach
the break even point with regards to power consumption, let alone expect any
decrease.

One problem is the age time of dirty buffers. Linux uses 30 seconds per
default, so if you dirty any data then flusing of that data will commence
at most 30 seconds from then. Another is the journal commit interval of
journalled file systems such as ext3, which is 5 seconds on a stock kernel.
Both of these are tweakable either from proc/sysctl or as mount options
though, and thus partly solvable from user space.

The kernel update daemon (kupdated) also runs at specific intervals, flushing
old dirty data out. Default is every 5 seconds, this too can be tweaked
from sysctl.

So what does the laptop mode patch do? It attempts to fully utilize the
hard drive once it has been spun up, flushing the old dirty data out to
disk. Instead of flushing just the expired data, it will clean everything.
When a read causes the disk to spin up, we kick off this flushing after
a few seconds. This means that once the disk spins down again, everything
is up to date. That allows longer dirty data and journal expire times.

It follows that you have to set long expire times to get long spin downs.
This means you could potentially loose 10 minutes worth of data, if you
set a 10 minute expire count instead of just 30 seconds worth. The biggest
risk here is undoubtedly running out of battery.

Settings
--------

The main knob is /proc/sys/vm/laptop mode. Setting that to 1 switches the
vm (and block layer) to laptop mode. Leaving it to 0 makes the kernel work
like before. When in laptop mode, you also want to extend the intervals
desribed above. See the laptop-mode.sh script for how to do that.

It can happen that the disk still keeps spinning up and you don't quite
know why or what causes it. The laptop mode patch has a little helper for
that as well, /proc/sys/vm/block-dump. When set to 1, it will dump info to
the kernel message buffer about what process caused the io. Be very careful
when playing with this setting, it is advisable to shut down syslog first!

Result
------

Using the laptop-mode.sh script with its default settings, I get the full
10 minutes worth of drive spin down. Provided your work load is cached,
the disk will only spin up every 10 minutes (well actually, 9 minutes and 55
seconds due to the 5 second delay in flushing dirty data after the last read
completes). I can't tell you exactly how much extra battery life you will
gain in laptop mode, it will vary greatly on the laptop and workload in
question. The only way to know for sure is to try it out. Getting 10% extra
battery life is not unrealistic.

Notes
-----

Patch only changes journal expire time for ext3. reiserfs uses a hardwire
value, should be trivial to adapt though (basically just make it call
get_buffer_flushtime() and uses that). I have not looked at other
journalling file systems, I'll happily accept patches to rectify that!

--prC3/KjdfqNV7evK
Content-Type: application/x-sh
Content-Disposition: attachment; filename="laptop-mode.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A#=0A# start of stop laptop mode, best run by a power management=
 daemon when=0A# ac gets connected/disconnected from a laptop=0A#=0A# FIXME=
: assumes HZ =3D=3D 100=0A=0A# age time, in seconds. should be put into a s=
ysconfig file=0AMAX_AGE=3D600=0A=0A# kernel default dirty buffer age=0ADEF_=
AGE=3D30=0ADEF_UPDATE=3D5=0A=0Aif [ ! -w /proc/sys/vm/laptop_mode ]; then=
=0A	echo "Kernel is not patched with laptop_mode patch"=0A	exit 1=0Afi=0A=
=0Acase "$1" in=0A	start)=0A		AGE=3D$((100*$MAX_AGE))=0A		echo -n "Starting=
 laptop mode"=0A		echo "1" > /proc/sys/vm/laptop_mode=0A		echo "30 500 0 0 =
$AGE $AGE 60 20 0" > /proc/sys/vm/bdflush=0A		# if no AAM support, manually=
 set spin down=0A		if [ ! -d /proc/aam/hda ]; then=0A			hdparm -S6 /dev/hda=
=0A		else=0A			echo 1 > /proc/aam/hda/enabled=0A		fi=0A		echo "."=0A		;;=0A=
	stop)=0A		U_AGE=3D$((100*$DEF_UPDATE))=0A		B_AGE=3D$((100*$DEF_AGE))=0A		e=
cho -n "Stopping laptop mode"=0A		echo "0" > /proc/sys/vm/laptop_mode=0A		e=
cho "30 500 0 0 $U_AGE $B_AGE 60 20 0" > /proc/sys/vm/bdflush=0A		if [ ! -d=
 /proc/aam/hda ]; then=0A			hdparm -S0 /dev/hda=0A		else=0A			echo 0 > /pro=
c/aam/hda/enabled=0A		fi=0A		echo "."=0A		;;=0A	*)=0A		echo "$0 {start|stop=
}"=0A		;;=0A=0Aesac=0A=0Aexit 0=0A
--prC3/KjdfqNV7evK--
