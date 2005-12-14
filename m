Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVLNVKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVLNVKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVLNVKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:10:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:61433 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964967AbVLNVKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:10:08 -0500
Subject: IPMI Panic bug
From: Paolo Galtieri <pgaltieri@mvista.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 14:10:07 -0700
Message-Id: <1134594607.10075.20.camel@playin.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
  while doing some testing I discovered that if the BIOS on a
board does not properly setup the DMI information it leads to 
a panic in the IPMI code.  The panic is due to dereferencing 
a pointer which is not initialized.  The pointer is initialized
in port_setup() and/or mem_setup() and used in init_one_smi() and
cleanup_one_si(), however if either port_setup() or mem_setup()
return ENODEV the pointer does not get initialized.  The patch
is below done against 2.6.15-rc5-git4

Paolo

--- linux-2.6.15-rc5/drivers/char/ipmi/ipmi_si_intf.c	2005-12-05
10:02:56.000000000 -0700
+++ new-linux-2.6.15-rc5/drivers/char/ipmi/ipmi_si_intf.c	2005-12-14
13:57:02.000000000 -0700
@@ -2399,7 +2399,8 @@
 			new_smi->handlers->cleanup(new_smi->si_sm);
 		kfree(new_smi->si_sm);
 	}
-	new_smi->io_cleanup(new_smi);
+	if (new_smi->io_cleanup)
+		new_smi->io_cleanup(new_smi);
 
 	return rv;
 }
@@ -2518,7 +2519,8 @@
 
 	kfree(to_clean->si_sm);
 
-	to_clean->io_cleanup(to_clean);
+	if (to_clean->io_cleanup)
+		to_clean->io_cleanup(to_clean);
 }
 
 static __exit void cleanup_ipmi_si(void)



