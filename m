Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268080AbTBRWPu>; Tue, 18 Feb 2003 17:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268083AbTBRWPt>; Tue, 18 Feb 2003 17:15:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55775 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268080AbTBRWPk>;
	Tue, 18 Feb 2003 17:15:40 -0500
Subject: [PATCH] mkinitrd fix for 2.5 modutils
From: Stephen Hemminger <shemminger@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>,
       carbonated beverage <ramune@net-ronin.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1045607137.12949.146.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Feb 2003 14:25:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch to mkinitrd allows it to correctly construct
a ram disk with modules for both 2.4 and 2.5 kernels.  The problem is
that the change in extension from .o to .ko confused it. Without the
patch it is impossible to boot kernels that have ext3 as a module with
an ext3 root file system.

Not sure who the owner of mkinitrd is.
Wonder what other utilities got busted as well?
Patch is agains RHAT 8.0 other distro's may vary.

--- mkinitrd.orig	2002-09-04 22:07:04.000000000 -0700
+++ mkinitrd	2003-02-18 14:15:16.000000000 -0800
@@ -35,6 +35,7 @@
 builtins=""
 pivot=1
 modulefile=/etc/modules.conf
+modext="o"
 rc=0
 
 if [ `uname -m` = "ia64" ]; then
@@ -128,7 +129,7 @@
 	modName="sbp2"
     fi
     
-    fmPath=`(cd /lib/modules/$kernel; echo find . -name $modName.o | /sbin/nash --quiet)`
+    fmPath=`(cd /lib/modules/$kernel; echo find . -name $modName.$modext | /sbin/nash --quiet)`
 
     if [ ! -f /lib/modules/$kernel/$fmPath ]; then
 	if [ -n "$skiperrors" ]; then
@@ -276,6 +277,11 @@
     exit 1
 fi
 
+# Hack for module extension change in 2.5
+if [[ $kernel = 2.[56].* ]]; then
+    modext="ko"
+fi
+
 # find a temporary directory which doesn't use tmpfs
 TMPDIR=""
 for t in /tmp /var/tmp /root ${PWD}; do
@@ -461,7 +467,7 @@
 
 dd if=/dev/zero of=$IMAGE bs=1k count=$IMAGESIZE 2> /dev/null || exit 1
 
-LODEV=$(echo findlodev $modName.o | /sbin/nash --quiet)
+LODEV=$(echo findlodev $modName.$modext | /sbin/nash --quiet)
 
 if [ -z "$LODEV" ]; then
     rm -rf $MNTPOINT $IMAGE
@@ -536,7 +542,7 @@
 
 for MODULE in $MODULES; do
     text=""
-    module=`echo $MODULE | sed "s|.*/||" | sed "s/.o$//"`
+    module=`echo $MODULE | sed "s|.*/||" | sed "s/.$modext$//"`
 
     options=`sed -n -e "s/^options[ 	][ 	]*$module[ 	][ 	]*//p" $modulefile 2>/dev/null`
 
@@ -547,7 +553,7 @@
         echo "Loading module $module$text"
     fi
     echo "echo \"Loading $module module\"" >> $RCFILE
-    echo "insmod /lib/$module.o $options" >> $RCFILE
+    echo "insmod /lib/$module.$modext $options" >> $RCFILE
 
     # Hack - we need a delay after loading usb-storage to give things
     #        time to settle down before we start looking a block devices



