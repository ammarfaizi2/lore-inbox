Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTJWSs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTJWSs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:48:56 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:13580 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S261660AbTJWSrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:47:51 -0400
Date: Thu, 23 Oct 2003 20:46:03 +0200
From: David Jez <dave.jez@seznam.cz>
To: Greg KH <greg@kroah.com>
Subject: diethotplug-0.4 utility patch
Message-ID: <20031023184603.GA81234@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi Greg,

  I send you patch for diethotplug-0.4, witch:
- adds remove action
- adds pci.rc & usb.rc
- usb.rc script remove modules not by fixed list as hotplug, but from
  list gotten from depend files when compiled
- for USB: matching by vendor & class, not only by vendor (-ENODEV bug)

  Regards,
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diethotplug-0.4-djz.diff"

diff -urN diethotplug-0.4.orig/ChangeLog diethotplug-0.4/ChangeLog
--- diethotplug-0.4.orig/ChangeLog	Wed Jan  9 23:03:42 2002
+++ diethotplug-0.4/ChangeLog	Thu Oct 23 10:15:00 2003
@@ -1,3 +1,9 @@
+0.4-djz	(20031023)	* fixed -ENODEV bug.
+			+ add remove action
+			+ add rc/pci.rc for loading modules for PCI devices
+			+ add rc/usb.rc for loading USB subsystem
+	TODO		? add rc/isapnp.rc for loading modules for ISA PnP devices
+			- rc binaries can not be compiled with klibc yet
 0.4 - patch for the Makefile and dietlibc stuff from Erik Andersen.
     - renamed the dietlibc subdirectory to klibc
     - synced with my previous klibc changes
diff -urN diethotplug-0.4.orig/Makefile diethotplug-0.4/Makefile
--- diethotplug-0.4.orig/Makefile	Wed Jan  9 22:28:05 2002
+++ diethotplug-0.4/Makefile	Sat Jul 19 19:32:41 2003
@@ -152,10 +152,22 @@
 	$(CC) $(LDFLAGS) -o $(ROOT) $(OBJS) $(LIB_OBJS) $(ARCH_LIB_OBJS)
 	$(STRIPCMD) $(ROOT)
 
+
+rc:	rc/pci.rc rc/usb.rc
+
+rc/pci.rc:	pci_modules.h logging.o util.o  rc/pci-rc.o
+	$(CC) $(LDFLAGS) -o rc/pci.rc logging.o util.o  rc/pci-rc.o  $(LIB_OBJS) $(ARCH_LIB_OBJS)
+	$(STRIPCMD) rc/pci.rc
+
+rc/usb.rc:	usb_modules.h logging.o util.o  rc/usb-rc.o
+	$(CC) $(LDFLAGS) -o rc/usb.rc logging.o util.o  rc/usb-rc.o  $(LIB_OBJS) $(ARCH_LIB_OBJS)
+	$(STRIPCMD) rc/usb.rc
+
+
 clean:
 	-find . \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -type f -print \
 	 | xargs rm -f 
-	-rm -f core $(ROOT) $(GEN_HEADERS)
+	-rm -f core $(ROOT) $(GEN_HEADERS)  rc/isapnp.rc rc/pci.rc rc/usb.rc
 	$(MAKE) -C klibc clean
 
 DISTFILES = $(shell find . \( -not -name '.' \) -print | grep -v CVS | grep -v "\.tar\.gz" | grep -v "\/\." | grep -v releases | grep -v BitKeeper | grep -v SCCS )
diff -urN diethotplug-0.4.orig/README diethotplug-0.4/README
--- diethotplug-0.4.orig/README	Wed Jan  9 19:06:05 2002
+++ diethotplug-0.4/README	Thu Apr 10 11:16:00 2003
@@ -35,5 +35,3 @@
 uncomment the comment in the line:
 #DEBUG = y
 in the Makefile
-
-
diff -urN diethotplug-0.4.orig/convert_ieee1394.pl diethotplug-0.4/convert_ieee1394.pl
--- diethotplug-0.4.orig/convert_ieee1394.pl	Wed Jan  9 19:17:53 2002
+++ diethotplug-0.4/convert_ieee1394.pl	Thu Apr 10 11:16:00 2003
@@ -54,4 +54,3 @@
 }
 
 print "\t{NULL}\n};\n";
