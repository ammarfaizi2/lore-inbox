Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSJJU3E>; Thu, 10 Oct 2002 16:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263714AbSJJUMq>; Thu, 10 Oct 2002 16:12:46 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:64479 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262974AbSJJUII>; Thu, 10 Oct 2002 16:08:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (9/9) misc
Date: Thu, 10 Oct 2002 14:39:46 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler>
In-Reply-To: <02101014305502.17770@boiler>
MIME-Version: 1.0
Message-Id: <0210101439460B.17770@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Part 9 of the EVMS core driver.

This is a series of patches and files required to properly configure and
build EVMS as part of the kernel. Included here is:

- patch for the MAINTAINERS file to include EVMS contact information.
- patch for arch/i386/config.in to provide a configuration menu option
  for EVMS. Patches for other architectures are available, and will be
  submitted in the future.
- patch for drivers/Makefile to process the EVMS directory.
- EVMS-specific configuration files and Makefiles. These currently only
  contain information on building the core driver. As addition plugins are
  submitted, the appropriate patches against these files will be provided.
- patch for include/linux/list.h to add a list_for_each_entry_safe() macro.
- patch for include/linux/major.h to add the EVMS major number (117).
- patch for include/linux/sysctl.h to add entries for EVMS.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



diff -Naur linux-2.5.41/MAINTAINERS linux-2.5.41-evms/MAINTAINERS
--- linux-2.5.41/MAINTAINERS	Mon Oct  7 13:24:40 2002
+++ linux-2.5.41-evms/MAINTAINERS	Thu Oct 10 11:23:27 2002
@@ -556,6 +556,13 @@
 W:	http://opensource.creative.com/
 S:	Maintained
 
+ENTERPRISE VOLUME MANAGEMENT SYSTEM (EVMS)
+P:	Mark Peloquin, Steve Pratt, Kevin Corry
+M:	peloquin@us.ibm.com, slpratt@us.ibm.com, corryk@us.ibm.com
+L:	evms-devel@lists.sourceforge.net
+W:	http://www.sourceforge.net/projects/evms/
+S:	Supported
+
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
 M:	Philip.Blundell@pobox.com
diff -Naur linux-2.5.41/arch/i386/config.in linux-2.5.41-evms/arch/i386/config.in
--- linux-2.5.41/arch/i386/config.in	Mon Oct  7 13:24:02 2002
+++ linux-2.5.41-evms/arch/i386/config.in	Thu Oct 10 11:24:05 2002
@@ -370,6 +370,8 @@
 fi
 endmenu
 
+source drivers/evms/Config.in
+
 source drivers/md/Config.in
 
 source drivers/message/fusion/Config.in
diff -Naur linux-2.5.41/drivers/Makefile linux-2.5.41-evms/drivers/Makefile
--- linux-2.5.41/drivers/Makefile	Mon Oct  7 13:24:49 2002
+++ linux-2.5.41-evms/drivers/Makefile	Thu Oct 10 11:22:27 2002
@@ -41,5 +41,6 @@
 obj-$(CONFIG_BLUEZ)		+= bluetooth/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
+obj-$(CONFIG_EVMS)		+= evms/
 
 include $(TOPDIR)/Rules.make
