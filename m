Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288432AbSA3GhB>; Wed, 30 Jan 2002 01:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSA3Ggv>; Wed, 30 Jan 2002 01:36:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1030 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288432AbSA3Ggf>; Wed, 30 Jan 2002 01:36:35 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Configure.help in 2.5.3-pre6
Date: Wed, 30 Jan 2002 06:35:43 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a3847v$17m$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201292147530.22800-100000@barbarella.hawaga.org.uk> <1012370595.3392.21.camel@phantasy>
X-Trace: palladium.transmeta.com 1012372577 10512 127.0.0.1 (30 Jan 2002 06:36:17 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 30 Jan 2002 06:36:17 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1012370595.3392.21.camel@phantasy>,
Robert Love  <rml@tech9.net> wrote:
>
>The intention is to fix [menu|x]config.  I believe plain 'ol `make
>config' works.  The new per-config.in config.help is here to stay.

Yes. On the other hand, if there are real problems with converting
menu/x config to multiple help-files, a short-term answer might indeed
be just the silly "concatenate everything into the same file".

I'd much _prefer_ to have somebody who knows menuconfug/xconfig (or just
wants to learn).  I have a totally untested patch for menuconfig, that
probably just works (like the regular config thing it doesn't actualy
take _advantage_ of pairing the Config.help files up with the questions,
but at least it should give you the help texts like it used to). 

I don't know tcl/tk _at_all_, so I haven't even looked at what the
required syntax is for header.tk to use the same kind of "find .  -name
Config.help" thing. 

		Linus

----- UNTESTED patch, use at your own risk -----
diff -u --recursive pre6/linux/scripts/Menuconfig linux/scripts/Menuconfig
--- pre6/linux/scripts/Menuconfig	Sun Aug  5 13:12:41 2001
+++ linux/scripts/Menuconfig	Tue Jan 29 22:31:46 2002
@@ -357,19 +357,18 @@
 
 
 #
-# Extract available help for an option from Configure.help
+# Extract available help for an option from Config.help
 # and send it to standard output.
 #
 # Most of this function was borrowed from the original kernel
 # Configure script.
 #
 function extract_help () {
-  if [ -f Documentation/Configure.help ]
-  then
-     #first escape regexp special characters in the argument:
-     var=$(echo "$1"|sed 's/[][\/.^$*]/\\&/g')
-     #now pick out the right help text:
-     text=$(sed -n "/^$var[ 	]*\$/,\${
+   #first escape regexp special characters in the argument:
+   var=$(echo "$1"|sed 's/[][\/.^$*]/\\&/g')
+   #now pick out the right help text:
+   text=$(cat /dev/null $(find . -name Config.help) |
+          sed -n "/^$var[ 	]*\$/,\${
                         /^$var[ 	]*\$/c\\
 ${var}:\\
 
@@ -378,19 +377,15 @@
                         s/^  //
 			/<file:\\([^>]*\\)>/s//\\1/g
                         p
-                    }" Documentation/Configure.help)
+                    }")
 
-     if [ -z "$text" ]
-     then
-          echo "There is no help available for this kernel option."
-	  return 1
-     else
-	  echo "$text"
-     fi
-  else
-	 echo "There is no help available for this kernel option."
-         return 1
-  fi
+   if [ -z "$text" ]
+   then
+        echo "There is no help available for this kernel option."
+        return 1
+   else
+	echo "$text"
+   fi
 }
 
 #

