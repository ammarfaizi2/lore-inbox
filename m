Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282741AbRK0CZV>; Mon, 26 Nov 2001 21:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282742AbRK0CZM>; Mon, 26 Nov 2001 21:25:12 -0500
Received: from rj.SGI.COM ([204.94.215.100]:48530 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S282741AbRK0CZG>;
	Mon, 26 Nov 2001 21:25:06 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16: 802.1Q VLAN non-modular 
In-Reply-To: Your message of "Mon, 26 Nov 2001 14:35:55 -0200."
             <Pine.LNX.4.33L.0111261435090.1491-100000@duckman.distro.conectiva> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Nov 2001 13:24:55 +1100
Message-ID: <10181.1006827895@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001 14:35:55 -0200 (BRST), 
Rik van Riel <riel@conectiva.com.br> wrote:
>On Mon, 26 Nov 2001, Maciej W. Rozycki wrote:
>
>>  It appears the 802.1Q VLAN support didn't receive even basic testing,
>> sigh...  It doesn't compile non-modular, due to vlan_proc_cleanup() being
>> discarded, yet needed in vlan_proc_init().  Following is a fix.
>
>OK, does anybody have good scripts for automatically compiling
>the kernel with many random configurations so we can discover
>bugs like this automagically ?

Ghozlane Toumi's random configurator for CML1 plus documentation.  I
use it to stress test kbuild 2.5.  make allyes, allno, allmod, random
(but valid according to CML1).

Add a .force_default file to constrain the config as required.  Due to
bugs in CML1 you have to force proc_fs on or off, otherwise you get
inconsistent results.  If you do not have the sound firmware files then
you have to force the relevant sound cards off.

.force_default (kbuild 2.4)

# Need _MODULE for a full test
CONFIG_MODULES=y
CONFIG_MODVERSIONS=n

# CML1 has problems with _PROC_FS, with forward references that get
# confused if it changes in mid flight.
CONFIG_PROC_FS=y

# Uncomment if you do not have the required sound firmware files
# CONFIG_SOUND_MSNDCLAS=n
# CONFIG_SOUND_MSNDPIN=n
# CONFIG_PSS_HAVE_BOOT=n
# CONFIG_MAUI_HAVE_BOOT=n

# Broken code, duplicate zlib symbols
CONFIG_JFFS2_FS=n


Patch against 2.4.16.

Index: 16.1/scripts/Configure
--- 16.1/scripts/Configure Tue, 03 Jul 2001 11:11:12 +1000 kaos (linux-2.4/38_Configure 1.1.2.1 644)
+++ 16.1(w)/scripts/Configure Tue, 27 Nov 2001 13:15:40 +1100 kaos (linux-2.4/38_Configure 1.1.2.1 644)
@@ -48,6 +48,10 @@
 #
 # 24 January 1999, Michael Elizabeth Chastain, <mec@shout.net>
 # - Improve the exit message (Jeff Ronne).
+#
+# 7 October 2000, Ghozlane Toumi, <gtoumi@messel.emse.fr>
+# added switches for "random" , "all yes" and "all modules"
+#
 
 #
 # Make sure we're really running bash.
@@ -76,6 +80,43 @@ function endmenu () {
 }
 
 #
+# returns a random number between 1 and $1
+#
+function rnd () {
+	rnd=$[ $RANDOM  %  $1 + 1 ]
+}
+
+#
+# randomly chose a number in a config list (LIST_CONFIG_NAME)
+# or in a range ( MIN_CONFIG_NAME MAX_CONFIG_NAME )
+# ONLY if there is no forced default (and we are in an "auto" mode)
+# we are limited by the range of values taken by  "$RANDOM"
+#
+#       rndval CONFIG_NAME
+#
+
+function rndval () {
+	[ "$AUTO" != "yes" -o -n "$old" ] && return
+	def_list=$(eval echo "\${LIST_$1}")
+	def_min=$(eval echo "\${MIN_$1}")
+	def_max=$(eval echo "\${MAX_$1}")
+
+	if [ -n "$def_list" ]; then
+	  set -- $(echo $def_list | sed 's/,/ /g')
+	  rnd $#
+	  while [ $rnd -le $# ] ; do
+	    def=$1
+	    shift
+	  done
+	  return
+	fi
+	if [ -n "$def_min" -a -n "$def_max" ]; then
+	  rnd $[ $def_max - $def_min ]
+	  def=$[ $def_min + $rnd ]
+	fi
+}
+
+#
 # help prints the corresponding help text from Configure.help to stdout
 #
 #       help variable
@@ -116,7 +157,11 @@ ${var}:\\
 #	readln prompt default oldval
 #
 function readln () {
-	if [ "$DEFAULT" = "-d" -a -n "$3" ]; then
+	if [ "$AUTO" = "yes" ]; then 
+		echo -n "$1"
+		ans=$2
+		echo $ans
+	elif [ "$DEFAULT" = "-d" -a -n "$3" ]; then
 		echo "$1"
 		ans=$2
 	else
@@ -176,6 +221,17 @@ function define_tristate () {
 function bool () {
 	old=$(eval echo "\${$2}")
 	def=${old:-'n'}
+	if [ "$AUTO" = "yes" -a -z "$old" ]; then
+	  if [ "$RND" = "-r" ]; then
+	    rnd 2
+	    case $rnd in
+	      "1") def="y" ;;
+	      "2") def="n" ;;
+	    esac
+	  else
+	    def=$DEF_ANS;
+	  fi
+	fi
 	case "$def" in
 	 "y" | "m") defprompt="Y/n/?"
 	      def="y"
@@ -207,6 +263,18 @@ function tristate () {
 	else 
 	  old=$(eval echo "\${$2}")
 	  def=${old:-'n'}
+	  if [ "$AUTO" = "yes" -a -z "$old" ]; then
+	     if [ "$RND" = "-r" ]; then 
+	      rnd 3
+	      case $rnd in
+	        "1") def="y" ;;
+	        "2") def="n" ;;
+	        "3") def="m" ;;
+	      esac
+	    else
+	      def=$DEF_ANS
+	    fi
+	  fi
 	  case "$def" in
 	   "y") defprompt="Y/m/n/?"
 		;;
