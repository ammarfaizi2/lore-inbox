Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTA0T1D>; Mon, 27 Jan 2003 14:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbTA0T1D>; Mon, 27 Jan 2003 14:27:03 -0500
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:30080 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S267285AbTA0T1A>;
	Mon, 27 Jan 2003 14:27:00 -0500
Date: Mon, 27 Jan 2003 11:35:04 -0800
From: Jerry Cooperstein <coop@axian.com>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127193504.GA9720@p3.attbi.com>
References: <200301231459.22789.schlicht@uni-mannheim.de> <20030127185228.GA8820@p3.attbi.com> <20030127191225.GA3707@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030127191225.GA3707@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 08:12:25PM +0100, Sam Ravnborg wrote:
> 
> 1) You do not need any targets like all: or mmodules:
> 2) The clean: rule will not be used in 2.5, use clean-files instead.
> 3) No reason to special case on .ko or not. .ko will not harm on 2.4
> 4) I cannot see any reason to declare all OBJS as .PHONY
> 5) It looks like you try to enable the use of make in the directory
>    where the module exists.
>    This is an unusual extension, which will clutter up the makefile
>    a bit.
>    I would prefer a mmake script or similar that did the make -c ... trick.
> 
> 	Sam

on 4): yep, no need for PHONY stuff (simplified script attached)

The reason for this cropping in is that I had a more complex script
that reflected my actual situation; I have a directory that contains
some kernel modules, some testing programs and other junk, and I 
build a complete Makefile that has rules for all these guys, not
just the kernel modules.  Which is why I violated your sensibilties
about the other points I guess.  I didn't just want to pass the
work off to the kernel building stuff.

If you want to do this I agree all you need is the part to generate
a objs-m list and the Rules.make stuff for 2.4, and that is 
simpler.  You could indeed remove all the targets etc, but then
as you note, you can't just say make, but have to do the 
     make -C KERNEL_SOURCE SUBDIRS=$PWD modules 
 business.

 I've attached that one too.

 coop

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================

#(FULL SCRIPT, NO PHONY):
######################################################################
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

rm -f Makefile

cat <<EOF > Makefile
obj-m += $OBJS
KROOT=$KROOT
all: mmodules
EOF

if [ $VERSION == 2.5 ] ; then
CLEANSTUFF="*.o *.ko .*cmd"

cat <<EOF >> Makefile
EOF

else

CLEANSTUFF="*.o .*flags"

cat <<EOF >> Makefile
TOPDIR=\$(KROOT)
include \$(TOPDIR)/Rules.make
EOF
fi

cat <<EOF >> Makefile
mmodules:
	\$(MAKE) -C \$(KROOT) SUBDIRS=$PWD modules
clean:
	rm $CLEANSTUFF
EOF

######################################################################
#(SHORT SCRIPT: no local make targets)

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

rm -f Makefile

cat <<EOF > Makefile
obj-m += $OBJS
KROOT=$KROOT
EOF

if [ $VERSION == 2.5 ] ; then

cat <<EOF >> Makefile
EOF

else

cat <<EOF >> Makefile
TOPDIR=\$(KROOT)
include \$(TOPDIR)/Rules.make
EOF
fi

