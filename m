Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVBFH4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVBFH4B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272664AbVBFH4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:56:01 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:9100 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271863AbVBFHza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:55:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] module-init-tools: generate modules.seriomap
Date: Sun, 6 Feb 2005 02:55:29 -0500
User-Agent: KMail/1.7.2
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.de>, Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502060255.30088.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

I have converted serio bus to use ID matching and changed serio drivers
to use MODULE_DEVICE_TABLE. Now that Vojtech pulled the changes into his
tree it would be nice if official module-init-tools generated the module
map so that hotplug scripts could automatically load proper drivers.

Please consider applying the patch below.

Thanks!

-- 
Dmitry

diff -urN module-init-tools-3.1-pre5/depmod.c module-init-tools/depmod.c
--- module-init-tools-3.1-pre5/depmod.c	2004-06-30 23:24:40.000000000 -0500
+++ module-init-tools/depmod.c	2005-01-23 01:16:04.000000000 -0500
@@ -683,6 +683,7 @@
 	{ "modules.ieee1394map", output_ieee1394_table },
 	{ "modules.isapnpmap", output_isapnp_table },
 	{ "modules.inputmap", output_input_table },
+	{ "modules.seriomap", output_serio_table },
 	{ "modules.alias", output_aliases },
 	{ "modules.symbols", output_symbols },
 };
diff -urN module-init-tools-3.1-pre5/depmod.h module-init-tools/depmod.h
--- module-init-tools-3.1-pre5/depmod.h	2003-12-23 21:10:57.000000000 -0500
+++ module-init-tools/depmod.h	2005-01-23 01:17:17.000000000 -0500
@@ -47,6 +47,8 @@
 	void *pnp_card_table;
 	unsigned int input_size;
 	void *input_table;
+	unsigned int serio_size;
+	void *serio_table;
 
 	/* File contents and length. */
 	void *data;
diff -urN module-init-tools-3.1-pre5/moduleops_core.c module-init-tools/moduleops_core.c
--- module-init-tools-3.1-pre5/moduleops_core.c	2004-05-23 22:01:48.000000000 -0500
+++ module-init-tools/moduleops_core.c	2005-01-23 01:43:21.000000000 -0500
@@ -196,6 +196,10 @@
 	module->input_size = PERBIT(INPUT_DEVICE_SIZE);
 	module->input_table = PERBIT(deref_sym)(module->data,
 					"__mod_input_device_table");
+
+	module->serio_size = PERBIT(SERIO_DEVICE_SIZE);
+	module->serio_table = PERBIT(deref_sym)(module->data,
+					"__mod_serio_device_table");
 }
 
 struct module_ops PERBIT(mod_ops) = {
diff -urN module-init-tools-3.1-pre5/tables.c module-init-tools/tables.c
--- module-init-tools-3.1-pre5/tables.c	2003-12-24 00:23:38.000000000 -0500
+++ module-init-tools/tables.c	2005-01-23 01:13:24.000000000 -0500
@@ -340,3 +340,36 @@
 		}
 	}
 }
+
+static void output_serio_entry(struct serio_device_id *serio, char *name, FILE *out)
+{
+	fprintf(out,
+		"%-20s 0x%02x 0x%02x  0x%02x 0x%02x\n",
+		name,
+		serio->type,
+		serio->extra,
+		serio->id,
+		serio->proto);
+}
+
+
+void output_serio_table(struct module *modules, FILE *out)
+{
+	struct module *i;
+
+	fprintf(out, "# serio module       type extra id   proto\n");
+
+	for (i = modules; i; i = i->next) {
+		struct serio_device_id *e;
+		char shortname[strlen(i->pathname) + 1];
+
+		if (!i->serio_table)
+			continue;
+
+		make_shortname(shortname, i->pathname);
+		for (e = i->serio_table; e->type || e->proto; e = (void *)e + i->serio_size)
+			output_serio_entry(e, shortname, out);
+	}
+}
+
+
diff -urN module-init-tools-3.1-pre5/tables.h module-init-tools/tables.h
--- module-init-tools-3.1-pre5/tables.h	2003-12-24 00:18:54.000000000 -0500
+++ module-init-tools/tables.h	2005-01-23 01:21:48.000000000 -0500
@@ -116,6 +116,15 @@
 #define INPUT_DEVICE_SIZE32 (4 + 4 * 2 + 4 + 16 * 4 + 4 + 2 * 4 + 4 + 4 + 4 + 4 * 4 + 4)
 #define INPUT_DEVICE_SIZE64 (8 + 4 * 2 + 8 + 8 * 8 + 8 + 8 + 8 + 8 + 8 + 2 * 8 + 8)
 
+struct serio_device_id {
+	unsigned char type;
+	unsigned char extra;
+	unsigned char id;
+	unsigned char proto;
+};
+#define SERIO_DEVICE_SIZE32 (4 * 1)
+#define SERIO_DEVICE_SIZE64 (4 * 1 + 4)
+
 /* Functions provided by tables.c */
 struct module;
 void output_usb_table(struct module *modules, FILE *out);
@@ -124,5 +133,6 @@
 void output_ccw_table(struct module *modules, FILE *out);
 void output_isapnp_table(struct module *modules, FILE *out);
 void output_input_table(struct module *modules, FILE *out);
+void output_serio_table(struct module *modules, FILE *out);
 
 #endif /* MODINITTOOLS_TABLES_H */
