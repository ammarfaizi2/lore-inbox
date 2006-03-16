Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWCPP2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWCPP2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWCPP2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:28:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751760AbWCPP17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:27:59 -0500
Message-ID: <44198459.8070700@ce.jp.nec.com>
Date: Thu, 16 Mar 2006 10:29:29 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>, maule@sgi.com
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       shaohua.li@intel.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <44176502.9050109@ce.jp.nec.com> <20060315235544.GA6504@suse.de> 
In-Reply-To: <20060315235544.GA6504@suse.de> 
Content-Type: multipart/mixed;
 boundary="------------050002060900000807020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050002060900000807020008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jun'ichi Nomura wrote:
> There is another problem that CONFIG_IA64_GENERIC still doesn't
> build due to error in SGI SN specific code.

The error is as followings.

   CC      arch/ia64/sn/pci/msi.o
/build/rc6/source/arch/ia64/sn/pci/msi.c: At top level:
/build/rc6/source/arch/ia64/sn/pci/msi.c:192: error: variable `sn_msi_ops' has initializer but incomplete type
/build/rc6/source/arch/ia64/sn/pci/msi.c:193: error: unknown field `setup' specified in initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:193: warning: excess elements in struct initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:193: warning: (near initialization for `sn_msi_ops')
/build/rc6/source/arch/ia64/sn/pci/msi.c:194: error: unknown field `teardown' specified in initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:194: warning: excess elements in struct initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:194: warning: (near initialization for `sn_msi_ops')
/build/rc6/source/arch/ia64/sn/pci/msi.c:196: error: unknown field `target' specified in initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:196: warning: excess elements in struct initializer
/build/rc6/source/arch/ia64/sn/pci/msi.c:196: warning: (near initialization for `sn_msi_ops')
/build/rc6/source/arch/ia64/sn/pci/msi.c:192: error: storage size of `sn_msi_ops' isn't known

The code seems to define its own msi_ops but never include a
definition of struct msi_ops.

I think this is a sign that some part of arch/ia64/sn/pci/msi.c
should move to something like drivers/pci/msi-sgi-sn.c.
I leave it to SGI developers, who should have a good insight on
what the proper fix is. Mark?

If such fix doesn't come up soon, the attached patch can be
a band-aid.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------050002060900000807020008
Content-Type: text/x-patch;
 name="ia64-sn-msi-build-band-aid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ia64-sn-msi-build-band-aid.patch"

--- linux-2.6.16-rc6-mm1.orig/arch/ia64/sn/pci/msi.c	2006-03-14 18:13:18.000000000 -0500
+++ linux-2.6.16-rc6-mm1/arch/ia64/sn/pci/msi.c	2006-03-16 01:51:51.000000000 -0500
@@ -10,14 +10,15 @@
 #include <linux/pci.h>
 #include <linux/cpumask.h>
 
-#include <asm/msi.h>
-
 #include <asm/sn/addrs.h>
 #include <asm/sn/intr.h>
 #include <asm/sn/pcibus_provider_defs.h>
 #include <asm/sn/pcidev.h>
 #include <asm/sn/nodepda.h>
 
+#include "../../../../drivers/pci/pci.h"
+#include "../../../../drivers/pci/msi.h"
+
 struct sn_msi_info {
 	u64 pci_addr;
 	struct sn_irq_info *sn_irq_info;

--------------050002060900000807020008--
