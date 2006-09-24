Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752144AbWIXS5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbWIXS5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbWIXS5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:57:39 -0400
Received: from khc.piap.pl ([195.187.100.11]:25764 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1752144AbWIXS5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:57:38 -0400
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: NV SATA breakage: jgarzik/libata-dev#upstream etc
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 24 Sep 2006 20:57:34 +0200
Message-ID: <m3wt7tm6sh.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following commit in libata-dev breaks NV SATA init - I don't
have a dump handy, but the problem is a NULL ptr dereference here:

libata-core.c
int ata_device_add(const struct ata_probe_ent *ent)
{
...
        /* register each port bound to this device */
        for (i = 0; i < host->n_ports; i++) {
...
                /* start port */
                rc = ap->ops->port_start(ap);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The problematic commit is fea63e38013ec628ab3f7fddc4c2148064b7910a:
"[PATCH] libata: fix non-uniform ports handling

Non-uniform ports handling got broken while updating libata to handle
those in the same host.  Only separate irq for the non-uniform
secondary port was implemented while all other fields (host flags,
transfer mode...) of the secondary port simply shared those of the
first.

For ata_piix combined mode, which ATM is the only user of non-uniform
ports, this causes the secondary port assume the wrong type.  This can
cause PATA port to use SATA ops, which results in bogus check on PCS
and detection failure.

This patch adds ata_probe_ent->pinfo2 which points to optional
port_info for the secondary port.  For the time being, this seems to
be the simplest solution.  This workaround will be removed together
with ata_probe_ent itself after init model is updated to allow more
flexibility."


All details etc. are, as always, available on request.

00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
(prog-if 85 [Master SecO PriO])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 7250
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
        I/O ports at c800 [size=8]
        I/O ports at c480 [size=4]
        I/O ports at c400 [size=8]
        I/O ports at c080 [size=4]
        I/O ports at c000 [size=16]
        Memory at feaf9000 (32-bit, non-prefetchable) [size=4K]
-- 
Krzysztof Halasa
