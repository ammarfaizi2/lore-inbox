Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSF0WHy>; Thu, 27 Jun 2002 18:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSF0WHx>; Thu, 27 Jun 2002 18:07:53 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39433 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316994AbSF0WHi>;
	Thu, 27 Jun 2002 18:07:38 -0400
Date: Fri, 28 Jun 2002 00:14:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: menuconfig and config uses $objtree
Message-ID: <20020628001452.A14485@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for separate obj and src trees make use of $objtree
within scripts/Menuconfig and scripts/Configure.
All temporary and all result files are located in directory pointed at
by $objtree.

This functionality is foreseen useful for both current kbuild and kbuild-2.5

	Sam

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611   -> 1.612  
#	  scripts/Menuconfig	1.6     -> 1.7    
#	   scripts/Configure	1.6     -> 1.7    
#	scripts/lxdialog/menubox.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/27	sam@mars.ravnborg.org	1.612
# To prepare for separate SRC and OBJ trees scripts/Configure and 
# scripts/Menuconfig now use $objtree for all temporary and result files.
# .config will from now on be placed in $objtree/.config which for the moment
# is equal to $TOPDIR.
# --------------------------------------------
#
diff -Nru a/scripts/Configure b/scripts/Configure
--- a/scripts/Configure	Fri Jun 28 00:09:08 2002
+++ b/scripts/Configure	Fri Jun 28 00:09:08 2002
@@ -125,7 +125,7 @@
    #first escape regexp special characters in the argument:
    var=$(echo "$1"|sed 's/[][\/.^$*]/\\&/g')
    #now pick out the right help text:
-   text=$(cat /dev/null $(find . -name Config.help) |
+   text=$(cat /dev/null $(find $srctree -name Config.help) |
 	sed -n "/^$var[ 	]*\$/,\${
 			/^$var[ 	]*\$/c\\
 ${var}:\\
@@ -600,9 +600,9 @@
 	done
 }
 
-CONFIG=.tmpconfig
-CONFIG_H=.tmpconfig.h
-FORCE_DEFAULT=.force_default
+CONFIG=$objtree/.tmpconfig
+CONFIG_H=$objtree/.tmpconfig.h
+FORCE_DEFAULT=$objtree/.force_default
 trap "rm -f $CONFIG $CONFIG_H ; exit 1" 1 2
 
 #
@@ -638,7 +638,7 @@
 	CONFIG_IN=$1
 fi
 
-for DEFAULTS in .config /lib/modules/`uname -r`/.config /etc/kernel-config /boot/config-`uname -r` arch/$ARCH/defconfig
+for DEFAULTS in $objtree/.config /lib/modules/`uname -r`/.config /etc/kernel-config /boot/config-`uname -r` arch/$ARCH/defconfig
 do
   [ -r $DEFAULTS ] && break
 done
@@ -649,9 +649,9 @@
     echo "# Using defaults found in" $DEFAULTS
     echo "#"
     . $DEFAULTS
-    sed -e 's/# \(CONFIG_[^ ]*\) is not.*/\1=n/' <$DEFAULTS >.config-is-not.$$
-    . .config-is-not.$$
-    rm .config-is-not.$$
+    sed -e 's/# \(CONFIG_[^ ]*\) is not.*/\1=n/' <$DEFAULTS >$objtree/.config-is-not.$$
+    . $objtree/.config-is-not.$$
+    rm $objtree/.config-is-not.$$
   else
     echo "#"
     echo "# No defaults found"
@@ -666,9 +666,9 @@
 s/# \(CONFIG_[^ ]*\) is not.*/\1=n/;
 s/# range \(CONFIG_[^ ]*\) \([^ ][^ ]*\) \([^ ][^ ]*\)/MIN_\1=\2; MAX_\1=\3/;
 s/# list \(CONFIG_[^ ]*\) \([^ ][^ ]*\)/LIST_\1=\2/
-' <$FORCE_DEFAULT >.default_val.$$
-    . .default_val.$$
-    rm .default_val.$$
+' <$FORCE_DEFAULT >$objtree/.default_val.$$
+    . $objtree/.default_val.$$
+    rm $objtree/.default_val.$$
   else
     echo "#"
     echo "# No defaults found"
@@ -678,17 +678,18 @@
 
 . $CONFIG_IN
 
-rm -f .config.old
-if [ -f .config ]; then
-	mv .config .config.old
+rm -f $objtree/.config.old
+if [ -f $objtree/.config ]; then
+	mv $objtree/.config $objtree/.config.old
 fi
-mv .tmpconfig .config
-mv .tmpconfig.h include/linux/autoconf.h
+mv $CONFIG   $objtree/.config
+mkdir -p $objtree/include/linux
+mv $CONFIG_H $objtree/include/linux/autoconf.h
 
 echo
 echo "*** End of Linux kernel configuration."
 echo "*** Check the top-level Makefile for additional configuration."
-if [ ! -f .hdepend -o "$CONFIG_MODVERSIONS" = "y" ] ; then
+if [ ! -f $objtree/.hdepend -o "$CONFIG_MODVERSIONS" = "y" ] ; then
     echo "*** Next, you must run 'make dep'."
 else
     echo "*** Next, you may run 'make bzImage', 'make bzdisk', or 'make install'."
diff -Nru a/scripts/Menuconfig b/scripts/Menuconfig
--- a/scripts/Menuconfig	Fri Jun 28 00:09:08 2002
+++ b/scripts/Menuconfig	Fri Jun 28 00:09:08 2002
@@ -74,7 +74,8 @@
 # - Implemented new functions: define_tristate(), define_int(), define_hex(),
 #   define_string(), dep_bool().
 # 
-
+# 27 July 2002, Sam Ravnborg <sam@ravnborg.org>
+# - All files are now located in $objtree
 
 #
 # Change this to TRUE if you prefer all kernel options listed
@@ -128,7 +129,7 @@
 #
 function comment () {
 	comment_ctr=$[ comment_ctr + 1 ]
-	echo -ne "': $comment_ctr' '--- $1' " >>MCmenu
+	echo -ne "': $comment_ctr' '--- $1' " >>$MCMENU
 }
 
 #
@@ -166,9 +167,9 @@
 	n)	flag=" " ;;
 	esac
 
