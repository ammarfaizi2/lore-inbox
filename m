Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVCJAzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVCJAzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVCJArs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:47:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:56479 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262629AbVCJAmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:32 -0500
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: add documentation for udev users
In-Reply-To: <1110413962220@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:19:23 -0800
Message-Id: <1110413963113@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2036, 2005/03/09 10:20:56-08:00, ecashin@coraid.com

[PATCH] aoe: add documentation for udev users

add documentation for udev users

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/aoe/aoe.txt         |   13 ++++++++++---
 Documentation/aoe/udev-install.sh |   22 ++++++++++++++++++++++
 Documentation/aoe/udev.txt        |   23 +++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)


diff -Nru a/Documentation/aoe/aoe.txt b/Documentation/aoe/aoe.txt
--- a/Documentation/aoe/aoe.txt	2005-03-09 16:16:07 -08:00
+++ b/Documentation/aoe/aoe.txt	2005-03-09 16:16:07 -08:00
@@ -6,9 +6,16 @@
 
 CREATING DEVICE NODES
 
-  Users of udev should find device nodes created automatically.  Two
-  scripts are provided in Documentation/aoe as examples of static
-  device node creation for using the aoe driver.
+  Users of udev should find the block device nodes created
+  automatically, but to create all the necessary device nodes, use the
+  udev configuration rules provided in udev.txt (in this directory).
+
+  There is a udev-install.sh script that shows how to install these
+  rules on your system.
+
+  If you are not using udev, two scripts are provided in
+  Documentation/aoe as examples of static device node creation for
+  using the aoe driver.
 
     rm -rf /dev/etherd
     sh Documentation/aoe/mkdevs.sh /dev/etherd
diff -Nru a/Documentation/aoe/udev-install.sh b/Documentation/aoe/udev-install.sh
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/aoe/udev-install.sh	2005-03-09 16:16:07 -08:00
@@ -0,0 +1,22 @@
+# install the aoe-specific udev rules from udev.txt into 
+# the system's udev configuration
+# 
+
+me="`basename $0`"
+
+# find udev.conf, often /etc/udev/udev.conf
+# (or environment can specify where to find udev.conf)
+#
+if test -z "$conf"; then
+	conf="`find /etc -type f -name udev.conf 2> /dev/null`"
+fi
+if test -z "$conf" || test ! -r $conf; then
+	echo "$me Error: could not find readable udev.conf in /etc" 1>&2
+	exit 1
+fi
+
+# find the directory where udev rules are stored, often
+# /etc/udev/rules.d
+#
+rules_d="`sed -n '/^udev_rules=/{ s!udev_rules=!!; s!\"!!g; p; }' $conf`"
+test "$rules_d" && sh -xc "cp `dirname $0`/udev.txt $rules_d/60-aoe.rules"
diff -Nru a/Documentation/aoe/udev.txt b/Documentation/aoe/udev.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/aoe/udev.txt	2005-03-09 16:16:07 -08:00
@@ -0,0 +1,23 @@
+# These rules tell udev what device nodes to create for aoe support.
+# They may be installed along the following lines (adjusted to what
+# you see on your system).
+# 
+#   ecashin@makki ~$ su
+#   Password:
+#   bash# find /etc -type f -name udev.conf
+#   /etc/udev/udev.conf
+#   bash# grep udev_rules= /etc/udev/udev.conf
+#   udev_rules="/etc/udev/rules.d/"
+#   bash# ls /etc/udev/rules.d/
+#   10-wacom.rules  50-udev.rules
+#   bash# cp /path/to/linux-2.6.xx/Documentation/aoe/udev.txt \
+#           /etc/udev/rules.d/60-aoe.rules
+#  
+
+# aoe char devices
+SUBSYSTEM="aoe", KERNEL="discover",	NAME="etherd/%k", GROUP="disk", MODE="0220"
+SUBSYSTEM="aoe", KERNEL="err",		NAME="etherd/%k", GROUP="disk", MODE="0440"
+SUBSYSTEM="aoe", KERNEL="interfaces",	NAME="etherd/%k", GROUP="disk", MODE="0220"
+
+# aoe block devices     
+KERNEL="etherd*",       NAME="%k", GROUP="disk"

