Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVBUPDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVBUPDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 10:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVBUPDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 10:03:42 -0500
Received: from eu31-234.clientes.euskaltel.es ([212.55.31.234]:24847 "HELO
	cortafuegos.ziv.es") by vger.kernel.org with SMTP id S262004AbVBUPCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 10:02:43 -0500
Subject: [PATCH] 1-Wire Dallas in bigendian machines
From: Asier Llano Palacios <a.llano@usyscom.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 16:04:39 +0100
Message-Id: <1108998279.4563.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2005 15:00:10.0203 (UTC) FILETIME=[09CAB2B0:01C51826]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been testing the 1-Wire Dallas in a bigendian machine (through a
GPIO) and I've found some problems that can easily addressed with the
provided patch. (inline at the end of the message).

I have a question about the implementation of w1_smem.
In the line 90 of drivers/w1/w1_smem.c.
  for (i = 0; i < 9; ++i)
     count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
I don't see why this loop is execute 9 times when the provided reg_num
is 8 bytes long. I don't understand the purpose of the last byte.

Thank you very much.

-- 
Asier Llano Palacios <a.llano@usyscom.com>



diff -urP linux-2.6.10/drivers/w1/w1.c
linux-2.6.10-w1-bigendian/drivers/w1/w1.c
--- linux-2.6.10/drivers/w1/w1.c	2004-12-24 22:34:30.000000000 +0100
+++ linux-2.6.10-w1-bigendian/drivers/w1/w1.c	2005-01-28
12:54:39.000000000 +0100
@@ -579,9 +579,10 @@
 			slave_count++;
 		}
 
-		if (slave_count == dev->slave_count &&
-			rn && ((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn, 7)) {
-			w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
+		if (slave_count == dev->slave_count && rn ) {
+			tmp = cpu_to_le64(rn);
+			if(((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&tmp, 7))
+				w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
 		}
 	}
 }
diff -urP linux-2.6.10/drivers/w1/w1.h
linux-2.6.10-w1-bigendian/drivers/w1/w1.h
--- linux-2.6.10/drivers/w1/w1.h	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10-w1-bigendian/drivers/w1/w1.h	2005-01-28
13:05:47.000000000 +0100
@@ -24,9 +24,17 @@
 
 struct w1_reg_num
 {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	__u64	family:8,
 		id:48,
 		crc:8;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u64	crc:8,
+		id:48,
+		family:8;
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
 };
 
 #ifdef __KERNEL__


