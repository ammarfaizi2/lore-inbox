Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTFXP7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbTFXP7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:59:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30870 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262175AbTFXP7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:59:10 -0400
Date: Tue, 24 Jun 2003 09:13:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 doesn't boot: /bin/insmod.old: file not found
Message-Id: <20030624091301.6a22a184.shemminger@osdl.org>
In-Reply-To: <1056436551.2674.2.camel@localhost.localdomain>
References: <23770.1056415063@firewall.ocs.com.au>
	<1056436551.2674.2.camel@localhost.localdomain>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun 2003 08:35:52 +0200
Ronald Bultje <rbultje@ronald.bitfreak.net> wrote:

> Hi Keith,
> 
> On Tue, 2003-06-24 at 02:37, Keith Owens wrote:
> > initrd needs the static version of insmod.  Copy /sbin/insmod.static.old
> > to the ramdisk and rename it as /bin/insmod.old to suit the 2.5 modutils.
> 
> Ah, right, insmod.static.old was indeed missing, I basically assumed
> it'd copy that one in automatically (since it worked for 2.4.20), but
> apparently, 2.4.20 just worked for no apparent reason while it shouldn't
> have.
> 
> Adding insmod.static.old to the ramdisk image (add the line 'inst
> /sbin/insmod.static.old "$MNTIMAGE/bin/insmod.old"' in /sbin/mkinitrd)
> fixed the issue for me. Thanks for the pointer!
> 
> Ronald

The modutils install doesn't save insmod.static (it should).  Assuming
you save the original 2.4 version as insmod.static.old, then the following
change to mkinitrd should correctly handle both 2.4 and 2.5 kernels.

--- /sbin/mkinitrd.orig	2003-06-24 09:08:21.000000000 -0700
+++ /sbin/mkinitrd	2003-05-14 14:55:55.000000000 -0700
@@ -35,6 +35,8 @@
 builtins=""
 pivot=1
 modulefile=/etc/modules.conf
+modext="o"
+insmod="/sbin/insmod.static.old"
 rc=0
 
 if [ `uname -m` = "ia64" ]; then
@@ -128,7 +130,7 @@
 	modName="sbp2"
     fi
     
-    fmPath=`(cd /lib/modules/$kernel; echo find . -name $modName.o | /sbin/nash --quiet)`
+    fmPath=`(cd /lib/modules/$kernel; echo find . -name $modName.$modext | /sbin/nash --quiet)`
 
     if [ ! -f /lib/modules/$kernel/$fmPath ]; then
 	if [ -n "$skiperrors" ]; then
@@ -276,6 +278,12 @@
     exit 1
 fi
 
+# Hack for module extension change in 2.5
+if [[ $kernel = 2.[56].* ]]; then
+    modext="ko"
+    insmod="/sbin/insmod.static"
+fi
+
 # find a temporary directory which doesn't use tmpfs
 TMPDIR=""
 for t in /tmp /var/tmp /root ${PWD}; do
@@ -461,7 +469,7 @@
 
 dd if=/dev/zero of=$IMAGE bs=1k count=$IMAGESIZE 2> /dev/null || exit 1
 
-LODEV=$(echo findlodev $modName.o | /sbin/nash --quiet)
+LODEV=$(echo findlodev $modName.$modext | /sbin/nash --quiet)
 
 if [ -z "$LODEV" ]; then
     rm -rf $MNTPOINT $IMAGE
@@ -500,7 +508,7 @@
 rm -rf $MNTPOINT/lost+found
 
 inst /sbin/nash "$MNTIMAGE/bin/nash"
-inst /sbin/insmod.static "$MNTIMAGE/bin/insmod"
+inst $insmod "$MNTIMAGE/bin/insmod"
 ln -s /sbin/nash $MNTIMAGE/sbin/modprobe
 
 for MODULE in $MODULES; do
@@ -536,7 +544,7 @@
 
 for MODULE in $MODULES; do
     text=""
-    module=`echo $MODULE | sed "s|.*/||" | sed "s/.o$//"`
+    module=`echo $MODULE | sed "s|.*/||" | sed "s/.$modext$//"`
 
     options=`sed -n -e "s/^options[ 	][ 	]*$module[ 	][ 	]*//p" $modulefile 2>/dev/null`
 
@@ -547,7 +555,7 @@
         echo "Loading module $module$text"
     fi
     echo "echo \"Loading $module module\"" >> $RCFILE
-    echo "insmod /lib/$module.o $options" >> $RCFILE
+    echo "insmod /lib/$module.$modext $options" >> $RCFILE
 
     # Hack - we need a delay after loading usb-storage to give things
     #        time to settle down before we start looking a block devices
