Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSHIEPP>; Fri, 9 Aug 2002 00:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318144AbSHIEPP>; Fri, 9 Aug 2002 00:15:15 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:25472 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318143AbSHIEPL>; Fri, 9 Aug 2002 00:15:11 -0400
Date: Thu, 8 Aug 2002 23:15:43 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sf.net
Subject: [patch] config language dep_* enhancements
Message-ID: <20020809041543.GA4818@cadcamlab.org>
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808164742.GA5780@cadcamlab.org>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Kai Germaschewski]
> > As you're hacking Configure anyway, what about "fixing"
> > 
> > 	dep_tristate ' ..' CONFIG_FOO $CONFIG_BAR,

[I wrote]
> I've thought about that many times.  I think the cleanest solution is
> to deprecate the '$' entirely:
> 
> 	dep_tristate ' ..' CONFIG_FOO CONFIG_BAR

This applies to 2.4.20pre and (except changelog bits) to 2.5.30 with
offsets.  I still haven't touched xconfig, because frankly it scares
me.  The tkparse.c vs Peter match is well underway, stay tuned..


diff -urN 2.4.20pre1/Documentation/kbuild/config-language.txt 2.4.20pre1p/Documentation/kbuild/config-language.txt
--- 2.4.20pre1/Documentation/kbuild/config-language.txt	2002-02-25 13:37:51.000000000 -0600
+++ 2.4.20pre1p/Documentation/kbuild/config-language.txt	2002-08-08 23:10:44.000000000 -0500
@@ -84,8 +84,17 @@
     to generate dependencies on individual CONFIG_* symbols instead of
     making one massive dependency on include/linux/autoconf.h.
 
-    A /dep/ is a dependency.  Syntactically, it is a /word/.  At run
-    time, a /dep/ must evaluate to "y", "m", "n", or "".
+    A /tristate/ is a single character in the set {"y","m","n"}.
+
+    A /dep/ is a dependency.  Syntactically, it is a /word/.  It is
+    either a /tristate/ or a /symbol/ (with an optional, but
+    deprecated, prefix "$").  At run time, the /symbol/, if present,
+    is expanded to produce a /tristate/.  If the /symbol/ has not been
+    defined, the /tristate/ will be "n".
+
+    In addition, the /dep/ may have a prefix "!", which negates the
+    sense of the /tristate/: "!y" and "!m" reduce to "n", and "!n"
+    reduces to "y".
 
     An /expr/ is a bash-like expression using the operators
     '=', '!=', '-a', '-o', and '!'.
@@ -439,12 +448,12 @@
 === dep_bool /prompt/ /symbol/ /dep/ ...
 
 This verb evaluates all of the dependencies in the dependency list.
-Any dependency which has a value of "y" does not restrict the input
-range.  Any dependency which has an empty value is ignored.
-Any dependency which has a value of "n", or which has some other value,
-(like "m") restricts the input range to "n".  Quoting dependencies is not
-allowed. Using dependencies with an empty value possible is not
-recommended.  See also dep_mbool below.
+Any dependency which expands to "y" (including "!n" and "!"; see
+above) does not restrict the input range.  Any dependency which
+expands to an empty value is ignored.  Any dependency which expands to
+"n", or any other value (like "m"), restricts the input range to "n".
+Quoting dependencies is not allowed. Using dependencies with an empty
+value possible is not recommended.  See also dep_mbool below.
 
 If the input range is restricted to the single choice "n", dep_bool
 silently assigns "n" to /symbol/.  If the input range has more than
@@ -469,11 +478,12 @@
 === dep_mbool /prompt/ /symbol/ /dep/ ...
 
 This verb evaluates all of the dependencies in the dependency list.
-Any dependency which has a value of "y" or "m" does not restrict the
-input range.  Any dependency which has an empty value is ignored.
-Any dependency which has a value of "n", or which has some other value,
-restricts the input range to "n".  Quoting dependencies is not allowed.
-Using dependencies with an empty value possible is not recommended.
+Any dependency which expands to "y" or "m" (including "!n" and "!";
+see above) does not restrict the input range.  Any dependency which
+expands to an empty value is ignored.  Any dependency which expands to
+"n", or any other value, restricts the input range to "n".  Quoting
+dependencies is not allowed.  Using dependencies with an empty value
+possible is not recommended.
 
 If the input range is restricted to the single choice "n", dep_bool
 silently assigns "n" to /symbol/.  If the input range has more than
@@ -514,12 +524,13 @@
 === dep_tristate /prompt/ /symbol/ /dep/ ...
 
 This verb evaluates all of the dependencies in the dependency list.
