Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266557AbUFVEFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266557AbUFVEFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 00:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266556AbUFVEFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 00:05:33 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:4823 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266562AbUFVEEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 00:04:21 -0400
To: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [PATCH] Export msi_remove_pci_irq_vectors
X-Message-Flag: Warning: May contain useful information
References: <52lligqqlc.fsf@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 21 Jun 2004 21:03:22 -0700
In-Reply-To: <52lligqqlc.fsf@topspin.com> (Roland Dreier's message of "Mon,
 21 Jun 2004 19:22:23 -0700")
Message-ID: <521xk8qlx1.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 04:03:22.0783 (UTC) FILETIME=[DC589AF0:01C4580D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a followup to my previous post about the request_mem_region in
msi.c, I noticed that the region is only released in
msi_remove_pci_irq_vectors().  Based on the fact that this function is
declared in linux/pci.h (and stubbed out if CONFIG_PCI_USE_VECTOR is
not defined), I'm guessing that the intent is for a device driver to
unconditionally call this when exiting.

However, a module can't call msi_remove_pci_irq_vectors unless the
symbol is exported... so if this is the way to do things, please apply
this patch.

On the other hand, MSI-HOWTO.txt seems to imply that the 0th MSI
vector should be cleaned up just by calling free_irq... so should
pci_disable_msi be calling msi_remove_pci_irq_vectors?

 - Roland

Index: linux-2.6.7/drivers/pci/msi.c
===================================================================
--- linux-2.6.7.orig/drivers/pci/msi.c	2004-06-15 22:20:03.000000000 -0700
+++ linux-2.6.7/drivers/pci/msi.c	2004-06-21 20:51:33.000000000 -0700
@@ -1011,3 +1011,4 @@
 EXPORT_SYMBOL(pci_enable_msi);
 EXPORT_SYMBOL(msi_alloc_vectors);
 EXPORT_SYMBOL(msi_free_vectors);
+EXPORT_SYMBOL(msi_remove_pci_irq_vectors);
