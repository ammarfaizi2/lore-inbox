Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRAAXQk>; Mon, 1 Jan 2001 18:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRAAXQX>; Mon, 1 Jan 2001 18:16:23 -0500
Received: from bhmas10-74-185-207.cwcom.net ([212.137.185.207]:1541 "EHLO
	Consulate.UFP.CX") by vger.kernel.org with ESMTP id <S129704AbRAAXQK>;
	Mon, 1 Jan 2001 18:16:10 -0500
Posted-Date: Mon, 1 Jan 2001 11:55:37 GMT
Date: Mon, 1 Jan 2001 11:55:37 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Michael Elizabeth Chastain <mec@shout.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <Pine.LNX.4.10.10012241410240.4404-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101011145580.15034-100000@MemAlpha.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

On Sun, 24 Dec 2000, Linus Torvalds wrote:

> On Sun, 24 Dec 2000, Tim Wright wrote:

>>> Which is all fine, but maybe the kernel really ought to detect
>>> that problem and complain at boot time?
>>> 
>>> Or does that happen already?

>> There was a similar thread to this recently. The issue is that if
>> you choose the wrong processor type, you may not even be able to
>> complain.

Perhaps the boot and setup code should always be compiled to assume that
it's running on an i386 (or whatever the lowest common denominator is)
until it has verified that the correct processor is actually present?
Memory says that the boot and setup code is discarded during the boot
process, so this shouldn't cause any problems.

> Indeed. Some of the issues end up just becoming compiler flags,
> which means that anything that uses C is "tainted" by the processor
> choice. And happily there isn't all that much non-C in the kernel
> any more.

> One thing we _could_ potentially do is to simplify the CPU selection
> a bit, and make it a two-stage process. Basically have a

>	bool 'Optimize for current CPU' CONFIG_CPU_CURRENT

> which most people who just want to get the best kernel would use.
> Less confusion that way.

Something along the lines of the enclosed patch ???

Best wishes from Riley.

***********************************************************************

--- linux-2.2.18/arch/i386/config.in~	Tue Dec 12 12:59:50 2000
+++ linux-2.2.18/arch/i386/config.in	Mon Jan  1 11:44:23 2001
@@ -9,16 +9,36 @@
 bool 'Prompt for development and/or incomplete code/drivers' CONFIG_EXPERIMENTAL
 endmenu
 
 mainmenu_option next_comment
 comment 'Processor type and features'
+bool 'Optimize for current CPU' CONFIG_CPU_CURRENT
+if [ "$CONFIG_CPU_CURRENT" = "y" ]; then
+
+  ########################################################
+  ##                                                    ##
+  ## Select current CPU. This is NOT valid in config.in ##
+  ## as it doesn't work with `make xconfig` at all, and ##
+  ## may not work with `make menuconfig` either.        ##
+  ##                                                    ##
+  ## The scripts/cpu shell script produces the variable ##
+  ## for the current processor or CONFIG_CPU_UNKNOWN if ##
+  ## it is unable to determine the current processor.   ##
+  ##                                                    ##
+  ########################################################
+
+  define_bool `bash -c scripts/cpu` y
+
+fi
+if [ "$CONFIG_CPU_CURRENT" != "y" -o "$CONFIG_CPU_UNKNOWN" = "y" ]; then
-choice 'Processor family' \
+  choice '  Processor family' \
 	"386			CONFIG_M386	\
 	 486/Cx486		CONFIG_M486	\
 	 586/K5/5x86/6x86	CONFIG_M586	\
 	 Pentium/K6/TSC		CONFIG_M586TSC	\
 	 PPro/6x86MX		CONFIG_M686" PPro
+fi
 #
 # Define implied options from the CPU selection here
 #
 if [ "$CONFIG_M386" != "y" ]; then
   define_bool CONFIG_X86_WP_WORKS_OK y
--- linux-2.2.18/scripts/cpu~	Thu Jan  1 01:00:00 1970
+++ linux-2.2.18/scripts/cpu	Mon Jan  1 14:39:11 2001
@@ -0,0 +1,33 @@
+#!/bin/bash
+
+function analyse() {
+	local CPU=CONFIG_CPU_UNKNOWN
+	local WORD
+
+	while read WORD ; do
+		case ".$WORD" in
+			.amd_k5)	CPU=CONFIG_M586 	;;
+			.amd_k6)	CPU=CONFIG_M586TSC	;;
+			.i386)		CPU=CONFIG_M386 	;;
+			.i486)		CPU=CONFIG_M486 	;;
+			.i586)		CPU=CONFIG_M586 	;;
+			.pentium)	CPU=CONFIG_M586 	;;
+		esac
+#		echo "DEBUG: WORD = '$WORD', CPU = $CPU" >&2
+	done
+	echo $CPU
+}
+
+function model() {
+	uname -m
+	grep '^model name' /proc/cpuinfo | cut -d : -f 2-
+}
+
+function prepare() {
+	tr '(-' ' _'				\
+		| tr -cd 'A-Z a-z_0-9\n' 	\
+		| tr A-Z a-z			\
+		| tr -s ' ' '\n'
+}
+
+model | prepare | analyse

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
