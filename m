Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268865AbRHNCGy>; Mon, 13 Aug 2001 22:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRHNCGo>; Mon, 13 Aug 2001 22:06:44 -0400
Received: from patan.Sun.COM ([192.18.98.43]:52166 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S268865AbRHNCGe>;
	Mon, 13 Aug 2001 22:06:34 -0400
Message-ID: <3B788893.43799E78@sun.com>
Date: Mon, 13 Aug 2001 19:10:27 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com, jgarzik@mandrakesoft.com, mj@ucw.cz,
        alan@redhat.com
Subject: [PATCH] PCI probe status cleanup
Content-Type: multipart/mixed;
 boundary="------------DC7F21C32BE910220CBDF251"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DC7F21C32BE910220CBDF251
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a very small patch against 2.4.8, which I have been sending for
a while.  It merely clears the Master Abort bit on a PCI bridge when a
failed probe occurs.

If there is any reason this can't go into the next 2.4.x release, please
let me know.  It has been in use here for months.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------DC7F21C32BE910220CBDF251
Content-Type: text/plain; charset=us-ascii;
 name="pci_bridge_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_bridge_cleanup.diff"

diff -ruN dist+patches-2.4.8/drivers/pci/pci.c cobalt-2.4.8/drivers/pci/pci.c
--- dist+patches-2.4.8/drivers/pci/pci.c	Wed Jul  4 09:41:34 2001
+++ cobalt-2.4.8/drivers/pci/pci.c	Mon Aug 13 16:42:12 2001
@@ -1232,8 +1236,19 @@
 		return NULL;
 
 	/* some broken boards return 0 or ~0 if a slot is empty: */
-	if (l == 0xffffffff || l == 0x00000000 || l == 0x0000ffff || l == 0xffff0000)
+	if (l == 0xffffffff || l == 0x00000000 
+	 || l == 0x0000ffff || l == 0xffff0000) {
+		/*
+		 * host/pci and pci/pci bridges will set Received Master Abort
+		 * (bit 13) on failed configuration access (happens when
+		 * searching for devices).  To be safe, clear the status
+		 * register.
+		 */
+		unsigned short st;
+		pci_read_config_word(temp, PCI_STATUS, &st);
+		pci_write_config_word(temp, PCI_STATUS, st);
 		return NULL;
+	}
 
 	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)

--------------DC7F21C32BE910220CBDF251--

