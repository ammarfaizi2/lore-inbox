Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTKOTpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 14:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTKOTpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 14:45:00 -0500
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:37385
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S261938AbTKOTo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 14:44:58 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: "PCI: Cannot allocate resource region" error misleading (with
 patch)
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Sat, 15 Nov 2003 14:44:56 -0500
Message-ID: <87llqhs9fr.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) XEmacs/21.4 (Reasonable
 Discussion, linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that this error typically indicates that the resource is
being remapped elsewhere, but no indication is given of the remapping,
leading the naive user (e.g., me) to believe no memory was mapped at
all.  Perhaps a reasonable patch would be:

--- linux-2.6.0-test9/arch/i386/pci/i386.c.orig 2003-11-15 14:17:30.000000000 -0500
+++ linux-2.6.0-test9/arch/i386/pci/i386.c      2003-11-15 14:22:45.000000000 -0500
@@ -143,7 +143,7 @@
                                    r->start, r->end, r->flags, disabled, pass);
                                pr = pci_find_parent_resource(dev, r);
                                if (!pr || request_resource(pr, r) < 0) {
-                                       printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s\n", idx, pci_name(dev));
+                                       printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s (requested %08lx-%08lx); deferring reassignment\n", idx, pci_name(dev), r->start, r->end);
                                        /* We'll assign a new address later */
                                        r->end -= r->start;
                                        r->start = 0;
@@ -192,8 +192,11 @@
                         *  the BIOS forgot to do so or because we have decided the old
                         *  address was unusable for some reason.
                         */
-                       if (!r->start && r->end)
-                               pci_assign_resource(dev, idx);
+                       if (!r->start && r->end) {
+                               if (!pci_assign_resource(dev, idx)) {
+                                       printk(KERN_ERR "PCI: Reassigned region %d of device %s to %08lx-%08lx\n", idx, pci_name(dev), r->start, r->end);
+                               }
+                       }
                }
 
                if (pci_probe & PCI_ASSIGN_ROMS) {

Of course, I haven't come up with a solution to my original problem,
but I'm inclined the believe it originates with the nVidia
closed-source driver instead of with the kernel, since the open source
nv XFree86 driver doesn't exhibit the same set of problems (e.g., DVD
playback is fine), although its set of problems is likely to be at
least as large.  If anyone has any leads or can offer any insight, it
would be greatly appreciated.

Cheers,
Kyle
