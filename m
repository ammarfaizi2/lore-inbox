Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWFVOY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWFVOY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWFVOY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:24:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:46181 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751798AbWFVOY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:24:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id:from;
        b=S8zAAW+9vh06eniFWGU0ZWbp2g0WRUnAhNrExauy0NrXreqMBGN5lQLplpf0qCXOPiRxx5UoxS1sS8+Yh9BACMxMmJFNw2rSCKHJ/hTnMHfle5IrvnL8aFN6yTDA3frY3Td5szWLtdzBZ5yNh/NG7+CFkO+4BHBpXjdPDDV93Cw=
To: linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] CRC ITU-T V.41
Date: Thu, 22 Jun 2006 16:29:02 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart16687503.WqzIcZuVvp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606221629.05406.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart16687503.WqzIcZuVvp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Patch was send 2 weeks ago, but required some small changes.
This is now the correct patch for latest linux-2.6 git tree.
Patch is against torvalds/linux-2.6.git

This will add the CRC calculation according
to the CRC ITU-T V.41 to the kernel lib/ folder.

This code has been derived from the rt2x00 driver,
currently found only in the wireless-dev tree, but
this library is generic and could be used by more
drivers who currently use their own implementation.

The rt2x00 driver will be updated to use this library
when this lib is merged into the kernel.

Signed-off-by Ivo van Doorn <IvDoorn@gmail.com>

=2D--

diff --git a/include/linux/crc-itu-t.h b/include/linux/crc-itu-t.h
new file mode 100644
index 0000000..a9953c7
=2D-- /dev/null
+++ b/include/linux/crc-itu-t.h
@@ -0,0 +1,28 @@
+/*
+ *	crc-itu-t.h - CRC ITU-T V.41 routine
+ *
+ * Implements the standard CRC ITU-T V.41:
+ *   Width 16
+ *   Poly  0x1021 (x^16 + x^12 + x^15 + 1)
+ *   Init  0
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2. See the file COPYING for more details.
+ */
+
+#ifndef CRC_ITU_T_H
+#define CRC_ITU_T_H
+
+#include <linux/types.h>
+
+extern u16 const crc_itu_t_table[256];
+
+extern u16 crc_itu_t(u16 crc, const u8 *buffer, size_t len);
+
+static inline u16 crc_itu_t_byte(u16 crc, const u8 data)
+{
+	return (crc << 8) ^ crc_itu_t_table[((crc >> 8) ^ data) & 0xff];
+}
+
+#endif /* CRC_ITU_T_H */
+
diff --git a/lib/Kconfig b/lib/Kconfig
index 3de9335..451d821 100644
=2D-- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -20,6 +20,14 @@ config CRC16
 	  the kernel tree does. Such modules that use library CRC16
 	  functions require M here.
=20
+config CRC_ITU_T
+	tristate "CRC ITU-T V.41 functions"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require CRC ITU-T V.41 functions, but a module built outside
+	  the kernel tree does. Such modules that use library CRC ITU-T V.41
+	  functions require M here.
+
 config CRC32
 	tristate "CRC32 functions"
 	default y
diff --git a/lib/Makefile b/lib/Makefile
index b830c9a..d2d08ce 100644
=2D-- a/lib/Makefile
+++ b/lib/Makefile
@@ -33,6 +33,7 @@ endif
=20
 obj-$(CONFIG_CRC_CCITT)	+=3D crc-ccitt.o
 obj-$(CONFIG_CRC16)	+=3D crc16.o
+obj-$(CONFIG_CRC_ITU_T)	+=3D crc-itu-t.o
 obj-$(CONFIG_CRC32)	+=3D crc32.o
 obj-$(CONFIG_LIBCRC32C)	+=3D libcrc32c.o
 obj-$(CONFIG_GENERIC_IOMAP) +=3D iomap.o
diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
new file mode 100644
index 0000000..15128ae
=2D-- /dev/null
+++ b/lib/crc-itu-t.c
@@ -0,0 +1,69 @@
+/*
+ *      crc-itu-t.c
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2. See the file COPYING for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/crc-itu-t.h>
+
+/** CRC table for the CRC ITU-T V.41 0x0x1021 (x^16 + x^12 + x^15 + 1) */
+const u16 crc_itu_t_table[256] =3D {
+	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
+	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
+	0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
+	0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
+	0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485,
+	0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
+	0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4,
+	0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
+	0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
+	0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
+	0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12,
+	0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
+	0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
+	0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
+	0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
+	0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
+	0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f,
+	0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
+	0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e,
+	0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
+	0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
+	0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
+	0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c,
+	0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
+	0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab,
+	0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
+	0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
+	0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
+	0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9,
+	0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
+	0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
+	0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
+};
+
+EXPORT_SYMBOL(crc_itu_t_table);
+
+/**
+ * crc_itu_t - Compute the CRC-ITU-T for the data buffer
+ *
+ * @crc: previous CRC value
+ * @buffer: data pointer
+ * @len: number of bytes in the buffer
+ *
+ * Returns the updated CRC value
+ */
+u16 crc_itu_t(u16 crc, const u8 *buffer, size_t len)
+{
+	while (len--)
+		crc =3D crc_itu_t_byte(crc, *buffer++);
+	return crc;
+}
+EXPORT_SYMBOL(crc_itu_t);
+
+MODULE_DESCRIPTION("CRC ITU-T V.41 calculations");
+MODULE_LICENSE("GPL");
+

--nextPart16687503.WqzIcZuVvp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEmqkxaqndE37Em0gRAo5vAJ4jqhVyRb7MCxHZYTRngGm9OBI4sgCePdof
u16oTaa/60zW7d5tJLs9IMI=
=gyac
-----END PGP SIGNATURE-----

--nextPart16687503.WqzIcZuVvp--
