Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSHIMnz>; Fri, 9 Aug 2002 08:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318325AbSHIMnz>; Fri, 9 Aug 2002 08:43:55 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:6661 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318324AbSHIMny>; Fri, 9 Aug 2002 08:43:54 -0400
Subject: [PATCH] Fix error in pnpbios escd read routine
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Chris Rankin <cj.rankin@ntlworld.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 09 Aug 2002 10:47:16 -0300
Message-Id: <1028900843.919.14.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, Dave:

This patch fixes an error in the pnpbios driver's routine
for reading ESCD data.  (Note the 'buf' changed to 'tmpbuf'.)
Also, it adds another sanity check.

This bug probably caused the crashes reported by Chris Rankin
and Zwane Mwaikambo some weeks ago.

--
Thomas Hood


--- linux-2.4.19-ac4/drivers/pnp/pnpbios_proc.c_ORIG	Wed Aug  7 23:31:08 2002
+++ linux-2.4.19-ac4/drivers/pnp/pnpbios_proc.c	Fri Aug  9 10:38:29 2002
@@ -62,39 +62,47 @@
 		"ESCD_size %d\n"
 		"NVRAM_base 0x%x\n",
 		escd.min_escd_write_size,
 		escd.escd_size,
 		escd.nv_storage_base
 	);
 }
 
+#define MAX_SANE_ESCD_SIZE (32*1024)
 static int proc_read_escd(char *buf, char **start, off_t pos,
                           int count, int *eof, void *data)
 {
 	struct escd_info_struc escd;
 	char *tmpbuf;
 	int escd_size, escd_left_to_read, n;
 
 	if (pnp_bios_escd_info(&escd))
 		return -EIO;
 
 	/* sanity check */
-	if (escd.escd_size > (32*1024)) {
-		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size is too great\n");
+	if (escd.escd_size > MAX_SANE_ESCD_SIZE) {
+		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS escd_info call is too great\n");
 		return -EFBIG;
 	}
 
 	tmpbuf = pnpbios_kmalloc(escd.escd_size, GFP_KERNEL);
 	if (!tmpbuf) return -ENOMEM;
 
 	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base))
 		return -EIO;
 
-	escd_size = (unsigned char)(buf[0]) + (unsigned char)(buf[1])*256;
+	escd_size = (unsigned char)(tmpbuf[0]) + (unsigned char)(tmpbuf[1])*256;
+
+	/* sanity check */
+	if (escd_size > MAX_SANE_ESCD_SIZE) {
+		printk(KERN_ERR "PnPBIOS: proc_read_escd: ESCD size reported by BIOS read_escd call is too great\n");
+		return -EFBIG;
+	}
+
 	escd_left_to_read = escd_size - pos;
 	if (escd_left_to_read < 0) escd_left_to_read = 0;
 	if (escd_left_to_read == 0) *eof = 1;
 	n = min(count,escd_left_to_read);
 	memcpy(buf, tmpbuf + pos, n);
 	kfree(tmpbuf);
 	*start = buf;
 	return n;


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
