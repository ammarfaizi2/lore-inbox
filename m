Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTK1TQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 14:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTK1TQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 14:16:42 -0500
Received: from smtp12.eresmas.com ([62.81.235.112]:52421 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S261950AbTK1TQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 14:16:30 -0500
Message-ID: <3FC79EED.2000906@wanadoo.es>
Date: Fri, 28 Nov 2003 20:15:57 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: [PATCH]-2.4.23 switches to kbuild
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010901000409010305030801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010901000409010305030801
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi,

Added random configurations options for stress testing.

This patch was done by Ghozlane Toumi <gtoumi@messel.emse.fr>
and documented by Keith Owens <kaos@ocs.com.au> on October 7 2000.

Very useful with OSDL compregress.sh[1] for stress testing
of kernel constructions.


[1] http://developer.osdl.org/~cherry/compile/

-thanks-
--
Software is like sex, it's better when it's bug free.


--------------010901000409010305030801
Content-Type: text/plain;
 name="kbuild_add_options.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kbuild_add_options.patch"

--- linux/Documentation/kbuild/00-INDEX	2000-09-17 18:45:06.000000000 +0200
+++ n/Documentation/kbuild/00-INDEX	2003-11-28 17:12:55.000000000 +0100
@@ -8,3 +8,5 @@
 	- specification of Config Language, the language in Config.in files
 makefiles.txt
 	- developer information for linux kernel makefiles
+random.txt
+	- automatically generate random configurations for stress testing
--- linux/Documentation/kbuild/random.txt	2003-11-28 17:24:10.000000000 +0100
+++ n/Documentation/kbuild/random.txt	2003-11-28 17:12:55.000000000 +0100
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
--- linux/Makefile	2003-11-26 01:34:08.000000000 +0100
+++ n/Makefile	2003-11-28 17:20:52.000000000 +0100
@@ -316,6 +316,22 @@
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
--- linux/scripts/Configure	2003-06-15 03:29:22.000000000 +0200
+++ n/scripts/Configure	2003-11-28 17:12:55.000000000 +0100
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
@@ -76,6 +80,43 @@
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
@@ -116,7 +157,11 @@
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
@@ -176,6 +221,17 @@
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
@@ -207,6 +263,18 @@
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
@@ -263,6 +331,17 @@
 
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
@@ -348,6 +427,7 @@
 function int () {
 	old=$(eval echo "\${$2}")
 	def=${old:-$3}
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  if expr "$ans" : '[0-9]*$' > /dev/null; then
@@ -379,6 +459,7 @@
 	old=$(eval echo "\${$2}")
 	def=${old:-$3}
 	def=${def#*[x,X]}
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  ans=${ans#*[x,X]}
@@ -461,6 +542,15 @@
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
@@ -509,6 +599,7 @@
 
 CONFIG=.tmpconfig
 CONFIG_H=.tmpconfig.h
+FORCE_DEFAULT=.force_default
 trap "rm -f $CONFIG $CONFIG_H ; exit 1" 1 2
 
 #
@@ -529,6 +620,16 @@
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
@@ -539,18 +640,37 @@
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


--------------010901000409010305030801--

