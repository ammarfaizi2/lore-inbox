Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319034AbSHFJle>; Tue, 6 Aug 2002 05:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319035AbSHFJld>; Tue, 6 Aug 2002 05:41:33 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:15357 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S319034AbSHFJlb>; Tue, 6 Aug 2002 05:41:31 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [RESEND] [RESEND] [RESEND] [PATCH] Trivial JFFS2 oops fix.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Aug 2002 10:45:04 +0100
Message-ID: <11297.1028627104@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Index: fs/jffs2/scan.c
===================================================================
RCS file: /home/cvs/mtd/fs/jffs2/scan.c,v
retrieving revision 1.51.2.2
retrieving revision 1.51.2.3
diff -u -p -r1.51.2.2 -r1.51.2.3
--- fs/jffs2/scan.c	23 Feb 2002 13:34:31 -0000	1.51.2.2
+++ fs/jffs2/scan.c	25 Jul 2002 20:49:06 -0000	1.51.2.3
@@ -31,7 +31,7 @@
  * provisions above, a recipient may use your version of this file
  * under either the RHEPL or the GPL.
  *
- * $Id: scan.c,v 1.51.2.2 2002/02/23 13:34:31 dwmw2 Exp $
+ * $Id: scan.c,v 1.51.2.3 2002/07/25 20:49:06 dwmw2 Exp $
  *
  */
 #include <linux/kernel.h>
@@ -256,6 +256,16 @@ static int jffs2_scan_eraseblock (struct
 		if (hdr_crc != node.hdr_crc) {
 			noisy_printk(&noise, "jffs2_scan_eraseblock(): Node at 0x%08x {0x%04x, 0x%04x, 0x%08x) has invalid CRC 0x%08x (calculated 0x%08x)\n",
 				     ofs, node.magic, node.nodetype, node.totlen, node.hdr_crc, hdr_crc);
+			DIRTY_SPACE(4);
+			ofs += 4;
+			continue;
+		}
+
+		if (ofs + node.totlen > jeb->offset + c->sector_size) {
+			/* Eep. Node goes over the end of the erase block. */
+			printk(KERN_WARNING "Node at 0x%08x with length 0x%08x would run over the end of the erase block\n",
+			       ofs, node.totlen);
+			printk(KERN_WARNING "Perhaps the file system was created with the wrong erase size?\n");
 			DIRTY_SPACE(4);
 			ofs += 4;
 			continue;


--
dwmw2


