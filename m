Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbUKKRpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbUKKRpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUKKRnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:43:53 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:22212 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262332AbUKKRjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:39:15 -0500
Date: Thu, 11 Nov 2004 09:39:01 -0800
From: Tim Hockin <thockin@google.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: small PCI probe patch for odd 64 bit BARs
Message-ID: <20041111173901.GH19615@google.com>
References: <20041111044809.GE19615@google.com> <20041110215142.3a81b426.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110215142.3a81b426.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 09:51:42PM -0800, Andrew Morton wrote:
> Tim Hockin <thockin@google.com> wrote:
> >
> > +			sz = pci_size(sz, 0xffffffff);
> 
> pci_size() takes three arguments, so this patch appears to not have been
> runtime tested :( 

Doh, I sent the 2.4 patch.  This one should work on 2.6.9, though I do
not have 2.6.9 running on this hardware, yet.  It was definitely runtime
tested on 2.4.


--- linux-2.6.9/drivers/pci/probe.c.orig	2004-11-10 20:42:03.000000000 -0800
+++ linux-2.6.9/drivers/pci/probe.c	2004-11-11 09:30:07.000000000 -0800
@@ -144,9 +144,11 @@
 			pci_write_config_dword(dev, reg+4, ~0);
 			pci_read_config_dword(dev, reg+4, &sz);
 			pci_write_config_dword(dev, reg+4, l);
-			if (~sz)
-				res->end = res->start + 0xffffffff +
-						(((unsigned long) ~sz) << 32);
+			sz = pci_size(l, sz, 0xffffffff);
+			if (sz) {
+				/* This BAR needs > 4GB?  Wow. */
+				res->end |= (unsigned long)sz<<32;
+			}
 #else
 			if (l) {
 				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", pci_name(dev));
