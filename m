Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUJJRAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUJJRAl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 13:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUJJRAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 13:00:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:60044 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268344AbUJJRAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 13:00:39 -0400
Date: Sun, 10 Oct 2004 10:00:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Li, Shaohua" <shaohua.li@intel.com>
cc: CaT <cat@zip.com.au>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: RE: promise controller resource alloc problems with ~2.6.8
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305754575A3@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0410100955120.3897@ppc970.osdl.org>
References: <16A54BF5D6E14E4D916CE26C9AD305754575A3@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Oct 2004, Li, Shaohua wrote:

> >On Thu, Sep 30, 2004 at 04:56:21PM -0700, Linus Torvalds wrote:
> >> Now, the reason for using "insert_resource()" in arch/i386/pci/i386.c
> >> should go away with Shaohua Li's patch, so I'd love to hear if
> applying
> >> Li's patch _and_ making the "insert_resource()" be a
> "request_resource()"
> >> fixes the problem for you.
> >
> >You meant this, right?
> >
> >if (!pr || insert_resource(pr, r) < 0)
> >	printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge
>  
> ^^^^^^^^^
> >%s\n", idx, pci_name(dev));
> I go through the thread again and I guess you changed the wrong place. 

Ahh.. Yes. I was confused, because there is only one "insert_region()" 
ain arch/i386/pci/i386.c, so I just automatically assumed CaT changed that 
one without looking at the details.

So if CaT changed the "request_resource()" in to an "insert_resource()"
in pcibios_allocate_bus_resources(), then that explains the impossible
dmesg.

Cat: change that one back, and the function to look at is
"pcibios_allocate_resources()" (almost the same name, but no "bus" in it),
which has a "insert_resource()" in it. That "insert_resource()" should be
a "request_resource()" (and for you it won't matter, but other people will
likely want to additionally apply Shaohua's patch to put in ACPI resources
last).

Hope this clears it all up. Knock wood.

		Linus
