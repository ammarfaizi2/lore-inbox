Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSLEQXf>; Thu, 5 Dec 2002 11:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSLEQXe>; Thu, 5 Dec 2002 11:23:34 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:40089 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261701AbSLEQXc>; Thu, 5 Dec 2002 11:23:32 -0500
Date: Thu, 5 Dec 2002 14:30:51 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, "" <linux-mm@kvack.org>
Subject: [PATCH] bugfix for HIGHMEM_DEBUG
Message-ID: <Pine.LNX.4.50L.0212051428070.22252-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I found a bug in the HIGHMEM_DEBUG code, in kunmap_atomic()
to be specific.  The problem is that kunmap_atomic() can get
called with an address which isn't page aligned, but we compare
that address to a page aligned address and bug if the two
aren't equal.

The obvious fix is to page-align the address before doing the
check, we're not doing anything else with it anyway since
kunmap_atomic() is a nop if HIGHMEM_DEBUG is off.

please apply,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?
http://www.surriel.com/		http://guru.conectiva.com/


--- include/asm/highmem.h.orig	2002-12-05 13:23:31.000000000 -0200
+++ include/asm/highmem.h	2002-12-05 13:13:18.000000000 -0200
@@ -106,7 +106,7 @@
 static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 {
 #if HIGHMEM_DEBUG
-	unsigned long vaddr = (unsigned long) kvaddr;
+	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();

 	if (vaddr < FIXADDR_START) // FIXME
