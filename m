Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWAVFKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWAVFKi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 00:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWAVFKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 00:10:38 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:61837 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751151AbWAVFKi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 00:10:38 -0500
Date: Sun, 22 Jan 2006 00:08:29 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc1-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Message-ID: <200601220010_MC3-1-B666-7037@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
	 charset=ISO-8859-1
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gregkh-pci-msi-vector-targeting-abstractions.patch breaks msi on x86_64:

In file included from include/asm/msi.h:11,
                 from drivers/pci/msi.h:9,
                 from drivers/pci/msi-apic.c:15:
include/asm/smp.h:103: error: syntax error before ‘->’ token


include/asm-x86_64/msi.h:#include <asm/mach_apic.h>

include/asm-x86_64/mach_apic.h:#define cpu_mask_to_apicid (genapic->cpu_mask_to_apicid)

include/asm-x86_64/smp.h:103:static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)


drivers/pci/msi.c does not have this problem because it includes <asm/smp.h>
_before_ "msi.h" so the #define overrides the inline function.

Ugly patch to fix this follows... at least it compiles now...


Fix msi on x86_64, broken due to include-ordering problems.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 drivers/pci/msi-apic.c |    2 ++
 1 files changed, 2 insertions(+)

--- 2.6.16-rc1-mm2.orig/drivers/pci/msi-apic.c
+++ 2.6.16-rc1-mm2/drivers/pci/msi-apic.c
@@ -11,6 +11,8 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 
+#include <asm/smp.h>
+
 #include "pci.h"
 #include "msi.h"
 
-- 
Chuck
