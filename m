Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUCGNbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbUCGNbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:31:39 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:49158 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261950AbUCGNbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:31:35 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: Highmem emulation for 2.6?
Date: Sun, 7 Mar 2004 14:19:36 +0100
User-Agent: KMail/1.6.1
Cc: Pavel Machek <pavel@ucw.cz>
References: <20040307125939.GA965@elf.ucw.cz>
In-Reply-To: <20040307125939.GA965@elf.ucw.cz>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403071415.51065@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oFySAtfe2ZVbZ46"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_oFySAtfe2ZVbZ46
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 07 March 2004 13:59, Pavel Machek wrote:

Hi Pavel,

> Does anyone have `subj`?
something like attached patch? Only for x86 now. Ontop of 2.6.4-rc1-mm2.

ciao, Marc

--Boundary-00=_oFySAtfe2ZVbZ46
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="emulate-highmem-2.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="emulate-highmem-2.6.patch"

--- old/include/asm-i386/setup.h	2004-02-26 01:29:43.000000000 +0100
+++ 2.6.4-rc1-mm2/include/asm-i386/setup.h	2004-03-07 14:08:33.000000000 +0100
@@ -13,7 +13,21 @@
 /*
  * Reserved space for vmalloc and iomap - defined in asm/page.h
  */
+#ifdef CONFIG_HIGHMEM_EMULATION
+#define ORDER_DOWN(x)  ((x >> (MAX_ORDER-1)) << (MAX_ORDER-1))
+#define MAXMEM_PFN					\
+({							\
+	int __max_pfn;					\
+	if (max_pfn > PFN_DOWN(MAXMEM))			\
+		__max_pfn = PFN_DOWN(MAXMEM);		\
+	else						\
+		__max_pfn = ORDER_DOWN(max_pfn / 5);	\
+	__max_pfn;					\
+)}
+#else
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+#endif
+
 #define MAX_NONPAE_PFN	(1 << 20)
 
 /*
--- old/arch/i386/Kconfig	2004-03-05 17:16:45.000000000 +0100
+++ 2.6.4-rc1-mm2/arch/i386/Kconfig	2004-03-07 14:11:57.000000000 +0100
@@ -773,6 +773,19 @@ config X86_PAE
 	depends on HIGHMEM64G
 	default y
 
+config HIGHMEM_EMULATION
+	bool '  Emulate HIGHMEM on lowmem machines'
+	depends on HIGHMEM
+	default n
+	---help---
+	  Really obvious. With this option turned on and also selecting
+	  High Memory Support (4GB||64GB) you can emulate HIGHMEM on lowmem
+	  mashines. This does nothing usefull, nothing speed improvement
+	  or anything else but helps you to debug HIGHMEM code on lowmem  
+	  mashines.
+
+	  If unsure, say N.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"

--Boundary-00=_oFySAtfe2ZVbZ46--
