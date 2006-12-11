Return-Path: <linux-kernel-owner+w=401wt.eu-S1762407AbWLKDsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762407AbWLKDsD (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 22:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762409AbWLKDsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 22:48:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:54472 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762406AbWLKDsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 22:48:01 -0500
Subject: pci_assign_resource() inconsistency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 14:47:55 +1100
Message-Id: <1165808875.7260.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

pci_assign_resource() was recently marked as much check the result code
(which I find annoying since it alread contains a printk if it fails but
anyway ... ).

So we do have a call to in in arch/powerpc/kernel/pci_32.c and I went to
fix the warning and ... wondered what should we do there ? So I looked
at other users and found it a bit strange...

So at first, an unassigned resource has the IORESOURCE_UNSET flag set
(or is supposed to). pci_assign_resource() itself will clear that flag
if it succeeds.

However, pretty much nothing else checks that flag, so it's mostly
useful.

Now, we have drivers/pci/setup-bus.c doing:

                if (pci_assign_resource(list->dev, idx)) {
                        res->start = 0;
                        res->end = 0;
                        res->flags = 0;
                }

So it basically destroys the resource content utterly when
pci_assign_resource() fails...

There are questions raised here:

 - Shouldn't we instead fix things so that instead, we properly
test for IORESOURCE_UNSET in pci_request_* & friends and just have
pci_assign_resource() continue as it's doing now, that is not clear that
flag if the assignment fails ?

 - setup-bus.c is a bit violent: As soon as it hits a p2p bridge, it
will bluntly re-assign everybody, not trying to check wether a resource
was already correctly assigned by the firmware or not. However, it never
sets IORESOURCE_UNSET. Thus if we do the above, we should probably have
it always set that bit before calling pci_assign_resource()...

Now the question is, what should I do in pci_32.c ... right now, we
unconditionally clear IORESOURCE_UNSET, which isn't very correct, then
call pci_assign_resource().

Should I do like the setup-bus.c and just completely wipe the resource
if pci_assign_resource() fail ? Or should I just stop clearing
IORESOURCE_UNSET (and thus rely on pci_assign_resource() to clear it
only if it succeeds, which seems to work) in which case I see no point
in making that function much check since there is nothing useful to do
when it fails and it does printk already.

Ben.
 

