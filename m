Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUABRZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 12:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265623AbUABRZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 12:25:25 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:29105
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265622AbUABRZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 12:25:23 -0500
Date: Fri, 2 Jan 2004 12:25:19 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, trivial@rustcorp.com.au,
       randy@kerneljanitors.org
Subject: [PATCH] drivers/cdrom/cm206.c trivial check_region() fix
Message-ID: <20040102172519.GA7343@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Fri, 2 Jan 2004 12:22:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check_region() fix


--- linux-clean/drivers/cdrom/cm206.c.org	2004-01-02 12:09:49.000000000 -0500
+++ linux-clean/drivers/cdrom/cm206.c	2004-01-02 12:22:23.000000000 -0500
@@ -1389,7 +1389,7 @@
 
    Linus says it is too dangerous to use writes for probing, so we
    stick with pure reads for a while. Hope that 8 possible ranges,
-   check_region, 15 bits of one port and 6 of another make things
+   request_region, 15 bits of one port and 6 of another make things
    likely enough to accept the region on the first hit...
  */
 int __init probe_base_port(int base)
@@ -1400,13 +1400,15 @@
 	if (base)
 		b = e = base;
 	for (base = b; base <= e; base += 0x10) {
-		if (check_region(base, 0x10))
+		if (!request_region(base, 0x10,"cm206"))
 			continue;
 		for (i = 0; i < 3; i++)
 			fool = inw(base + 2);	/* empty possibly uart_receive_buffer */
 		if ((inw(base + 6) & 0xffef) != 0x0001 ||	/* line_status */
-		    (inw(base) & 0xad00) != 0)	/* data status */
+		    (inw(base) & 0xad00) != 0)	{ /* data status */
+		    	release_region(base,0x10);
 			continue;
+		}
 		return (base);
 	}
 	return 0;
@@ -1444,7 +1446,6 @@
 		return -EIO;
 	}
 	printk(" adapter at 0x%x", cm206_base);
-	request_region(cm206_base, 16, "cm206");
 	cd = (struct cm206_struct *) kmalloc(size, GFP_KERNEL);
 	if (!cd)
                goto out_base;

O
