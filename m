Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSHHP5L>; Thu, 8 Aug 2002 11:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSHHP5L>; Thu, 8 Aug 2002 11:57:11 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:8323 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S317620AbSHHP5K>; Thu, 8 Aug 2002 11:57:10 -0400
Date: Thu, 8 Aug 2002 10:14:32 -0500
To: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@lists.sf.net
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020808151432.GD380@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028722608.18156.280.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Andi Kleen]
> I don't see why it is unmaintainable. What is so bad with these ifs?
> 64bit cleanness is just another dependency, nothing magic and fundamentally
> hard.
[...]
> (unfortunately there is no dep_tristate ... !$CONFIG_64BIT)
> Alternatively CONFIG_NO_64BIT to work around this issue.

The real solution (imo) is to add !$CONFIG_FOO support to the config
language.  Fortunately this is quite easy.  What do you people think?
I didn't do xconfig or config-language.txt but I can if desired.

Tested lightly with ash (not bash)..

Peter

diff -u'rNx*~' 2.4.20pre1/scripts/Configure 2.4.20pre1p/scripts/Configure
--- 2.4.20pre1/scripts/Configure	2001-07-02 15:56:40.000000000 -0500
+++ 2.4.20pre1p/scripts/Configure	2002-08-08 09:55:31.000000000 -0500
@@ -48,6 +48,9 @@
 #
 # 24 January 1999, Michael Elizabeth Chastain, <mec@shout.net>
 # - Improve the exit message (Jeff Ronne).
+#
+# 7 Aug 2002, Peter Samuelson, <peter@cadcamlab.org>
+# - allow negation (!$CONFIG_FOO) for dependencies in dep_* functions
 
 #
 # Make sure we're really running bash.
@@ -250,7 +253,7 @@
 	shift 2
 	while [ $# -gt 0 ]; do
 	  case "$1" in
- 	    n)
+ 	    n | !y | !m)
 	      define_tristate "$var" "n"
 	      return
 	      ;;
@@ -301,7 +304,7 @@
 	shift 2
 	while [ $# -gt 0 ]; do
 	  case "$1" in
-	    m | n)
+	    m | n | !y | !m)
 	      define_bool "$var" "n"
 	      return
 	      ;;
@@ -318,7 +321,7 @@
 	shift 2
 	while [ $# -gt 0 ]; do
 	  case "$1" in
-	    n)
+	    n | !y | !m)
 	      define_bool "$var" "n"
 	      return
 	      ;;
diff -u'rNx*~' 2.4.20pre1/scripts/Menuconfig 2.4.20pre1p/scripts/Menuconfig
--- 2.4.20pre1/scripts/Menuconfig	2002-06-14 15:09:40.000000000 -0500
+++ 2.4.20pre1p/scripts/Menuconfig	2002-08-08 09:55:32.000000000 -0500
@@ -77,8 +77,9 @@
 # 12 November 2001, Keith Owens <kaos@ocs.com.au>
 # Escape double quotes on eval so the quotes are still there on the second
 # evaluation, required to handle strings with special characters.
-# 
-
+#
+# 7 Aug 2002, Peter Samuelson <peter@cadcamlab.org>
+# Allow negation (!$CONFIG_FOO) for dependencies in dep_* functions
 
 #
 # Change this to TRUE if you prefer all kernel options listed
@@ -219,7 +220,7 @@
 	dep=y
 	shift 2
 	while [ $# -gt 0 ]; do
-		if   [ "$1" = y ]; then
+		if   [ "$1" = y -o "$1" = !n ]; then
 			shift
 		elif [ "$1" = m ]; then
 			dep=m
@@ -248,7 +249,7 @@
 	dep=y
 	shift 2
 	while [ $# -gt 0 ]; do
-		if [ "$1" = y ]; then
+		if [ "$1" = y -o "$1" = !n ]; then
 			shift
 		else
 			dep=n
@@ -268,7 +269,7 @@
 	dep=y
 	shift 2
 	while [ $# -gt 0 ]; do
-		if [ "$1" = y -o "$1" = m ]; then
+		if [ "$1" = y -o "$1" = m -o "$1" = !n ]; then
 			shift
 		else
 			dep=n
@@ -1089,7 +1090,7 @@
 		var="$2"
 		shift 2
 		while [ $# -gt 0 ]; do
-			if   [ "$1" = y ]; then
+			if   [ "$1" = y -o "$1" = !n ]; then
 				shift
 			elif [ "$1" = m -a "$x" != n ]; then
 				x=m; shift
@@ -1105,7 +1106,7 @@
 		var="$2"
 		shift 2
 		while [ $# -gt 0 ]; do
-			if   [ "$1" = y ]; then
+			if   [ "$1" = y -o "$1" = !n ]; then
 				shift
 			else 
 				x=n; shift $#
@@ -1119,7 +1120,7 @@
 		var="$2"
 		shift 2
 		while [ $# -gt 0 ]; do
-			if   [ "$1" = y -o "$1" = m ]; then
+			if   [ "$1" = y -o "$1" = m -o "$1" = !n ]; then
 				shift
 			else 
 				x=n; shift $#
