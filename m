Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUHYAhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUHYAhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUHYAhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:37:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:21424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267785AbUHYAhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:37:45 -0400
Date: Tue, 24 Aug 2004 17:37:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Alex Williamson <alex.williamson@hp.com>, akpm@osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <20040824220450.GE11165@kroah.com>
Message-ID: <Pine.LNX.4.58.0408241721330.17766@ppc970.osdl.org>
References: <20040715000527.GA18923@kroah.com> <1093384722.8445.10.camel@tdi>
 <20040824220450.GE11165@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Aug 2004, Greg KH wrote:
> 
> If someone can come up with a patch that works for everyone, I'll be
> glad to apply it.

Hmm.. Why exactly does the PCI layer re-locate the IO ports?

Afaik, ACPI requesting the region shouldn't matter. The 
"request_resource()" should still be happy..

Ahh. I see the problem. Because the ACPI code allocates the sub-resources, 
the request_resource thing is indeed not happy.

How about this _trivial_ change? Does that fix things for you guys? Can 
you send the /proc/ioport output if this works out for you, just so that 
we can see?

(The difference between "request_resource()" and "insert_resource()" is 
that the latter accepts pre-existing sub-resources that the firmware might 
have allocated within the resource we have..)

		Linus

===== arch/i386/pci/i386.c 1.16 vs edited =====
--- 1.16/arch/i386/pci/i386.c	2003-07-31 16:47:19 -07:00
+++ edited/arch/i386/pci/i386.c	2004-08-24 17:36:10 -07:00
@@ -142,7 +142,7 @@
 				DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
 				    r->start, r->end, r->flags, disabled, pass);
 				pr = pci_find_parent_resource(dev, r);
-				if (!pr || request_resource(pr, r) < 0) {
+				if (!pr || insert_resource(pr, r) < 0) {
 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s\n", idx, pci_name(dev));
 					/* We'll assign a new address later */
 					r->end -= r->start;
