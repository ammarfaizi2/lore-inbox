Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131721AbRAWWZc>; Tue, 23 Jan 2001 17:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRAWWZX>; Tue, 23 Jan 2001 17:25:23 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:54101
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130322AbRAWWZF>; Tue, 23 Jan 2001 17:25:05 -0500
Date: Tue, 23 Jan 2001 23:24:59 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/qlogicfas.c: check_region -> request_region + cleanup (241p9)
Message-ID: <20010123232459.K607@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I have not been able to find a probable maintainer for this code.)

The follow patch makes drivers/scsi/qlogicfas.c use the return code
from request_region instead of a call to check_region. It also
adds a missing free_irq on an error path and makes us check the
return from scsi_register.

It applies cleanly against ac10 and 241p9.

Comments?



--- linux-ac10-clean/drivers/scsi/qlogicfas.c	Mon Sep 18 22:36:25 2000
+++ linux-ac10/drivers/scsi/qlogicfas.c	Mon Jan 22 22:26:04 2001
@@ -132,7 +132,7 @@
 
 /*----------------------------------------------------------------*/
 /* driver state info, local to driver */
-static int	    qbase = 0;	/* Port */
+static int	    qbase;	/* Port */
 static int	    qinitid;	/* initiator ID */
 static int	    qabort;	/* Flag to cause an abort */
 static int	    qlirq = -1;	/* IRQ being used */
@@ -556,7 +556,7 @@
 
 	if( !qbase ) {
 		for (qbase = 0x230; qbase < 0x430; qbase += 0x100) {
-			if( check_region( qbase , 0x10 ) )
+			if( !request_region( qbase , 0x10, "qlogicfas" ) )
 				continue;
 			REG1;
 			if ( ( (inb(qbase + 0xe) ^ inb(qbase + 0xe)) == 7 )
@@ -616,8 +616,9 @@
 	if (qlirq >= 0 && !request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", NULL))
 		host->can_queue = 1;
 #endif
-	request_region( qbase , 0x10 ,"qlogicfas");
 	hreg = scsi_register( host , 0 );	/* no host data */
+	if (!hreg)
+		goto err_release_mem;
 	hreg->io_port = qbase;
 	hreg->n_io_port = 16;
 	hreg->dma_channel = -1;
@@ -629,6 +630,13 @@
 	host->name = qinfo;
 
 	return 1;
+
+ err_release_mem:
+	release_region(qbase, 0x10);
+	if (host->can_queue)
+		free_irq(qlirq, do_ql_ihandl);
+	return 0;
+
 }
 
 /*----------------------------------------------------------------*/

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

The president has kept all of the promises he intended to keep.
-Clinton aide George Stephanopolous speaking on "Larry King Live".
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
