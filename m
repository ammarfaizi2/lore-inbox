Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132016AbRCVNmI>; Thu, 22 Mar 2001 08:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132017AbRCVNlt>; Thu, 22 Mar 2001 08:41:49 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13019 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132016AbRCVNlc>;
	Thu, 22 Mar 2001 08:41:32 -0500
Message-ID: <3ABA00BB.A9C2DF1B@mandrakesoft.com>
Date: Thu, 22 Mar 2001 08:40:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <200103220638.HAA16050@green.mif.pg.gda.pl>
Content-Type: multipart/mixed;
 boundary="------------0F2CC4AF5E5D704FACF5F735"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0F2CC4AF5E5D704FACF5F735
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hmm, on second thought, I think I would prefer the attached patch
(compiled but not tested).

Hardware usually returns all 1's when it's not present, or not working,
so think checking for addresses filled with 1's is a good idea too.

I also took the patch from alan's tree and made the memcmp against
six-byte 'zaddr' rather than a seven-byte string :)

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
--------------0F2CC4AF5E5D704FACF5F735
Content-Type: text/plain; charset=us-ascii;
 name="etherdev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="etherdev.patch"

Index: include/linux/etherdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/etherdevice.h,v
retrieving revision 1.1.1.14.4.2
diff -u -r1.1.1.14.4.2 etherdevice.h
--- include/linux/etherdevice.h	2001/03/21 14:10:50	1.1.1.14.4.2
+++ include/linux/etherdevice.h	2001/03/22 13:37:15
@@ -46,6 +46,25 @@
 	memcpy (dest->data, src, len);
 }
 
+/**
+ * is_valid_ether_addr - Determine if the given Ethernet address is valid
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
+ * a multicast address, and is not FF:FF:FF:FF:FF:FF.
+ *
+ * Return true if the address is valid.
+ */
+static inline int is_valid_ether_addr( u8 *addr )
+{
+	const char zaddr[6] = {0,};
+	const char faddr[6] = {0xFF,0xFF,0xFF,0xFF,0xFF,0xFF};
+
+	return !(addr[0]&1) &&
+	       memcmp( addr, zaddr, 6) &&
+	       memcmp( addr, faddr, 6);
+}
+
 #endif
 
 #endif	/* _LINUX_ETHERDEVICE_H */

--------------0F2CC4AF5E5D704FACF5F735--

