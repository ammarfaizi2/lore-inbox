Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSGGBAm>; Sat, 6 Jul 2002 21:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSGGBAl>; Sat, 6 Jul 2002 21:00:41 -0400
Received: from smtp.comcast.net ([24.153.64.2]:54568 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S314138AbSGGBAh>;
	Sat, 6 Jul 2002 21:00:37 -0400
Date: Sat, 06 Jul 2002 21:05:15 -0400
From: Justin Hibbits <jrh29@po.cwru.edu>
Subject: Patch for Menuconfig script
To: linux-kernel@vger.kernel.org
Cc: mec@shout.net
Message-id: <3D2793CB.90002@po.cwru.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a patch to the Menuconfig script (can be easily adapted to 
the other ones) that allows you to configure the kernel without the 
requirement of bash (I tested it with ksh, in POSIX-only mode).  Feel 
free to flame me :P

(Yes it is kinda big, but that's because I had to hack a bunch of parts 
with it)

Justin Hibbits

--- ../../linux/scripts/Menuconfig	Sun Aug  5 16:12:41 2001
+++ Menuconfig	Sat Jul  6 20:48:15 2002
@@ -83,11 +83,6 @@
 single_menu_mode=
 
 #
-# Make sure we're really running bash.
-#
-[ -z "$BASH" ] && { echo "Menuconfig requires bash" 1>&2; exit 1; }
-
-#
 # Cache function definitions, turn off posix compliance
 #
 set -h +o posix
@@ -101,7 +96,7 @@
 # This function looks for: (1) the current value, or (2) the default value
 # from the arch-dependent defconfig file, or (3) a default passed by the caller.
 
-function set_x_info () {
+set_x_info () {
     eval x=\$$1
     if [ -z "$x" ]; then
 	eval `sed -n -e 's/# \(.*\) is not set.*/\1=n/' -e "/^$1=/p" arch/$ARCH/defconfig`
@@ -126,7 +121,7 @@
 #
 # Additional comments
 #
-function comment () {
+comment () {
 	comment_ctr=$[ comment_ctr + 1 ]
 	echo -ne "': $comment_ctr' '--- $1' " >>MCmenu
 }
@@ -134,23 +129,23 @@
 #
 # Define a boolean to a specific value.
 #
-function define_bool () {
+define_bool () {
 	eval $1=$2
 }
 
-function define_tristate () {
+define_tristate () {
 	eval $1=$2
 }
 
-function define_hex () {
+define_hex () {
 	eval $1=$2
 }
 
-function define_int () {
+define_int () {
 	eval $1=$2
 }
 
-function define_string () {
+define_string () {
 	eval $1="$2"
 }
 
@@ -158,7 +153,7 @@
 # Create a boolean (Yes/No) function for our current menu
 # which calls our local bool function.
 #
-function bool () {
+bool () {
 	set_x_info "$2" "n"
 
 	case $x in
@@ -168,7 +163,7 @@
 
 	echo -ne "'$2' '[$flag] $1$info' " >>MCmenu
 
-	echo -e "function $2 () { l_bool '$2' \"\$1\" ;}\n" >>MCradiolists
+	echo -e "$2 () { l_bool '$2' \"\$1\" ;}\n" >>MCradiolists
 }
 
 #
@@ -177,7 +172,7 @@
 #
 # Collapses to a boolean (Yes/No) if module support is disabled.
 #
-function tristate () {
+tristate () {
 	if [ "$CONFIG_MODULES" != "y" ]
 	then
 		bool "$1" "$2"
@@ -193,7 +188,7 @@
 		echo -ne "'$2' '<$flag> $1$info' " >>MCmenu
 	
 		echo -e "
-		function $2 () { l_tristate '$2' \"\$1\" ;}" >>MCradiolists
+		$2 () { l_tristate '$2' \"\$1\" ;}" >>MCradiolists
 	fi
 }
 
@@ -209,7 +204,7 @@
 #       are nested, and one module requires the presence of something
 #       else in the kernel.
 #
-function dep_tristate () {
+dep_tristate () {
 	ques="$1"
 	var="$2"
 	dep=y
@@ -238,7 +233,7 @@
 #   Same as above, but now only Y and N are allowed as dependency
 #   (i.e. third and next arguments).
 #
-function dep_bool () {
+dep_bool () {
 	ques="$1"
 	var="$2"
 	dep=y
@@ -258,7 +253,7 @@
 	fi
 }
 
-function dep_mbool () {
+dep_mbool () {
 	ques="$1"
 	var="$2"
 	dep=y
@@ -281,41 +276,41 @@
 #
 # Add a menu item which will call our local int function.
 # 
-function int () {
+int () {
 	set_x_info "$2" "$3"
 
 	echo -ne "'$2' '($x) $1$info' " >>MCmenu
 
-	echo -e "function $2 () { l_int '$1' '$2' '$3' '$x' ;}" >>MCradiolists
+	echo -e "$2 () { l_int '$1' '$2' '$3' '$x' ;}" >>MCradiolists
 }
 
 #
 # Add a menu item which will call our local hex function.
 # 
-function hex () {
+hex () {
 	set_x_info "$2" "$3"
 	x=${x##*[x,X]}
 
 	echo -ne "'$2' '($x) $1$info' " >>MCmenu
 
-	echo -e "function $2 () { l_hex '$1' '$2' '$3' '$x' ;}" >>MCradiolists
+	echo -e "$2 () { l_hex '$1' '$2' '$3' '$x' ;}" >>MCradiolists
 }
 
 #
 # Add a menu item which will call our local string function.
 # 
-function string () {
+string () {
 	set_x_info "$2" "$3"
 
 	echo -ne "'$2' '     $1: \"$x\"$info' " >>MCmenu
 
-	echo -e "function $2 () { l_string '$1' '$2' '$3' '$x' ;}" >>MCradiolists
+	echo -e "$2 () { l_string '$1' '$2' '$3' '$x' ;}" >>MCradiolists
 }
 
 #
 # Add a menu item which will call our local One-of-Many choice list.
 #
-function choice () {
+choice () {
 	#
 	# Need to remember params cause they're gonna get reset.
 	#
@@ -346,7 +341,7 @@
 	echo -ne "'$firstchoice' '($current) $title' " >>MCmenu
 
 	echo -e "
-	function $firstchoice () \
+	$firstchoice () \
 		{ l_choice '$title' \"$choices\" \"$current\" ;}" >>MCradiolists
 }
 
@@ -363,7 +358,7 @@
 # Most of this function was borrowed from the original kernel
 # Configure script.
 #
-function extract_help () {
+extract_help () {
   if [ -f Documentation/Configure.help ]
   then
      #first escape regexp special characters in the argument:
@@ -396,7 +391,7 @@
 #
 # Activate a help dialog.
 #
-function help () {
+help () {
 	if extract_help $1 >help.out
 	then
 		$DIALOG	--backtitle "$backtitle" --title "$2"\
@@ -411,7 +406,7 @@
 #
 # Show the README file.
 #
-function show_readme () {
+show_readme () {
 	$DIALOG --backtitle "$backtitle" \
 		--textbox scripts/README.Menuconfig $ROWS $COLS
 }
@@ -420,7 +415,7 @@
 # Begin building the dialog menu command and Initialize the 
 # Radiolist function file.
 #
-function menu_name () {
+menu_name () {
 	echo -ne "$DIALOG --title '$1'\
 			--backtitle '$backtitle' \
 			--menu '$menu_instructions' \
@@ -432,14 +427,14 @@
 #
 # Add a submenu option to the menu currently under construction.
 #
-function submenu () {
+submenu () {
 	echo -ne "'activate_menu $2' '$1  --->' " >>MCmenu
 }
 
 #
 # Handle a boolean (Yes/No) option.
 #
-function l_bool () {
+l_bool () {
 	if [ -n "$2" ]
 	then
 		case "$2" in
@@ -460,7 +455,7 @@
 #
 # Same as bool() except options are (Module/No)
 #
-function mod_bool () {
+mod_bool () {
 	if [ "$CONFIG_MODULES" != "y" ]; then
 	    define_bool "$2" "n"
 	else
@@ -473,14 +468,14 @@
  
 	    echo -ne "'$2' '<$flag> $1$info' " >>MCmenu
  
-	    echo -e "function $2 () { l_mod_bool '$2' \"\$1\" ;}" >>MCradiolists
+	    echo -e "$2 () { l_mod_bool '$2' \"\$1\" ;}" >>MCradiolists
 	fi
 }
 
 #
 # Same as l_bool() except options are (Module/No)
 #
-function l_mod_bool() {
+l_mod_bool() {
 	if [ -n "$2" ]
 	then
 		case "$2" in
@@ -508,7 +503,7 @@
 #
 # Handle a tristate (Yes/No/Module) option.
 #
-function l_tristate () {
+l_tristate () {
 	if [ -n "$2" ]
 	then
 		eval x=\$$1
@@ -533,7 +528,7 @@
 #
 # Create a dialog for entering an integer into a kernel option.
 #
-function l_int () {
+l_int () {
 	while true
 	do
 		if $DIALOG --title "$1" \
@@ -567,7 +562,7 @@
 #
 # Create a dialog for entering a hexadecimal into a kernel option.
 #
-function l_hex () {
+l_hex () {
 	while true
 	do
 		if $DIALOG --title "$1" \
@@ -600,7 +595,7 @@
 #
 # Create a dialog for entering a string into a kernel option.
 #
-function l_string () {
+l_string () {
 	while true
 	do
 		if $DIALOG --title "$1" \
@@ -628,7 +623,7 @@
 #
 # Handle a one-of-many choice list.
 #
-function l_choice () {
+l_choice () {
 	#
 	# Need to remember params cause they're gonna get reset.
 	#
@@ -693,14 +688,14 @@
 #
 # Call awk, and watch for error codes, etc.
 #
-function callawk () {
+callawk () {
 awk "$1" || echo "Awk died with error code $?. Giving up." || exit 1
 }
 
 #
 # A faster awk based recursive parser. (I hope)
 #
-function parser1 () {
+parser1 () {
 callawk '
 BEGIN {
 	menu_no = 0
@@ -722,7 +717,7 @@
 			printf("submenu %s MCmenu%s\n", $0, menu_no) >>menu
 
 			newmenu = sprintf("MCmenu%d", menu_no);
-			printf( "function MCmenu%s () {\n"\
+			printf( "MCmenu%s () {\n"\
 				"default=$1\n"\
 				"menu_name %s\n",\
 				 menu_no, $0) >newmenu
@@ -749,7 +744,7 @@
 #
 # Secondary parser for single menu mode.
 #
-function parser2 () {
+parser2 () {
 callawk '
 BEGIN {
 	parser("'$CONFIG_IN'","MCmenu0")
@@ -777,10 +772,10 @@
 #
 # Parse all the config.in files into mini scripts.
 #
-function parse_config_files () {
+parse_config_files () {
 	rm -f MCmenu*
 
-	echo "function MCmenu0 () {" >MCmenu0
+	echo "MCmenu0 () {" >MCmenu0
 	echo 'default=$1' >>MCmenu0
 	echo "menu_name 'Main Menu'" >>MCmenu0
 
@@ -807,7 +802,7 @@
 	for i in MCmenu*
 	do
 		echo -n "."
-		source ./$i
+		. ./$i
 	done
 	rm -f MCmenu*
 }
@@ -819,7 +814,7 @@
 # one per configuration option.  These functions will in turn execute
 # dialog commands or recursively call other menus.
 #
-function activate_menu () {
+activate_menu () {
 	rm -f lxdialog.scrltmp
 	while true
 	do
@@ -1047,13 +1042,13 @@
 # Load config options from a file.
 # Converts all "# OPTION is not set" lines to "OPTION=n" lines
 #
-function load_config_file () {
+load_config_file () {
 	awk '
 	  /# .* is not set.*/ { printf("%s=n\n", $2) }
 	! /# .* is not set.*/ { print }
 	' $1 >.tmpconfig
 
-	source ./.tmpconfig
+	. ./.tmpconfig
 	rm -f .tmpconfig
 }
 
@@ -1070,17 +1065,17 @@
 	#
 	# Nested function definitions, YIPEE!
 	#
-	function bool () {
+	bool () {
 		set_x_info "$2" "n"
 		eval define_bool "$2" "$x"
 	}
 
-	function tristate () {
+	tristate () {
 		set_x_info "$2" "n"
 		eval define_tristate "$2" "$x"
 	}
 
-	function dep_tristate () {
+	dep_tristate () {
 		set_x_info "$2" "n"
 		var="$2"
 		shift 2
@@ -1096,7 +1091,7 @@
 		define_tristate "$var" "$x"
 	}
 
-	function dep_bool () {
+	dep_bool () {
 		set_x_info "$2" "n"
 		var="$2"
 		shift 2
@@ -1110,7 +1105,7 @@
 		define_bool "$var" "$x"
 	}
 
-	function dep_mbool () {
+	dep_mbool () {
 		set_x_info "$2" "n"
 		var="$2"
 		shift 2
@@ -1124,47 +1119,47 @@
 		define_bool "$var" "$x"
 	}
 
-	function int () {
+	int () {
 		set_x_info "$2" "$3"
 		echo "$2=$x" 		>>$CONFIG
 		echo "#define $2 ($x)"	>>$CONFIG_H
 	}
 
-	function hex () {
+	hex () {
 		set_x_info "$2" "$3"
 		echo "$2=$x" 			 >>$CONFIG
 		echo "#define $2 0x${x##*[x,X]}" >>$CONFIG_H
 	}
 
-	function string () {
+	string () {
 		set_x_info "$2" "$3"
 		echo "$2=\"$x\"" 			 >>$CONFIG
 		echo "#define $2 \"$x\""	>>$CONFIG_H
 	}
 
-	function define_hex () {
+	define_hex () {
 		eval $1="$2"
                	echo "$1=$2"			>>$CONFIG
 		echo "#define $1 0x${2##*[x,X]}"	>>$CONFIG_H
 	}
 
-	function define_int () {
+	define_int () {
 		eval $1="$2"
 		echo "$1=$2" 			>>$CONFIG
 		echo "#define $1 ($2)"		>>$CONFIG_H
 	}
 
-	function define_string () {
+	define_string () {
 		eval $1="$2"
 		echo "$1=\"$2\""		>>$CONFIG
 		echo "#define $1 \"$2\""	>>$CONFIG_H
 	}
 
-	function define_bool () {
+	define_bool () {
 		define_tristate "$1" "$2"
 	}
 
-	function define_tristate () {
+	define_tristate () {
 		eval $1="$2"
 
    		case "$2" in
@@ -1192,7 +1187,7 @@
         	esac
 	}
 
-	function choice () {
+	choice () {
 		#
 		# Find the first choice that's already set to 'y'
 		#
@@ -1236,19 +1231,19 @@
 		done
 	}
 
-	function mainmenu_name () {
+	mainmenu_name () {
 		:
 	}
 
-	function mainmenu_option () {
+	mainmenu_option () {
 		comment_is_option=TRUE
 	}
 
-	function endmenu () {
+	endmenu () {
 		:
 	}
 
-	function comment () {
+	comment () {
 		if [ "$comment_is_option" ]
 		then
 			comment_is_option=



