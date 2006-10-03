Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWJCBWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWJCBWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWJCBWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:22:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030214AbWJCBWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:22:43 -0400
Date: Tue, 3 Oct 2006 03:22:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20061003012241.GF3278@stusta.de>
References: <20061002214954.GD665@shell0.pdx.osdl.net> <20061002234428.GE3278@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002234428.GE3278@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 01:44:28AM +0200, Adrian Bunk wrote:
> On Mon, Oct 02, 2006 at 02:49:54PM -0700, Judith Lebzelter wrote:
> 
> > Hello:
> 
> Hi Judith,
> 
> > For the automated cross-compile builds at OSDL, powerpc 64-bit 
> > 'allmodconfig' is failing.  The warnings/errors below appear in 
> > the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.
> 
> known for ages - the drivers need fixing.
> 
> You might want to convince Andrew accepting my patch to make 
> virt_to_bus/bus_to_virt give compile warnings on i386 for making
> people more aware of this problem...
>...

In case anyone is interested, the patch is below.

cu
Adrian


<--  snip  -->


virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
on i386.

Without such warnings people will never update their code and fix 
the errors in PPC64 builds.

And yes, some of the drivers affected are maintained.

This also catches accidential additions of users for these functions 
like a usage of bus_to_virt() in the infiniband code that was added in 
2.6.17-rc1 (already removed).

This patch increases the number of warnings shown during builds, but it 
seems worth including it at least in -mm for making people aware of this 
issue.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 7 Jul 2006
- 26 Jun 2006
- 27 Apr 2006
- 19 Apr 2006
- 6 Jan 2006
- 13 Dec 2005
- 23 Nov 2005
- 18 Nov 2005
- 12 Nov 2005

--- linux-2.6.14-mm2-full/include/asm-i386/io.h.old	2005-11-12 01:44:38.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-i386/io.h	2005-11-12 01:45:58.000000000 +0100
@@ -144,8 +144,14 @@
  *
  * Allow them on x86 for legacy drivers, though.
  */
-#define virt_to_bus virt_to_phys
-#define bus_to_virt phys_to_virt
+static inline unsigned long __deprecated virt_to_bus(volatile void * address)
+{
+	return __pa(address);
+}
+static inline void * __deprecated bus_to_virt(unsigned long address)
+{
+	return __va(address);
+}
 
 /*
  * readX/writeX() are used to access memory mapped devices. On some

