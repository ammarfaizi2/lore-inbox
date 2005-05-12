Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVELIUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVELIUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVELIUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:20:37 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:1052
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261305AbVELIUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:20:13 -0400
Message-Id: <s2831fcc.039@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:20:25 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] allow early printk to use more than 25 lines
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part6142ADD9.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part6142ADD9.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Allow early printk code to take advantage of the full size of the screen,
not just the first 25 lines.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/arch/x86_64/kernel/early_printk.c =
linux-2.6.12-rc4/arch/x86_64/kernel/early_printk.c
--- linux-2.6.12-rc4.base/arch/x86_64/kernel/early_printk.c	2005-05-11 =
17:27:54.819859960 +0200
+++ linux-2.6.12-rc4/arch/x86_64/kernel/early_printk.c	2005-05-11 =
17:50:36.252890680 +0200
@@ -2,20 +2,24 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/tty.h>
 #include <asm/io.h>
 #include <asm/processor.h>
=20
 /* Simple VGA output */
=20
 #ifdef __i386__
+#include <asm/setup.h>
 #define VGABASE		(__ISA_IO_base + 0xb8000)
 #else
+#include <asm/bootsetup.h>
 #define VGABASE		((void __iomem *)0xffffffff800b8000UL)
 #endif
=20
-#define MAX_YPOS	25
-#define MAX_XPOS	80
+#define MAX_YPOS	max_ypos
+#define MAX_XPOS	max_xpos
=20
+static int max_ypos =3D 25, max_xpos =3D 80;
 static int current_ypos =3D 1, current_xpos =3D 0;=20
=20
 static void early_vga_write(struct console *con, const char *str, =
unsigned n)
@@ -196,7 +200,10 @@ int __init setup_early_printk(char *opt)
 	} else if (!strncmp(buf, "ttyS", 4)) {=20
 		early_serial_init(buf);
 		early_console =3D &early_serial_console;	=09
-	} else if (!strncmp(buf, "vga", 3)) {
+	} else if (!strncmp(buf, "vga", 3)
+	           && SCREEN_INFO.orig_video_isVGA =3D=3D 1) {
+		max_xpos =3D SCREEN_INFO.orig_video_cols;
+		max_ypos =3D SCREEN_INFO.orig_video_lines;
 		early_console =3D &early_vga_console;=20
 	}
 	early_console_initialized =3D 1;



--=__Part6142ADD9.1__=
Content-Type: text/plain; name="linux-2.6.12-rc4-early-printk.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-early-printk.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Allow early printk code to take advantage of the full size of the screen,
not just the first 25 lines.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/arch/x86_64/kernel/early_printk.c linux-2.6.12-rc4/arch/x86_64/kernel/early_printk.c
--- linux-2.6.12-rc4.base/arch/x86_64/kernel/early_printk.c	2005-05-11 17:27:54.819859960 +0200
+++ linux-2.6.12-rc4/arch/x86_64/kernel/early_printk.c	2005-05-11 17:50:36.252890680 +0200
@@ -2,20 +2,24 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/tty.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 
 /* Simple VGA output */
 
 #ifdef __i386__
+#include <asm/setup.h>
 #define VGABASE		(__ISA_IO_base + 0xb8000)
 #else
+#include <asm/bootsetup.h>
 #define VGABASE		((void __iomem *)0xffffffff800b8000UL)
 #endif
 
-#define MAX_YPOS	25
-#define MAX_XPOS	80
+#define MAX_YPOS	max_ypos
+#define MAX_XPOS	max_xpos
 
+static int max_ypos = 25, max_xpos = 80;
 static int current_ypos = 1, current_xpos = 0; 
 
 static void early_vga_write(struct console *con, const char *str, unsigned n)
@@ -196,7 +200,10 @@ int __init setup_early_printk(char *opt)
 	} else if (!strncmp(buf, "ttyS", 4)) { 
 		early_serial_init(buf);
 		early_console = &early_serial_console;		
-	} else if (!strncmp(buf, "vga", 3)) {
+	} else if (!strncmp(buf, "vga", 3)
+	           && SCREEN_INFO.orig_video_isVGA == 1) {
+		max_xpos = SCREEN_INFO.orig_video_cols;
+		max_ypos = SCREEN_INFO.orig_video_lines;
 		early_console = &early_vga_console; 
 	}
 	early_console_initialized = 1;

--=__Part6142ADD9.1__=--
