Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWDUAkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWDUAkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWDUAkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:40:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:22470 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932181AbWDUAko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:40:44 -0400
Date: Thu, 20 Apr 2006 19:40:42 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries: avoid crash in PCI code if mem system not up.
Message-ID: <20060421004042.GC7242@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,
Please apply and forward upstream.  And a question: once 
upon a time, the arch PCI subsystem was inited after mem init 
was done; currently, it seems to be happening before mem init. 
Is this intentional? 

--linas


[PATCH] powerpc/pseries: avoid crash in PCI code if mem system not up.

The powerpc code is currently performing PCI setup before
memory initialization. PCI setup touches PCI config space
registers. If the PCI card is bad, this will evoke an error,
which currrently can't be handled, as the PCI error recovery 
code expects kmalloc() to be functional.  This patch will
cause the system to punt instead of crashing with

cpu 0x0: Vector: 300 (Data Access) at [c0000000004434d0]
    pc: c0000000000c06b4: .kmem_cache_alloc+0x8c/0xf4
    lr: c00000000004ad6c: .eeh_send_failure_event+0x48/0xfc

This patch Will also print name of the offending pci device.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----

 arch/powerpc/platforms/pseries/eeh_event.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_event.c	2006-04-05 09:56:38.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_event.c	2006-04-20 19:29:48.000000000 -0500
@@ -124,7 +124,16 @@ int eeh_send_failure_event (struct devic
 {
 	unsigned long flags;
 	struct eeh_event *event;
+	char *location;
 
+	if (!mem_init_done)
+	{
+		printk(KERN_ERR "EEH: event during early boot not handled\n");
+		location = (char *) get_property(dn, "ibm,loc-code", NULL);
+		printk(KERN_ERR "EEH: device node = %s\n", dn->full_name);
+		printk(KERN_ERR "EEH: PCI location = %s\n", location);
+		return 1;
+	}
 	event = kmalloc(sizeof(*event), GFP_ATOMIC);
 	if (event == NULL) {
 		printk (KERN_ERR "EEH: out of memory, event not handled\n");
