Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317205AbSFBSAf>; Sun, 2 Jun 2002 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSFBSAe>; Sun, 2 Jun 2002 14:00:34 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:16072 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317205AbSFBSAc>; Sun, 2 Jun 2002 14:00:32 -0400
Date: Sun, 2 Jun 2002 12:00:11 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] kbuild-2.5: additional targets
Message-ID: <Pine.LNX.4.44.0206021156370.14017-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5: additional targets into Makefile

This patch adds support for targets defconfig, randconfig, allyes, allno, 
allmod into the basic Makefile. Therefor, scripts/Configure must get 
patched.

diff -Nur kbuild-2.5/Makefile kbuild-2.5/Makefile
--- kbuild-2.5/Makefile Sat Jun  1 16:19:37 2002
+++ kbuild-2.5/Makefile Sat Jun  1 16:19:37 2002 +0000 thunder (thunder-2.5/Makefile 1.1 0644)
@@ -195,6 +195,9 @@
 oldconfig: symlinks
 	$(CONFIG_SHELL) scripts/Configure -d arch/$(ARCH)/config.in
 
+defconfig: symlinks
+	yes '' | $(CONFIG_SHELL) scripts/Configure -d arch/$(ARCH)/config.in
+
 xconfig: symlinks
 	@$(MAKE) -C scripts kconfig.tk
 	wish -f scripts/kconfig.tk
@@ -205,6 +208,18 @@
 
 config: symlinks
 	$(CONFIG_SHELL) scripts/Configure arch/$(ARCH)/config.in
+
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
 
 # make asm->asm-$(ARCH) symlink
 
diff -Nur kbuild-2.5/scripts/Configure kbuild-2.5/scripts/Configure
--- kbuild-2.5/scripts/Configure Sat Jun  1 16:19:35 2002
+++ kbuild-2.5/scripts/Configure Sat Jun  1 16:19:35 2002 +0000 thunder (thunder-2.5/scripts/Configure 1.1 0644)
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
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

