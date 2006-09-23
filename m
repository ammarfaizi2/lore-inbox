Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWIWAS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWIWAS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWIWAS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:18:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60388 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964964AbWIWAS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:18:56 -0400
Date: Sat, 23 Sep 2006 01:18:41 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ancient breakage in ebus_init()
Message-ID: <20060923001841.GV29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back when pci_dev had base_address[], loop of form
	base = &...->base_address[0];
	for (.....) {
		...
		*base++ = addr;
	}
was fine, but when that array got spread in ->resource[...].start
replacing the initialization with
	base = &...->resource[0].start;
was not a sufficient modification.  IOW this code got broken for cases
when there had been more than one resource to fill.  All way back in
2.3.41-pre3...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/kernel/ebus.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/ebus.c b/arch/sparc/kernel/ebus.c
index 81c0cbd..75ac24d 100644
--- a/arch/sparc/kernel/ebus.c
+++ b/arch/sparc/kernel/ebus.c
@@ -277,7 +277,7 @@ void __init ebus_init(void)
 	struct pci_dev *pdev;
 	struct pcidev_cookie *cookie;
 	struct device_node *dp;
-	unsigned long addr, *base;
+	struct resource *p;
 	unsigned short pci_command;
 	int len, reg, nreg;
 	int num_ebus = 0;
@@ -321,13 +321,12 @@ void __init ebus_init(void)
 		}
 		nreg = len / sizeof(struct linux_prom_pci_registers);
 
-		base = &ebus->self->resource[0].start;
+		p = &ebus->self->resource[0];
 		for (reg = 0; reg < nreg; reg++) {
 			if (!(regs[reg].which_io & 0x03000000))
 				continue;
 
-			addr = regs[reg].phys_lo;
-			*base++ = addr;
+			(p++)->start = regs[reg].phys_lo;
 		}
 
 		ebus->ofdev.node = dp;
-- 
1.4.2.GIT


