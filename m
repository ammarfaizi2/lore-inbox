Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTATOw2>; Mon, 20 Jan 2003 09:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbTATOw2>; Mon, 20 Jan 2003 09:52:28 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:51117 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265936AbTATOw0>;
	Mon, 20 Jan 2003 09:52:26 -0500
Date: Mon, 20 Jan 2003 15:57:22 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301201457.PAA25276@harpo.it.uu.se>
To: davidsen@tmr.com
Subject: Re: [2.5] initrd/mkinitrd still not working
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003 14:46:53 -0500 (EST), Bill Davidsen wrote:
>Could someone *please* point me to the version of mkinitrd which works
>with the new module code? The mkinitrd from Redhat and Slackware can not
>find scsi modules which are in the module tree and modeles.dep. If I
>build initrd by hand based on what worked for 2.5.47 it starts to load a
>*still* can't find the module.
>...
>sh arch/i386/boot/install.sh 2.5.56 arch/i386/boot/bzImage System.map ""
>No module sym53c8xx found for kernel 2.5.56
>...
>/lib/modules/2.5.56/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.ko

Recent 2.5 gives modules a .ko suffix instead of the traditional .o,
and modules are described in /etc/modprobe.conf instead of modules.conf.
The quick-n-dirty patch below to RH8.0's /sbin/mkinitrd might do the trick.

As to why the .o -> .ko name change was necessary, I have no idea.
Rusty?

/Mikael

--- mkinitrd.~1~	2003-01-20 15:39:34.000000000 +0100
+++ mkinitrd	2003-01-20 15:49:48.000000000 +0100
@@ -34,7 +34,7 @@
 img_vers=""
 builtins=""
 pivot=1
-modulefile=/etc/modules.conf
+modulefile=/etc/modprobe.conf
 rc=0
 
 if [ `uname -m` = "ia64" ]; then
@@ -128,7 +128,7 @@
 	modName="sbp2"
     fi
     
-    fmPath=`(cd /lib/modules/$kernel; echo find . -name $modName.o | /sbin/nash --quiet)`
+    fmPath=`(cd /lib/modules/$kernel; echo find . -name $modName.ko | /sbin/nash --quiet)`
 
     if [ ! -f /lib/modules/$kernel/$fmPath ]; then
 	if [ -n "$skiperrors" ]; then
@@ -320,7 +320,7 @@
 fi
 
 if [ -n "$needusb" ]; then
-    drivers=$(awk '/^alias usb-controller[0-9]* / { print $3}' < /etc/modules.conf)
+    drivers=$(awk '/^alias usb-controller[0-9]* / { print $3}' < $modulefile)
     if [ -n "$drivers" ]; then
 	findmodule usbcore
 	for driver in $drivers; do
@@ -461,7 +461,7 @@
 
 dd if=/dev/zero of=$IMAGE bs=1k count=$IMAGESIZE 2> /dev/null || exit 1
 
-LODEV=$(echo findlodev $modName.o | /sbin/nash --quiet)
+LODEV=$(echo findlodev $modName.ko | /sbin/nash --quiet)
 
 if [ -z "$LODEV" ]; then
     rm -rf $MNTPOINT $IMAGE
@@ -536,7 +536,7 @@
 
 for MODULE in $MODULES; do
     text=""
-    module=`echo $MODULE | sed "s|.*/||" | sed "s/.o$//"`
+    module=`echo $MODULE | sed "s|.*/||" | sed "s/.ko$//"`
 
     options=`sed -n -e "s/^options[ 	][ 	]*$module[ 	][ 	]*//p" $modulefile 2>/dev/null`
 
@@ -547,7 +547,7 @@
         echo "Loading module $module$text"
     fi
     echo "echo \"Loading $module module\"" >> $RCFILE
-    echo "insmod /lib/$module.o $options" >> $RCFILE
+    echo "insmod /lib/$module.ko $options" >> $RCFILE
 
     # Hack - we need a delay after loading usb-storage to give things
     #        time to settle down before we start looking a block devices
