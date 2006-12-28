Return-Path: <linux-kernel-owner+w=401wt.eu-S1753864AbWL1Xwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbWL1Xwn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbWL1Xwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:52:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43293 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbWL1Xwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:52:42 -0500
Date: Thu, 28 Dec 2006 15:51:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ard -kwaak- van Breemen <ard@telegraafnet.nl>, Greg KH <greg@kroah.com>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-Id: <20061228155148.f5469729.akpm@osdl.org>
In-Reply-To: <20061222154234.GI31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
	<20061222082248.GY31882@telegraafnet.nl>
	<20061222003029.4394bd9a.akpm@osdl.org>
	<20061222144134.GH31882@telegraafnet.nl>
	<20061222154234.GI31882@telegraafnet.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could someone please test this?


From: Andrew Morton <akpm@osdl.org>

Various people have reported machines failing to boot since pci_bus_sem was
switched from a spinlock to an rwsem.

The reason for this is that these people had "ide=" on the kernel commandline,
and ide_setup() can end up calling PCI functions which do
down_read(&pci_bus_sem).


Ard has worked out the call tree:

init/main.c         start_kernel
kernel/params.c      parse_args("Booting kernel"
kernel/params.c       parse_one
drivers/ide/ide.c      ide_setup
drivers/ide/ide.c       init_ide_data
drivers/ide/ide.c        init_hwif_default
include/asm-i386/ide.h    ide_default_io_base(index)
drivers/pci/search.c       pci_find_device
drivers/pci/search.c        pci_find_subsys
                             down_read(&pci_bus_sem);


down_read() will unconditionally enable interrupts and some early interrupt
(source unknown) comes in and whacks the machine, apparently because the LDT
isn't set up yet.

Fix that by avoiding taking the semaphore in the PCI code in this situation.

Cc: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Yinghai Lu <yinghai.lu@amd.com>
Cc: <take@libero.it>
Cc: <agalanin@mera.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pci/search.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff -puN drivers/pci/search.c~pci-avoid-taking-pci_bus_sem-early-in-boot drivers/pci/search.c
--- a/drivers/pci/search.c~pci-avoid-taking-pci_bus_sem-early-in-boot
+++ a/drivers/pci/search.c
@@ -259,6 +259,16 @@ pci_get_subsys(unsigned int vendor, unsi
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
+
+	/*
+	 * pci_get_subsys() can be called on the ide_setup() path, super-early
+	 * in boot.  But the down_read() will enable local interrupts, which
+	 * can cause some machines to crash.  So here we detect that situation
+	 * and bail out early.
+	 */
+	if (unlikely(list_empty(pci_devices)))
+		return NULL;
+
 	down_read(&pci_bus_sem);
 	n = from ? from->global_list.next : pci_devices.next;
 
_

