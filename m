Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316803AbSEaUrV>; Fri, 31 May 2002 16:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSEaUrU>; Fri, 31 May 2002 16:47:20 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:62737 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316803AbSEaUrQ>;
	Fri, 31 May 2002 16:47:16 -0400
Date: Fri, 31 May 2002 22:49:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: [PATCH] kbuild: Add new test targets: allyes, allno, randconfig
Message-ID: <20020531224957.D13857@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adds targets useful when doing test-compilation of a kernel.
allyes is useful to see how much of the 2.5 kernel that does not yet compile.
randconfig can be used in a random manner to test strange configuration, for example over a night.
The usage is documented in Documentation/kbuild/random.txt

Credits for this patch goes to Gohzlane Toumi and Keith Owens. I simply extracted it from kbuild-2.5.

	Sam

--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="random.diff"

--- random.txt.orig	Thu Jan  1 01:00:00 1970
+++ random.txt	Fri May 31 21:41:55 2002
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
--- Configure.orig	Fri May 31 22:04:36 2002
+++ Configure	Fri May 31 21:41:55 2002
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
@@ -109,7 +150,11 @@
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
@@ -169,6 +214,17 @@
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
@@ -200,6 +256,18 @@
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
@@ -256,6 +324,17 @@
 
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
@@ -351,6 +430,7 @@
 	else
 	  max=10000000     # !!
 	fi
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  if expr \( \( $ans + 0 \) \>= $min \) \& \( $ans \<= $max \) >/dev/null 2>&1 ; then
@@ -382,6 +462,7 @@
 	old=$(eval echo "\${$2}")
 	def=${old:-$3}
 	def=${def#*[x,X]}
+	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
 	  ans=${ans#*[x,X]}
@@ -464,6 +545,15 @@
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
@@ -512,6 +602,7 @@
 
 CONFIG=.tmpconfig
 CONFIG_H=.tmpconfig.h
+FORCE_DEFAULT=.force_default
 trap "rm -f $CONFIG $CONFIG_H ; exit 1" 1 2
 
 #
@@ -532,34 +623,57 @@
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
 fi
 
-DEFAULTS=.config
-if [ ! -f .config ]; then
-  DEFAULTS=/etc/kernel-config
-  if [ ! -f $DEFAULTS ]; then
-    DEFAULTS=/boot/config-`uname -r`
-    if [ ! -f $DEFAULTS ]; then
-      DEFAULTS=arch/$ARCH/defconfig
-    fi
+for DEFAULTS in .config /lib/modules/`uname -r`/.config /etc/kernel-config /boot/config-`uname -r` arch/$ARCH/defconfig
+do
+  [ -r $DEFAULTS ] && break
+done
+
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
   fi
-fi
-
-if [ -f $DEFAULTS ]; then
-  echo "#"
-  echo "# Using defaults found in" $DEFAULTS
-  echo "#"
-  . $DEFAULTS
-  sed -e 's/# \(CONFIG_[^ ]*\) is not.*/\1=n/' <$DEFAULTS >.config-is-not.$$
-  . .config-is-not.$$
-  rm .config-is-not.$$
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
--- Makefile.orig	Fri May 31 21:39:25 2002
+++ Makefile	Fri May 31 22:16:02 2002
@@ -206,6 +206,18 @@
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
 # make asm->asm-$(ARCH) symlink
 
 symlinks:

--Sw7tCqrGA+HQ0/zt--
