Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRIPKS5>; Sun, 16 Sep 2001 06:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271645AbRIPKSu>; Sun, 16 Sep 2001 06:18:50 -0400
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:22282 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S271498AbRIPKSj>; Sun, 16 Sep 2001 06:18:39 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: Kristian Hogsberg <hogsberg@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] modutils: ieee1394 device_id extraction
In-Reply-To: <29177.1000629997@ocs3.intra.ocs.com.au>
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 16 Sep 2001 12:18:53 +0200
In-Reply-To: <29177.1000629997@ocs3.intra.ocs.com.au>
Message-ID: <m3pu8rh20i.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 16-09-2001 12:19:00,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 16-09-2001 12:19:02,
	Serialize complete at 16-09-2001 12:19:02
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> On 15 Sep 2001 18:02:10 +0200, 
> Kristian Hogsberg <hogsberg@users.sf.net> wrote:
> >I've been adding hotplug support to the ieee1394 subsystem, and the
> >ieee1394 stack in cvs now calls the usermode helper just like usb, pci
> >and the rest of them.  Next step is to extend depmod so it extracts
> >the device id tables from the 1394 device drivers, which is exactly
> >what the patch below does.
> >
> >Keith, would you apply this to modutils?
> 
> Patch looks OK, expect that sometimes you use hpsb and sometimes
> ieee1394 as a prefix for variable names.  Can they all be iee1394,
> including the device table?  Use MODULE_DEVICE_TABLE(ieee1394,name)
> instead of MODULE_DEVICE_TABLE(hpsb, name).

Ok, the patch below changes this.  Within the drivers, though, hpsb
(High Performance Serial Bus) is used, but I believe ieee1394 is more
widely recognized.

Kristian


diff -ur modutils-2.4.8/depmod/depmod.c modutils-2.4.8-ieee1394/depmod/depmod.c
--- modutils-2.4.8/depmod/depmod.c	Wed Aug 22 07:13:56 2001
+++ modutils-2.4.8-ieee1394/depmod/depmod.c	Sun Sep 16 11:38:03 2001
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
+unsigned int ieee1394_device_id_ver;
+
+struct ieee1394_device_id {
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
+	struct ieee1394_device_id *ieee1394_device;
+	int n_ieee1394_device;
 } MODULE;
 
 typedef enum SYM_STATUS {
@@ -646,6 +668,41 @@
 }
 
 /*
+ *	Extract any ieee1394_device_table from the module.
+ *	Note: assumes same machine and arch for depmod and module.
+ */
+static void extract_ieee1394_device_id(struct obj_file *f, void *image, unsigned long m_size, MODULE *mod)
+{
+	struct ieee1394_device_id ieee1394_device, *latest;
+	ElfW(Addr) ref_ieee1394, ref_ref_ieee1394;
+	unsigned tgt_long ieee1394_device_size;
+	ref_ieee1394 = obj_symbol_final_value(f, obj_find_symbol(f, "__module_ieee1394_device_size"));
+	if (!in_range(f, m_size, ref_ieee1394, sizeof(ieee1394_device_size)))
+		return;
+	memcpy(&ieee1394_device_size, (char *)image + ref_ieee1394 - f->baseaddr, sizeof(ieee1394_device_size));
+	ref_ref_ieee1394 = obj_symbol_final_value(f, obj_find_symbol(f, "__module_ieee1394_device_table"));
+	if (!in_range(f, m_size, ref_ref_ieee1394, sizeof(ref_ieee1394)))
+		return;
+	memcpy(&ref_ieee1394, (char *)image + ref_ref_ieee1394 - f->baseaddr, sizeof(ref_ieee1394));
+	extract_version(f, image, m_size, "ieee1394_device", &ieee1394_device_id_ver, 1, 1);
+	if (ieee1394_device_size != sizeof(ieee1394_device)) {
+		error("Unexpected value (%" tgt_long_fmt "d) in '%s' for ieee1394_device_size%s",
+		ieee1394_device_size, f->filename, has_kernel_changed);
+		exit(-1);
+	}
+	while (in_range(f, m_size, ref_ieee1394, ieee1394_device_size)) {
+		memset(&ieee1394_device, 0, sizeof(ieee1394_device));
+		memcpy(&ieee1394_device, (char *)image + ref_ieee1394 - f->baseaddr, ieee1394_device_size);
+		ref_ieee1394 += ieee1394_device_size;
+		if (ieee1394_device.match_flags == 0)
+			break;
+		mod->ieee1394_device = xrealloc(mod->ieee1394_device, ++(mod->n_ieee1394_device)*sizeof(*(mod->ieee1394_device)));
+		latest = mod->ieee1394_device + mod->n_ieee1394_device-1;
+		*latest = ieee1394_device;
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
+	extract_ieee1394_device_id(f, image, m_size, mod);
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
+		struct ieee1394_device_id *ieee1394_device = ptmod->ieee1394_device;
+		if (!ptmod->n_ieee1394_device)
+			continue;
+		for (j = 0; j < ptmod->n_ieee1394_device; j++, ieee1394_device++) {
+			fprintf(ieee1394map, "%-20s 0x%08x  0x%06x  0x%06x 0x%06x     0x%06x\n", 
+				shortname(ptmod->name),
+				ieee1394_device->match_flags,
+				ieee1394_device->vendor_id,
+				ieee1394_device->model_id,
+				ieee1394_device->specifier_id,
+				ieee1394_device->version);
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
Only in modutils-2.4.8-ieee1394/depmod: depmod.c.orig
Only in modutils-2.4.8-ieee1394/depmod: depmod.c~
diff -ur modutils-2.4.8/include/config.h modutils-2.4.8-ieee1394/include/config.h
--- modutils-2.4.8/include/config.h	Fri Jan  5 02:45:19 2001
+++ modutils-2.4.8-ieee1394/include/config.h	Sat Sep 15 16:52:52 2001
@@ -92,6 +92,7 @@
 	GEN_ISAPNPMAPFILE,
 	GEN_USBMAPFILE,
 	GEN_PARPORTMAPFILE,
+	GEN_IEEE1394MAPFILE,
 	GEN_DEPFILE,
 };
 
diff -ur modutils-2.4.8/util/alias.h modutils-2.4.8-ieee1394/util/alias.h
--- modutils-2.4.8/util/alias.h	Thu Aug 16 14:12:26 2001
+++ modutils-2.4.8-ieee1394/util/alias.h	Sat Sep 15 16:52:52 2001
@@ -247,6 +247,7 @@
 	"modules.isapnpmap",
 	"modules.usbmap",
 	"modules.parportmap",
+	"modules.ieee1394map",
 	"System.map",
 	".config",
 	"build",		/* symlink to source tree */
Only in modutils-2.4.8-ieee1394/util: alias.h.orig
diff -ur modutils-2.4.8/util/config.c modutils-2.4.8-ieee1394/util/config.c
--- modutils-2.4.8/util/config.c	Sun Mar 25 13:13:48 2001
+++ modutils-2.4.8-ieee1394/util/config.c	Sat Sep 15 16:52:52 2001
@@ -116,6 +116,7 @@
 	{"isapnpmap", NULL, 0},
 	{"usbmap", NULL, 0},
 	{"parportmap", NULL, 0},
+	{"ieee1394map", NULL, 0},
 	{"dep", NULL, 0},
 };
 


