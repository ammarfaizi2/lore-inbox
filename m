Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTIKWVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbTIKWVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:21:25 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:52644 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261556AbTIKWVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:21:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16224.62817.533540.928220@gargle.gargle.HOWL>
Date: Fri, 12 Sep 2003 00:21:21 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: mathieu.desnoyers@polymtl.ca
Subject: [PATCH][2.4.23-pre3] repair mpparse for default MP systems
CC: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu,

This patch for 2.4.23-pre3 should fix the problems your dual
P5 with default MP config has been having since 2.4.21-pre2.
Please let us know if it works or not.

/Mikael

--- linux-2.4.23-pre3/arch/i386/kernel/mpparse.c.~1~	2003-09-11 19:49:56.000000000 +0200
+++ linux-2.4.23-pre3/arch/i386/kernel/mpparse.c	2003-09-11 23:31:32.000000000 +0200
@@ -683,6 +683,24 @@
 	struct mpc_config_lintsrc lintsrc;
 	int linttypes[2] = { mp_ExtINT, mp_NMI };
 	int i;
+	struct {
+		int mp_bus_id_to_type[MAX_MP_BUSSES];
+		int mp_bus_id_to_node[MAX_MP_BUSSES];
+		int mp_bus_id_to_local[MAX_MP_BUSSES];
+		int mp_bus_id_to_pci_bus[MAX_MP_BUSSES];
+		struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
+	} *bus_data;
+
+	bus_data = alloc_bootmem(sizeof(*bus_data));
+	if (!bus_data)
+		panic("SMP mptable: out of memory!\n");
+	mp_bus_id_to_type = bus_data->mp_bus_id_to_type;
+	mp_bus_id_to_node = bus_data->mp_bus_id_to_node;
+	mp_bus_id_to_local = bus_data->mp_bus_id_to_local;
+	mp_bus_id_to_pci_bus = bus_data->mp_bus_id_to_pci_bus;
+	mp_irqs = bus_data->mp_irqs;
+	for (i = 0; i < MAX_MP_BUSSES; ++i)
+		mp_bus_id_to_pci_bus[i] = -1;
 
 	/*
 	 * local APIC has default address
