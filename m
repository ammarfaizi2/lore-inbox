Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbRA2V7e>; Mon, 29 Jan 2001 16:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129956AbRA2V7Y>; Mon, 29 Jan 2001 16:59:24 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:16752
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129718AbRA2V7P>; Mon, 29 Jan 2001 16:59:15 -0500
Date: Mon, 29 Jan 2001 22:59:08 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/scsi/seagate.c use ioremap instead of isa_{read,write} (241p11)
Message-ID: <20010129225907.M603@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I have not been able to find a probable current maintainer for
this code.)

The following patch makes drivers/scsi/seagate.c use ioremap
instead of isa_{read, write}.

It applies against ac12 and 241p11.

Please comment, esp. on the size of the remappings.


--- linux-ac12-clean/drivers/scsi/seagate.c	Sun Nov 12 04:01:11 2000
+++ linux-ac12/drivers/scsi/seagate.c	Sun Jan 28 21:52:39 2001
@@ -256,10 +256,31 @@
 MODULE_PARM(irq, "i");
 
 #define retcode(result) (((result) << 16) | (message << 8) | status)
-#define STATUS ((u8) isa_readb(st0x_cr_sr))
-#define DATA ((u8) isa_readb(st0x_dr))
-#define WRITE_CONTROL(d) { isa_writeb((d), st0x_cr_sr); }
-#define WRITE_DATA(d) { isa_writeb((d), st0x_dr); }
+#define STATUS ((u8) read_data(st0x_cr_sr))
+#define DATA ((u8) read_data(st0x_dr))
+#define WRITE_CONTROL(d) write_data(d, st0x_cr_sr)
+#define WRITE_DATA(d) write_data(d, st0x_dr)
+
+static inline u8 read_data(unsigned long offset) {
+	void *ptr = ioremap(offset, sizeof(u8));
+	u8 ret;
+	
+	if (!ptr)
+		return 1;
+	ret = readb(ptr);
+	iounmap(ptr);
+	return ret;
+}
+
+static inline int write_data(int data, unsigned long offset) {
+	void *ptr = ioremap(offset, sizeof(u8));
+	
+	if (!ptr)
+		return 1;
+	writeb(data, ptr);
+	iounmap(ptr);
+	return 0;
+}
 
 void st0x_setup (char *str, int *ints)
 {

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

I've never had major knee surgery on any other part of my body.
-Winston Bennett, University of Kentucky basketball forward
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