-
diff -urN diethotplug-0.4.orig/convert_pci.pl diethotplug-0.4/convert_pci.pl
--- diethotplug-0.4.orig/convert_pci.pl	Wed Jan  9 19:17:53 2002
+++ diethotplug-0.4/convert_pci.pl	Thu Apr 10 11:16:00 2003
@@ -54,4 +54,3 @@
 }
 
 print "\t{NULL}\n};\n";
-
diff -urN diethotplug-0.4.orig/convert_usb.pl diethotplug-0.4/convert_usb.pl
--- diethotplug-0.4.orig/convert_usb.pl	Wed Jan  9 19:17:53 2002
+++ diethotplug-0.4/convert_usb.pl	Thu Apr 10 11:16:00 2003
@@ -61,4 +61,3 @@
 }
 
 print "\t{NULL}\n};\n";
-
diff -urN diethotplug-0.4.orig/hotplug.c diethotplug-0.4/hotplug.c
--- diethotplug-0.4.orig/hotplug.c	Wed Jan  9 20:57:29 2002
+++ diethotplug-0.4/hotplug.c	Thu Apr 10 11:16:00 2003
@@ -64,4 +64,3 @@
 	 */
 	return call_subsystem (argv[1], main_subsystem);
 }
-
diff -urN diethotplug-0.4.orig/hotplug.h diethotplug-0.4/hotplug.h
--- diethotplug-0.4.orig/hotplug.h	Wed Jan  9 20:57:29 2002
+++ diethotplug-0.4/hotplug.h	Sat Jul 19 19:48:27 2003
@@ -33,6 +33,9 @@
 	int (* handler) (void);
 };
 
+#define ACTION_ADD	1
+#define ACTION_REMOVE	0
+
 #ifdef DEBUG
 #include <syslog.h>
 	#define dbg(format, arg...) do { log_message (LOG_DEBUG, __FUNCTION__ ": " format, ## arg); } while (0)
@@ -47,10 +50,10 @@
 extern int split_2values (const char *string, int base, unsigned int * value1, unsigned int * value2);
 extern int call_subsystem (const char *string, struct subsystem *subsystem);
 extern int load_module (const char *module_name);
+extern int remove_module (const char *module_name);
 
 extern int usb_handler (void);
 extern int pci_handler (void);
 extern int ieee1394_handler (void);
 
 #endif
-
diff -urN diethotplug-0.4.orig/ieee1394.c diethotplug-0.4/ieee1394.c
--- diethotplug-0.4.orig/ieee1394.c	Wed Jan  9 20:57:29 2002
+++ diethotplug-0.4/ieee1394.c	Sat Jul 19 19:47:38 2003
@@ -35,7 +35,7 @@
 #define IEEE1394_MATCH_VERSION		0x0008
 
 
-static int match (unsigned int vendor_id, unsigned int specifier_id, unsigned int version)
+static int match (unsigned int vendor_id, unsigned int specifier_id, unsigned int version, int action)
 {
 	int i;
 	int retval;
@@ -69,17 +69,22 @@
 			continue;
 		}
 		/* found one! */
-		dbg ("loading %s", ieee1394_module_map[i].module_name);
-		retval = load_module (ieee1394_module_map[i].module_name);
+		if (action == ACTION_ADD) {
+			dbg ("loading %s", ieee1394_module_map[i].module_name);
+			retval = load_module (ieee1394_module_map[i].module_name);
+		} else {
+			dbg ("removing %s", ieee1394_module_map[i].module_name);
+			retval = remove_module (ieee1394_module_map[i].module_name);
+		}
 		if (retval)
 			return retval;
 	}
 
-	return -ENODEV;
+	return 0;
 }
 
 
-static int ieee1394_add (void)
+static int ieee1394_add_remove (int action)
 {
 	char *vendor_env;
 	char *specifier_env;
@@ -102,16 +107,21 @@
 	specifier_id = strtoul (specifier_env, NULL, 16);
 	version = strtoul (version_env, NULL, 16);
 
-	error = match (vendor_id, specifier_id, version);
+	error = match (vendor_id, specifier_id, version, action);
 
 	return error;
 }
 
 
+static int ieee1394_add (void)
+{
+	return ieee1394_add_remove (ACTION_ADD);
+}
+
+
 static int ieee1394_remove (void)
 {
-	/* right now we don't do anything here :) */
-	return 0;
+	return ieee1394_add_remove (ACTION_REMOVE);
 }
 
 