@@ -263,6 +331,17 @@ function dep_tristate () {
 
 	if [ $need_module = 1 ]; then
 	   if [ "$CONFIG_MODULES" = "y" ]; then
+		if [ "$AUTO" = "yes" -a -z "$old" ]; then
+		   if [ "$RND" = "-r" ]; then
+		      rnd 2
+		      case $rnd in
+			"1") def="m" ;;
+			"2") def="n" ;;
+		      esac
+		   else
+		      def=$DEF_ANS
+		   fi
+		fi
 		case "$def" in
 		 "y" | "m") defprompt="M/n/?"
 		      def="m"
@@ -358,6 +437,7 @@ function int () {
 	else
 	  max=10000000     # !!
 	fi
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  if expr \( \( $ans + 0 \) \>= $min \) \& \( $ans \<= $max \) >/dev/null 2>&1 ; then
@@ -389,6 +469,7 @@ function hex () {
 	old=$(eval echo "\${$2}")
 	def=${old:-$3}
 	def=${def#*[x,X]}
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  ans=${ans#*[x,X]}
@@ -471,6 +552,15 @@ function choice () {
 		shift; shift
 	done
 
+	if [ "$RND" = "-r" -a -z "$old" ] ; then 
+	  set -- $choices
+	  rnd $#
+	  while [ $rnd -le $# ] ; do 
+	    def=$1
+	    shift ; shift
+	  done
+	fi
+
 	val=""
 	while [ -z "$val" ]; do
 		ambg=n
@@ -519,6 +609,7 @@ function choice () {
 
 CONFIG=.tmpconfig
 CONFIG_H=.tmpconfig.h
+FORCE_DEFAULT=.force_default
 trap "rm -f $CONFIG $CONFIG_H ; exit 1" 1 2
 
 #
@@ -539,6 +630,16 @@ if [ "$1" = "-d" ] ; then
 	shift
 fi
 
+RND=""
+DEF_ANS=""
+AUTO=""
+case "$1" in 
+	-r) RND="-r" ; AUTO="yes" ; shift ;;
+	-y) DEF_ANS="y" ; AUTO="yes" ; shift ;;
+	-m) DEF_ANS="m" ; AUTO="yes" ; shift ;;
+	-n) DEF_ANS="n" ; AUTO="yes" ; shift ;;
+esac
+
 CONFIG_IN=./config.in
 if [ "$1" != "" ] ; then
 	CONFIG_IN=$1
@@ -549,18 +650,37 @@ if [ -f .config ]; then
   DEFAULTS=.config
 fi
 
-if [ -f $DEFAULTS ]; then
-  echo "#"
-  echo "# Using defaults found in" $DEFAULTS
-  echo "#"
-  . $DEFAULTS
-  sed -e 's/# \(CONFIG_[^ ]*\) is not.*/\1=n/' <$DEFAULTS >.config-is-not.$$
-  . .config-is-not.$$
-  rm .config-is-not.$$
+if [ "$AUTO" != "yes" ]; then
+  if [ -f $DEFAULTS ]; then
+    echo "#"
+    echo "# Using defaults found in" $DEFAULTS
+    echo "#"
+    . $DEFAULTS
+    sed -e 's/# \(CONFIG_[^ ]*\) is not.*/\1=n/' <$DEFAULTS >.config-is-not.$$
+    . .config-is-not.$$
+    rm .config-is-not.$$
+  else
+    echo "#"
+    echo "# No defaults found"
+    echo "#"
+  fi
 else
-  echo "#"
-  echo "# No defaults found"
-  echo "#"
+  if [ -f $FORCE_DEFAULT ]; then
+    echo "#"
+    echo "# Forcing defaults found in $FORCE_DEFAULT"
+    echo "#"
+    sed -e '
+s/# \(CONFIG_[^ ]*\) is not.*/\1=n/;
+s/# range \(CONFIG_[^ ]*\) \([^ ][^ ]*\) \([^ ][^ ]*\)/MIN_\1=\2; MAX_\1=\3/;
+s/# list \(CONFIG_[^ ]*\) \([^ ][^ ]*\)/LIST_\1=\2/
+' <$FORCE_DEFAULT >.default_val.$$
+    . .default_val.$$
+    rm .default_val.$$
+  else
+    echo "#"
+    echo "# No defaults found"
+    echo "#"
+  fi 
 fi
 
 . $CONFIG_IN
Index: 16.1/Makefile
--- 16.1/Makefile Tue, 27 Nov 2001 11:15:00 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.31 644)
+++ 16.1(w)/Makefile Tue, 27 Nov 2001 13:15:40 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.31 644)
@@ -289,6 +289,18 @@ menuconfig: include/linux/version.h syml
 config: symlinks
 	$(CONFIG_SHELL) scripts/Configure arch/$(ARCH)/config.in
 
+randconfig: symlinks
+	$(CONFIG_SHELL) scripts/Configure -r arch/$(ARCH)/config.in
+
+allyes: symlinks
+	$(CONFIG_SHELL) scripts/Configure -y arch/$(ARCH)/config.in
+
+allno: symlinks
+	$(CONFIG_SHELL) scripts/Configure -n arch/$(ARCH)/config.in
+
+allmod: symlinks
+	$(CONFIG_SHELL) scripts/Configure -m arch/$(ARCH)/config.in
+
 include/config/MARKER: scripts/split-include include/linux/autoconf.h
 	scripts/split-include include/linux/autoconf.h include/config
 	@ touch include/config/MARKER
Index: 16.1/Documentation/kbuild/00-INDEX
--- 16.1/Documentation/kbuild/00-INDEX Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/V/c/50_00-INDEX 1.1 644)
+++ 16.1(w)/Documentation/kbuild/00-INDEX Tue, 27 Nov 2001 13:15:40 +1100 kaos (linux-2.4/V/c/50_00-INDEX 1.1 644)
@@ -8,3 +8,5 @@ config-language.txt
 	- specification of Config Language, the language in Config.in files
 makefiles.txt
 	- developer information for linux kernel makefiles
