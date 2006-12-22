Return-Path: <linux-kernel-owner+w=401wt.eu-S1751483AbWLVSds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWLVSds (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 13:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWLVSds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 13:33:48 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:61216 "EHLO
	brmea-mail-4.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbWLVSdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 13:33:47 -0500
X-Greylist: delayed 2790 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 13:33:47 EST
Date: Fri, 22 Dec 2006 12:47:13 -0500
From: James Puthukattukaran <James.Puthukattukaran@sun.com>
Subject: [PATCH]: x86-64 system crashes when no memory populating Node 0
To: linux-kernel@vger.kernel.org
Message-id: <458C1A21.8090009@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 4 socket AMD Operton system. The 2.6.18 kernel I have crashes 
when there is no memory in node0.

--James


diff -uNr linux-2.6.18-orig/arch/x86_64/kernel/aperture.c 
linux-2.6.18-new/arch/x86_64/kernel/aperture.c
--- linux-2.6.18-orig/arch/x86_64/kernel/aperture.c     2006-09-19 
23:42:06.000000000 -0400
+++ linux-2.6.18-new/arch/x86_64/kernel/aperture.c      2006-12-20 
19:43:42.000000000 -0500
@@ -38,7 +38,6 @@

 static u32 __init allocate_aperture(void)
 {
-       pg_data_t *nd0 = NODE_DATA(0);
        u32 aper_size;
        void *p;

@@ -52,12 +51,13 @@
         * Unfortunately we cannot move it up because that would make the
         * IOMMU useless.
         */
-       p = __alloc_bootmem_node(nd0, aper_size, aper_size, 0);
+
+       p = __alloc_bootmem(aper_size, aper_size, 0);
        if (!p || __pa(p)+aper_size > 0xffffffff) {
                printk("Cannot allocate aperture memory hole (%p,%uK)\n",
                       p, aper_size>>10);
                if (p)
-                       free_bootmem_node(nd0, __pa(p), aper_size);
+                       free_bootmem(__pa(p), aper_size);
                return 0;
        }
        printk("Mapping aperture over %d KB of RAM @ %lx\n",

