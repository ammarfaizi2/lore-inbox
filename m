Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUA0VcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUA0VcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:32:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:46241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265772AbUA0VcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:32:15 -0500
Date: Tue, 27 Jan 2004 13:33:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: moilanen@austin.ibm.com, johnrose@austin.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH][2.6] PCI Scan all functions
Message-Id: <20040127133314.0ddf00cd.akpm@osdl.org>
In-Reply-To: <20040127211253.GA27583@kroah.com>
References: <1075222501.1030.45.camel@magik>
	<20040127211253.GA27583@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Tue, Jan 27, 2004 at 10:55:01AM -0600, Jake Moilanen wrote:
> > There are some arch, like PPC64, that need to be able to scan all the
> > PCI functions.  The problem comes in on a logically partitioned system
> > where function 0 on a PCI-PCI bridge is assigned to one partition and
> > say function 2 is assiged to another partition.  On the second
> > partition, it would appear that function 0 does not exist, but function
> > 2 does.  If all the functions are not scanned, everything under function
> > 2 would not be detected.
> 
> Heh, I think the PPC64 people need to get together and all talk about
> this, as I just got a different patch, that solves much the same problem
> from John Rose (it's on the linuxppc64 mailing list.)
> 
> Can you two get together and not patch the same section of code to do
> the same thing in different ways?

While we're on the topic, what's with the below patch?  I've had it in -mm
for ages but apparently there's some disagreement over it.



From: Anton Blanchard <anton@samba.org>

We have IO BARs on ppc64 machines that begin at address 0. The current
pci probe code will ignore anything that starts at 0. Remove these checks.



---

 drivers/pci/probe.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/pci/probe.c~ppc64-bar-0-fix drivers/pci/probe.c
--- 25/drivers/pci/probe.c~ppc64-bar-0-fix	2004-01-13 23:23:18.000000000 -0800
+++ 25-akpm/drivers/pci/probe.c	2004-01-13 23:23:18.000000000 -0800
@@ -176,7 +176,7 @@ void __devinit pci_read_bridge_bases(str
 		limit |= (io_limit_hi << 16);
 	}
 
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res->start = base;
 		res->end = limit + 0xfff;
@@ -187,7 +187,7 @@ void __devinit pci_read_bridge_bases(str
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
 	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
 	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		res->start = base;
 		res->end = limit + 0xfffff;
@@ -213,7 +213,7 @@ void __devinit pci_read_bridge_bases(str
 		}
 #endif
 	}
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		res->start = base;
 		res->end = limit + 0xfffff;

_

