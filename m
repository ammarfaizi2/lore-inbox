Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbTCYHEp>; Tue, 25 Mar 2003 02:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbTCYHEp>; Tue, 25 Mar 2003 02:04:45 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:23176 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261572AbTCYHEo>; Tue, 25 Mar 2003 02:04:44 -0500
Date: Tue, 25 Mar 2003 08:15:32 +0100
From: Andi Kleen <ak@muc.de>
To: ink@jurassic.park.msu.ru
Cc: linux-kernel@vger.kernel.org
Subject: cacheline size detection code in 2.5.66
Message-ID: <20030325071532.GA19217@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

You added this code in 2.5.66: 

+       /*
+        * Assume PCI cacheline size of 32 bytes for all x86s except K7/K8
+        * and P4. It's also good for 386/486s (which actually have 16)
+        * as quite a few PCI devices do not support smaller values.
+        */
+        pci_cache_line_size = 32 >> 2;
+       if (c->x86 >= 6 && c->x86_vendor == X86_VENDOR_AMD)
+               pci_cache_line_size = 64 >> 2;  /* K7 & K8 */
+       else if (c->x86 > 6)
+               pci_cache_line_size = 128 >> 2; /* P4 */

This will be wrong on Pentium M for example which has a 32byte cache
line but x86 model 9. But it's actually not needed, because all the 
new CPUs report their cacheline size as part of CPUID for CLFLUSH.

When the CPU supports CLFLUSH you can just extract it from 
the second byte in the second word reported by CPUID 1.
With that just use what the CPU tells you. This should also
work correctly on VIA etc which afaik support CLFLUSH 
in the newer CPUs.

The x86-64 port extract it like this in setup.c:
	if (c->x86_capability[0] & (1<<19)) 
       		c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
	}. 
I changed its pci code to use that directly now. i386 likely
should too. When no CLFLUSH is supported you can safely assume 32byte
cachelines.

-Andi

	



