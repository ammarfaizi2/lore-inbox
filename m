Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVCCVXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVCCVXh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVCCVQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:16:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40109 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262421AbVCCVHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:07:19 -0500
Date: Thu, 3 Mar 2005 13:27:37 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: mikpe@csd.uu.se, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: [thomas_cj_chang@wistron.com.tw: Kernel 2.4.28 can't boot into OS without noapic]
Message-ID: <20050303162736.GC7935@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I'm forwarding your message to Mikael and Len, who have knowledge
on the IOAPIC infrastructure. 

----- Forwarded message from thomas_cj_chang@wistron.com.tw -----

From: thomas_cj_chang@wistron.com.tw
Date: Wed, 2 Mar 2005 13:37:03 +0800
To: marcelo.tosatti@cyclades.com
Subject: Kernel 2.4.28 can't boot into OS without noapic

Hi,

Sorry to interrupt you. I'm BIOS engineer from Taiwan. I found an kernel IO-APIC
bug in my current project.
The BUS id report in MPTable was miss interpreter by kernel. For more detail
information please reference below description.

System architecture

      +-----------+    HT LINK    +-------+  HT LINK  +-------+
      |  nvidia   +---------------+ CPU0  +-----------+  CPU1 |
      |   CK804   | (bus 80)      +---+---+           +-------+
      +-----------+                   | (HT LINK)
                                 +---+------+
                                 | AMD 8131 | (bus 0)
                                 +---+------+
                                      |
                                 +---+------+
                                 | AMD 8111 | (bus 1)
                                 +----------+


Kernel 2.4.xx will parsing MPTable and contruct a table as below.
It is ok for signal PCI bus system. But in Multiple PCI bus system BIOS
will using actual PCI bus number as the bus ID. In this case bus number
and array index not equivalent. There is no problem to create this array.
 But when boot with SMP kernel IO-APIC code 'pin_2_irq' will using bus ID
as the array index to reference 'mp_bus_id_to_type' array. It will
get incorrect bus type thus irq pin will not programming and system may go
suspend by peripheral driver never get it interrupt signal.
This problem can easily solve by increase 'MAX_MP_BUSSES' but it will waste
kernel memory size. Or we can correct 'smp_read_mpc' to support
multiple PCI bus ID assignment.


        +---------------+
        |               |
        +---------------+
        |               |
        :               :
        |               |
        +---------------+  <- mp_bus_id_to_type, bus_data
        |  bus0         |
        |  bus1         |
        |  bus2         |  ? mp_bus_id_to_type[80]
        |  bus3         |
        |  bus80        |
        |  bus81        |
        +---------------+  <- mp_bus_id_to_node
        |               |
        |               |
        |               |
        +---------------+  <- mp_bus_id_to_local
        |               |
        |               |
        |               |
        +---------------+  <- mp_bus_id_to_pci_bus
        |               |
        |               |
        |               |
        +---------------+  <- mp_irqs
        |               |
        |               |
        |               |
        +---------------+


Here is MP spec about multiple PCI bus section.
D.2 Bus Entries in Systems with More Than One PCI Bus
To accommodate systems with more than one PCI bus within the confines of version
 1.1 of this
specification, construction of the bus entries on the MP configuration table
must be handled in a
very particular sequence:
1. Begin with bus entries for the PCI buses. Start at bus zero, using the actual
 PCI bus number as
the bus ID for the bus entry.
2. Add entries for other buses. These entries can use bus ID numbers left vacant
 by the PCI bus
entries.
This sequence implies that bus ID numbers do not have to increase sequentially
by increments of
one; the requirement is that they must appear in ascending order by bus ID
number. This specific
interpretation of the information presented in Table 4-7 ensures consistency
between the
information in the MP configuration table and the model for systems with
multiple PCI buses that
is presented in the formal PCI specification, which allows for more flexibility
in bus numbering.
This numbering scheme requires bus entries in the MP configuration table to be
sorted
appropriately. For example, bus entries should appear in the order PCI (0), EISA
 (1), and PCI(4)
in a system with three buses, two PCI buses numbered 0 and 4, and a single EISA
bus numbered
as 1.


Best Regard
Thomas CJ Chang
  Office - 8691-2319
  Mobile - 0933825636

----- End forwarded message -----
