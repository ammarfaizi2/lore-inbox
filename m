Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTLQGTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 01:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTLQGTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 01:19:33 -0500
Received: from gizmo05ps.bigpond.com ([144.140.71.15]:48080 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S263463AbTLQGTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 01:19:24 -0500
Mail-Copies-To: never
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [CFT][RFC] Module auto-unloading solution.
Keywords: modules,steve,regexp,bin,usr,opts,use,script,modprobe,internalpersist,auto-rmmod,unload
From: Steve Youngs <sryoungs@bigpond.net.au>
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Organization: Linux Users - Fanatics Dept.
X-URL: <http://users.bigpond.net.au/sryoungs/>
X-Request-PGP: <http://users.bigpond.net.au/sryoungs/pgp/sryoungs.asc>
X-OpenPGP-Fingerprint: 1659 2093 19D5 C06E D320  3A20 1D27 DB4B A94B 3003
X-Attribution: SY
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Wed, 17 Dec 2003 16:19:15 +1000
Message-ID: <microsoft-free.87vfogezks.fsf@eicq.dnsalias.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Folks!

Modules don't auto-unload, they haven't since the introduction of
kmod.  Whether that's right or wrong is _not_ what this post is
about.

I do know that there are a lot of people out there using Linux who
like to have their unused modules silently and cleanly automatically
unload.  For that reason, I put together the script at the end of this
post.  So people have the option if they want it.

Before I offer it to the general public, it'd be fantastic if some of
you could look it over, kick the tyres and take it for a spin around
the block.  All comments etc would be very welcome and greatly
appreciated. 

Thanks.

---------------------------------------------------
#!/bin/bash

## Copyright (C) 2003 Steve Youngs

## RCS: $Id: auto-rmmod.sh,v 1.7 2003-12-17 15:34:51+10 steve Exp $
## Author:        Steve Youngs <sryoungs@bigpond.net.au>
## Maintainer:    Steve Youngs <sryoungs@bigpond.net.au>
## Created:       <2003-11-25>
## Last-Modified: <2003-12-17 15:34:33 (steve)>
## Homepage:      None yet.  For now, email the Maintainer for the latest 
##                version

## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions
## are met:
##
## 1. Redistributions of source code must retain the above copyright
##    notice, this list of conditions and the following disclaimer.
##
## 2. Redistributions in binary form must reproduce the above copyright
##    notice, this list of conditions and the following disclaimer in the
##    documentation and/or other materials provided with the distribution.
##
## 3. Neither the name of the author nor the names of any contributors
##    may be used to endorse or promote products derived from this
##    software without specific prior written permission.
##
## THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
## IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
## WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
## DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
## FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
## CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
## SUBSTITUTE GOODS OR SERVICES LOSS OF USE, DATA, OR PROFITS OR
## BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
## WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
## OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
## IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

### Commentary:
## 
##   This script is for people who want their kernel modules auto-unloaded
##   when they are not in use.  It won't try to unload ethernet drivers
##   because these modules don't set the "in-use" property.  If you want
##   to unload your ethernet drivers just do so manually with 
##    `modprobe -r module'.
##
##   If you have any modules that you don't want this script to unload
##   you can specify a regular expression of modules on the command
##   line.  See `auto-rmmod.sh --help' for details.
##
##   *************************** W A R N I N G ***************************
##   *                                                                   *
##   * Even though I have taken considerable care to ensure that ONLY    *
##   * unused modules are ever unloaded you should thoroughly test this  *
##   * script BEFORE putting it to use.                                  *
##   *                                                                   *
##   * For testing purposes you can use: `auto-rmmod.sh [REGEXP] --test' *
##   *                                                                   *
##   *********************************************************************

## Setup and Usage:
##
##   Check the paths in the variables listed after "### Code:", ensure
##   that they are correct.
##
##   Test with `auto-rmmod.sh [REGEXP] --test' until you're happy with
##   what is going on.
##
##   Next add a cron entry similar to this one to root's crontab:
##
##        0-59/10 * * * * exec /path/to/auto-rmmod.sh [REGEXP]
##
##   That will run the script once every ten minutes.  Now you can sit
##   back and enjoy the wonders of automatic loading and unloading of
##   your kernel modules.

## Note: Modules that don't want to auto-load:
##
##   The loading mechanism for character device modules changed in
##   2.6.0-test10.  In pre -test10 kernels these modules were called
##   with `char-major-<major>', in -test10 and later kernels they are
##   now called with `char-major-<major>-<minor>'.  The modules,
##   themselves, are supposed to export these chardev aliases, but as
##   yet, not many of them do.  To work around this until your module
##   has been fixed put `alias char-major-<major>-<minor> module' or
##   `alias char-major-<major>-* module' into your
##   `/etc/modprobe.conf'.  This will also be true of block devices,
##   but as at -test11 it still hasn't been implemented.

## Feedback, bug reports and patches etc:
##
##   All are welcome.  Send them to the address listed at "Maintainer"
##   at the top of this file.

### Todo:
##
##     

### Code:

## Ensure that all of these are correct for your system.
BASENAME=/usr/bin/basename
CAT=/usr/bin/cat
CUT=/usr/bin/cut
FIND=/usr/bin/find
GREP=/usr/bin/grep
ID=/usr/bin/id
MODPROBE=/sbin/modprobe
SED=/usr/bin/sed
TR=/usr/bin/tr
XARGS=/usr/bin/xargs

############################################################
#          Nothing Configurable Beyond this point          #
############################################################

currentkernel=`uname -r`
ethernetdir=/lib/modules/$currentkernel/kernel/drivers/net
opts=$1

# Check to see if this is a test run.
if [ "$opts" == "--test" -o "$2" == "--test" ]; then
    if [ "$opts" == "--test" ]; then
	unset opts
    fi
    MODPROBE="$MODPROBE --dry-run --verbose"
fi

# There's no point in running this unless we're root.
function chkuser() {
    if [ `$ID --user` -ne 0 ]; then
	echo "Error:  You must be root to run this."
	exit 1
    fi
}

function buildregexp() {
    # Create a regexp of ethernet modules.
    $FIND $ethernetdir -type f -name \*.ko > /dev/null 2>&1
    if [ $? -eq 0 ]; then
	for file in `ls /lib/modules/$currentkernel/kernel/drivers/net/`; do
	    convertedname=`$BASENAME $file .ko|$SED s/-/_/`
	    if [ $internalpersist ]; then
		internalpersist="$convertedname\|$internalpersist"
	    else
		internalpersist="$convertedname"
	    fi
	done
	# Need to truncate a trailing '\|'.
	internalpersist=`expr match "$internalpersist" '\(.*[^\\\\|]\)'` 
    fi

    # Set the list of persistant modules to any ethernet modules.
    if [ $internalpersist ]; then
	persistantmods="$internalpersist"
    fi

    # Add any user supplied regexp to the list of modules to NOT unload.
    if [[ $opts && $persistantmods ]]; then
	persistantmods="$persistantmods\|$opts"
    elif [ $opts ]; then
	persistantmods="$opts"
    fi
}

# The actual guts of this has to run 2 or 3 times to clean up all the
# modules.  The reason behind this is that removing one module can
# free up another, so we take a couple of extra passes at it.
function doit() {
    i=1
    while [ $i -le 3 ]; do
	if [ $persistantmods ]; then
	    $CAT /proc/modules | $GREP -v $persistantmods | \
		$CUT -d ' ' -f 1,3 | $GREP ' 0$' | $CUT -d ' ' -f 1 | \
		$TR '\n' ' ' | $XARGS $MODPROBE --remove
	    i=$[ i + 1 ]
	else
	    $CAT /proc/modules | $CUT -d ' ' -f 1,3 | $GREP ' 0$' | \
		$CUT -d ' ' -f 1 | $TR '\n' ' ' | $XARGS $MODPROBE --remove
	    i=$[ i + 1 ]
	fi
    done
}

function usage() {
    cat<<EOF
`$BASENAME $0`
`$BASENAME $0` [REGEXP]
`$BASENAME $0` [OPTION]

REGEXP

  Is a regular expression of module names that you DO NOT want this
  script to unload.  Be aware that the kernel converts dashes ('-') to
  underscores ('_') in module names.  Also note that you should NOT
  include the suffix '.ko'.

  Example: If you never want this script to unload 'foo-bar.ko',
  'foo-baz.ko', and 'widgets.ko', the REGEXP would be
  'foo_ba[rz]\|widgets'.  Be sure to surround your REGEXP in single
  quotes to avoid unexpected results.

  See grep(1) for the format of REGEXP.

OPTION

  -h|--help|--usage ..... Display this usage text.

  --test ................ Run in "test mode".  Display the modules to
                          be removed, but do not actually remove them.
EOF
}

case $opts in
    \?|-\?|h|-h|--help|--usage)
	usage
	exit 0
	;;
    *)
	chkuser
	buildregexp
	doit
	exit 0
	;;