@@ -135,4 +145,3 @@
 
 	return call_subsystem (action, ieee1394_subsystem);
 }
-
diff -urN diethotplug-0.4.orig/pci.c diethotplug-0.4/pci.c
--- diethotplug-0.4.orig/pci.c	Wed Jan  9 20:57:29 2002
+++ diethotplug-0.4/pci.c	Sat Jul 19 19:47:38 2003
@@ -31,7 +31,7 @@
 
 static int match_vendor (unsigned int vendor, unsigned int device,
 			 unsigned int subvendor, unsigned int subdevice,
-			 unsigned int pci_class)
+			 unsigned int pci_class, int action)
 {
 	int i;
 	int retval;
@@ -76,8 +76,13 @@
 		}
 
 		/* found one! */
-		dbg ("loading %s", pci_module_map[i].module_name);
-		retval = load_module (pci_module_map[i].module_name);
+		if (action == ACTION_ADD) {
+			dbg ("loading %s", pci_module_map[i].module_name);
+			retval = load_module (pci_module_map[i].module_name);
+		} else {
+			dbg ("removing %s", pci_module_map[i].module_name);
+			retval = remove_module (pci_module_map[i].module_name);
+		}
 		if (retval)
 			return retval;
 	}
@@ -85,7 +90,7 @@
 	return 0;
 }
 	
-static int pci_add (void)
+static int pci_add_remove (int action)
 {
 	char *class_env;
 	char *id_env;
@@ -115,16 +120,21 @@
 		return error;
 	class = strtoul (class_env, NULL, 16);
 
-	error = match_vendor (vendor, device, subvendor, subdevice, class);
+	error = match_vendor (vendor, device, subvendor, subdevice, class, action);
 
 	return error;
 }
 
 
+static int pci_add (void)
+{
+	return pci_add_remove (ACTION_ADD);
+}
+
+
 static int pci_remove (void)
 {
-	/* right now we don't do anything here :) */
-	return 0;
+	return pci_add_remove (ACTION_REMOVE);
 }
 
 static struct subsystem pci_subsystem[] = {
@@ -146,5 +156,3 @@
 
 	return call_subsystem (action, pci_subsystem);
 }
