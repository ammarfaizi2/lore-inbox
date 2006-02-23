Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWBWRJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWBWRJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWBWRJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:09:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751745AbWBWRJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:09:08 -0500
Date: Thu, 23 Feb 2006 09:08:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <1140713001.4672.73.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> 
 <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de>
 <1140713001.4672.73.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Feb 2006, Arjan van de Ven wrote:
> > 
> > I think you would first need to move the code first for that. Currently it starts
> > at 1MB, which means 1MB is already wasted of the aligned 2MB TLB entry.
> > 
> > I wouldn't have a problem with moving the 64bit kernel to 2MB though.
> 
> that was easy since it's a Config entry already ;)

Btw, the "low TLB entry" for the direct-mapped case can't be used as a 
hugetlb page anyway, due to the MMU splitting it up due to the special 
MTRR regions, if I recall correctly.

So this is probably a bigger performance win than just the difference 
between using one or two TLB entries.

The same should be true on x86, btw. Where we should use a physical start 
address of 4MB for best performance.

Does anybody want to run benchmarks? (Totally untested, may not boot, 
might physically accost your pets for all I know).

		Linus

---
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 0afec85..d2b1df8 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -715,7 +715,7 @@ config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
 
 	default "0x1000000" if CRASH_DUMP
-	default "0x100000"
+	default "0x400000"
 	help
 	  This gives the physical address where the kernel is loaded. Normally
 	  for regular kernels this value is 0x100000 (1MB). But in the case