-	echo -ne "'$2' '[$flag] $1$info' " >>MCmenu
+	echo -ne "'$2' '[$flag] $1$info' " >>$MCMENU
 
-	echo -e "function $2 () { l_bool '$2' \"\$1\" ;}\n" >>MCradiolists
+	echo -e "function $2 () { l_bool '$2' \"\$1\" ;}\n" >>$MCRADIO
 }
 
 #
@@ -190,10 +191,10 @@
 		*) flag=" " ;;
 		esac
 	
-		echo -ne "'$2' '<$flag> $1$info' " >>MCmenu
+		echo -ne "'$2' '<$flag> $1$info' " >>$MCMENU
 	
 		echo -e "
-		function $2 () { l_tristate '$2' \"\$1\" ;}" >>MCradiolists
+		function $2 () { l_tristate '$2' \"\$1\" ;}" >>$MCRADIO
 	fi
 }
 
@@ -284,9 +285,9 @@
 function int () {
 	set_x_info "$2" "$3"
 
-	echo -ne "'$2' '($x) $1$info' " >>MCmenu
+	echo -ne "'$2' '($x) $1$info' " >>$MCMENU
 
-	echo -e "function $2 () { l_int '$1' '$2' '$3' '$x' ;}" >>MCradiolists
+	echo -e "function $2 () { l_int '$1' '$2' '$3' '$x' ;}" >>$MCRADIO
 }
 
 #
@@ -296,9 +297,9 @@
 	set_x_info "$2" "$3"
 	x=${x##*[x,X]}
 
-	echo -ne "'$2' '($x) $1$info' " >>MCmenu
+	echo -ne "'$2' '($x) $1$info' " >>$MCMENU
 
-	echo -e "function $2 () { l_hex '$1' '$2' '$3' '$x' ;}" >>MCradiolists
+	echo -e "function $2 () { l_hex '$1' '$2' '$3' '$x' ;}" >>$MCRADIO
 }
 
 #
@@ -307,9 +308,9 @@
 function string () {
 	set_x_info "$2" "$3"
 
-	echo -ne "'$2' '     $1: \"$x\"$info' " >>MCmenu
+	echo -ne "'$2' '     $1: \"$x\"$info' " >>$MCMENU
 
-	echo -e "function $2 () { l_string '$1' '$2' '$3' '$x' ;}" >>MCradiolists
+	echo -e "function $2 () { l_string '$1' '$2' '$3' '$x' ;}" >>$MCRADIO
 }
 
 #
@@ -343,11 +344,11 @@
 
 	: ${current:=$default}
 
-	echo -ne "'$firstchoice' '($current) $title' " >>MCmenu
+	echo -ne "'$firstchoice' '($current) $title' " >>$MCMENU
 
 	echo -e "
 	function $firstchoice () \
-		{ l_choice '$title' \"$choices\" \"$current\" ;}" >>MCradiolists
+		{ l_choice '$title' \"$choices\" \"$current\" ;}" >>$MCRADIO
 }
 
 } # END load_functions()
@@ -367,7 +368,7 @@
    #first escape regexp special characters in the argument:
    var=$(echo "$1"|sed 's/[][\/.^$*]/\\&/g')
    #now pick out the right help text:
-   text=$(cat /dev/null $(find . -name Config.help) |
+   text=$(cat /dev/null $(find $srctree -name Config.help) |
           sed -n "/^$var[ 	]*\$/,\${
                         /^$var[ 	]*\$/c\\
 ${var}:\\
@@ -392,15 +393,16 @@
 # Activate a help dialog.
 #
 function help () {
-	if extract_help $1 >help.out
+	HELP=$objtree/help.out
+	if extract_help $1 >$HELP
 	then
 		$DIALOG	--backtitle "$backtitle" --title "$2"\
-			--textbox help.out $ROWS $COLS
+			--textbox $HELP $ROWS $COLS
 	else
 		$DIALOG	--backtitle "$backtitle" \
-			--textbox help.out $ROWS $COLS
+			--textbox $HELP $ROWS $COLS
 	fi
-	rm -f help.out
+	rm -f $HELP
 }
 
 #
@@ -408,7 +410,7 @@
 #
 function show_readme () {
 	$DIALOG --backtitle "$backtitle" \
-		--textbox scripts/README.Menuconfig $ROWS $COLS
+		--textbox $srctree/scripts/README.Menuconfig $ROWS $COLS
 }
 
 #
@@ -420,15 +422,15 @@
 			--backtitle '$backtitle' \
 			--menu '$menu_instructions' \
 			$ROWS $COLS $((ROWS-10)) \
-			'$default' " >MCmenu
-	>MCradiolists
+			'$default' " >$MCMENU
+	>$MCRADIO
 }
 
 #
 # Add a submenu option to the menu currently under construction.
 #
 function submenu () {
-	echo -ne "'activate_menu $2' '$1  --->' " >>MCmenu
+	echo -ne "'activate_menu $2' '$1  --->' " >>$MCMENU
 }
 
 #
@@ -466,9 +468,9 @@
 	    *)   flag=' ' ;;
 	    esac
  
-	    echo -ne "'$2' '<$flag> $1$info' " >>MCmenu
+	    echo -ne "'$2' '<$flag> $1$info' " >>$MCMENU
  
-	    echo -e "function $2 () { l_mod_bool '$2' \"\$1\" ;}" >>MCradiolists
+	    echo -e "function $2 () { l_mod_bool '$2' \"\$1\" ;}" >>$MCRADIO
 	fi
 }
 
