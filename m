Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272374AbRIOQCR>; Sat, 15 Sep 2001 12:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272375AbRIOQCI>; Sat, 15 Sep 2001 12:02:08 -0400
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:60425 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S272374AbRIOQB7>; Sat, 15 Sep 2001 12:01:59 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [PATCH] modutils: ieee1394 device_id extraction
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 15 Sep 2001 18:02:10 +0200
Message-ID: <m38zfgmohp.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 15-09-2001 18:02:15,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 15-09-2001 18:02:22,
	Serialize complete at 15-09-2001 18:02:22
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've been adding hotplug support to the ieee1394 subsystem, and the
ieee1394 stack in cvs now calls the usermode helper just like usb, pci
and the rest of them.  Next step is to extend depmod so it extracts
the device id tables from the 1394 device drivers, which is exactly
what the patch below does.

Keith, would you apply this to modutils?

Thanks,
Kristian


diff -ur modutils-2.4.8/depmod/depmod.c modutils-2.4.8-hpsb/depmod/depmod.c
--- modutils-2.4.8/depmod/depmod.c	Wed Aug 22 07:13:56 2001
+++ modutils-2.4.8-hpsb/depmod/depmod.c	Sat Sep 15 17:35:08 2001
@@ -182,6 +182,26 @@
 	ElfW(Addr) pattern;
 };
 
+/* Device tables for ieee1394 devices.
+ * Added sep. 15, 2001, Kristian Hogsberg <hogsberg@users.sf.net>.
+ * See linux/drivers/ieee1394/ieee1394_hotplug.h
+ */
+
+#ifndef u32
+#define u32 u_int32_t
+#endif
+
+unsigned int hpsb_device_id_ver;
+
+struct hpsb_device_id {
+	u32 match_flags;
+	u32 vendor_id;
+	u32 model_id;
+	u32 specifier_id;
+	u32 version;
+	void *driver_data;
+};
+
 typedef struct MODULE {
 	char *name;
 	int resolved;
@@ -201,6 +221,8 @@
 	int n_usb_device;
 	struct parport_device_id *parport_device;
 	int n_parport_device;
+	struct hpsb_device_id *hpsb_device;
+	int n_hpsb_device;
 } MODULE;
 
 typedef enum SYM_STATUS {
@@ -646,6 +668,41 @@
 }
 
 /*
+ *	Extract any hpsb_device_table from the module.
+ *	Note: assumes same machine and arch for depmod and module.
+ */
+static void extract_hpsb_device_id(struct obj_file *f, void *image, unsigned long m_size, MODULE *mod)
+{
+	struct hpsb_device_id hpsb_device, *latest;
+	ElfW(Addr) ref_hpsb, ref_ref_hpsb;
+	unsigned tgt_long hpsb_device_size;
+	ref_hpsb = obj_symbol_final_value(f, obj_find_symbol(f, "__module_hpsb_device_size"));
+	if (!in_range(f, m_size, ref_hpsb, sizeof(hpsb_device_size)))
+		return;
+	memcpy(&hpsb_device_size, (char *)image + ref_hpsb - f->baseaddr, sizeof(hpsb_device_size));
+	ref_ref_hpsb = obj_symbol_final_value(f, obj_find_symbol(f, "__module_hpsb_device_table"));
+	if (!in_range(f, m_size, ref_ref_hpsb, sizeof(ref_hpsb)))
+		return;
+	memcpy(&ref_hpsb, (char *)image + ref_ref_hpsb - f->baseaddr, sizeof(ref_hpsb));
+	extract_version(f, image, m_size, "hpsb_device", &hpsb_device_id_ver, 1, 1);
+	if (hpsb_device_size != sizeof(hpsb_device)) {
+		error("Unexpected value (%" tgt_long_fmt "d) in '%s' for hpsb_device_size%s",
+		hpsb_device_size, f->filename, has_kernel_changed);
+		exit(-1);
+	}
+	while (in_range(f, m_size, ref_hpsb, hpsb_device_size)) {
+		memset(&hpsb_device, 0, sizeof(hpsb_device));
+		memcpy(&hpsb_device, (char *)image + ref_hpsb - f->baseaddr, hpsb_device_size);
+		ref_hpsb += hpsb_device_size;
+		if (hpsb_device.match_flags == 0)
+			break;
+		mod->hpsb_device = xrealloc(mod->hpsb_device, ++(mod->n_hpsb_device)*sizeof(*(mod->hpsb_device)));
+		latest = mod->hpsb_device + mod->n_hpsb_device-1;
+		*latest = hpsb_device;
+	}
+}
+
+/*
  *	Read the symbols in an object and register them in the symbol table.
  *	Return -1 if there is an error.
  */
