Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTFSX2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTFSX2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:28:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18847 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261956AbTFSXZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:25:47 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1056065970863@kroah.com>
Subject: Re: [PATCH] PCI changes and fixes for 2.5.72
In-Reply-To: <1056065969234@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jun 2003 16:39:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1327.5.2, 2003/06/16 16:44:06-07:00, willy@debian.org

[PATCH] PCI: Unconfuse /proc

If we are to cope with multiple domains with clashing PCI bus numbers,
we must refrain from creating two directories of the same name in
/proc/bus/pci.  This is one solution to the problem; busses with a
non-zero domain number get it prepended.

Alternative solutions include cowardly refusing to create non-domain-zero
bus directories, refusing to create directories with clashing names, and
sticking our heads in the sand and pretending the problem doesn't exist.


 drivers/pci/proc.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)


diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Thu Jun 19 16:32:21 2003
+++ b/drivers/pci/proc.c	Thu Jun 19 16:32:21 2003
@@ -383,7 +383,11 @@
 		return -EACCES;
 
 	if (!(de = bus->procdir)) {
-		sprintf(name, "%02x", bus->number);
+		if (pci_domain_nr(bus) == 0) {
+			sprintf(name, "%02x", bus->number);
+		} else {
+			sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
+		}
 		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
 		if (!de)
 			return -ENOMEM;