-
-
diff -urN diethotplug-0.4.orig/rc/pci-rc.c diethotplug-0.4/rc/pci-rc.c
--- diethotplug-0.4.orig/rc/pci-rc.c	Thu Jan  1 01:00:00 1970
+++ diethotplug-0.4/rc/pci-rc.c	Sat Jul 19 20:03:15 2003
@@ -0,0 +1,150 @@
+/*
+ * pci-rc.c      mostly to recover lost boot-time pci hotplug events
+ *
+ * Copyright (C) 2003 David Jez <dave.jez@seznam.cz>
+ *
+ *      This program is free software; you can redistribute it and/or modify it
+ *      under the terms of the GNU General Public License as published by the
+ *      Free Software Foundation version 2 of the License.
+ *
+ *      This program is distributed in the hope that it will be useful, but
+ *      WITHOUT ANY WARRANTY; without even the implied warranty of
+ *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *      General Public License for more details.
+ *
+ *      You should have received a copy of the GNU General Public License along
+ *      with this program; if not, write to the Free Software Foundation, Inc.,
+ *      675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "../hotplug.h"
+#include "../pci_modules.h"
+
+#define PROC_PCI "/proc/bus/pci"
+#define PROC_DEV PROC_PCI"/devices"
+
+
+int pci_rc_start_stop (int action)
+{
+FILE *f, *ff;
+long buf;
+unsigned short int bus, slot, func, vendor, device, subvendor, subdevice;
+unsigned long int pciclass;
+unsigned char pcic;
+char filename[128];
+char env[128];
+char c;
+char *argv[3];
+
+
+	if ((f = fopen (PROC_DEV, "r")) == NULL) {
+		dbg ("error: can't open file!\n");
+		return 1;
+	}
+	while (1) {
+		/* read bus/slot.function */
+		fscanf (f, "%lx", &buf);
+		if (feof (f))
+			break;
+
+		bus = (buf >> 8);
+		sprintf (filename, "%s/%02x", PROC_PCI, bus);
+		slot = ((buf & 0xff) / 8);
+		sprintf (filename, "%s/%02x", filename, slot);
+		func = ((buf & 0xff) % 8);
+		sprintf (filename, "%s.%x", filename, func);
+
+		if ((ff = fopen (filename, "rb")) == NULL) {
+			dbg ("error: can't open file!\n");
+			return 2;
+		}
+
+		fread (&vendor, sizeof(vendor), 1, ff);
+		fread (&device, sizeof(device), 1, ff);
+		fseek (ff, 44, SEEK_SET);
+		fread (&subvendor, sizeof(subvendor), 1, ff);
+		fread (&subdevice, sizeof(subdevice), 1, ff);
+		fseek (ff, 9, SEEK_SET);
+		fread (&pcic, sizeof(pcic), 1, ff);
+		pciclass = pcic;
+		fread (&pcic, sizeof(pcic), 1, ff);
+		pciclass |= (pcic << 8);
+		fread (&pcic, sizeof(pcic), 1, ff);
+		pciclass |= (pcic << 16);
+
+		switch (fork()) {
+			case 0:
+				/* we are the child, so lets run the program */
+				if (action == ACTION_ADD)
+					setenv ("ACTION", ADD_STRING, 1);
+				else
+					setenv ("ACTION", REMOVE_STRING, 1);
+
+				sprintf (env, "%04X:%04X", vendor, device);
+				setenv ("PCI_ID", env, 1);
+				sprintf (env, "%04X:%04X", subvendor, subdevice);
+				setenv ("PCI_SUBSYS_ID", env, 1);
+				sprintf (env, "%06lX", pciclass);
+				setenv ("PCI_CLASS", env, 1);
+
+				argv[0] = "/sbin/hotplug";
+				argv[1] = "pci";
+				argv[2] = NULL;
+
+				execv ("/sbin/hotplug", argv);
+				exit(0);
+				break;
+			case (-1):
+				dbg ("fork failed.");
+				break;
+			default:
+				break;
+		}
+		if (fclose (ff) == EOF) {
+			dbg ("error: can't close file!\n");
+			return 3;
+		}
+
+		/* drop rest of line */
+		while ( ((c = getc (f)) != '\n') && (c != EOF) );
+	}
+	if (fclose (f) == EOF) {
+		dbg ("error: can't close file!\n");
+		return 4;
+	}
+
+	return 0;
+}
+
+
+int pci_rc_start (void)
+{
+	return pci_rc_start_stop (ACTION_ADD);
+}
+
+int pci_rc_stop (void)
+{
+	return pci_rc_start_stop (ACTION_REMOVE);
+}
+
+
+static struct subsystem pci_rc_subsystem[] = {
+	{ "start", pci_rc_start },
+	{ "stop", pci_rc_stop },
+	{ NULL, NULL }
+};
+
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		printf ("Usage: %s {start|stop}\n", argv[0]);
+		return 5;
+	}
+	return call_subsystem (argv[1], pci_rc_subsystem);
+}
diff -urN diethotplug-0.4.orig/rc/usb-rc.c diethotplug-0.4/rc/usb-rc.c
--- diethotplug-0.4.orig/rc/usb-rc.c	Thu Jan  1 01:00:00 1970
+++ diethotplug-0.4/rc/usb-rc.c	Sat Jul 19 19:32:41 2003
@@ -0,0 +1,162 @@
+/*
+ * usb-rc.c      This brings the USB subsystem up and down safely.
+ *
+ * Copyright (C) 2003 David Jez <dave.jez@seznam.cz>
+ *
+ *      This program is free software; you can redistribute it and/or modify it
+ *      under the terms of the GNU General Public License as published by the
+ *      Free Software Foundation version 2 of the License.
+ *
+ *      This program is distributed in the hope that it will be useful, but
+ *      WITHOUT ANY WARRANTY; without even the implied warranty of
+ *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *      General Public License for more details.
+ *
+ *      You should have received a copy of the GNU General Public License along
+ *      with this program; if not, write to the Free Software Foundation, Inc.,
+ *      675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "../hotplug.h"
+#include "../usb_modules.h"
+
+#define PROC_CMD "/proc/cmdline"
+#define PROC_MOD "/proc/modules"
+
+#define UHCI     0
+#define USB_UHCI 1
+
+int default_uhci=USB_UHCI;
+
+
+int usb_rc_start (void)
+{
+FILE *f;
+char buf[128];
+int usb_host_controller=default_uhci;
+int status;
+
+
+	if ((f = fopen (PROC_CMD, "r")) == NULL) {
+		dbg ("error: can't open file!");
+		return 1;
+	}
+	while (!feof (f)) {
+		fscanf (f, "%127s", buf);
+		if (!strcmp (buf, "nousb")) {
+			dbg ("'nousb' kernel parametr found, exit");
+			return 2;
+		}
+		if (!strcmp (buf, "usb_host_controller=uhci")) {
+			dbg ("note: force to load uhci instead of usb-uhci ..." );
+			usb_host_controller=UHCI;
+		}
+	}
+	if (fclose (f) == EOF) {
+		dbg ("error: can't close file!");
+		return 3;
+	}
+
+	load_module ("usbcore");
+	wait (&status);
+	if (mount ("usbdevfs", "/proc/bus/usb", "usbdevfs", 0, 0) < 0)
+		dbg ("error: mount failed!");
+
+	load_module ("ehci-hcd");
+	load_module ("ohci-hcd");
+	load_module ("uhci-hcd");
+	load_module ("usb-ohci");
+	if (usb_host_controller == UHCI)
+		load_module ("uhci");
+	else
+		load_module ("usb-uhci");
+
+	return 0;
+}
+
+
+int usb_rc_stop (void)
+{
+FILE *f;
+char buf[128];
+int i;
+int status;
+
+
+	/* force unload all loaded usb modules */
+	if ((f = fopen (PROC_MOD, "r")) == NULL) {
+		dbg ("error: can't open file!");
+		return 5;
+	}
+	while (1) {
+		/* read module name */
+		fscanf (f, "%127s", buf);
+		if (feof (f))
+			break;
+		for (i = 0; usb_module_map[i].module_name != NULL; ++i)
+			if (!strcmp (buf, usb_module_map[i].module_name)) {
+				remove_module (usb_module_map[i].module_name);
+				break;
+			}
+		/* drop rest of line */
+		while ( ((buf[1] = getc (f)) != '\n') && (buf[1] != EOF) );
+	}
+	if (fclose (f) == EOF) {
+		dbg ("error: can't close file!");
+		return 6;
+	}
+
+	switch (fork()) {
+		case 0:
+			/* we are the child, so lets run the program */
+			execlp ("/sbin/rmmod", "/sbin/rmmod", "-a", 0);
+			exit(0);
+			break;
+		case (-1):
+			dbg ("fork failed.");
+			break;
+		default:
+			break;
+	}
+
+	remove_module ("uhci");
+	remove_module ("usb-uhci");
+	remove_module ("usb-ohci");
+	remove_module ("uhci-hcd");
+	remove_module ("ohci-hcd");
+	remove_module ("ehci-hcd");
+
+	if (umount ("/proc/bus/usb") < 0)
+		dbg ("error: umount failed!");
+	wait (&status);
+	remove_module ("usbcore");
+
+	return 0;
+}
+
+
+static struct subsystem usb_rc_subsystem[] = {
+	{ "start", usb_rc_start },
+	{ "stop", usb_rc_stop },
+	{ NULL, NULL }
+};
+
+
+int main(int argc, char *argv[])
+{
+	if ((argc != 2) && (argc != 3)) {
+		printf ("Usage: %s {start|stop}\n", argv[0]);
+		return 4;
+	}
+	if ((argc == 3) && (!strcmp (argv[2], "uhci"))) {
+		dbg ("note: force to load uhci instead of usb-uhci ..." );
+		default_uhci=UHCI;
+	}
+	return call_subsystem (argv[1], usb_rc_subsystem);
+}
diff -urN diethotplug-0.4.orig/usb.c diethotplug-0.4/usb.c
--- diethotplug-0.4.orig/usb.c	Wed Jan  9 20:57:29 2002
+++ diethotplug-0.4/usb.c	Sat Jul 19 19:47:38 2003
@@ -46,7 +46,7 @@
 	
 
 
