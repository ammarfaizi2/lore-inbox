Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWJ1SkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWJ1SkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWJ1SkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:40:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:56361 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751318AbWJ1SkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:40:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=chTJPxd8xtbwncDOr2taEwcsezxNY7k/cKRoopVeRtfcJVp7JX8gC0erXKnoQpZqDmgwE8c7OVFldsV6Gk3BN9W06zJQRkEb/hYuJYOiK4KYy5OWj3W3JFRslWjFl28EaHKMkd3Q26YFGdPEfsbaBlTcFiQX59XGoBjm1+nxJfo=
Date: Sun, 29 Oct 2006 03:40:42 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] pci: fix __pci_register_driver error handling
Message-ID: <20061028184042.GB9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__pci_register_driver() error path forgot to unwind.
driver_unregister() needs to be called when pci_create_newid_file() failed.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/pci/pci-driver.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: work-fault-inject/drivers/pci/pci-driver.c
===================================================================
--- work-fault-inject.orig/drivers/pci/pci-driver.c
+++ work-fault-inject/drivers/pci/pci-driver.c
@@ -445,9 +445,12 @@ int __pci_register_driver(struct pci_dri
 
 	/* register with core */
 	error = driver_register(&drv->driver);
+	if (error)
+		return error;
 
-	if (!error)
-		error = pci_create_newid_file(drv);
+	error = pci_create_newid_file(drv);
+	if (error)
+		driver_unregister(&drv->driver);
 
 	return error;
 }
