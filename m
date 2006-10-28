Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWJ1Swv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWJ1Swv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWJ1Swv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:52:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:245 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932085AbWJ1Swu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:52:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=fdDm+wS0MFKZCTMPoD9vGhs0tn3W2T+F3fgECC7yvz9p29LKNO5EGZOlZA0HRCtegbCCK045WGmq6qu6IcFZcSEVpuxTdgxRSD5rpSysg0gQbQk+J6aukMVW8rzig/QVHYyCO1Ce4rFUCeC/YiPUVP+UiDZgMr4OYL+9IayekJE=
Date: Sun, 29 Oct 2006 03:53:13 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH] acpi: fix single linked list manipulation
Message-ID: <20061028185313.GK9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Len Brown <len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes single linked list manipulation for sub_driver.
If the remving entry is not on the head of the sub_driver list,
it goes into infinate loop.

Though that infinate loop doesn't happen. Because the only user of
acpi_pci_register_dirver() is acpiphp.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/acpi/pci_root.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: work-fault-inject/drivers/acpi/pci_root.c
===================================================================
--- work-fault-inject.orig/drivers/acpi/pci_root.c
+++ work-fault-inject/drivers/acpi/pci_root.c
@@ -98,11 +98,12 @@ void acpi_pci_unregister_driver(struct a
 
 	struct acpi_pci_driver **pptr = &sub_driver;
 	while (*pptr) {
-		if (*pptr != driver)
-			continue;
-		*pptr = (*pptr)->next;
-		break;
+		if (*pptr == driver)
+			break;
+		pptr = &(*pptr)->next;
 	}
+	BUG_ON(!*pptr);
+	*pptr = (*pptr)->next;
 
 	if (!driver->remove)
 		return;
