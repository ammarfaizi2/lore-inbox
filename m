Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317222AbSFBS6T>; Sun, 2 Jun 2002 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317223AbSFBS6S>; Sun, 2 Jun 2002 14:58:18 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:35534 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317222AbSFBS6O>; Sun, 2 Jun 2002 14:58:14 -0400
Date: Sun, 2 Jun 2002 12:57:21 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] kbuild-2.5: quote Menuconfig quotemarks
Message-ID: <Pine.LNX.4.44.0206021254390.14017-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5: quote the quotemarks in scripts/Menuconfig in order to pass 
            them through to eval and avoid annoying bugs

BTW, these patches are also available at
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/>

diff -Nur kbuild-2.5/scripts/Menuconfig kbuild-2.5/scripts/Menuconfig
--- kbuild-2.5/scripts/Menuconfig Sat Jun  1 16:19:33 2002
+++ kbuild-2.5/scripts/Menuconfig Sat Jun  1 16:19:33 2002 +0000 thunder (thunder-2.5/scripts/Menuconfig 1.1 0644)
@@ -73,6 +73,10 @@
 # - Support for multiple conditions in dep_tristate().
 # - Implemented new functions: define_tristate(), define_int(), define_hex(),
 #   define_string(), dep_bool().
+#
+# 12 November 2001, Keith Owens <kaos@ocs.com.au>
+# Escape double quotes on eval so the quotes are still there on the second
+# evaluation, required to handle strings with special characters.
 # 
 
 
@@ -105,11 +109,11 @@
     eval x=\$$1
     if [ -z "$x" ]; then
 	eval `sed -n -e 's/# \(.*\) is not set.*/\1=n/' -e "/^$1=/p" arch/$ARCH/defconfig`
-	eval x=\${$1:-"$2"}
+	eval x=\${$1:-\"$2\"}
 	eval $1=$x
 	eval INFO_$1="' (NEW)'"
     fi
-    eval info="\$INFO_$1"
+    eval info=\"\$INFO_$1\"
 }
 
 #
@@ -151,7 +155,7 @@
 }
 
 function define_string () {
-	eval $1="$2"
+	eval $1=\"$2\"
 }
 
 #
@@ -333,7 +337,7 @@
 
 	while [ -n "$2" ]
 	do
-		if eval [ "_\$$2" = "_y" ]
+		if eval [ \"_\$$2\" = \"_y\" ]
 		then
 			current=$1
 			break
@@ -543,9 +547,9 @@
 			# we avoid them:
 			if expr "$answer" : '0$' '|' "$answer" : '[1-9][0-9]*$' '|' "$answer" : '-[1-9][0-9]*$' >/dev/null
 			then
-				eval $2="$answer"
+				eval $2=\"$answer\"
 			else
-				eval $2="$3"
+				eval $2=\"$3\"
 				echo -en "\007"
 				${DIALOG} --backtitle "$backtitle" \
 					--infobox "You have made an invalid entry." 3 43
@@ -576,9 +580,9 @@
 
 			if expr "$answer" : '[0-9a-fA-F][0-9a-fA-F]*$' >/dev/null
 			then
-				eval $2="$answer"
+				eval $2=\"$answer\"
 			else
-				eval $2="$3"
+				eval $2=\"$3\"
 				echo -en "\007"
 				${DIALOG} --backtitle "$backtitle" \
 					--infobox "You have made an invalid entry." 3 43
@@ -676,9 +680,9 @@
 	do
 		if [ "$2" = "$choice" ]
 		then
-			eval $2="y"
+			eval $2=\"y\"
 		else
-			eval $2="n"
+			eval $2=\"n\"
 		fi
 		
 		shift ; shift
@@ -941,9 +945,9 @@
 
 			[ "_" = "_$ALT_CONFIG" ] && break
 
-			if eval [ -r "$ALT_CONFIG" ]
+			if eval [ -r \"$ALT_CONFIG\" ]
 			then
-				eval load_config_file "$ALT_CONFIG"
+				eval load_config_file \"$ALT_CONFIG\"
 				break
 			else
 				echo -ne "\007"
@@ -1067,12 +1071,12 @@
 	#
 	function bool () {
 		set_x_info "$2" "n"
-		eval define_bool "$2" "$x"
+		eval define_bool \"$2\" \"$x\"
 	}
 
 	function tristate () {
 		set_x_info "$2" "n"
-		eval define_tristate "$2" "$x"
+		eval define_tristate \"$2\" \"$x\"
 	}
 
 	function dep_tristate () {
@@ -1138,19 +1142,19 @@
 	}
 
 	function define_hex () {
-		eval $1="$2"
+		eval $1=\"$2\"
                	echo "$1=$2"			>>$CONFIG
 		echo "#define $1 0x${2##*[x,X]}"	>>$CONFIG_H
 	}
 
 	function define_int () {
-		eval $1="$2"
+		eval $1=\"$2\"
 		echo "$1=$2" 			>>$CONFIG
 		echo "#define $1 ($2)"		>>$CONFIG_H
 	}
 
 	function define_string () {
-		eval $1="$2"
+		eval $1=\"$2\"
 		echo "$1=\"$2\""		>>$CONFIG
 		echo "#define $1 \"$2\""	>>$CONFIG_H
 	}
@@ -1160,7 +1164,7 @@
 	}
 
 	function define_tristate () {
-		eval $1="$2"
+		eval $1=\"$2\"
 
    		case "$2" in
          	y)
@@ -1199,7 +1203,7 @@
 		set -- $choices
 		while [ -n "$2" ]
 		do
-			if eval [ "_\$$2" = "_y" ]
+			if eval [ \"_\$$2\" = \"_y\" ]
 			then
 				current=$1
 				break
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

