Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVACRwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVACRwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVACRvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:51:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261760AbVACRtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:49:17 -0500
Date: Mon, 3 Jan 2005 17:49:10 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Len Brown <len.brown@intel.com>
Cc: Michael Geithe <warpy@gmx.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: __iounmap: bad address c00f0000 (Re: 2.6.10-bk5)
Message-ID: <20050103174910.GV26051@parcelfarce.linux.theplanet.co.uk>
References: <200501030114.55399.warpy@gmx.de> <1104773076.18173.64.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104773076.18173.64.camel@d845pe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 12:24:36PM -0500, Len Brown wrote:
> On Sun, 2005-01-02 at 19:14, Michael Geithe wrote:
> 
> > DMI 2.3 present.
> > __iounmap: bad address c00f0000
> > ACPI: RSDP (v000 AMI                                   ) @ 0x000fa380
> 
> Not and ACPI issue:-)
> 
> Looks like the warning is provoked by Al Viro's update to dmi_iterate().
> Perhaps there is a conflict between dmi_table()'s bt_iounmap(),
> and dmi_iterate()'s new iounmap() on the same address?

No.

diff -urN RC10-base/arch/i386/kernel/dmi_scan.c RC10-current/arch/i386/kernel/dmi_scan.c
--- RC10-base/arch/i386/kernel/dmi_scan.c	2004-12-27 06:06:58.000000000 -0500
+++ RC10-current/arch/i386/kernel/dmi_scan.c	2005-01-03 12:46:48.211661680 -0500
@@ -104,6 +104,11 @@
 	u8 buf[15];
 	char __iomem *p, *q;
 
+	/*
+	 * no iounmap() for that ioremap(); it would be a no-op, but it's
+	 * so early in setup that sucker gets confused into doing what
+	 * it shouldn't if we actually call it.
+	 */
 	for (p = q = ioremap(0xF0000, 0x10000); q < p + 0x10000; q += 16) {
 		memcpy_fromio(buf, q, 15);
 		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
@@ -125,13 +130,10 @@
 				num, len));
 			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
 				base));
-			if(dmi_table(base,len, num, decode)==0) {
-				iounmap(p);
+			if(dmi_table(base,len, num, decode)==0)
 				return 0;
-			}
 		}
 	}
-	iounmap(p);
 	return -1;
 }
 
