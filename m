Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUJJDP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUJJDP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 23:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUJJDP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 23:15:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:9917 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268077AbUJJDPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 23:15:22 -0400
Date: Sat, 9 Oct 2004 20:15:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: CaT <cat@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
In-Reply-To: <20041010021929.GA1322@zip.com.au>
Message-ID: <Pine.LNX.4.58.0410092002070.3897@ppc970.osdl.org>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org>
 <20040930233048.GC7162@zip.com.au> <Pine.LNX.4.58.0409301646040.2403@ppc970.osdl.org>
 <20041001103032.GA1049@zip.com.au> <Pine.LNX.4.58.0410010731560.2403@ppc970.osdl.org>
 <20041002045725.GC1049@zip.com.au> <Pine.LNX.4.58.0410021211120.2301@ppc970.osdl.org>
 <20041010021929.GA1322@zip.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Oct 2004, CaT wrote:
> > 
> > That's really wrong. Hmm.. Can you enable debugging for the PCI resource 
> > stuff? It's DEBUG_CONFIG in drivers/pci/setup-res.c, and DEBUG in 
> > arch/i386/pci/pci.h, and now your dmesg should be a lot more verbose about 
> > the bootup resources..
> 
> I did this:
> 
> ./setup-res.c:#define DEBUG_CONFIG 1
> ./pci.h:#define DEBUG
> 
> dmesg attached.

Thanks. This is really _really_ confusing. Your dmesg clearly says:

	PCI: Resource 44000000-47ffffff (f=1208, d=0, p=0)
	PCI: Resource 000010f0-000010f7 (f=101, d=0, p=0)
	PCI: Resource 00001800-00001803 (f=101, d=0, p=0)
	PCI: Resource 000010f8-000010ff (f=101, d=0, p=0)
	PCI: Resource 00001804-00001807 (f=101, d=0, p=0)
	PCI: Resource 00001080-000010bf (f=101, d=0, p=0)	*****
	PCI: Resource 42000000-4201ffff (f=200, d=0, p=0)
	PCI: Resource 00001000-0000107f (f=101, d=0, p=0)
	PCI: Resource 40900000-4090007f (f=200, d=0, p=0)
	PCI: Resource 00001400-000014ff (f=101, d=0, p=0)
	PCI: Resource 42100000-421000ff (f=200, d=0, p=0)
	PCI: Resource 000010a0-000010af (f=101, d=0, p=0)	*****
	PCI: Resource 41000000-41ffffff (f=1208, d=0, p=0)
	PCI: Resource 40800000-40803fff (f=200, d=0, p=0)
	PCI: Resource 40000000-407fffff (f=200, d=0, p=0)

note how the two resources I marked should have clashed, and if you had a
"request_resource()" in the loop that prints this out, then the code
_should_ have looked like this:

				....
                                DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
                                    r->start, r->end, r->flags, disabled, pass);
                                pr = pci_find_parent_resource(dev, r);
                                if (!pr || request_resource(pr, r) < 0) {
                                        printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s\n", idx, pci_name(dev));
                                        /* We'll assign a new address later */
                                        r->end -= r->start;
                                        r->start = 0;
				....

ie _immediately_ after the thing that prints out the resource, you have a 
"request_resource()" that should have _clashed_ with an earlier one, 
dammit!

And "request_resource()" hasn't actually changed lately (insert_resource() 
_did_ change), so I don't understand why it's now broken for you.

Can you add another DBG() statement to just after the

	pr = pci_find_parent_resource(..)

line? One that proints out the parent resource, ie just something like

	DBG("Parent resource: %08lx-%08lx (%lx)", pr->start, pr->end, pr->flags);

to see if the code somehow gets _really_ confused, and thinks that the
earlier clashing resource is actually the parent resource (it's definitely
not - the resource at 1080 is PCI device 0:0d.0, which is your promise IDE
controller).

I wonder if request_resource() is broken. "insert_resource()" had been 
broken for a _loong_ time (since its inception), maybe 
"request_resource()" also is. Hmm..

Greg, do you see something I've missed? I feel stupid.

		Linus
