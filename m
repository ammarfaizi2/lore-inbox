Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVAJRiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVAJRiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVAJRh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:37:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:18324 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262347AbVAJRVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:02 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776581385@kroah.com>
Date: Mon, 10 Jan 2005 09:20:58 -0800
Message-Id: <110537765846@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.12, 2004/12/17 15:43:58-08:00, macro@mips.com

[PATCH] PCI: PCI early fixup missing bits

 A few bits seem to be missing for PCI early fixup to work -- the
pci_fixup_device() helper ignores fixups of the pci_fixup_early type.
Also the local class variable needs to be refreshed after performing the
fixups for they can change dev->class.


Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

patch-mips-2.6.10-rc2-20041124-pci_fixup_early-1


 drivers/pci/probe.c  |    1 +
 drivers/pci/quirks.c |    7 +++++++
 2 files changed, 8 insertions(+)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-01-10 09:00:47 -08:00
+++ b/drivers/pci/probe.c	2005-01-10 09:00:47 -08:00
@@ -501,6 +501,7 @@
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
+	class = dev->class >> 8;
 
 	switch (dev->hdr_type) {		    /* header type */
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-01-10 09:00:47 -08:00
+++ b/drivers/pci/quirks.c	2005-01-10 09:00:47 -08:00
@@ -1237,6 +1237,8 @@
 	}
 }
 
+extern struct pci_fixup __start_pci_fixups_early[];
+extern struct pci_fixup __end_pci_fixups_early[];
 extern struct pci_fixup __start_pci_fixups_header[];
 extern struct pci_fixup __end_pci_fixups_header[];
 extern struct pci_fixup __start_pci_fixups_final[];
@@ -1250,6 +1252,11 @@
 	struct pci_fixup *start, *end;
 
 	switch(pass) {
+	case pci_fixup_early:
+		start = __start_pci_fixups_early;
+		end = __end_pci_fixups_early;
+		break;
+
 	case pci_fixup_header:
 		start = __start_pci_fixups_header;
 		end = __end_pci_fixups_header;

