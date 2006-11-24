Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935030AbWKXTfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935030AbWKXTfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 14:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935029AbWKXTfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 14:35:32 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:22229 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S935025AbWKXTfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 14:35:31 -0500
Date: Fri, 24 Nov 2006 14:33:47 -0500
From: Thomas Tuttle <linux-kernel@ttuttle.net>
Subject: [PATCH] Implementation of acpi_video_get_next_level
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com
Mail-followup-to: len.brown@intel.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpi-devel@lists.sourceforge.net,
	linux-acpi@intel.com
Message-id: <20061124193347.GA22622@lion>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=4jXrM3lyYWu4nBt5
Content-disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: multipart/mixed; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

PATCH: Implementation of acpi_video_get_level

(patch file attached)

acpi_video_get_next_level was supposed to implement an algorithm to
select a new brightness level based on the old brightness level of an
ACPI video device, but it simply says "/* Fix me */" and returns the
current brightness.

This patch implements acpi_video_get_next_level properly.  It had to
change a few constants at the top of the file because they were
(apparently) wrong, but it appears to work on my Dell Inspiron e1405
(with BIOS A05 only--BIOS A04 doesn't seem to send ACPI video hotkey
events).

I'm sending this to Len Brown, the linux-kernel and linux-acpi lists at
kernel.org, the acpi-devel list at Sourceforge, and the linux-acpi alias
at Intel.  I'm not sure who should be the one to apply it, but it's a
small and simple enough patch that it shouldn't require a complicated
review.

Thanks for your time, and hope this helps,

Thomas Tuttle

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi_video_get_next_level.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 56666a9..2fc78ca 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
  *  Copyright (C) 2004 Bruno Ducrot <ducrot@poupinou.org>
+ *  Copyright (C) 2006 Thomas Tuttle <linux-kernel@ttuttle.net>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
  *
@@ -47,11 +48,11 @@ #define ACPI_VIDEO_NOTIFY_CYCLE		0x82
 #define ACPI_VIDEO_NOTIFY_NEXT_OUTPUT	0x83
 #define ACPI_VIDEO_NOTIFY_PREV_OUTPUT	0x84
=20
-#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x82
-#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x83
-#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x84
-#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x85
-#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x86
+#define ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS	0x85
+#define	ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS	0x86
+#define ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS	0x87
+#define ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS	0x88
+#define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x89
=20
 #define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
 #define ACPI_VIDEO_HEAD_END		(~0u)
@@ -1509,8 +1510,30 @@ static int
 acpi_video_get_next_level(struct acpi_video_device *device,
 			  u32 level_current, u32 event)
 {
-	/*Fix me */
-	return level_current;
+	int min, max, min_above, max_below, i, l;
+	max =3D max_below =3D 0;
+	min =3D min_above =3D 255;
+	for (i =3D 0; i < device->brightness->count; i++) {
+		l =3D device->brightness->levels[i];
+		if (l < min) min =3D l;
+		if (l > max) max =3D l;
+		if (l < min_above && l > level_current) min_above =3D l;
+		if (l > max_below && l < level_current) max_below =3D l;
+	}
+
+	switch (event) {
+	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:
+		return (level_current < max) ? min_above : min;
+	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:
+		return (level_current < max) ? min_above : max;
+	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:
+		return (level_current > min) ? max_below : min;
+	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:
+	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:
+		return 0;
+	default:
+		return level_current;
+	}
 }
=20
 static void

--gj572EiMnwbLXET9--

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFZ0kbgPpxLpYWreERAm79AJoDkZa+sikGw9JstcJbg7TkdLbkGgCfZbXa
EnKrVcugeOhpDEbJJwSuBhg=
=XE3p
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
