Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264852AbUFHGer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264852AbUFHGer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUFHGer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:34:47 -0400
Received: from mail.donpac.ru ([80.254.111.2]:2695 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264852AbUFHGeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:34:19 -0400
Date: Tue, 8 Jun 2004 10:34:17 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-ID: <20040608063417.GB19170@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org> <20040607124125.GT3776@pazke> <20040607220157.1e67ec39.akpm@osdl.org> <20040608051808.GA19170@pazke> <20040607222513.6bebcbb6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <20040607222513.6bebcbb6.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 159, 06 07, 2004 at 10:25:13 -0700, Andrew Morton wrote:
> Andrey Panin <pazke@donpac.ru> wrote:
> >
> > On 159, 06 07, 2004 at 10:01:57 -0700, Andrew Morton wrote:
> > > Andrey Panin <pazke@donpac.ru> wrote:
> > > >
> > > > Could you apply attached patch (only exports DMI check functions) instead of them ?
> > > 
> > > I'll need a better description of what it does, please.
> > 
> > This patch creates and exports 2 functions which can be used
> > by the rest of kernel code to perform DMI data checks:
> 
> Thanks.  Could you please regenerate a new diff?  The last one I had
> doesn't seem to apply.

Patch rediffed agains 2.6.7-rc2-mm2 attached.

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-dmi-api-2.6.7-rc2-mm2"

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc2-mm2.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc2-mm2/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc2-mm2.vanilla/arch/i386/kernel/dmi_scan.c	2004-06-08 10:13:50.000000000 +0400
+++ linux-2.6.7-rc2-mm2/arch/i386/kernel/dmi_scan.c	2004-06-08 10:22:41.000000000 +0400
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <linux/pm.h>
 #include <asm/system.h>
+#include <linux/dmi.h>
 #include <linux/bootmem.h>
 
 unsigned long dmi_broken;
@@ -142,21 +143,6 @@ static int __init dmi_iterate(void (*dec
 	return -1;
 }
 
-
-enum
-{
-	DMI_BIOS_VENDOR,
-	DMI_BIOS_VERSION,
-	DMI_BIOS_DATE,
-	DMI_SYS_VENDOR,
-	DMI_PRODUCT_NAME,
-	DMI_PRODUCT_VERSION,
-	DMI_BOARD_VENDOR,
-	DMI_BOARD_NAME,
-	DMI_BOARD_VERSION,
-	DMI_STRING_MAX
-};
-
 static char *dmi_ident[DMI_STRING_MAX];
 
 /*
@@ -179,26 +165,11 @@ static void __init dmi_save_ident(struct
 }
 
 /*
- *	DMI callbacks for problem boards
+ * Ugly compatibility crap.
  */
-
-struct dmi_strmatch
-{
-	u8 slot;
-	char *substr;
-};
-
-#define NONE	255
-
-struct dmi_blacklist
-{
-	int (*callback)(struct dmi_blacklist *);
-	char *ident;
-	struct dmi_strmatch matches[4];
-};
-
-#define NO_MATCH	{ NONE, NULL}
-#define MATCH(a,b)	{ a, b }
+#define dmi_blacklist	dmi_system_id
+#define NO_MATCH	{ DMI_NONE, NULL}
+#define MATCH		DMI_MATCH
 
 /* 
  * Reboot options and system auto-detection code provided by
@@ -1078,9 +1049,6 @@ static __initdata struct dmi_blacklist d
 
 static __init void dmi_check_blacklist(void)
 {
-	struct dmi_blacklist *d;
-	int i;
-		
 #ifdef	CONFIG_ACPI_BOOT
 #define	ACPI_BLACKLIST_CUTOFF_YEAR	2001
 
@@ -1102,25 +1070,7 @@ static __init void dmi_check_blacklist(v
 		}
 	}
 #endif
-
-	d=&dmi_blacklist[0];
-	while(d->callback)
-	{
-		for(i=0;i<4;i++)
-		{
-			int s = d->matches[i].slot;
-			if(s==NONE)
-				continue;
-			if(dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
-				continue;
-			/* No match */
-			goto fail;
-		}
-		if(d->callback(d))
-			return;
-fail:			
-		d++;
-	}
+ 	dmi_check_system(dmi_blacklist);
 }
 
 	
@@ -1187,3 +1137,52 @@ void __init dmi_scan_machine(void)
 }
 
 EXPORT_SYMBOL(is_unsafe_smbus);
+
+
+/**
+ *	dmi_check_system - check system DMI data
+ *	@list: array of dmi_system_id structures to match against
+ *
+ *	Walk the blacklist table running matching functions until someone
+ *	returns non zero or we hit the end. Callback function is called for
+ *	each successfull match. Returns the number of matches.
+ */
+int dmi_check_system(struct dmi_system_id *list)
+{
+	int i, count = 0;
+	struct dmi_system_id *d = list;
+
+	while (d->ident) {
+		for (i = 0; i < ARRAY_SIZE(d->matches); i++) {
+			int s = d->matches[i].slot;
+			if (s == DMI_NONE)
+				continue;
+			if (dmi_ident[s] && strstr(dmi_ident[s], d->matches[i].substr))
+				continue;
+			/* No match */
+			goto fail;
+		}
+		if (d->callback && d->callback(d))
+			break;
+		count++;
+fail:		d++;
+	}
+
+	return count;
+}
+
+EXPORT_SYMBOL(dmi_check_system);
+
+/**
+ *	dmi_get_system_info - return DMI data value
+ *	@field: data index (see enum dmi_filed)
+ *
+ *	Returns one DMI data value, can be used to perform
+ *	complex DMI data checks.
+ */
+char * dmi_get_system_info(int field)
+{
+	return dmi_ident[field];
+}
+
+EXPORT_SYMBOL(dmi_get_system_info);
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc2-mm2.vanilla/include/linux/dmi.h linux-2.6.7-rc2-mm2/include/linux/dmi.h
--- linux-2.6.7-rc2-mm2.vanilla/include/linux/dmi.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6.7-rc2-mm2/include/linux/dmi.h	2004-06-08 10:22:41.000000000 +0400
@@ -0,0 +1,47 @@
+#ifndef __DMI_H__
+#define __DMI_H__
+
+enum dmi_field {
+	DMI_NONE,
+	DMI_BIOS_VENDOR,
+	DMI_BIOS_VERSION,
+	DMI_BIOS_DATE,
+	DMI_SYS_VENDOR,
+	DMI_PRODUCT_NAME,
+	DMI_PRODUCT_VERSION,
+	DMI_BOARD_VENDOR,
+	DMI_BOARD_NAME,
+	DMI_BOARD_VERSION,
+	DMI_STRING_MAX,
+};
+
+/*
+ *	DMI callbacks for problem boards
+ */
+struct dmi_strmatch {
+	u8 slot;
+	char *substr;
+};
+
+struct dmi_system_id {
+	int (*callback)(struct dmi_system_id *);
+	char *ident;
+	struct dmi_strmatch matches[4];
+	void *driver_data;
+};
+
+#define DMI_MATCH(a,b)	{ a, b }
+
+#if defined(CONFIG_X86) && !defined(CONFIG_X86_64)
+
+extern int dmi_check_system(struct dmi_system_id *list);
+extern char * dmi_get_system_info(int field);
+
+#else
+
+static inline int dmi_check_system(struct dmi_system_id *list) { return 0; }
+static inline char * dmi_get_system_info(int field) { return NULL; }
+
+#endif
+
+#endif	/* __DMI_H__ */

--2JFBq9zoW8cOFH7v--
