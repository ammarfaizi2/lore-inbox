Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266577AbUGPQeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbUGPQeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 12:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUGPQeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 12:34:14 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:3791 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S266577AbUGPQeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 12:34:10 -0400
Subject: [PATCH] ipmi_msghandler module load failure
From: Khalid Aziz <khalid_aziz@hp.com>
To: Corey Minyard <minyard@acm.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089995643.5015.47.camel@lyra.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 10:34:04 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey,

On a 2.6.7 kernel, when I try to modprobe ipmi_msghandler, it fails to
load with following message:

FATAL: Error inserting ipmi_msghandler (/lib/modules/2.6.7/kernel/drivers/char/ipmi/ipmi_msghandler.ko): Invalid module format

And there is an error message in dmesg:

ipmi_msghandler: init symbol 0xa000000200058080 used in module code at a000000200031b32

What I have been able to determine is that ipmi_msghandler.c defines
ipmi_init_msghandler() as the module_init() routine and then it also
calls ipmi_init_msghandler() diretcly from couple of other places. This
does not seem to be okay in 2.6.7 kernel. I was able to fix this by
defining a new module_init routine which in turn calls
ipmi_init_msghandler(). I also removed __init from
ipmi_init_msghandler() since it gets called from ipmi_open() on an open
of the ipmi device file. So I would think we want to keep
ipmi_init_msghandler() around even after initialization. Here is the
patch. Please apply if it looks good:

--- linux-2.6.7/drivers/char/ipmi/ipmi_msghandler.c	2004-06-15 23:19:36.000000000 -0600
+++ linux-2.6.7.new/drivers/char/ipmi/ipmi_msghandler.c	2004-07-16 10:28:52.000000000 -0600
@@ -3072,7 +3072,7 @@
 	200   /* priority: INT_MAX >= x >= 0 */
 };
 
-static __init int ipmi_init_msghandler(void)
+static int ipmi_init_msghandler(void)
 {
 	int i;
 
@@ -3107,6 +3107,11 @@
 	return 0;
 }
 
+static __init int ipmi_init_msghandler_mod(void)
+{
+	ipmi_init_msghandler();
+}
+
 static __exit void cleanup_ipmi(void)
 {
 	int count;
@@ -3143,7 +3148,7 @@
 }
 module_exit(cleanup_ipmi);
 
-module_init(ipmi_init_msghandler);
+module_init(ipmi_init_msghandler_mod);
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(ipmi_alloc_recv_msg);

-- 
Khalid

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid_aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
				- Alessandro Rubini


