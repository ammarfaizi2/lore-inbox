Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162342AbWKQEZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162342AbWKQEZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 23:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162343AbWKQEZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 23:25:25 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:26480 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1162342AbWKQEZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 23:25:25 -0500
Date: Thu, 16 Nov 2006 20:25:20 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, y-goto@jp.fujitsu.com,
       kamezawa.hiroyu@jp.fujitsu.com, kmannth@us.ibm.com
Subject: memory hotplug function redefinition/confusion
Message-Id: <20061116202520.afcb9224.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.19-rc5-mm2:

include/linux/memory_hotplug.h uses CONFIG_NUMA to decide:

#ifdef CONFIG_NUMA
extern int memory_add_physaddr_to_nid(u64 start);
#else
static inline int memory_add_physaddr_to_nid(u64 start)
{
	return 0;
}
#endif

but mm/init.c uses CONFIG_ACPI_NUMA to decide:

#ifndef CONFIG_ACPI_NUMA
int memory_add_physaddr_to_nid(u64 start)
{
	return 0;
}
EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
#endif

#ifndef CONFIG_ACPI_NUMA
int memory_add_physaddr_to_nid(u64 start)
{
	return 0;
}
#endif

(sic: duplicate function above)

The CONFIG_NUMA vs. CONFIG_ACPI_NUMA seems to cause this build error:

  CC      arch/x86_64/mm/init.o
arch/x86_64/mm/init.c:501: error: redefinition of 'memory_add_physaddr_to_nid'
include/linux/memory_hotplug.h:71: error: previous definition of 'memory_add_phys
addr_to_nid' was here
arch/x86_64/mm/init.c:509: error: redefinition of 'memory_add_physaddr_to_nid'
arch/x86_64/mm/init.c:501: error: previous definition of 'memory_add_physaddr_to_
nid' was here
make[1]: *** [arch/x86_64/mm/init.o] Error 1
make: *** [arch/x86_64/mm] Error 2

---
~Randy
