Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265377AbUFBXjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUFBXjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUFBXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:39:23 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:43537 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S265377AbUFBXil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:38:41 -0400
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: akpm@osdl.org, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Better names for EDD legacy_* fields
References: <20040530200300.GA4681@apps.cwi.nl>
	<s5g8yf9ljb3.fsf@patl=users.sf.net>
	<20040531180821.GC5257@louise.pinerecords.com>
	<s5gaczonzej.fsf@patl=users.sf.net>
	<20040531170347.425c2584.seanlkml@sympatico.ca>
	<s5gfz9f2vok.fsf@patl=users.sf.net>
	<20040601235505.GA23408@apps.cwi.nl>
	<s5gpt8ijf1g.fsf@patl=users.sf.net>
	<20040602150051.GA3165@lists.us.dell.com>
	<s5ghdttlkvg.fsf@patl=users.sf.net>
	<20040602230309.GR23408@apps.cwi.nl>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gise97cy5.fsf@patl=users.sf.net>
Date: 02 Jun 2004 19:38:40 -0400
In-Reply-To: <20040602230309.GR23408@apps.cwi.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

> Ach - I should have been more explicit instead of saying (etc.).
> Also legacy_cylinders is really legacy_max_cylinder (one less than
> the number of cylinders).

In my defense, I barely even thought about the cylinder count.  I only
included it for completeness...  It is meaningless on drives larger
than 8G, and even on older/smaller drives, it is kind of bogus.
According to <http://www.ctyme.com/intr/rb-0621.htm>:

    The maximum cylinder number reported in CX is usually two less
    than the total cylinder count reported in the fixed disk parameter
    table (see INT 41h,INT 46h) because early hard disks used the last
    cylinder for testing purposes; however, on some Zenith machines,
    the maximum cylinder number reportedly is three less than the
    count in the fixed disk parameter table.

So it is not "one less", but often two or three...

Nevertheless, you are correct.  Revised trivial search&replace patch
attached.

 - Pat


--=-=-=
Content-Disposition: attachment; filename=rename_edd_legacy.txt
Content-Description: rename_edd_legacy.txt

diff -u -r linux-2.6.6-orig/drivers/firmware/edd.c linux-2.6.6/drivers/firmware/edd.c
--- linux-2.6.6-orig/drivers/firmware/edd.c	2004-05-09 22:32:27.000000000 -0400
+++ linux-2.6.6/drivers/firmware/edd.c	2004-06-02 19:17:26.000000000 -0400
@@ -334,7 +334,7 @@
 }
 
 static ssize_t
-edd_show_legacy_cylinders(struct edd_device *edev, char *buf)
+edd_show_legacy_max_cylinder(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info;
 	char *p = buf;
@@ -344,12 +344,12 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "0x%x\n", info->legacy_cylinders);
+	p += snprintf(p, left, "0x%x\n", info->legacy_max_cylinder);
 	return (p - buf);
 }
 
 static ssize_t
-edd_show_legacy_heads(struct edd_device *edev, char *buf)
+edd_show_legacy_max_head(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info;
 	char *p = buf;
@@ -359,12 +359,12 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "0x%x\n", info->legacy_heads);
+	p += snprintf(p, left, "0x%x\n", info->legacy_max_head);
 	return (p - buf);
 }
 
 static ssize_t
-edd_show_legacy_sectors(struct edd_device *edev, char *buf)
+edd_show_legacy_sectors_per_track(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info;
 	char *p = buf;
@@ -374,7 +374,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "0x%x\n", info->legacy_sectors);
+	p += snprintf(p, left, "0x%x\n", info->legacy_sectors_per_track);
 	return (p - buf);
 }
 
@@ -450,7 +450,7 @@
  */
 
 static int
-edd_has_legacy_cylinders(struct edd_device *edev)
+edd_has_legacy_max_cylinder(struct edd_device *edev)
 {
 	struct edd_info *info;
 	if (!edev)
@@ -458,11 +458,11 @@
 	info = edd_dev_get_info(edev);
 	if (!info)
 		return -EINVAL;
-	return info->legacy_cylinders > 0;
+	return info->legacy_max_cylinder > 0;
 }
 
 static int
-edd_has_legacy_heads(struct edd_device *edev)
+edd_has_legacy_max_head(struct edd_device *edev)
 {
 	struct edd_info *info;
 	if (!edev)
@@ -470,11 +470,11 @@
 	info = edd_dev_get_info(edev);
 	if (!info)
 		return -EINVAL;
-	return info->legacy_heads > 0;
+	return info->legacy_max_head > 0;
 }
 
 static int
-edd_has_legacy_sectors(struct edd_device *edev)
+edd_has_legacy_sectors_per_track(struct edd_device *edev)
 {
 	struct edd_info *info;
 	if (!edev)
@@ -482,7 +482,7 @@
 	info = edd_dev_get_info(edev);
 	if (!info)
 		return -EINVAL;
-	return info->legacy_sectors > 0;
+	return info->legacy_sectors_per_track > 0;
 }
 
 static int
@@ -569,12 +569,14 @@
 static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
 static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, NULL);
 static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
-static EDD_DEVICE_ATTR(legacy_cylinders, 0444, edd_show_legacy_cylinders,
-		       edd_has_legacy_cylinders);
-static EDD_DEVICE_ATTR(legacy_heads, 0444, edd_show_legacy_heads,
-		       edd_has_legacy_heads);
-static EDD_DEVICE_ATTR(legacy_sectors, 0444, edd_show_legacy_sectors,
-		       edd_has_legacy_sectors);
+static EDD_DEVICE_ATTR(legacy_max_cylinder, 0444,
+                       edd_show_legacy_max_cylinder,
+		       edd_has_legacy_max_cylinder);
+static EDD_DEVICE_ATTR(legacy_max_head, 0444, edd_show_legacy_max_head,
+		       edd_has_legacy_max_head);
+static EDD_DEVICE_ATTR(legacy_sectors_per_track, 0444,
+                       edd_show_legacy_sectors_per_track,
+		       edd_has_legacy_sectors_per_track);
 static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
 		       edd_has_default_cylinders);
 static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
@@ -601,9 +603,9 @@
 
 /* These attributes are conditional and only added for some devices. */
 static struct edd_attribute * edd_attrs[] = {
-	&edd_attr_legacy_cylinders,
-	&edd_attr_legacy_heads,
-	&edd_attr_legacy_sectors,
+	&edd_attr_legacy_max_cylinder,
+	&edd_attr_legacy_max_head,
+	&edd_attr_legacy_sectors_per_track,
 	&edd_attr_default_cylinders,
 	&edd_attr_default_heads,
 	&edd_attr_default_sectors_per_track,
diff -u -r linux-2.6.6-orig/include/linux/edd.h linux-2.6.6/include/linux/edd.h
--- linux-2.6.6-orig/include/linux/edd.h	2004-06-02 16:12:17.000000000 -0400
+++ linux-2.6.6/include/linux/edd.h	2004-06-02 19:16:57.000000000 -0400
@@ -166,9 +166,9 @@
 	u8 device;
 	u8 version;
 	u16 interface_support;
-	u16 legacy_cylinders;
-	u8 legacy_heads;
-	u8 legacy_sectors;
+	u16 legacy_max_cylinder;
+	u8 legacy_max_head;
+	u8 legacy_sectors_per_track;
 	struct edd_device_params params;
 } __attribute__ ((packed));

--=-=-=--
