Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbTBKVKZ>; Tue, 11 Feb 2003 16:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbTBKVKX>; Tue, 11 Feb 2003 16:10:23 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:16350 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S266627AbTBKVKE>; Tue, 11 Feb 2003 16:10:04 -0500
Subject: Re: [PATCH] module-init-tools vs. mkinitrd
From: Nicholas Miell <nmiell@attbi.com>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E48AAD1.6060200@freemail.hu>
References: <3E48AAD1.6060200@freemail.hu>
Content-Type: multipart/mixed; boundary="=-7TReV5fCnHuR/b4v2WJA"
Organization: 
Message-Id: <1044998376.1195.10.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 11 Feb 2003 13:19:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7TReV5fCnHuR/b4v2WJA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is a bit more useful.


--=-7TReV5fCnHuR/b4v2WJA
Content-Description: 
Content-Disposition: inline; filename=mkinitrd-new-modules.patch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- mkinitrd	2002-09-04 22:07:04.000000000 -0700
+++ /sbin/mkinitrd	2003-02-11 12:57:58.000000000 -0800
@@ -128,7 +128,7 @@
 	modName="sbp2"
     fi
     
-    fmPath=`(cd /lib/modules/$kernel; echo find . -name $modName.o | /sbin/nash --quiet)`
+    fmPath=`(cd /lib/modules/$kernel; echo find . -name $modName$o | /sbin/nash --quiet)`
 
     if [ ! -f /lib/modules/$kernel/$fmPath ]; then
 	if [ -n "$skiperrors" ]; then
@@ -276,6 +276,9 @@
     exit 1
 fi
 
+# 2.5.48 changed the module extension from o to ko
+o=`echo $kernel | awk 'BEGIN { FS="."}; { if ( $2 >= 5 && $3 >= 48 ) print ".ko"; else print ".o"; }'`
+
 # find a temporary directory which doesn't use tmpfs
 TMPDIR=""
 for t in /tmp /var/tmp /root ${PWD}; do
@@ -461,7 +464,7 @@
 
 dd if=/dev/zero of=$IMAGE bs=1k count=$IMAGESIZE 2> /dev/null || exit 1
 
-LODEV=$(echo findlodev $modName.o | /sbin/nash --quiet)
+LODEV=$(echo findlodev $modName$o | /sbin/nash --quiet)
 
 if [ -z "$LODEV" ]; then
     rm -rf $MNTPOINT $IMAGE
@@ -500,7 +503,14 @@
 rm -rf $MNTPOINT/lost+found
 
 inst /sbin/nash "$MNTIMAGE/bin/nash"
-inst /sbin/insmod.static "$MNTIMAGE/bin/insmod"
+
+# use the old insmod (when necessary)
+old=""
+if [ $o = ".o" -a -x /sbin/insmod.static.old ]; then
+    old=".old";
+fi
+inst /sbin/insmod.static$old "$MNTIMAGE/bin/insmod"
+
 ln -s /sbin/nash $MNTIMAGE/sbin/modprobe
 
 for MODULE in $MODULES; do
@@ -536,7 +546,7 @@
 
 for MODULE in $MODULES; do
     text=""
-    module=`echo $MODULE | sed "s|.*/||" | sed "s/.o$//"`
+    module=`echo $MODULE | sed "s|.*/||" | sed "s/$o$//"`
 
     options=`sed -n -e "s/^options[ 	][ 	]*$module[ 	][ 	]*//p" $modulefile 2>/dev/null`
 
@@ -547,7 +557,7 @@
         echo "Loading module $module$text"
     fi
     echo "echo \"Loading $module module\"" >> $RCFILE
-    echo "insmod /lib/$module.o $options" >> $RCFILE
+    echo "insmod /lib/$module$o $options" >> $RCFILE
 
     # Hack - we need a delay after loading usb-storage to give things
     #        time to settle down before we start looking a block devices

--=-7TReV5fCnHuR/b4v2WJA--