-Any dependency which has a value of "y" does not restrict the input range.
-Any dependency which has a value of "m" restricts the input range to
-"m" or "n".  Any dependency which has an empty value is ignored.
-Any dependency which has a value of "n", or which has some other value,
-restricts the input range to "n".  Quoting dependencies is not allowed.
-Using dependencies with an empty value possible is not recommended.
+Any dependency which expands to "y" (including "!n" or "!"; see above)
+does not restrict the input range.  Any dependency which expands to
+"m" restricts the input range to "m" or "n".  Any dependency which
+expands to an empty value is ignored.  Any dependency which expands to
+"n", or any other value, restricts the input range to "n".  Quoting
+dependencies is not allowed.  Using dependencies with an empty value
+possible is not recommended.
 
 If the input range is restricted to the single choice "n", dep_tristate
 silently assigns "n" to /symbol/.  If the input range has more than
diff -urN 2.4.20pre1/scripts/Configure 2.4.20pre1p/scripts/Configure
--- 2.4.20pre1/scripts/Configure	2001-07-02 15:56:40.000000000 -0500
+++ 2.4.20pre1p/scripts/Configure	2002-08-08 22:31:49.000000000 -0500
@@ -48,6 +48,15 @@
 #
 # 24 January 1999, Michael Elizabeth Chastain, <mec@shout.net>
 # - Improve the exit message (Jeff Ronne).
+#
+# 8 Aug 2002, Peter Samuelson <peter@cadcamlab.org>
+# for dependencies in dep_* functions:
+# - deprecate '$' (dep_bool 'foo' CONFIG_FOO CONFIG_BAR CONFIG_BAZ)
+# - allow negation:
+#     dep_bool 'New Foo' CONFIG_FOO !CONFIG_OLDFOO
+#     dep_bool 'Old Foo' CONFIG_OLDFOO !CONFIG_FOO
+#   (Note that since the !CONFIG_OLDFOO is a forward reference, it
+#   is meaningless for the line-based interface.)
 
 #
 # Make sure we're really running bash.
@@ -232,6 +241,28 @@
 }
 
 #
+# dep_calc reduces a dependency line down to a single char [ymn]
+#
+function dep_calc () {
+	local neg arg
+	cur_dep=y	# return value
+	for arg; do
+	  neg=;
+	  case "$arg" in
+	    !*) neg=N; arg=${arg#?} ;;
+	  esac
+	  case "$arg" in
+	    y|m|n) ;;
+	    *) arg=$(eval echo \$$arg) ;;
+	  esac
+	  case "$neg$arg" in
+	    m) cur_dep=m ;;
+	    n|Ny|Nm) cur_dep=n; return ;;
+	  esac
+	done
+}
+
+#
 # dep_tristate processes a tristate argument that depends upon
 # another option or options.  If any of the options we depend upon is a
 # module, then the only allowable options are M or N.  If all are Y, then
@@ -248,18 +279,16 @@
 	var=$2
 	need_module=0
 	shift 2
-	while [ $# -gt 0 ]; do
-	  case "$1" in
- 	    n)
+	dep_calc "$@"
+	case $cur_dep in
+	    n)
 	      define_tristate "$var" "n"
 	      return
 	      ;;
 	    m)
 	      need_module=1
 	      ;;
-	  esac
-	  shift
-	done
+	esac
 
 	if [ $need_module = 1 ]; then
 	   if [ "$CONFIG_MODULES" = "y" ]; then
@@ -299,15 +328,13 @@
 	ques=$1
 	var=$2
 	shift 2
-	while [ $# -gt 0 ]; do
-	  case "$1" in
+	dep_calc "$@"
+	case $cur_dep in
 	    m | n)
 	      define_bool "$var" "n"
 	      return
 	      ;;
-	  esac
-	  shift
-	done
+	esac
 
 	bool "$ques" "$var"
 }
@@ -316,8 +343,8 @@
 	ques=$1
 	var=$2
 	shift 2
-	while [ $# -gt 0 ]; do
-	  case "$1" in
+	dep_calc "$@"
+	case $cur_dep in
 	    n)
 	      define_bool "$var" "n"
 	      return
diff -urN 2.4.20pre1/scripts/Menuconfig 2.4.20pre1p/scripts/Menuconfig
--- 2.4.20pre1/scripts/Menuconfig	2002-06-14 15:09:40.000000000 -0500
+++ 2.4.20pre1p/scripts/Menuconfig	2002-08-08 22:32:09.000000000 -0500
@@ -77,8 +77,14 @@
 # 12 November 2001, Keith Owens <kaos@ocs.com.au>
 # Escape double quotes on eval so the quotes are still there on the second
 # evaluation, required to handle strings with special characters.