@@ -534,9 +536,9 @@
 		if $DIALOG --title "$1" \
 			--backtitle "$backtitle" \
 			--inputbox "$inputbox_instructions_int" \
-			10 75 "$4" 2>MCdialog.out
+			10 75 "$4" 2>$MCDIALOG
 		then
-			answer="`cat MCdialog.out`"
+			answer="`cat $MCDIALOG`"
 			answer="${answer:-$3}"
 
 			# Semantics of + and ? in GNU expr changed, so
@@ -568,9 +570,9 @@
 		if $DIALOG --title "$1" \
 			--backtitle "$backtitle" \
 			--inputbox "$inputbox_instructions_hex" \
-			10 75 "$4" 2>MCdialog.out
+			10 75 "$4" 2>$MCDIALOG
 		then
-			answer="`cat MCdialog.out`"
+			answer="`cat $MCDIALOG`"
 			answer="${answer:-$3}"
 			answer="${answer##*[x,X]}"
 
@@ -601,9 +603,9 @@
 		if $DIALOG --title "$1" \
 			--backtitle "$backtitle" \
 			--inputbox "$inputbox_instructions_string" \
-			10 75 "$4" 2>MCdialog.out
+			10 75 "$4" 2>$MCDIALOG
 		then
-			answer="`cat MCdialog.out`"
+			answer="`cat $MCDIALOG`"
 			answer="${answer:-$3}"
 
 			#