+random.txt
+	- automatically generate random configurations for stress testing
Index: 16.1/Documentation/kbuild/random.txt
--- 16.1/Documentation/kbuild/random.txt Tue, 27 Nov 2001 13:16:56 +1100 kaos ()
+++ 16.1(w)/Documentation/kbuild/random.txt Tue, 27 Nov 2001 13:15:40 +1100 kaos (linux-2.4/K/f/22_random.txt  644)
@@ -0,0 +1,47 @@
+Code by Ghozlane Toumi <gtoumi@messel.emse.fr>, documentation by
+Keith Owens <kaos@ocs.com.au>
+
+In addition to the normal config targets you can make
+
+  randconfig	random configuration.
+
+  allyes	reply 'y' to all options, maximal kernel.
+
+  allno		reply 'n' to all options, minimal kernel.
+
+  allmod	build everything as modules where possible.
+
+
+All random configurations will satisfy the config rules, that is, all
+configurations should be valid.  Any build errors indicate bugs in the
+config dependency rules or in the Makefiles.
+
+You can constrain the random configuration, e.g. you may want to force
+the use of modules or the absence of /proc or cramfs must be a module.
+If file .force_default exists then it is read to preset selected
+values, all other values will be randomly selected, subject to the
+config rules.  The syntax of .force_default is:
+
+CONFIG_foo=value
+  Force this value, for example CONFIG_MODULES=y, CONFIG_PROC_FS=n,
+  CONFIG_RAMFS=m.
+
+# CONFIG_foo is not set
+  Equivalent to CONFIG_foo=n, supported because this is the format used
+  in .config.  NOTE: The leading '#' is required.
+
+# list CONFIG_foo val1,val2,val3
+  Pick a value for CONFIG_foo from the list.  CONFIG_foo must be an int
+  or hex option.  NOTE: The leading '#' is required.
+
+# range CONFIG_foo min max
+  Pick a value for CONFIG_foo in the range min <=> max.  CONFIG_foo
+  must be an int option.  NOTE: The leading '#' is required.
+
+If you have repeated settings of the same option in .force_default then
+values take precedence over lists which take precedence over range.
+Within each group the last setting for an option is used.
+
+Answers "randomised" are bool(), tristate(), dep_tristate() and
+choice().  Unless specified in .force_default, int, hex, and string
+options use the default values from config.in.

