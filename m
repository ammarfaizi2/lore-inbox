Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbUKKEsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbUKKEsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 23:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbUKKEsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 23:48:42 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:3219 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262172AbUKKEsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 23:48:40 -0500
Date: Wed, 10 Nov 2004 20:48:09 -0800
From: Tim Hockin <thockin@google.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com, akpm@osdl.org
Subject: small PCI probe patch for odd 64 bit BARs
Message-ID: <20041111044809.GE19615@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current PCI probe code breaks for 64 bit BARs that do not decode a
full 64 bits.  Example:

We have a device that uses a 64 bit BAR.  When you write all Fs to the
BARs, you get:

	000000ff ffff0000

It wants 64k, in the first TB of RAM.  The current code totally borks on
this.

Simple patch against 2.6.9:

Signed-Off-By: Tim Hockin <thockin@google.com>



--- drivers/pci/probe.c.orig	2004-11-10 20:42:03.000000000 -0800
+++ drivers/pci/probe.c	2004-11-10 20:42:07.000000000 -0800
@@ -144,9 +144,11 @@
 			pci_write_config_dword(dev, reg+4, ~0);
 			pci_read_config_dword(dev, reg+4, &sz);
 			pci_write_config_dword(dev, reg+4, l);
-			if (~sz)
-				res->end = res->start + 0xffffffff +
-						(((unsigned long) ~sz) << 32);
+			sz = pci_size(sz, 0xffffffff);
+			if (sz) {
+				/* this BAR needs > 4GB?  Wow. */
+				res->end |= (unsigned long)sz<<32;
+			}
 #else
 			if (l) {
 				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", pci_name(dev));





