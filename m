Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbUKKRpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUKKRpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUKKRnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:43:39 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:61965 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262326AbUKKRm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:42:29 -0500
Date: Thu, 11 Nov 2004 09:42:17 -0800
From: Tim Hockin <thockin@google.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: small PCI probe patch for odd 64 bit BARs
Message-ID: <20041111174217.GI19615@google.com>
References: <20041111044809.GE19615@google.com> <20041111172221.GB18538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111172221.GB18538@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 09:22:21AM -0800, Greg KH wrote:
> On Wed, Nov 10, 2004 at 08:48:09PM -0800, Tim Hockin wrote:
> > The current PCI probe code breaks for 64 bit BARs that do not decode a
> > full 64 bits.  Example:
> > 
> > We have a device that uses a 64 bit BAR.  When you write all Fs to the
> > BARs, you get:
> > 
> > 	000000ff ffff0000
> > 
> > It wants 64k, in the first TB of RAM.  The current code totally borks on
> > this.
> > 
> > Simple patch against 2.6.9:
> 
> As Andrew pointed out, you didn't even compile test this patch, not nice.

Yeah, I sent the 2.4 patch and called it 2.6, bny mistake.  The one that
actually came out of the 2.6.9 tree here was sent a few minutes ago, and
here again.

I was in a rush, I screwed up.  This version has been compile tested,
and run tested under 2.4.

Sorry, again.



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
