Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVACSbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVACSbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVACSbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:31:05 -0500
Received: from fmr16.intel.com ([192.55.52.70]:432 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261765AbVACRuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:50:00 -0500
Subject: Re: __iounmap: bad address c00f0000 (Re: 2.6.10-bk5)
From: Len Brown <len.brown@intel.com>
To: Michael Geithe <warpy@gmx.de>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1104773076.18173.64.camel@d845pe>
References: <200501030114.55399.warpy@gmx.de>
	 <1104773076.18173.64.camel@d845pe>
Content-Type: text/plain
Organization: 
Message-Id: <1104774583.18174.68.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Jan 2005 12:49:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 12:24, Len Brown wrote:
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
> 
> -Len
> 


Try this.

Suggested-by: Al Viro
Signed-off-by: Len Brown <len.brown@intel.com>


===== arch/i386/kernel/dmi_scan.c 1.74 vs edited =====
--- 1.74/arch/i386/kernel/dmi_scan.c	2004-12-28 14:07:48 -05:00
+++ edited/arch/i386/kernel/dmi_scan.c	2005-01-03 12:46:33 -05:00
@@ -126,12 +126,12 @@
 			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
 				base));
 			if(dmi_table(base,len, num, decode)==0) {
-				iounmap(p);
+				/* too early to call iounmap(p); */
 				return 0;
 			}
 		}
 	}
-	iounmap(p);
+	/* too early to call iounmap(p); */
 	return -1;
 }
 



