Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTJ2OaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 09:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTJ2OaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 09:30:18 -0500
Received: from quechua.inka.de ([193.197.184.2]:37587 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261347AbTJ2OaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 09:30:10 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Date: Wed, 29 Oct 2003 15:30:30 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.29.14.30.29.628488@dungeon.inka.de>
References: <3F9D82F0.4000307@mvista.com> <20031027210054.GR24286@marowsky-bree.de> <3F9D8AAA.7010308@mvista.com> <20031028110034.GG30725@marowsky-bree.de> <1067364727.4612.359.camel@persist.az.mvista.com> <20031028224416.GA8671@kroah.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 22:52:33 +0000, Greg KH wrote:
> For SDE:
> $ find . -type f | egrep '[.c|.h]$' | xargs wc -l | tail -1
>   57328 total
...

> For udev:
> $ find . -type f | egrep '[.c|.h]$' | xargs wc -l | tail -1
>   17632 total

Here is a config file and a 41 lines shell script, that
will populate /udev with all devices found via /sys.
A version to add or remove only one file should be about
the same size.

---cat /etc/makedev.conf---
ttyS0 root dialout 0660
zero root root 0666
null root root 0666

---cat makedev---
#!/bin/sh

set -e

DEV=/udev
CONFIG=/etc/makedev.conf

cd $DEV

find /sys/class -name dev |while read A;
do
	B=`dirname $A`
	B=`basename $B`
	MM=`cat $A|tr ":" " "`
	mknod --mode=0600 $B c $MM
	if grep -q "$B " $CONFIG
	then
		USER=`grep "$B " $CONFIG|cut -d" " -f2`
		GROUP=`grep "$B " $CONFIG|cut -d" " -f3`
		MODE=`grep "$B " $CONFIG|cut -d" " -f4`
		chown $USER.$GROUP $B
		chmod $MODE $B
	fi
done

find /sys/block -name dev |while read A;
do
	B=`dirname $A`
	B=`basename $B`
	MM=`cat $A|tr ":" " "`
	mknod --mode=0600 $B b $MM
	if grep -q "$B " $CONFIG
	then
		USER=`grep "$B " $CONFIG|cut -d" " -f2`
		GROUP=`grep "$B " $CONFIG|cut -d" " -f3`
		MODE=`grep "$B " $CONFIG|cut -d" " -f4`
		chown $USER.$GROUP $B
		chmod $MODE $B
	fi
done
---cut---

So udev is 99% overhead?

sure, it's fast and small, and has lots of features that I don't need.

> 	SDE:	57328 lines
> 	udev:	 9090 lines
 shell script:     41 lines

> that udev is suffering from "lack of maintainability and bloat" if you
> really want :)

bloat. lots of bloat. what is that tdb database for?
filesystems are persistent. if you want to save space,
create a tar file :-) 

> p.s. yes, I know lines of code is a horrible metric, and doesn't really
> mean squat.  I just want to point out the huge size difference between
> the current state of udev and SDE, with pretty much identical
> functionality from what I can tell.

I agree. lines of codes is a horrible metric, and comparing a shell
script that uses many external commands to a c application with
everything build is makes absolutely no sense. but I wonder why
the off the shelf machine needs a c applications, if all those
external commands are installed anyway.

Regards, Andreas

