Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVCVHS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVCVHS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVCVHS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:18:59 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:49297 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261970AbVCVHSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:18:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kenan Esau <kenan.esau@conan.de>
Subject: [PATCH 1/4] Lifebook: dmi on x86 only
Date: Tue, 22 Mar 2005 02:14:55 -0500
User-Agent: KMail/1.7.2
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <1111419068.8079.15.camel@localhost> <200503220213.46375.dtor_core@ameritech.net>
In-Reply-To: <200503220213.46375.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220214.55379.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Input: lifebook - DMI facility is only available on i386, do not
       attempt to compile on anything else.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 lifebook.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

Index: dtor/drivers/input/mouse/lifebook.c
===================================================================
--- dtor.orig/drivers/input/mouse/lifebook.c
+++ dtor/drivers/input/mouse/lifebook.c
@@ -15,17 +15,17 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
-#include <linux/dmi.h>
 
 #include "psmouse.h"
 #include "lifebook.h"
 
 static int max_y = 1024;
 
-
+#if defined(__i386__)
+#include <linux/dmi.h>
 static struct dmi_system_id lifebook_dmi_table[] = {
        {
-               .ident = "Fujitsu Siemens Lifebook B-Sereis",
+               .ident = "Lifebook",
                .matches = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK B Series"),
                },
@@ -33,6 +33,13 @@ static struct dmi_system_id lifebook_dmi
        { }
 };
 
+static inline int lifebook_check_dmi(void)
+{
+        return dmi_check_system(lifebook_dmi_table) ? 0 : -1;
+}
+#else
+static inline int lifebook_check_dmi(void) { return -1; }
+#endif
 
 static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
@@ -102,8 +109,7 @@ static void lifebook_disconnect(struct p
 int lifebook_detect(struct psmouse *psmouse, unsigned int max_proto, 
                     int set_properties)
 {
-        if (!dmi_check_system(lifebook_dmi_table) && 
-            (max_proto != PSMOUSE_LIFEBOOK) )
+        if (lifebook_check_dmi() && max_proto != PSMOUSE_LIFEBOOK)
                 return -1;
 
 	if (set_properties) {