esac

### auto-rmmod.sh ends here

## $Log: auto-rmmod.sh,v $
## Revision 1.7  2003-12-17 15:34:51+10  steve
## Doc fix.
##
## Revision 1.6  2003-12-17 14:59:05+10  steve
## Major rewrite, getting ready for general consumption.
## Added a "usage" function, command line options, and the option to run
## in "test" mode.
##
## Revision 1.5  2003-12-15 16:08:20+10  steve
## Even more doc fixes.
##
## Revision 1.4  2003-12-15 15:35:40+10  steve
## Rename to `auto-rmmod.sh'
##
## Revision 1.3  2003-12-15 15:33:06+10  steve
## Doc fixes.
##
## Revision 1.2  2003-11-25 09:54:46+10  steve
## Don't use an external file with the `-f' switch, just use a regexp
## directly from the script.
##

#Local Variables:
#time-stamp-start: "Last-Modified:[ 	]+\\\\?[\"<]+"
#time-stamp-end: "\\\\?[\">]"
#time-stamp-line-limit: 10
#time-stamp-format: "%4y-%02m-%02d %02H:%02M:%02S (%u)"
#End:

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: A94B3003>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|------------------------------<sryoungs@bigpond.net.au>---|

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Eicq - The XEmacs ICQ Client <http://eicq.sf.net/>

iEYEABECAAYFAj/f9WYACgkQHSfbS6lLMAPQYQCgrnKGPrkX0XlHDQ++d13V7DZj
9JoAnRdaRYgJpBf/atYGpXXjOi5BcAZ+
=ZjFW
-----END PGP SIGNATURE-----
--=-=-=--
