Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264865AbTFWXsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTFWXqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:46:35 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64951 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264692AbTFWXpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:45:49 -0400
Date: Mon, 23 Jun 2003 16:59:25 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.5.73
Message-ID: <20030623235925.GD12207@kroah.com>
References: <20030623235852.GA12207@kroah.com> <20030623235910.GB12207@kroah.com> <20030623235919.GC12207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623235919.GC12207@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1348.14.3, 2003/06/23 14:44:35-07:00, willy@debian.org

[PATCH] PCI: unconfuse arch/i386/pci/Makefile

I was looking in this Makefile for link order when my head began to hurt.
Apparently you can't have both NUMAQ and VISWS selected, so getting rid
of all the ifdefs/ifndefs like this should work.


 arch/i386/pci/Makefile |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)


diff -Nru a/arch/i386/pci/Makefile b/arch/i386/pci/Makefile
--- a/arch/i386/pci/Makefile	Mon Jun 23 16:53:57 2003
+++ b/arch/i386/pci/Makefile	Mon Jun 23 16:53:57 2003
@@ -1,27 +1,13 @@
-obj-y		:= i386.o
+obj-y				:= i386.o
 
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 
-obj-$(CONFIG_X86_VISWS)		+= visws.o
+pci-y				:= fixup.o
+pci-$(CONFIG_ACPI_PCI)		+= acpi.o
+pci-y				+= legacy.o irq.o
 
-ifdef	CONFIG_X86_NUMAQ
-obj-y		+= numa.o
-else
-obj-y		+= fixup.o
+pci-$(CONFIG_X86_VISWS)		:= visws.o fixup.o
+pci-$(CONFIG_X86_NUMAQ)		:= numa.o irq.o
 
-ifdef	CONFIG_ACPI_PCI
-obj-y		+= acpi.o
-endif
-
-ifndef	CONFIG_X86_VISWS
-obj-y		+= legacy.o
-endif
-
-endif		# CONFIG_X86_NUMAQ
-
-ifndef	CONFIG_X86_VISWS
-obj-y		+= irq.o
-endif
-
-obj-y		+= common.o
+obj-y				+= $(pci-y) common.o