@@ -658,9 +660,9 @@
 		if $DIALOG --title "$title" \
 			--backtitle "$backtitle" \
 			--radiolist "$radiolist_instructions" \
-			15 70 6 $list 2>MCdialog.out
+			15 70 6 $list 2>$MCDIALOG
 		then
-			choice=`cat MCdialog.out`
+			choice=`cat $MCDIALOG`
 			break
 		fi
 
@@ -700,10 +702,10 @@
 BEGIN {
 	menu_no = 0
 	comment_is_option = 0
-	parser("'$CONFIG_IN'","MCmenu0")
+	parser("'$CONFIG_IN'","'$objtree'","'$MCMENUMAIN'")
 }
 
-function parser(ifile,menu) {
+function parser(ifile,menudir,mainmenu) {
 
 	while (getline <ifile) {
 		if ($1 == "mainmenu_option") {
@@ -714,28 +716,28 @@
 			sub($1,"",$0)
 			++menu_no
 
-			printf("submenu %s MCmenu%s\n", $0, menu_no) >>menu
+			printf("submenu %s MCmenu%s\n", $0, menu_no) >>mainmenu
 
-			newmenu = sprintf("MCmenu%d", menu_no);
+			newmenu = sprintf("%s/MCmenu%d", menudir, menu_no);
 			printf( "function MCmenu%s () {\n"\
 				"default=$1\n"\
 				"menu_name %s\n",\
 				 menu_no, $0) >newmenu
 
-			parser(ifile, newmenu)
+			parser(ifile, menudir, newmenu)
 		}
 		else if ($0 ~ /^#|\$MAKE|mainmenu_name/) {
-			printf("") >>menu
+			printf("") >>mainmenu
 		}
 		else if ($1 ~ "endmenu") {
-			printf("}\n") >>menu
+			printf("}\n") >>mainmenu
 			return
 		} 
 		else if ($1 == "source") {
-			parser($2,menu)
+			parser($2,menudir,mainmenu)
 		}
 		else {
-			print >>menu
+			print >>mainmenu
 		}
 	}
 }'
@@ -747,23 +749,23 @@
 function parser2 () {
 callawk '
 BEGIN {
-	parser("'$CONFIG_IN'","MCmenu0")
+	parser("'$CONFIG_IN'","'$objtree'","'$MCMENUMAIN'")
 }
 
-function parser(ifile,menu) {
+function parser(ifile,menudir,mainmenu) {
 
 	while (getline <ifile) {
 		if ($0 ~ /^#|$MAKE|mainmenu_name/) {
-			printf("") >>menu
+			printf("") >>mainmenu
 		}
 		else if ($1 ~ /mainmenu_option|endmenu/) {
-			printf("") >>menu
+			printf("") >>mainmenu
 		} 
 		else if ($1 == "source") {
-			parser($2,menu)
+			parser($2,menudir,mainmenu)
 		}
 		else {
-			print >>menu
+			print >>mainmenu
 		}
 	}
 }'
@@ -773,11 +775,11 @@
 # Parse all the config.in files into mini scripts.
 #
 function parse_config_files () {
-	rm -f MCmenu*
+	rm -f $objtree/MCmenu*
 
-	echo "function MCmenu0 () {" >MCmenu0
-	echo 'default=$1' >>MCmenu0
-	echo "menu_name 'Main Menu'" >>MCmenu0
+	echo "function MCmenu0 () {" >$MCMENUMAIN
+	echo 'default=$1' >>$MCMENUMAIN
+	echo "menu_name 'Main Menu'" >>$MCMENUMAIN
 
 	if [ "_$single_menu_mode" = "_TRUE" ]
 	then
@@ -786,11 +788,11 @@
 		parser1
 	fi
 
-	echo "comment ''"	>>MCmenu0
-	echo "g_alt_config" 	>>MCmenu0
-	echo "s_alt_config" 	>>MCmenu0
+	echo "comment ''"	>>$MCMENUMAIN
+	echo "g_alt_config" 	>>$MCMENUMAIN
+	echo "s_alt_config" 	>>$MCMENUMAIN
 
-	echo "}" >>MCmenu0
+	echo "}" >>$MCMENUMAIN
 
 	#
 	# These mini scripts must be sourced into the current
@@ -799,12 +801,12 @@
 	# in activate_menu(), among other things.  Once they are
 	# sourced we can discard them.
 	#
-	for i in MCmenu*
+	for i in $objtree/MCmenu*
 	do
 		echo -n "."
-		source ./$i
+		source $i
 	done
-	rm -f MCmenu*
+	rm -f $objtree/MCmenu*
 }
 
 #
@@ -815,12 +817,13 @@
 # dialog commands or recursively call other menus.
 #
 function activate_menu () {
-	rm -f lxdialog.scrltmp
+	MCERROR=$objtree/MCerror
+	rm -f $objtree/lxdialog.scrltmp
 	while true
 	do
 		comment_ctr=0		#So comment lines get unique tags
 
-		$1 "$default" 2> MCerror #Create the lxdialog menu & functions
+		$1 "$default" 2> $MCERROR #Create the lxdialog menu & functions
 
 		if [ "$?" != "0" ]
 		then
@@ -832,7 +835,7 @@
 report:
 
 EOM
-			sed 's/^/ Q> /' MCerror
+			sed 's/^/ Q> /' $MCERROR
 			cat <<EOM
 
 Please report this to the maintainer <mec@shout.net>.  You may also
@@ -845,14 +848,14 @@
 			cleanup
 			exit 1
 		fi
-		rm -f MCerror
+		rm -f $MCERROR
 
-		. ./MCradiolists		#Source the menu's functions
+		. $MCRADIO		#Source the menu's functions
 
-		. ./MCmenu 2>MCdialog.out	#Activate the lxdialog menu
+		. $MCMENU 2>$MCDIALOG	#Activate the lxdialog menu
 		ret=$?
 
-		read selection <MCdialog.out
+		read selection <$MCDIALOG
 
 		case "$ret" in
 		0|3|4|5|6)
@@ -914,7 +917,7 @@
 #
 g_alt_config () {
 	echo -n "get_alt_config 'Load an Alternate Configuration File' "\
-		>>MCmenu
+		>>$MCMENU
 }
 
 #
@@ -922,6 +925,7 @@
 # configuration from it.
 #
 get_alt_config () {
+	HELP=$objtree/help.out
 	set -f ## Switch file expansion OFF
 
 	while true
@@ -933,11 +937,11 @@
 Enter the name of the configuration file you wish to load.  \
 Accept the name shown to restore the configuration you \
 last retrieved.  Leave blank to abort."\
-			11 55 "$ALT_CONFIG" 2>MCdialog.out
+			11 55 "$ALT_CONFIG" 2>$MCDIALOG
 
 		if [ "$?" = "0" ]
 		then
-			ALT_CONFIG=`cat MCdialog.out`
+			ALT_CONFIG=`cat $MCDIALOG`
 
 			[ "_" = "_$ALT_CONFIG" ] && break
 
@@ -952,7 +956,7 @@
 				sleep 2
 			fi
 		else
-			cat <<EOM >help.out
+			cat <<EOM >$HELP
 
 For various reasons, one may wish to keep several different kernel
 configurations available on a single machine.  
@@ -967,12 +971,12 @@
 EOM
 			$DIALOG	--backtitle "$backtitle"\
 				--title "Load Alternate Configuration"\
-				--textbox help.out $ROWS $COLS
+				--textbox $HELP $ROWS $COLS
 		fi
 	done
 
 	set +f ## Switch file expansion ON
-	rm -f help.out MCdialog.out
+	rm -f $HELP $MCDIALOG
 }
 
 #
@@ -980,7 +984,7 @@
 #
 s_alt_config () {
 	echo -n "save_alt_config 'Save Configuration to an Alternate File' "\
-		 >>MCmenu
+		 >>$MCMENU
 }
 
 #
@@ -988,6 +992,7 @@
 # configuration to it.
 #
 save_alt_config () {
+	HELP=$objtree/help.out
 	set -f  ## Switch file expansion OFF
 			
 	while true
@@ -996,11 +1001,11 @@
 			--inputbox "\
 Enter a filename to which this configuration should be saved \
 as an alternate.  Leave blank to abort."\
-			10 55 "$ALT_CONFIG" 2>MCdialog.out
+			10 55 "$ALT_CONFIG" 2>$MCDIALOG
 
 		if [ "$?" = "0" ]
 		then
-			ALT_CONFIG=`cat MCdialog.out`
+			ALT_CONFIG=`cat $MCDIALOG`
 
 			[ "_" = "_$ALT_CONFIG" ] && break
 
@@ -1016,7 +1021,7 @@
 				sleep 2
 			fi
 		else
-			cat <<EOM >help.out
+			cat <<EOM >$HELP
 
 For various reasons, one may wish to keep different kernel
 configurations available on a single machine.  
@@ -1030,12 +1035,12 @@
 EOM
 			$DIALOG	--backtitle "$backtitle"\
 				--title "Save Alternate Configuration"\
-				--textbox help.out $ROWS $COLS
+				--textbox $HELP $ROWS $COLS
 		fi
 	done
 
 	set +f  ## Switch file expansion ON
-	rm -f help.out MCdialog.out
+	rm -f $HELP $MCDIALOG
 }
 
 #
@@ -1261,11 +1266,11 @@
 
 	echo -n "."
 
-	DEF_CONFIG="${1:-.config}"
-	DEF_CONFIG_H="include/linux/autoconf.h"
+	DEF_CONFIG="$objtree/${1:-.config}"
+	DEF_CONFIG_H="$objtree/include/linux/autoconf.h"
 
-	CONFIG=.tmpconfig
-	CONFIG_H=.tmpconfig.h
+	CONFIG=$objtree/.tmpconfig
+	CONFIG_H=$objtree/.tmpconfig.h
 
 	echo "#" >$CONFIG
 	echo "# Automatically generated by make menuconfig: don't edit" >>$CONFIG
@@ -1277,10 +1282,11 @@
 	echo "#define AUTOCONF_INCLUDED" >> $CONFIG_H
 
 	echo -n "."
-	if . $CONFIG_IN >>.menuconfig.log 2>&1
+	if . $CONFIG_IN >>$MENULOG 2>&1
 	then
-		if [ "$DEF_CONFIG" = ".config" ]
+		if [ "$DEF_CONFIG" = "$objtree/.config" ]
 		then
+			mkdir -p $objtree/include/linux
 			mv $CONFIG_H $DEF_CONFIG_H
 		fi
 
@@ -1307,11 +1313,11 @@
 }
 
 cleanup1 () {
-	rm -f MCmenu* MCradiolists MCdialog.out help.out
+	rm -f $MCMENU $MCMENUMAIN $MCRADIO $MCDIALOG $MCHELP
 }
 
 cleanup2 () {
-	rm -f .tmpconfig .tmpconfig.h
+	rm -f $objtree/.tmpconfig $objtree/.tmpconfig.h
 }
 
 set_geometry () {
@@ -1366,7 +1372,13 @@
 Please enter a string value. \
 Use the <TAB> key to move from the input field to the buttons below it."
 
-DIALOG="./scripts/lxdialog/lxdialog"
+DIALOG="$srctree/scripts/lxdialog/lxdialog"
+
+#Menu files
+MCMENU=$objtree/MCmenu
+MCMENUMAIN=$objtree/MCmenu0
+MCRADIO=$objtree/MCradiolists
+MCDIALOG=$objtree/MCdialog.out
 
 kernel_version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}"
 
@@ -1384,8 +1396,8 @@
 fi
 
 DEFAULTS=arch/$ARCH/defconfig
-if [ -f .config ]; then
-  DEFAULTS=.config
+if [ -f $objtree/.config ]; then
+  DEFAULTS=$objtree/.config
 fi
 
 if [ -f $DEFAULTS ]
@@ -1398,7 +1410,8 @@
 
 
 # Fresh new log.
->.menuconfig.log
+MENULOG=$objtree/.menuconfig.log
+>$MENULOG
 
 # Load the functions used by the config.in files.
 echo -n "Preparing scripts: functions" 
@@ -1419,7 +1432,7 @@
 #
 # Read config.in files and parse them into one shell function per menu.
 #
-echo -n ", parsing"
+echo -n ", parsing $CONFIG_IN"
 parse_config_files $CONFIG_IN
 
 echo "done."
@@ -1444,7 +1457,7 @@
 	echo
 	echo "*** End of Linux kernel configuration."
 	echo "*** Check the top-level Makefile for additional configuration."
-	if [ ! -f .hdepend -o "$CONFIG_MODVERSIONS" = "y" ] ; then
+	if [ ! -f $objtree/.hdepend -o "$CONFIG_MODVERSIONS" = "y" ] ; then
 	    echo "*** Next, you must run 'make dep'."
 	else
 	    echo "*** Next, you may run 'make bzImage', 'make bzdisk', or 'make install'."
@@ -1458,8 +1471,8 @@
 fi
 
 # Remove log if empty.
-if [ ! -s .menuconfig.log ] ; then
-	rm -f .menuconfig.log
+if [ ! -s $MENULOG ] ; then
+	rm -f $MENULOG
 fi
 
 exit 0
diff -Nru a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
--- a/scripts/lxdialog/menubox.c	Fri Jun 28 00:09:08 2002
+++ b/scripts/lxdialog/menubox.c	Fri Jun 28 00:09:08 2002
@@ -55,7 +55,7 @@
  * would leave mis-synchronized lxdialog.scrltmp files lying around,
  * fscanf would read in 'scroll', and eventually that value would get used.
  */
-
+#include <limits.h>
 #include "dialog.h"
 
 static int menu_width, item_x;
@@ -172,6 +172,7 @@
     int key = 0, button = 0, scroll = 0, choice = 0, first_item = 0, max_choice;
     WINDOW *dialog, *menu;
     FILE *f;
+    char scrltmp[PATH_MAX];
 
     max_choice = MIN (menu_height, item_no);
 
@@ -237,7 +238,8 @@
     item_x = (menu_width - item_x) / 2;
 
     /* get the scroll info from the temp file */
-    if ( (f=fopen("lxdialog.scrltmp","r")) != NULL ) {
+    sprintf(scrltmp, "%s/lxdialog.scrltmp", getenv("objtree"));
+    if ( (f=fopen(scrltmp,"r")) != NULL ) {
 	if ( (fscanf(f,"%d\n",&scroll) == 1) && (scroll <= choice) &&
 	     (scroll+max_choice > choice) && (scroll >= 0) &&
 	     (scroll+max_choice <= item_no) ) {
@@ -246,7 +248,7 @@
 	    fclose(f);
 	} else {
 	    scroll=0;
-	    remove("lxdialog.scrltmp");
+	    remove(scrltmp);
 	    fclose(f);
 	    f=NULL;
 	}
@@ -400,7 +402,7 @@
 	case 'n':
 	case 'm':
 	    /* save scroll info */
-	    if ( (f=fopen("lxdialog.scrltmp","w")) != NULL ) {
+	    if ( (f=fopen(scrltmp,"w")) != NULL ) {
 		fprintf(f,"%d\n",scroll);
 		fclose(f);
 	    }
@@ -427,7 +429,7 @@
 	    else
             	fprintf(stderr, "%s\n", items[(scroll + choice) * 2]);
 
-	    remove("lxdialog.scrltmp");
+	    remove(scrltmp);
 	    return button;
 	case 'e':
 	case 'x':
@@ -438,6 +440,6 @@
     }
 
     delwin (dialog);
-    remove("lxdialog.scrltmp");
+    remove(scrltmp);
     return -1;			/* ESC pressed */
 }
