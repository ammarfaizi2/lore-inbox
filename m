Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbTDNVlN (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTDNVkg (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:40:36 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:61797 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263943AbTDNVjI (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:39:08 -0400
Date: Mon, 14 Apr 2003 17:50:46 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kunmap_atomic debugging problem
Message-ID: <Pine.LNX.4.44.0304141749550.2691-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resend from a few months ago ;)]

I found a bug in the HIGHMEM_DEBUG code, in kunmap_atomic()
to be specific.  The problem is that kunmap_atomic() can get
called with an address which isn't page aligned, but we compare
that address to a page aligned address and bug if the two
aren't equal.

The obvious fix is to page-align the address before doing the
check, we're not doing anything else with it anyway since
kunmap_atomic() is a nop if HIGHMEM_DEBUG is off.


--- linux-2.4.20/include/asm-i386/highmem.h.debug	2003-04-14 17:46:28.000000000 -0400
+++ linux-2.4.20/include/asm-i386/highmem.h	2003-04-14 17:46:43.000000000 -0400
@@ -109,7 +109,7 @@ static inline void *kmap_atomic(struct p
 static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 {
 #if HIGHMEM_DEBUG
-	unsigned long vaddr = (unsigned long) kvaddr;
+	unsigned long vaddr = (unsigned long) kvaddr & PAGE_ADDRESS;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < FIXADDR_START) // FIXME

