Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129812AbQLRUDr>; Mon, 18 Dec 2000 15:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129930AbQLRUDi>; Mon, 18 Dec 2000 15:03:38 -0500
Received: from stm.lbl.gov ([131.243.16.51]:52743 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S129812AbQLRUDY>;
	Mon, 18 Dec 2000 15:03:24 -0500
Date: Mon, 18 Dec 2000 11:32:46 -0800
From: David Schleef <ds@schleef.org>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
Message-ID: <20001218113246.A14376@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <91bnoc$vij$2@enterprise.cistron.net> <20001215155741.B4830@ping.be> <01cf01c066ab$036fc030$890216ac@ottawa.loran.com> <20001216164151.J3199@cadcamlab.org> <024701c0690a$56f9ba10$890216ac@ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <024701c0690a$56f9ba10$890216ac@ottawa.loran.com>; from dana.lacoste@peregrine.com on Mon, Dec 18, 2000 at 10:51:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 10:51:09AM -0500, Dana Lacoste wrote:
> 
> Can we get a #3 going?  I think it could really help both the cross-compile
> people and those who just want to make sure their modules are compiling in
> the 'correct' environment.  It also allows for things like 'kgcc vs. gcc' to
> be 'properly' resolved by the distribution-creator as it should be, instead of
> linux-kernel or the 3rd party module mailing lists.

I use the following script (scripts/dep.linux from Comedi-0.7.53).
It could easily be improved to handle the /lib/modules/*/build/include
link.  I've also developed (actually, "gathered") a lot of other stuff
for convenient non-kernel module compiling, including compatiblity
header files, Makefiles, etc.  Good places to look for stuff include
comedi, RTAI, RTLinux, PCMCIA, and MTD.

Keep in mind that there is no "correct" environment except that
which the user specifies.



dave...



#!/bin/sh

if [ "$LINUXDIR" = "" ]
then
	echo -n "Enter location of Linux source tree [/usr/src/linux]: "
	read LINUXDIR
	: ${LINUXDIR:=/usr/src/linux}
fi

if [ ! -f "$LINUXDIR/.config" ];then
	echo Kernel source tree at $LINUXDIR is not configured
	echo Fix before continuing
	exit 1
fi

echo using LINUXDIR=$LINUXDIR
echo LINUXDIR=$LINUXDIR >.sourcedirs

. $LINUXDIR/.config

#
# check for a bad situation
#
if [ "$CONFIG_MODULES" = "n" ]
then
	cat <<EOF
 *****
 *****    WARNING!!!
 *****
 *****    Your kernel is configured to not allow loadable modules.
 *****    You are attempting to compile a loadable module for this
 *****    kernel.  This is a problem.  Please correct it.
 *****
EOF
exit
fi

#
# check running kernel vs. /usr/src/linux and warn if necessary
#
read dummy dummy dummy2 <$LINUXDIR/include/linux/version.h
UTS_VERSION=`echo $dummy2|sed 's/"//g'`

echo UTS_VERSION=$UTS_VERSION >.uts_version

if [ "$(uname -r)" != "$UTS_VERSION" ]
then
	cat <<EOF
 *****
 *****    WARNING!!!
 *****
 *****    The kernel that is currently running is a different
 *****    version than the source in $LINUXDIR.  The current
 *****    compile will create a module that is *incompatible*
 *****    with the running kernel.
 *****
EOF
fi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
