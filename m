Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWFRPsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWFRPsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWFRPsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:48:00 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751188AbWFRPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:47:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=lEUVWKn735f64KVlZIrv7g2b1I7YyIZOLIj8pD4i5qP3XnGkf6vvED9HsKFpubMF1aAMU9aFmuXZsxwyELZ9qWZ/dWCmSIuxr1UcZrpLBnfL6+tIJyQCTEo+uOKSokqfUOLxHMLlfBI5edHuTDtEBrCBAxHq90l3OTyhnUp90NQ=
Message-ID: <44957026.2020405@gmail.com>
Date: Sun, 18 Jun 2006 23:24:22 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To enable this feature, CONFIG_VT_HW_CONSOLE_BINDING must be set to 'y'. This
feature will default to 'n' to minimize users accidentally corrupting their
virtual terminals.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/char/Kconfig |   17 +++++++++++++++++
 drivers/char/vt.c    |   43 +++++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 29afe21..336aa31 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -62,6 +62,23 @@ config HW_CONSOLE
 	depends on VT && !S390 && !UML
 	default y
 
+config VT_HW_CONSOLE_BINDING
+       bool "Support for binding and unbinding console drivers"
+       depends on HW_CONSOLE
+       default n
+       ---help---
+         The virtual terminal is the device that interacts with the physical
+         terminal through console drivers. On these systems, at least one
+         console driver is loaded. In other configurations, additional console
+         drivers may be enabled, such as the framebuffer console. If more than
+         1 console driver is enabled, setting this to 'y' will allow you to
+         select the console driver that will serve as the backend for the
+         virtual terminals.
+
+	 See <file:Documentation/console/console.txt> for more
+	 information. For framebuffer console users, please refer to
+	 <file:Documentation/fb/fbcon.txt>.
+
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
 	---help---
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index d0cc421..1d98151 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2691,22 +2691,6 @@ #include <linux/device.h>
 
 static struct class *vtconsole_class;
 
-static int con_is_graphics(const struct consw *csw, int first, int last)
-{
-	int i, retval = 0;
-
-	for (i = first; i <= last; i++) {
-		struct vc_data *vc = vc_cons[i].d;
-
-		if (vc && vc->vc_mode == KD_GRAPHICS) {
-			retval = 1;
-			break;
-		}
-	}
-
-	return retval;
-}
-
 static int bind_con_driver(const struct consw *csw, int first, int last,
 			   int deflt)
 {
@@ -2808,6 +2792,23 @@ err:
 	return retval;
 };
 
+#ifdef CONFIG_VT_HW_CONSOLE_BINDING
+static int con_is_graphics(const struct consw *csw, int first, int last)
+{
+	int i, retval = 0;
+
+	for (i = first; i <= last; i++) {
+		struct vc_data *vc = vc_cons[i].d;
+
+		if (vc && vc->vc_mode == KD_GRAPHICS) {
+			retval = 1;
+			break;
+		}
+	}
+
+	return retval;
+}
+
 static int unbind_con_driver(const struct consw *csw, int first, int last,
 			     int deflt)
 {
@@ -2977,6 +2978,16 @@ static int vt_unbind(struct con_driver *
 err:
 	return 0;
 }
+#else
+static inline int vt_bind(struct con_driver *con)
+{
+	return 0;
+}
+static inline int vt_unbind(struct con_driver *con)
+{
+	return 0;
+}
+#endif /* CONFIG_VT_HW_CONSOLE_BINDING */
 
 static ssize_t store_bind(struct class_device *class_device,
 			  const char *buf, size_t count)

