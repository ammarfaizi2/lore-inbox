Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTDDVLO (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbTDDVLN (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:11:13 -0500
Received: from [62.37.236.142] ([62.37.236.142]:34731 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S261300AbTDDVKw (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:10:52 -0500
Message-ID: <3E8DF7AE.2010003@wanadoo.es>
Date: Fri, 04 Apr 2003 23:22:54 +0200
From: =?ISO-8859-1?Q?xos=E9_v=E1zquez_p=E9rez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kbuild(2.4) bug and half solution
References: <3E8DD415.6080507@wanadoo.es> <Pine.LNX.4.44.0304042211290.12110-100000@serv>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030807040800000906010404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030807040800000906010404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Roman Zippel wrote:
> Hi,
> 
> On Fri, 4 Apr 2003, XosÉ Vazquez wrote:
> 
>>-if [ "$CONFIG_PROC_FS" = "y" ]; then
>>-   bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
>>-fi
>>+
>>+dep_bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
>>$CONFIG_PROC_FS
>>+
> 
> 
> You can also change this into '[ "$CONFIG_PROC_FS" != "n" ]', so this 
> would also work for the choice option.

yes, it works

kbuild_error.patch is a solution for this error and
kbuild_add_options.patch(this is not mine) is a patch to add the missing
config options(randconfig,allyesconfig,allnoconfig,allmodconfig).
Very useful to find compilation errors/warnings with compregress.sh
script from: http://fire.osdl.org/archive/cherry/stability
it's a good idea has it very handy before release official kernels
and to avoid stupid errors.

patches are for 2.4.21-pre6 and only for i386, I don't include other
arch (arch/XXX/config.in) because I can test it.

-thanks a 1oooooo-

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!

--------------030807040800000906010404
Content-Type: text/plain;
 name="kbuild_add_options.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kbuild_add_options.patch"

Add the missing config options for 2.4.21-pre6.

Index: 21-pre6.1/scripts/Configure
--- 21-pre6.1/scripts/Configure Sun, 12 Jan 2003 11:14:47 +1100 kaos (linux-2.4/38_Configure 1.1.2.1.3.1 644)
+++ 21-pre6.1(w)/scripts/Configure Sat, 29 Mar 2003 09:43:50 +1100 kaos (linux-2.4/38_Configure 1.1.2.1.3.1 644)
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
@@ -348,6 +427,7 @@ function define_int () {
 function int () {
 	old=$(eval echo "\${$2}")
 	def=${old:-$3}
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  if expr "$ans" : '[0-9]*$' > /dev/null; then
@@ -379,6 +459,7 @@ function hex () {
 	old=$(eval echo "\${$2}")
 	def=${old:-$3}
 	def=${def#*[x,X]}
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  ans=${ans#*[x,X]}
@@ -461,6 +542,15 @@ function choice () {
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
@@ -509,6 +599,7 @@ function choice () {
 
 CONFIG=.tmpconfig
 CONFIG_H=.tmpconfig.h
+FORCE_DEFAULT=.force_default
 trap "rm -f $CONFIG $CONFIG_H ; exit 1" 1 2
 
 #
@@ -529,6 +620,16 @@ if [ "$1" = "-d" ] ; then
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
@@ -539,18 +640,37 @@ if [ -f .config ]; then
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
Index: 21-pre6.1/Makefile
--- 21-pre6.1/Makefile Fri, 28 Mar 2003 18:07:01 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.52 644)
+++ 21-pre6.1(w)/Makefile Sat, 29 Mar 2003 09:59:01 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.52 644)
@@ -310,6 +310,22 @@ menuconfig: include/linux/version.h syml
 config: symlinks
 	$(CONFIG_SHELL) scripts/Configure arch/$(ARCH)/config.in
 
+defconfig: symlinks
+	@rm -f .config
+	yes '' | $(CONFIG_SHELL) scripts/Configure arch/$(ARCH)/config.in
+
+randconfig: symlinks
+	$(CONFIG_SHELL) scripts/Configure -r arch/$(ARCH)/config.in
+
+allyesconfig: symlinks
+	$(CONFIG_SHELL) scripts/Configure -y arch/$(ARCH)/config.in
+
+allnoconfig: symlinks
+	$(CONFIG_SHELL) scripts/Configure -n arch/$(ARCH)/config.in
+
+allmodconfig: symlinks
+	$(CONFIG_SHELL) scripts/Configure -m arch/$(ARCH)/config.in
+
 include/config/MARKER: scripts/split-include include/linux/autoconf.h
 	scripts/split-include include/linux/autoconf.h include/config
 	@ touch include/config/MARKER
Index: 21-pre6.1/Documentation/kbuild/00-INDEX
--- 21-pre6.1/Documentation/kbuild/00-INDEX Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/V/c/50_00-INDEX 1.1 644)
+++ 21-pre6.1(w)/Documentation/kbuild/00-INDEX Sat, 29 Mar 2003 09:43:50 +1100 kaos (linux-2.4/V/c/50_00-INDEX 1.1 644)
@@ -8,3 +8,5 @@ config-language.txt
 	- specification of Config Language, the language in Config.in files
 makefiles.txt
 	- developer information for linux kernel makefiles
+random.txt
+	- automatically generate random configurations for stress testing
Index: 21-pre6.1/Documentation/kbuild/random.txt
--- 21-pre6.1/Documentation/kbuild/random.txt Sat, 29 Mar 2003 10:00:03 +1100 kaos ()
+++ 21-pre6.1(w)/Documentation/kbuild/random.txt Sat, 29 Mar 2003 09:35:16 +1100 kaos (linux-2.4/T/g/8_random.txt  644)
@@ -0,0 +1,47 @@
+Code by Ghozlane Toumi <gtoumi@messel.emse.fr>, documentation by
+Keith Owens <kaos@ocs.com.au>
+
+In addition to the normal config targets you can make
+
+  randconfig	random configuration.
+
+  allyesconfig	reply 'y' to all options, maximal kernel.
+
+  allnoconfig	reply 'n' to all options, minimal kernel.
+
+  allmodconfig	build everything as modules where possible.
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

--------------030807040800000906010404
Content-Type: text/plain;
 name="kbuild_error.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kbuild_error.patch"

diff -Nur linux/arch/i386/config.in linux.new/arch/i386/config.in
--- linux/arch/i386/config.in   Fri Apr  4 22:59:49 2003
+++ linux.new/arch/i386/config.in       Fri Apr  4 22:52:55 2003
@@ -315,7 +315,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    choice 'Kernel core (/proc/kcore) format' \
        "ELF            CONFIG_KCORE_ELF        \
         A.OUT          CONFIG_KCORE_AOUT" ELF
diff -Nur linux/drivers/char/ftape/Config.in linux.new/drivers/char/ftape/Config.in
--- linux/drivers/char/ftape/Config.in  Thu Jan 16 04:26:28 2003
+++ linux.new/drivers/char/ftape/Config.in      Fri Apr  4 22:53:55 2003
@@ -10,7 +10,7 @@
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    int '  Number of ftape buffers (EXPERIMENTAL)' CONFIG_FT_NR_BUFFERS 3
 fi
-if [ "$CONFIG_PROC_FS" = "y" ]; then
+if [ "$CONFIG_PROC_FS" != "n" ]; then
    bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
 fi
 choice 'Debugging output'                      \
diff -Nur linux/drivers/media/radio/Config.in linux.new/drivers/media/radio/Config.in
--- linux/drivers/media/radio/Config.in Fri Apr  4 22:59:57 2003
+++ linux.new/drivers/media/radio/Config.in     Fri Apr  4 22:52:13 2003
@@ -40,7 +40,7 @@
       hex '    Trust i/o port (usually 0x350 or 0x358)' CONFIG_RADIO_TRUST_PORT 350
    fi
    dep_tristate '  Typhoon Radio (a.k.a. EcoRadio)' CONFIG_RADIO_TYPHOON $CONFIG_VIDEO_DEV
-   if [ "$CONFIG_PROC_FS" = "y" ]; then
+   if [ "$CONFIG_PROC_FS" != "n" ]; then
       if [ "$CONFIG_RADIO_TYPHOON" != "n" ]; then
          bool '    Support for /proc/radio-typhoon' CONFIG_RADIO_TYPHOON_PROC_FS
       fi

--------------030807040800000906010404--