-static int match_vendor_product (unsigned short vendor, unsigned short product, unsigned short bcdDevice)
+static int match_vendor_product (unsigned short vendor, unsigned short product, unsigned short bcdDevice, int action)
 {
 	int i;
 	int retval;
@@ -77,18 +77,23 @@
 				continue;
 			}
 			/* found one! */
-			dbg ("loading %s", usb_module_map[i].module_name);
-			retval = load_module (usb_module_map[i].module_name);
+			if (action == ACTION_ADD) {
+				dbg ("loading %s", usb_module_map[i].module_name);
+				retval = load_module (usb_module_map[i].module_name);
+			} else {
+				dbg ("removing %s", usb_module_map[i].module_name);
+				retval = remove_module (usb_module_map[i].module_name);
+			}
 			if (retval)
 				return retval;
 		}
 	}
 
-	return -ENODEV;
+	return 0;
 }
 	
 
-static int match_device_class (unsigned char class, unsigned char subclass, unsigned char protocol)
+static int match_device_class (unsigned char class, unsigned char subclass, unsigned char protocol, int action)
 {
 	int i;
 	int retval;
@@ -114,18 +119,23 @@
 				continue;
 			}
 			/* found one! */
-			dbg ("loading %s", usb_module_map[i].module_name);
-			retval = load_module (usb_module_map[i].module_name);
+			if (action == ACTION_ADD) {
+				dbg ("loading %s", usb_module_map[i].module_name);
+				retval = load_module (usb_module_map[i].module_name);
+			} else {
+				dbg ("removing %s", usb_module_map[i].module_name);
+				retval = remove_module (usb_module_map[i].module_name);
+			}
 			if (retval)
 				return retval;
 		}
 	}
 
