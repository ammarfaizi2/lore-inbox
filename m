Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945929AbWBCTr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945929AbWBCTr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945926AbWBCTr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:47:57 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:45692 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1945931AbWBCTrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:47:55 -0500
Date: Fri, 03 Feb 2006 14:47:53 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6.16rc2] compile error
In-reply-to: <20060203190126.GA28929@mars.ravnborg.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200602031447.53193.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <ds08vk$hk$1@sea.gmane.org>
 <20060203190126.GA28929@mars.ravnborg.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 14:01, Sam Ravnborg wrote:
>On Fri, Feb 03, 2006 at 07:55:47PM +0100, Alexander Fieroch wrote:
>> Hello,
>>
>> I can't compile kernel 2.6.16-rc[12] and get the following error:
>>
>> # make
>> /bin/sh: -c: line 0: syntax error near unexpected token `('
>> /bin/sh: -c: line 0: `set -e; echo '  CHK    
>> include/linux/version.h'; mkdir -p include/linux/;        if [ `echo
>> -n "2.6.16-rc2 .file null .ident
>> GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
>> .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo
>> '"2.6.16-rc2 .file null .ident
>> GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
>> .note.GNU-stack,,@progbits" exceeds 64 characters' >&2; exit 1; fi;
>> (echo \#define UTS_RELEASE \"2.6.16-rc2 .file null .ident
>> GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
>> .note.GNU-stack,,@progbits\"; echo \#define LINUX_VERSION_CODE `expr
>> 2 \\* 65536 + 6 \\* 256 + 16`; echo '#define KERNEL_VERSION(a,b,c)
>> (((a) << 16) + ((b) << 8) + (c))'; ) <
>> /usr/src/linux-2.6.16rc2/Makefile > include/linux/version.h.tmp; if
>> [ -r include/linux/version.h ] && cmp -s include/linux/version.h
>> include/linux/version.h.tmp; then rm -f include/linux/version.h.tmp;
>> else echo '  UPD
>> include/linux/version.h'; mv -f include/linux/version.h.tmp
>> include/linux/version.h; fi'
>> make: *** [include/linux/version.h] Error 2
>
>You are hit be an outstanding issue with -rc1 + rc2.
>When you build as root you will alter /dev/null and in your case it
>became a regular file.

That didn't hit me Sam, and I built it as root, running it right now.

>Recreate /dev/null and build as normal user for now.
>You can apply patch below to fix it - will be in next -rc.
>
> Sam
>
>diff-tree 3835f82183eab8b67ddda6b32c127859a546c82d (from
> 3ee68c4af3fd7228c1be63254b9f884614f9ebb2) Author: Sam Ravnborg
> <sam@mars.ravnborg.org>
>Date:   Sat Jan 21 12:03:09 2006 +0100
>
>    kconfig: fix /dev/null breakage
>
>    While running "make menuconfig" and "make mrproper"
>    some people experienced that /dev/null suddenly changed
>    permissions or suddenly became a regular file.
>    The main reason was that /dev/null was used as output
>    to gcc in the check-lxdialog.sh script and gcc did
>    some strange things with the output file; in this
>    case /dev/null when it errorred out.
>
>    Following patch implements a suggestion
>    from Bryan O'Sullivan <bos@serpentine.com> to
>    use gcc -print-file-name=libxxx.so.
>
>    Also the Makefile is adjusted to not resolve value of
>    HOST_EXTRACFLAGS and HOST_LOADLIBES until they are actually used.
>    This prevents us from calling gcc when running make
> *clean/mrproper
>
>    Thanks to Eyal Lebedinsky <eyal@eyal.emu.id.au> and
>    Jean Delvare <khali@linux-fr.org> for the first error reports.
>
>    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>    ---
>
>diff --git a/scripts/kconfig/lxdialog/Makefile
> b/scripts/kconfig/lxdialog/Makefile index fae3e29..bbf4887 100644
>--- a/scripts/kconfig/lxdialog/Makefile
>+++ b/scripts/kconfig/lxdialog/Makefile
>@@ -1,11 +1,14 @@
> # Makefile to build lxdialog package
> #
>
> check-lxdialog  := $(srctree)/$(src)/check-lxdialog.sh
>-HOST_EXTRACFLAGS:= $(shell $(CONFIG_SHELL) $(check-lxdialog)
> -ccflags) -HOST_LOADLIBES  := $(shell $(CONFIG_SHELL)
> $(check-lxdialog) -ldflags $(HOSTCC)) +
>+# Use reursively expanded variables so we do not call gcc unless
>+# we really need to do so. (Do not call gcc as part of make mrproper)
>+HOST_EXTRACFLAGS = $(shell $(CONFIG_SHELL) $(check-lxdialog)
> -ccflags) +HOST_LOADLIBES   = $(shell $(CONFIG_SHELL)
> $(check-lxdialog) -ldflags $(HOSTCC))
>
> HOST_EXTRACFLAGS += -DLOCALE
>
> .PHONY: dochecklxdialog
> $(obj)/dochecklxdialog:
>diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh
> b/scripts/kconfig/lxdialog/check-lxdialog.sh index 448e353..120d624
> 100644
>--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
>+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
>@@ -2,21 +2,21 @@
> # Check ncurses compatibility
>
> # What library to link
> ldflags()
> {
>-	echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null
>+	$cc -print-file-name=libncursesw.so | grep -q /
> 	if [ $? -eq 0 ]; then
> 		echo '-lncursesw'
> 		exit
> 	fi
>-	echo "main() {}" | $cc -lncurses -xc - -o /dev/null 2> /dev/null
>+	$cc -print-file-name=libncurses.so | grep -q /
> 	if [ $? -eq 0 ]; then
> 		echo '-lncurses'
> 		exit
> 	fi
>-	echo "main() {}" | $cc -lcurses -xc - -o /dev/null 2> /dev/null
>+	$cc -print-file-name=libcurses.so | grep -q /
> 	if [ $? -eq 0 ]; then
> 		echo '-lcurses'
> 		exit
> 	fi
> 	exit 1
>@@ -34,14 +34,17 @@ ccflags()
> 	else
> 		echo '-DCURSES_LOC="<curses.h>"'
> 	fi
> }
>
>-compiler=""
>+# Temp file, try to clean up after us
>+tmp=.lxdialog.tmp
>+trap "rm -f $tmp" 0 1 2 3 15
>+
> # Check if we can link to ncurses
> check() {
>-	echo "main() {}" | $cc -xc - -o /dev/null 2> /dev/null
>+	echo "main() {}" | $cc -xc - -o $tmp 2> /dev/null
> 	if [ $? != 0 ]; then
> 		echo " *** Unable to find the ncurses libraries."          1>&2
> 		echo " *** make menuconfig require the ncurses libraries"  1>&2
> 		echo " *** "                                               1>&2
> 		echo " *** Install ncurses (ncurses-devel) and try again"  1>&2
>@@ -57,10 +60,11 @@ usage() {
> if [ $# == 0 ]; then
> 	usage
> 	exit 1
> fi
>
>+cc=""
> case "$1" in
> 	"-check")
> 		shift
> 		cc="$@"
> 		check
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
