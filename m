Return-Path: <linux-kernel-owner+w=401wt.eu-S1030328AbWL3UPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWL3UPw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 15:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWL3UPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 15:15:52 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:51395 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030331AbWL3UPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 15:15:51 -0500
Date: Sat, 30 Dec 2006 21:15:48 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2.6.20-rc2-git1] PCI: prevent down_read when pci_devices is empty
Message-ID: <20061230201548.GV912@telegraafnet.nl>
References: <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl> <20061222154234.GI31882@telegraafnet.nl> <20061228155148.f5469729.akpm@osdl.org> <20061229125108.GK912@telegraafnet.nl> <20061229132759.GL912@telegraafnet.nl> <20061229141058.GM912@telegraafnet.nl> <20061229150132.GN912@telegraafnet.nl> <20061229154251.GR912@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229154251.GR912@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pci_find_subsys gets called very early by obsolete ide setup
parameters.  This is a bogus call since pci is not initialized
yet, so the list is empty.  But in the mean time, interrupts get
enabled by down_read. This can result in a kernel panic when the
irq controller gets initialized.
This patch checks if the device list is empty before taking the
semaphore, and hence will not enable irq's. Furthermore it will
inform that it is called while pci_devices is empty as a reminder
that the ide code needs to be fixed.
The pci_get_subsys can get called in the same manner, and as such
is patched in the same manner.

Signed-off-by: Ard van Breemen <ard@telegraafnet.nl>
----
This patch is an adaption of Andrew Mortons patch.

--- linux-2.6.19.vanilla/drivers/pci/search.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19.ok/drivers/pci/search.c	2006-12-29 15:38:18.000000000 +0000
@@ -193,6 +193,17 @@ static struct pci_dev * pci_find_subsys(
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
+
+	/*
+	 * pci_find_subsys() can be called on the ide_setup() path, super-early
+	 * in boot.  But the down_read() will enable local interrupts, which
+	 * can cause some machines to crash.  So here we detect and flag that
+	 * situation and bail out early.
+	 */
+	if(unlikely(list_empty(&pci_devices))) {
+		printk(KERN_INFO "pci_find_subsys() called while pci_devices is still empty\n");
+		return NULL;
+	}
 	down_read(&pci_bus_sem);
 	n = from ? from->global_list.next : pci_devices.next;
 
@@ -259,6 +270,16 @@ pci_get_subsys(unsigned int vendor, unsi
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
+	/*
+	 * pci_get_subsys() can potentially be called by drivers super-early
+	 * in boot.  But the down_read() will enable local interrupts, which
+	 * can cause some machines to crash.  So here we detect and flag that
+	 * situation and bail out early.
+	 */
+	if(unlikely(list_empty(&pci_devices))) {
+		printk(KERN_NOTICE "pci_get_subsys() called while pci_devices is still empty\n");
+		return NULL;
+	}
 	down_read(&pci_bus_sem);
 	n = from ? from->global_list.next : pci_devices.next;
 