-	return -ENODEV;
+	return 0;
 }
 
 
-static int match_interface_class (unsigned char class, unsigned char subclass, unsigned char protocol)
+static int match_interface_class (unsigned char class, unsigned char subclass, unsigned char protocol, int action)
 {
 	int i;
 	int retval;
@@ -151,18 +161,23 @@
 				continue;
 			}
 			/* found one! */
-			dbg ("loading %s", usb_module_map[i].module_name);
-			retval = load_module (usb_module_map[i].module_name);
+			if (action == ACTION_ADD) {
+				dbg ("loading %s", usb_module_map[i].module_name);
+				retval = load_module (usb_module_map[i].module_name);
+			} else {
+				dbg ("removing %s", usb_module_map[i].module_name);
+				retval = remove_module (usb_module_map[i].module_name);
+			}
 			if (retval)
 				return retval;
 		}
 	}
 
-	return -ENODEV;
+	return 0;
 }
 
 
-static int usb_add (void)
+static int usb_add_remove (int action)
 {
 	char *product_env;
 	char *type_env;
@@ -189,7 +204,7 @@
 	if (error)
 		return error;
 
-	error = match_vendor_product (idVendor, idProduct, bcdDevice);
+	error = match_vendor_product (idVendor, idProduct, bcdDevice, action);
 	if (error)
 		return error;
 	
@@ -199,7 +214,7 @@
 		return error;
 	error = match_device_class ((unsigned char)device_class,
 				    (unsigned char)device_subclass,
-				    (unsigned char)device_protocol);
+				    (unsigned char)device_protocol, action);
 	if (error)
 		return error;
 
@@ -215,15 +230,21 @@
 		return error;
 	error = match_interface_class ((unsigned char)interface_class,
 				       (unsigned char)interface_subclass,
-				       (unsigned char)interface_protocol);
+				       (unsigned char)interface_protocol,
+				       action);
 	return error;
 }
 
 
+static int usb_add (void)
+{
+	return usb_add_remove (ACTION_ADD);
+}
+
+
 static int usb_remove (void)
 {
-	/* right now we don't do anything here :) */
-	return 0;
+	return usb_add_remove (ACTION_REMOVE);
 }
 
 
@@ -247,5 +268,3 @@
 
 	return call_subsystem (action, usb_subsystem);
 }
-
-
diff -urN diethotplug-0.4.orig/util.c diethotplug-0.4/util.c
--- diethotplug-0.4.orig/util.c	Wed Jan  9 20:57:29 2002
+++ diethotplug-0.4/util.c	Sat Jul 19 19:32:41 2003
@@ -209,3 +209,27 @@
 	return 0;
 }
 
+
+int remove_module (const char *module_name)
+{
+	char *argv[4];
+
+	argv[0] = "/sbin/rmmod";
+	argv[1] = "-r";
+	argv[2] = (char *)module_name;
+	argv[3] = NULL;
+	dbg ("removing module %s", module_name);
+	switch (fork()) {
+		case 0:
+			/* we are the child, so lets run the program */
+			execv ("/sbin/rmmod", argv);
+			exit(0);
+			break;
+		case (-1):
+			dbg ("fork failed.");
+			break;
+		default:
+			break;
+	}
+	return 0;
+}

--0F1p//8PRICkK4MW--
