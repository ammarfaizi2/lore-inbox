Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933617AbWKQO3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933617AbWKQO3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933619AbWKQO3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:29:49 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43199 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S933617AbWKQO3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:29:48 -0500
Date: Fri, 17 Nov 2006 23:28:44 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: memory hotplug function redefinition/confusion
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       kamezawa.hiroyu@jp.fujitsu.com, kmannth@us.ibm.com
In-Reply-To: <20061116202520.afcb9224.randy.dunlap@oracle.com>
References: <20061116202520.afcb9224.randy.dunlap@oracle.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061117231515.ADBF.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> include/linux/memory_hotplug.h uses CONFIG_NUMA to decide:
(snip)
> but mm/init.c uses CONFIG_ACPI_NUMA to decide:
(snip)
> (sic: duplicate function above)

Indeed. It is strange. This is a patch for it.

Thanks for your report!

Bye.

--------

This is to fix compile error of x86-64 memory hotplug without
any NUMA option.

  CC      arch/x86_64/mm/init.o
arch/x86_64/mm/init.c:501: error: redefinition of 'memory_add_physaddr_to_nid'
include/linux/memory_hotplug.h:71: error: previous definition of 'memory_add_phys
addr_to_nid' was here
arch/x86_64/mm/init.c:509: error: redefinition of 'memory_add_physaddr_to_nid'
arch/x86_64/mm/init.c:501: error: previous definition of 'memory_add_physaddr_to_
nid' was here
make[1]: *** [arch/x86_64/mm/init.o] Error 1

I confirmed compile completion with !NUMA, (NUMA & !ACPI_NUMA),
or (NUMA & ACPI_NUMA).

This patch is for 2.6.19-rc5-mm2.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

----

 arch/x86_64/mm/init.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

Index: 19-rc5-mm2/arch/x86_64/mm/init.c
===================================================================
--- 19-rc5-mm2.orig/arch/x86_64/mm/init.c	2006-11-17 22:31:30.000000000 +0900
+++ 19-rc5-mm2/arch/x86_64/mm/init.c	2006-11-17 22:31:40.000000000 +0900
@@ -496,7 +496,7 @@ int remove_memory(u64 start, u64 size)
 }
 EXPORT_SYMBOL_GPL(remove_memory);
 
-#ifndef CONFIG_ACPI_NUMA
+#if !defined(CONFIG_ACPI_NUMA) && defined(CONFIG_NUMA)
 int memory_add_physaddr_to_nid(u64 start)
 {
 	return 0;
@@ -504,13 +504,6 @@ int memory_add_physaddr_to_nid(u64 start
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
 
-#ifndef CONFIG_ACPI_NUMA
-int memory_add_physaddr_to_nid(u64 start)
-{
-	return 0;
-}
-#endif
-
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #ifdef CONFIG_MEMORY_HOTPLUG_RESERVE

-- 
Yasunori Goto 


