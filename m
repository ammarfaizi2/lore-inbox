Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262028AbTCLUzR>; Wed, 12 Mar 2003 15:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbTCLUym>; Wed, 12 Mar 2003 15:54:42 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53692 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S262013AbTCLUy1>; Wed, 12 Mar 2003 15:54:27 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Walrond <andrew@walrond.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Dmesg: Use a PAE enabled kernel
References: <3E63736F.6090000@walrond.org> <26670000.1046707704@[10.10.2.4]>
	<3E6381B9.4090708@walrond.org>
	<1046713568.6530.32.camel@irongate.swansea.linux.org.uk>
	<3E6387AE.9080001@walrond.org>
	<1046719362.7316.4.camel@irongate.swansea.linux.org.uk>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Mar 2003 13:05:02 -0800
In-Reply-To: <1046719362.7316.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <523clswb29.fsf_-_@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Mar 2003 21:05:04.0804 (UTC) FILETIME=[0DDFAE40:01C2E8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about something like the following (untested) patch?

This is against 2.5 but will probably apply with offset to 2.4.

 - Roland

--- 1.71/arch/i386/kernel/setup.c	Thu Feb 27 16:10:55 2003
+++ edited/arch/i386/kernel/setup.c	Wed Mar 12 12:54:42 2003
@@ -634,8 +634,11 @@
 		max_low_pfn = MAXMEM_PFN;
 #ifndef CONFIG_HIGHMEM
 		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
-					MAXMEM>>20);
+		printk(KERN_WARNING "WARNING: only %ldMB can be addressed.\n"
+                       "%ldMB of RAM is inaccessible and will not be used.\n",
+		       MAXMEM >> 20,
+		       PAGE_SHIFT < 20 ? (max_pfn - MAXMEM_PFN) >> (20 - PAGE_SHIFT)
+				       : (max_pfn - MAXMEM_PFN) << (PAGE_SHIFT - 20));
 		if (max_pfn > MAX_NONPAE_PFN)
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
 		else
@@ -644,9 +647,12 @@
 #else /* !CONFIG_HIGHMEM */
 #ifndef CONFIG_X86_PAE
 		if (max_pfn > MAX_NONPAE_PFN) {
-			max_pfn = MAX_NONPAE_PFN;
-			printk(KERN_WARNING "Warning only 4GB will be used.\n");
+			printk(KERN_WARNING "WARNING: only 4GB can be addressed.\n"
+			       "%ldMB of RAM is inaccessible and will not be used.\n",
+			       PAGE_SHIFT < 20 ? (max_pfn - MAX_NONPAE_PFN) >> (20 - PAGE_SHIFT)
+					       : (max_pfn - MAX_NONPAE_PFN) << (PAGE_SHIFT - 20));
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
+			max_pfn = MAX_NONPAE_PFN;
 		}
 #endif /* !CONFIG_X86_PAE */
 #endif /* !CONFIG_HIGHMEM */