-# 
-
+#
+# 8 Aug 2002, Peter Samuelson <peter@cadcamlab.org>
+# for dependencies in dep_* functions:
+# - deprecate '$' (dep_bool 'foo' CONFIG_FOO CONFIG_BAR CONFIG_BAZ)
+# - allow negation:
+#     dep_bool 'New Foo' CONFIG_FOO !CONFIG_OLDFOO
+#     dep_bool 'Old Foo' CONFIG_OLDFOO !CONFIG_FOO
+#   (Yes, forward references DTRT in Menuconfig.)
 
 #
 # Change this to TRUE if you prefer all kernel options listed
@@ -202,6 +208,28 @@
 }
 
 #
+# Reduces a dependency line down to a single char [ymn]
+#
+function dep_calc () {
+	local neg arg
+	cur_dep=y	# return value
+	for arg; do
+	  neg=;
+	  case "$arg" in
+	    !*) neg=N; arg=${arg#?} ;;
+	  esac
+	  case "$arg" in
+	    y|m|n) ;;
+	    *) arg=$(eval echo \$$arg) ;;
+	  esac
+	  case "$neg$arg" in
+	    m) cur_dep=m ;;
+	    n|Ny|Nm) cur_dep=n; return ;;
+	  esac
+	done
+}
+
+#
 # Create a tristate radiolist function which is dependent on
 # another kernel configuration option.
 #
@@ -216,26 +244,13 @@
 function dep_tristate () {
 	ques="$1"
 	var="$2"
-	dep=y
-	shift 2
-	while [ $# -gt 0 ]; do
-		if   [ "$1" = y ]; then
-			shift
-		elif [ "$1" = m ]; then
-			dep=m
-			shift
-		else
-			dep=n
-			shift $#
-		fi
-	done
-	if [ "$dep" = y ]; then
-	    tristate "$ques" "$var"
-	elif [ "$dep" = m ]; then
-	    mod_bool "$ques" "$var"
-	else 
-	    define_tristate "$var" n
-	fi
+	shift 2	
+	dep_calc "$@"
+	case $cur_dep in
+	  y) tristate "$ques" "$var" ;;
+	  m) mod_bool "$ques" "$var" ;;
+	  n) define_tristate "$var" n ;;
+	esac
 }
 
 #
@@ -245,41 +260,23 @@
 function dep_bool () {
 	ques="$1"
 	var="$2"
-	dep=y
 	shift 2
-	while [ $# -gt 0 ]; do
-		if [ "$1" = y ]; then
-			shift
-		else
-			dep=n
-			shift $#
-		fi
-	done
-	if [ "$dep" = y ]; then
-	    bool "$ques" "$var"
-	else 
-	    define_bool "$var" n
-	fi
+	dep_calc "$@"
+	case $cur_dep in
+	  y) bool "$ques" "$var" ;;
+	  *) define_bool "$var" n ;;
+	esac
 }
 
 function dep_mbool () {
 	ques="$1"
 	var="$2"
-	dep=y
 	shift 2
-	while [ $# -gt 0 ]; do
-		if [ "$1" = y -o "$1" = m ]; then
-			shift
-		else
-			dep=n
-			shift $#
-		fi
-	done
-	if [ "$dep" = y ]; then
-	    bool "$ques" "$var"
-	else 
-	    define_bool "$var" n
-	fi
+	dep_calc "$@"
+	case $cur_dep in
+	  y|m) bool "$ques" "$var" ;;
+	  n) define_bool "$var" n ;;
+	esac
 }
 
 #
@@ -1088,15 +1085,11 @@
 		set_x_info "$2" "n"
 		var="$2"
 		shift 2
-		while [ $# -gt 0 ]; do
-			if   [ "$1" = y ]; then
-				shift
-			elif [ "$1" = m -a "$x" != n ]; then
-				x=m; shift
-			else 
-				x=n; shift $#
-			fi
-		done
+		dep_calc "$@"
+		case $cur_dep$x in
+			my) x=m ;;
+			n*) x=n ;;
+		esac
 		define_tristate "$var" "$x"
 	}
 
@@ -1104,13 +1097,8 @@
 		set_x_info "$2" "n"
 		var="$2"
 		shift 2
-		while [ $# -gt 0 ]; do
-			if   [ "$1" = y ]; then
-				shift
-			else 
-				x=n; shift $#
-			fi
-		done
+		dep_calc "$@"
+		[ $cur_dep = y ] || x=n
 		define_bool "$var" "$x"
 	}
 
@@ -1118,13 +1106,8 @@
 		set_x_info "$2" "n"
 		var="$2"
 		shift 2
-		while [ $# -gt 0 ]; do
-			if   [ "$1" = y -o "$1" = m ]; then
-				shift
-			else 
-				x=n; shift $#
-			fi
-		done
+		dep_calc "$@"
+		[ $cur_dep = n ] && x=n
 		define_bool "$var" "$x"
 	}
 
