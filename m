Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbRGJGtB>; Tue, 10 Jul 2001 02:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265790AbRGJGsu>; Tue, 10 Jul 2001 02:48:50 -0400
Received: from patan.Sun.COM ([192.18.98.43]:43239 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S265786AbRGJGsg>;
	Tue, 10 Jul 2001 02:48:36 -0400
Message-ID: <3B4AA705.29150671@sun.com>
Date: Mon, 09 Jul 2001 23:56:05 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mj@ucw.cz
CC: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  PCI probing status cleanup
Content-Type: multipart/mixed;
 boundary="------------ED94359E14918E72AA283D28"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ED94359E14918E72AA283D28
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Martin et al,

Attached is a tiny patch that clears the master abort bit on bridges when
probing PCI devices.

Please let me know if there is any reason this would not be included in the
mainline kernel.

Thanks
Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------ED94359E14918E72AA283D28
Content-Type: text/plain; charset=us-ascii;
 name="pci_bridge.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_bridge.diff"

diff -ruN dist-2.4.6/drivers/pci/pci.c cobalt-2.4.6/drivers/pci/pci.c
--- dist-2.4.6/drivers/pci/pci.c	Mon Jul  2 14:42:53 2001
+++ cobalt-2.4.6/drivers/pci/pci.c	Mon Jul  9 11:04:01 2001
@@ -1229,8 +1233,19 @@
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

--------------ED94359E14918E72AA283D28--

