Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTE0X2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTE0X2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:28:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:5833 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264445AbTE0X1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:27:50 -0400
Date: Tue, 27 May 2003 18:40:16 -0500
From: linas@austin.ibm.com
To: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: patch, drivers/ide, 2.4.21pre4, module-related
Message-ID: <20030527184016.A36540@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi, 

Attached is teeny patch that sort-of helps make IDE kernel modules 
actually be modular.

I didn't realize that IDE modules weren't supposed to work in 2.4.21pre4
before I started bug hunting.  Then, later,  I accidentally forgot
to disable IDE modules, which lead to further confusion.   The 
attached patch helps a little, but I am presuming that it is probably 
made obsolete by mainstream IDE work.  So this patch is really just 
'FYI'. 

--linas

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Description: linux-2.4.21pre4-ide-modules.patch
Content-Disposition: attachment; filename=x

Index: ide-taskfile.c
===================================================================
RCS file: /cvs/linuxppc64/linuxppc64_2_4/drivers/ide/ide-taskfile.c,v
retrieving revision 1.3
diff -u -r1.3 ide-taskfile.c
--- ide-taskfile.c	8 Jan 2003 18:31:58 -0000	1.3
+++ ide-taskfile.c	27 May 2003 23:28:36 -0000
@@ -653,8 +653,11 @@
 	 * hwif->INB(IDE_STATUS_REG); return.
 	 */
 	if (--rq->current_nr_sectors <= 0)
-		if (!DRIVER(drive)->end_request(drive, 1))
+	{
+		if ((NULL == DRIVER(drive)) || 
+		    (!DRIVER(drive)->end_request(drive, 1)))
 			return ide_stopped;
+	}
 	/*
 	 * ERM, it is techincally legal to leave/exit here but it makes
 	 * a mess of the code ...
Index: setup-pci.c
===================================================================
RCS file: /cvs/linuxppc64/linuxppc64_2_4/drivers/ide/setup-pci.c,v
retrieving revision 1.1
diff -u -r1.1 setup-pci.c
--- setup-pci.c	8 Jan 2003 18:08:22 -0000	1.1
+++ setup-pci.c	27 May 2003 23:28:36 -0000
@@ -172,7 +172,8 @@
  *	is already in DMA mode we check and enforce IDE simplex rules.
  */
 
-static unsigned long __init ide_get_or_set_dma_base (ide_hwif_t *hwif)
+/* This must not be marked __init, since it is called during module load */
+static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
 {
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;

--0OAP2g/MAC+5xKAE--
