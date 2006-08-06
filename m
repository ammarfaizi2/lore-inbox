Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWHFHdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWHFHdx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWHFHdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:33:35 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:40101 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932522AbWHFHd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:33:28 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 12/12] hdaps: Simplify whitelist
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:57 +0300
Message-Id: <11548493143575-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11548492171301-git-send-email-multinymous@gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hdaps driver can now reliably detect accelerometer hardware, as a 
free bonus from switch to thinkpad_ec. The whitelist is thus needed 
only for overriding the default axis configuratrion. This patch simplifies
the whitelist to reflect this. Behavior on previously working modules is
completely unaffected, and new models will work automatically (though not
necessarily with correct axis configuration).

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
 hdaps.c |   66 +++++++++++++---------------------------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff -up a/drivers/hwmon/hdaps.c a/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c
+++ a/drivers/hwmon/hdaps.c
@@ -652,79 +652,41 @@ static struct attribute_group hdaps_attr
 
 /* Module stuff */
 
-/* hdaps_dmi_match - found a match.  return one, short-circuiting the hunt. */
-static int hdaps_dmi_match(struct dmi_system_id *id)
-{
-	printk(KERN_INFO "hdaps: %s detected.\n", id->ident);
-	return 1;
-}
-
 /* hdaps_dmi_match_invert - found an inverted match. */
 static int hdaps_dmi_match_invert(struct dmi_system_id *id)
 {
 	hdaps_invert = 1;
-	printk(KERN_INFO "hdaps: inverting axis readings.\n");
-	return hdaps_dmi_match(id);
-}
-
-#define HDAPS_DMI_MATCH_NORMAL(model)	{		\
-	.ident = "IBM " model,				\
-	.callback = hdaps_dmi_match,			\
-	.matches = {					\
-		DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),	\
-		DMI_MATCH(DMI_PRODUCT_VERSION, model)	\
-	}						\
+	printk(KERN_INFO "hdaps: %s detected, inverting axes\n", 
+	       id->ident);
+	return 1;
 }
 
-#define HDAPS_DMI_MATCH_INVERT(model)	{		\
-	.ident = "IBM " model,				\
+#define HDAPS_DMI_MATCH_INVERT(vendor,model)	{	\
+	.ident = vendor " " model,			\
 	.callback = hdaps_dmi_match_invert,		\
 	.matches = {					\
-		DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),	\
+		DMI_MATCH(DMI_BOARD_VENDOR, vendor),	\
 		DMI_MATCH(DMI_PRODUCT_VERSION, model)	\
 	}						\
 }
 
-#define HDAPS_DMI_MATCH_LENOVO(model)   {               \
-        .ident = "Lenovo " model,                       \
-        .callback = hdaps_dmi_match_invert,             \
-        .matches = {                                    \
-                DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),  \
-                DMI_MATCH(DMI_PRODUCT_VERSION, model)   \
-        }                                               \
-}
-
 static int __init hdaps_init(void)
 {
 	int ret;
 
-	/* Note that HDAPS_DMI_MATCH_NORMAL("ThinkPad T42") would match
+	/* List of models with abnormal axis configuration.
+	   Note that HDAPS_DMI_MATCH_NORMAL("ThinkPad T42") would match
 	  "ThinkPad T42p", so the order of the entries matters */
 	struct dmi_system_id hdaps_whitelist[] = {
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),
-		HDAPS_DMI_MATCH_INVERT("ThinkPad R50p"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad R50"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad R51"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad R52"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),	 /* R52 (1846AQG) */
-		HDAPS_DMI_MATCH_INVERT("ThinkPad T41p"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad T41"),
-		HDAPS_DMI_MATCH_INVERT("ThinkPad T42p"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad T42"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad T43"),
-		HDAPS_DMI_MATCH_LENOVO("ThinkPad T60p"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad X40"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41"),
-		HDAPS_DMI_MATCH_LENOVO("ThinkPad X60"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad Z60m"),
+		HDAPS_DMI_MATCH_INVERT("IBM","ThinkPad R50p"),
+		HDAPS_DMI_MATCH_INVERT("IBM","ThinkPad T41p"),
+		HDAPS_DMI_MATCH_INVERT("IBM","ThinkPad T42p"),
+		HDAPS_DMI_MATCH_INVERT("LENOVO","ThinkPad T60p"),
+		HDAPS_DMI_MATCH_INVERT("LENOVO","ThinkPad X60"),
 		{ .ident = NULL }
 	};
 
-	if (!dmi_check_system(hdaps_whitelist)) {
-		printk(KERN_WARNING "hdaps: supported laptop not found!\n");
-		ret = -ENODEV;
-		goto out;
-	}
+	dmi_check_system(hdaps_whitelist); /* default to normal axes */
 
 	/* Init timer before platform_driver_register, in case of suspend */
 	init_timer(&hdaps_timer);
