Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTA0Snz>; Mon, 27 Jan 2003 13:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbTA0Sny>; Mon, 27 Jan 2003 13:43:54 -0500
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:21888 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S267277AbTA0Snv>;
	Mon, 27 Jan 2003 13:43:51 -0500
Date: Mon, 27 Jan 2003 10:52:28 -0800
From: Jerry Cooperstein <coop@axian.com>
To: linux-kernel@vger.kernel.org
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127185228.GA8820@p3.attbi.com>
References: <200301231459.22789.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301231459.22789.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The solution

make -C KERNEL_SOURCE SUBDIRS=$PWD modules

is fine, but you have to have a Makefile in the current directory,
and that Makefile needs a somewhat different form for 2.4 and
2.5 kernels.  Here is a quick and dirty script for generating
a quick boilerplate for the sources in that directory.  Straightforward
to customize and extend etc.  (You may have to change some whitespace
to TABS for make...)

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================

#!/bin/bash

# script for generating external Makefile for kernel modules
# Jerry Cooperstein, Axian Inc 2003_01_27
# Too trivial to GPL; use as desired.

# do either "makeit"; assumes kernel source at /usr/src/linux-`uname -r`
#    or     "makeit /usr/src/linux-2.5.59 or makeit /usr/src/linux-2.4.20" etc.

# Should work on all 2.4, 2.5 kernels.
# assumes all .c files in current directory are modules

if [ "$1" == "" ] ; then
    KROOT=/usr/src/linux-`uname -r`
else
    KROOT="$1"
fi

if [ `echo $KROOT | grep 2.5` ] ; then
    VERSION=2.5
else
    VERSION=2.4
fi

OBJS=""
for names in *.c ; do 
    OBJS=$OBJS" `basename $names .c`.o"
done

PHONYS="$OBJS"

rm -f Makefile

cat <<EOF > Makefile
obj-m += $OBJS
KROOT=$KROOT
all: mmodules
EOF

if [ $VERSION == 2.5 ] ; then
CLEANSTUFF="*.o *.ko .*cmd"

cat <<EOF >> Makefile
PHONYS=$PHONYS
.PHONY:	 \$(PHONYS) clean
EOF

else

CLEANSTUFF="*.o .*flags"

cat <<EOF >> Makefile
TOPDIR=\$(KROOT)
include \$(TOPDIR)/Rules.make
.PHONY:	 clean
EOF
fi

cat <<EOF >> Makefile
mmodules:
	\$(MAKE) -C \$(KROOT) SUBDIRS=$PWD modules
clean:
	rm $CLEANSTUFF
EOF