@@ -827,6 +884,7 @@
 	extract_isapnp_card_id(f, image, m_size, mod);
 	extract_usb_device_id(f, image, m_size, mod);
 	extract_parport_device_id(f, image, m_size, mod);
+	extract_hpsb_device_id(f, image, m_size, mod);
 	free(image);
 
 	obj_free(f);
@@ -1025,6 +1083,7 @@
 	FILE *isapnpmap = stdout;
 	FILE *usbmap = stdout;
 	FILE *parportmap = stdout;
+	FILE *ieee1394map = stdout;
 	MODULE **tbdep;
 	MODULE *ptmod;
 	int i;
@@ -1038,6 +1097,7 @@
 		isapnpmap = gen_file_open(gen_file+GEN_ISAPNPMAPFILE);
 		usbmap = gen_file_open(gen_file+GEN_USBMAPFILE);
 		parportmap = gen_file_open(gen_file+GEN_PARPORTMAPFILE);
+		ieee1394map = gen_file_open(gen_file+GEN_IEEE1394MAPFILE);
 	}
 
 	skipchars = strlen(base_dir);
@@ -1216,6 +1276,27 @@
 		}
 	}
 
+	ptmod = modules;
+	fprintf(ieee1394map, "# ieee1394 module    ");
+	/* Requires all users to be on kernel 2.4.0 or later */
+	fprintf(ieee1394map, "match_flags ");
+	fprintf(ieee1394map, "vendor_id model_id specifier_id version\n");
+	for (i = 0; i < n_modules; i++, ptmod++) {
+		int j;
+		struct hpsb_device_id *hpsb_device = ptmod->hpsb_device;
+		if (!ptmod->n_hpsb_device)
+			continue;
+		for (j = 0; j < ptmod->n_hpsb_device; j++, hpsb_device++) {
+			fprintf(ieee1394map, "%-20s 0x%08x  0x%06x  0x%06x 0x%06x     0x%06x\n", 
+				shortname(ptmod->name),
+				hpsb_device->match_flags,
+				hpsb_device->vendor_id,
+				hpsb_device->model_id,
+				hpsb_device->specifier_id,
+				hpsb_device->version);
+		}
+	}
+
 	if (generic_string != stdout)
 		fclose(generic_string);
 	if (pcimap != stdout)
@@ -1225,6 +1306,8 @@
 	if (usbmap != stdout)
 		fclose(usbmap);
 	if (parportmap != stdout)
+		fclose(parportmap);
+	if (ieee1394map != stdout)
 		fclose(parportmap);
 	/* Close depfile last, it's timestamp is critical */
 	if (dep != stdout)
Only in modutils-2.4.8-hpsb/depmod: depmod.c.orig
Only in modutils-2.4.8-hpsb/depmod: depmod.c~
diff -ur modutils-2.4.8/include/config.h modutils-2.4.8-hpsb/include/config.h
--- modutils-2.4.8/include/config.h	Fri Jan  5 02:45:19 2001
+++ modutils-2.4.8-hpsb/include/config.h	Sat Sep 15 16:52:52 2001
@@ -92,6 +92,7 @@
 	GEN_ISAPNPMAPFILE,
 	GEN_USBMAPFILE,
 	GEN_PARPORTMAPFILE,
+	GEN_IEEE1394MAPFILE,
 	GEN_DEPFILE,
 };
 
diff -ur modutils-2.4.8/util/alias.h modutils-2.4.8-hpsb/util/alias.h
--- modutils-2.4.8/util/alias.h	Thu Aug 16 14:12:26 2001
+++ modutils-2.4.8-hpsb/util/alias.h	Sat Sep 15 16:52:52 2001
@@ -247,6 +247,7 @@
 	"modules.isapnpmap",
 	"modules.usbmap",
 	"modules.parportmap",
+	"modules.ieee1394map",
 	"System.map",
 	".config",
 	"build",		/* symlink to source tree */
Only in modutils-2.4.8-hpsb/util: alias.h.orig
diff -ur modutils-2.4.8/util/config.c modutils-2.4.8-hpsb/util/config.c
--- modutils-2.4.8/util/config.c	Sun Mar 25 13:13:48 2001
+++ modutils-2.4.8-hpsb/util/config.c	Sat Sep 15 16:52:52 2001
@@ -116,6 +116,7 @@
 	{"isapnpmap", NULL, 0},
 	{"usbmap", NULL, 0},
 	{"parportmap", NULL, 0},
+	{"ieee1394map", NULL, 0},
 	{"dep", NULL, 0},
 };
 

