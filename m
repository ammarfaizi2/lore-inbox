Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUAESoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUAESoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:44:17 -0500
Received: from main.gmane.org ([80.91.224.249]:38112 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265266AbUAESoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:44:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [ANNOUNCE] 2004-01-05 release of hotplug scripts
Date: Mon, 05 Jan 2004 19:43:58 +0100
Message-ID: <yw1x8ykm2q35.fsf@ford.guide>
References: <20040105183058.GA22066@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:HXKWgVxGzPmK4bvAekrbthnbT8w=
Cc: linux-hotplug-devel@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Greg KH <greg@kroah.com> writes:

> This release is recommended for _anyone_ using the 2.6.0 and beyond
> kernels who is still using hotplug scripts older than 2003_08_05, as a
> number of changes have been made in order to support the 2.6 kernel
> properly.

This patch makes things work better on my laptop running linux
2.6.1-rc1.  Most likely it can be done in a better way.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hotplug-linux2.6.diff

Index: etc/hotplug/hotplug.functions
===================================================================
RCS file: /cvsroot/linux-hotplug/admin/etc/hotplug/hotplug.functions,v
retrieving revision 1.22
diff -u -r1.22 hotplug.functions
--- etc/hotplug/hotplug.functions	7 Oct 2003 21:15:38 -0000	1.22
+++ etc/hotplug/hotplug.functions	5 Jan 2004 18:33:33 -0000
@@ -139,7 +139,7 @@
     do
 	# maybe driver modules need loading
         LOADED=false
-	if ! lsmod | grep -q "^$MODULE " > /dev/null 2>&1; then
+	if ! lsmod | grep -q "^${MODULE//-/_} " > /dev/null 2>&1; then
 	    if grep -q "^$MODULE\$" $HOTPLUG_DIR/blacklist \
 		    >/dev/null 2>&1; then
 		debug_mesg "... blacklisted module:  $MODULE"
Index: etc/hotplug/pci.agent
===================================================================
RCS file: /cvsroot/linux-hotplug/admin/etc/hotplug/pci.agent,v
retrieving revision 1.13
diff -u -r1.13 pci.agent
--- etc/hotplug/pci.agent	16 Sep 2003 19:42:17 -0000	1.13
+++ etc/hotplug/pci.agent	5 Jan 2004 18:33:33 -0000
@@ -147,7 +147,7 @@
 add)
     pci_convert_vars
 
-    LABEL="PCI slot $PCI_SLOT_NAME"
+    LABEL="PCI slot $PCI_SLOT"
 
     # on 2.4 systems, modutils maintains MAP_CURRENT
     if [ -r $MAP_CURRENT ]; then
Index: etc/hotplug/pci.rc
===================================================================
RCS file: /cvsroot/linux-hotplug/admin/etc/hotplug/pci.rc,v
retrieving revision 1.7
diff -u -r1.7 pci.rc
--- etc/hotplug/pci.rc	6 Jun 2003 18:27:23 -0000	1.7
+++ etc/hotplug/pci.rc	5 Jan 2004 18:33:33 -0000
@@ -25,6 +25,11 @@
 #     . /etc/sysconfig/pci
 # fi
 
+sys_file ()
+{
+    cut -f2 -dx $DEVICE/$1
+}
+
 pci_boot_events ()
 {
     #
@@ -46,14 +51,27 @@
     PCI_SUBSYS_ID=0:0
     export ACTION PCI_CLASS PCI_ID PCI_SLOT PCI_SUBSYS_ID
 
-    # these notifications will be handled by pcimodules
-    for BUS in `cd /proc/bus/pci;find * -type d -print`; do
-	for SLOT_FUNC in `cd /proc/bus/pci/$BUS; echo *`; do
-	    PCI_SLOT=$BUS:$SLOT_FUNC
-	    : hotplug pci for $PCI_SLOT
-	    /sbin/hotplug pci
+    case $KERNEL in
+	2.5*|2.6*)
+	    for DEVICE in /sys/bus/pci/devices/*; do
+		PCI_CLASS=`sys_file class`
+		PCI_ID=`sys_file vendor`:`sys_file device`
+		PCI_SLOT=`echo $DEVICE | cut -d: -f2-`
+		PCI_SUBSYS_ID=`sys_file subsystem_vendor`:`sys_file subsystem_device`
+		/sbin/hotplug pci
+	    done
+	    ;;
+	2.4*)
+	# these notifications will be handled by pcimodules
+	for BUS in `cd /proc/bus/pci;find * -type d -print`; do
+	    for SLOT_FUNC in `cd /proc/bus/pci/$BUS; echo *`; do
+		PCI_SLOT=$BUS:$SLOT_FUNC
+		: hotplug pci for $PCI_SLOT
+		/sbin/hotplug pci
+	    done
 	done
-    done
+	;;
+    esac
 }
 
 # See how we were called.

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


-- 
Måns Rullgård
mru@kth.se

--=-=-=--

