Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTEZUFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbTEZUFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:05:10 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38668 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262202AbTEZUFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:05:04 -0400
Date: Mon, 26 May 2003 22:17:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Eric <eric@cisu.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New make config options
Message-ID: <20030526201759.GA1075@mars.ravnborg.org>
Mail-Followup-To: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
References: <200305261004.25297.eric@cisu.net> <200305261724.23712.rudmer@legolas.dynup.net> <200305261318.24887.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305261318.24887.eric@cisu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 01:18:24PM -0500, Eric wrote:
> On Monday 26 May 2003 10:24 am, Rudmer van Dijk wrote:
> > what about `make allmodconfig` ??
> >
> Now if we can convince someone to code it :(
> I wish I could throw something together myself but I can only suggest the 
> ideas.  Hopefully someone with the time/skills/interest can put something 
> together to do this. I would have no problems testing the feature if someone 
> else who could write it needs some help testing.

IIRC you can dig out allmodconfig + allnoconfig from Keith Owens
kbuild-2.5 patch sets. See kbuild on sourceforge.

He made a version compatible with the 2.4 kernel, and what you need
is the changes to the scripts/configure script.
If you do not find a 2.4 version, you can take that diff from the
2.5 kernel. [Browsing a bit - got it]
It was Ghozlane Toumi who actually coded this.

Here is the patch (for an older 2.5 kernel).
You may have to apply it by hand.
Then you just have to add a few targets in the main Makefile.

	Sam

===== Configure 1.5 vs 1.6 =====
--- 1.5/scripts/Configure	Tue Apr 23 12:32:30 2002
+++ 1.6/scripts/Configure	Thu Jun  6 02:40:52 2002
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