diff -Naur linux-2.5.41/drivers/evms/Config.in linux-2.5.41-evms/drivers/evms/Config.in
--- linux-2.5.41/drivers/evms/Config.in	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/drivers/evms/Config.in	Thu Oct 10 11:18:21 2002
@@ -0,0 +1,25 @@
+#
+# EVMS kernel configuration
+#
+
+mainmenu_option next_comment
+comment 'Enterprise Volume Management System'
+
+tristate 'EVMS Kernel Runtime' CONFIG_EVMS
+
+if [ "$CONFIG_EVMS" != "n" ]; then
+	choice '  EVMS Debug Level' \
+		"Critical	CONFIG_EVMS_INFO_CRITICAL \
+		 Serious	CONFIG_EVMS_INFO_SERIOUS \
+		 Error		CONFIG_EVMS_INFO_ERROR \
+		 Warning	CONFIG_EVMS_INFO_WARNING \
+		 Default	CONFIG_EVMS_INFO_DEFAULT \
+		 Details	CONFIG_EVMS_INFO_DETAILS \
+		 Debug		CONFIG_EVMS_INFO_DEBUG \
+		 Extra		CONFIG_EVMS_INFO_EXTRA \
+		 Entry_Exit	CONFIG_EVMS_INFO_ENTRY_EXIT \
+		 Everything	CONFIG_EVMS_INFO_EVERYTHING" Default
+fi
+
+endmenu
+
diff -Naur linux-2.5.41/drivers/evms/Makefile linux-2.5.41-evms/drivers/evms/Makefile
--- linux-2.5.41/drivers/evms/Makefile	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/drivers/evms/Makefile	Thu Oct 10 11:18:13 2002
@@ -0,0 +1,8 @@
+#
+# Makefile for the kernel EVMS driver and modules.
+#
+
+obj-$(CONFIG_EVMS) += core/
+
+include $(TOPDIR)/Rules.make
+
diff -Naur linux-2.5.41/drivers/evms/core/Config.help linux-2.5.41-evms/drivers/evms/core/Config.help
--- linux-2.5.41/drivers/evms/core/Config.help	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/drivers/evms/core/Config.help	Thu Oct 10 11:16:58 2002
@@ -0,0 +1,30 @@
+CONFIG_EVMS
+  EVMS runtime driver. This is a plugin-based framework for volume
+  management, and combines support for partitioning, software RAID,
+  LVM, and more into a single interface.
+  
+  User-space tools are required to perform administration of EVMS logical
+  volumes. Please visit <http://www.sourceforge.net/projects/evms> for 
+  more details on downloading and installing these tools.
+  
+  This driver is also available as a modules called evmscore.o ( = code
+  which can be inserted and removed from the running kernel whenever you
+  want). If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.
+
+CONFIG_EVMS_INFO_CRITICAL
+  Set the level for kernel messages from EVMS. Each level on the list
+  produces message for that level and all levels above it. Thus, level
+  "Critical" only logs the most critical messages (and thus the fewest),
+  whereas level "Everything" produces more information that will probably
+  ever be useful.  Level "Default" is a good starting point. Level "Debug"
+  is good if you are having problems with EVMS and want more basic info
+  on what's going on during the volume discovery process.
+
+  EVMS also supports a boot-time kernel parameter to set the info level.
+  To use this method, specify "evms_info_level=5" at boot time, or add the
+  line "append = "evms_info_level=5"" to your lilo.conf file (replacing 5
+  with your desired info level). See include/linux/evms.h for the
+  numerical definitions of the info levels. To use this boot-time parameter,
+  the EVMS core driver must be statically built into the kernel (not as a
+  module).
diff -Naur linux-2.5.41/drivers/evms/core/Makefile linux-2.5.41-evms/drivers/evms/core/Makefile
--- linux-2.5.41/drivers/evms/core/Makefile	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/drivers/evms/core/Makefile	Thu Oct 10 11:17:16 2002
@@ -0,0 +1,41 @@
+#
+# Makefile for the EVMS core.
+#
+
+export-objs := evms.o services.o
+
+evmscore-objs := evms.o services.o discover.o passthru.o
+
+obj-$(CONFIG_EVMS) += evmscore.o
+
+EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_DEFAULT
+ifeq ($(CONFIG_EVMS_INFO_CRITICAL),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_CRITICAL
+endif
+ifeq ($(CONFIG_EVMS_INFO_SERIOUS),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_SERIOUS
+endif
+ifeq ($(CONFIG_EVMS_INFO_ERROR),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_ERROR
+endif
+ifeq ($(CONFIG_EVMS_INFO_WARNING),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_WARNING
+endif
+ifeq ($(CONFIG_EVMS_INFO_DETAILS),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_DETAILS
+endif
+ifeq ($(CONFIG_EVMS_INFO_DEBUG),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_DEBUG
+endif
+ifeq ($(CONFIG_EVMS_INFO_EXTRA),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_EXTRA
+endif
+ifeq ($(CONFIG_EVMS_INFO_ENTRY_EXIT),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_ENTRY_EXIT
+endif
+ifeq ($(CONFIG_EVMS_INFO_EVERYTHING),y)
+	EXTRA_CFLAGS=-DEVMS_INFO_LEVEL=EVMS_INFO_EVERYTHING
+endif
+
+include $(TOPDIR)/Rules.make
+
diff -Naur linux-2.5.41/include/linux/list.h linux-2.5.41-evms/include/linux/list.h
--- linux-2.5.41/include/linux/list.h	Mon Oct  7 13:22:55 2002
+++ linux-2.5.41-evms/include/linux/list.h	Thu Oct 10 14:13:52 2002
@@ -240,6 +240,20 @@
 	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
 		     prefetch(pos->member.next))
 
+/**
+ * list_for_each_entry_safe - iterate over list of a given type, safe against removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		n = list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member != (head);					\
+	     pos = n,							\
+		n = list_entry(pos->member.next, typeof(*pos), member))
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
 #endif
diff -Naur linux-2.5.41/include/linux/major.h linux-2.5.41-evms/include/linux/major.h
--- linux-2.5.41/include/linux/major.h	Mon Oct  7 15:57:47 2002
+++ linux-2.5.41-evms/include/linux/major.h	Wed Jul 10 09:45:46 2002
@@ -140,6 +140,8 @@
 
 #define LVM_CHAR_MAJOR	109	/* Logical Volume Manager */
 
+#define EVMS_MAJOR	117	/* Enterprise Volume Management System */
+
 #define RTF_MAJOR	150
 #define RAW_MAJOR	162
 
diff -Naur linux-2.5.41/include/linux/sysctl.h linux-2.5.41-evms/include/linux/sysctl.h
--- linux-2.5.41/include/linux/sysctl.h	Mon Oct  7 15:57:47 2002
+++ linux-2.5.41-evms/include/linux/sysctl.h	Mon Oct  7 15:57:44 2002
@@ -578,7 +578,8 @@
 	DEV_HWMON=2,
 	DEV_PARPORT=3,
 	DEV_RAID=4,
-	DEV_MAC_HID=5
+	DEV_MAC_HID=5,
+	DEV_EVMS=6,
 };
 
 /* /proc/sys/dev/cdrom */
@@ -594,6 +595,18 @@
 /* /proc/sys/dev/parport */
 enum {
 	DEV_PARPORT_DEFAULT=-3
+};
+
+/* /proc/sys/dev/evms */
+enum {
+	DEV_EVMS_INFO_LEVEL=1,
+	DEV_EVMS_MD=2
+};
+
+/* /proc/sys/dev/evms/raid */
+enum {
+	DEV_EVMS_MD_SPEED_LIMIT_MIN=1,
+	DEV_EVMS_MD_SPEED_LIMIT_MAX=2
 };
 
 /* /proc/sys/dev/raid */
