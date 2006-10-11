Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161456AbWJKVJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161456AbWJKVJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWJKVJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:09:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:39843 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161450AbWJKVJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:23 -0400
Date: Wed, 11 Oct 2006 14:09:03 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 63/67] ide-generic: jmicron fix
Message-ID: <20061011210903.GL16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ide-generic-jmicron-fix.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Some people find their Jmicron pata port reports its disabled even
though it has devices on it and was boot probed. Fix this

(Candidate for 2.6.18.*, less so for 2.6.19 as we've got a proper
jmicron driver on the merge for that to replace ide-generic support)

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/ide/pci/generic.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.18.orig/drivers/ide/pci/generic.c
+++ linux-2.6.18/drivers/ide/pci/generic.c
@@ -245,10 +245,12 @@ static int __devinit generic_init_one(st
 	if (dev->vendor == PCI_VENDOR_ID_JMICRON && PCI_FUNC(dev->devfn) != 1)
 		goto out;
 
-	pci_read_config_word(dev, PCI_COMMAND, &command);
-	if (!(command & PCI_COMMAND_IO)) {
-		printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
-		goto out;
+	if (dev->vendor != PCI_VENDOR_ID_JMICRON) {
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		if (!(command & PCI_COMMAND_IO)) {
+			printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
+			goto out;
+		}
 	}
 	ret = ide_setup_pci_device(dev, d);
 out:

--
