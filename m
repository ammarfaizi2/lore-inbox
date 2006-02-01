Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWBAIIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWBAIIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 03:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWBAIIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 03:08:13 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:14272 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750706AbWBAIIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 03:08:11 -0500
Date: Wed, 1 Feb 2006 03:03:38 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch -mm4] i386: __init should be __cpuinit
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <200602010306_MC3-1-B751-57FB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060201053357.GA5335@redhat.com>

On Wed, 1 Feb 2006 at 00:33:57 -0500, Dave Jones wrote:

> On Tue, Jan 31, 2006 at 11:49:43PM -0500, Chuck Ebbert wrote:
>  > To fix this, change every instance of __init that seems suspicious
>  > into __cpuinit.  When !CONFIG_HOTPLUG_CPU there is no change in .text
>  > or .data size.  When enabled, .text += 3248 bytes; .data += 2148 bytes.
>  > 
>  > This should be safe in every case; the only drawback is the extra code and
>  > data when CPU hotplug is enabled.
>
> How about leaving it __init on non-hotplug systems, and somehow removing
> those from cpu_devs, so get_cpu_vendor() just skips them ?
> NULL'ing those entries should be just a few bytes, instead of adding 5KB.

That's what I wanted to do but wasn't sure how.  Maybe e.g. like this?

--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/umc.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/umc.c
@@ -5,12 +5,12 @@
 
 /* UMC chips appear to be only either 386 or 486, so no special init takes place.
  */
-static void __cpuinit init_umc(struct cpuinfo_x86 * c)
+static void __init init_umc(struct cpuinfo_x86 * c)
 {
 
 }
 
-static struct cpu_dev umc_cpu_dev __cpuinitdata = {
+static struct cpu_dev umc_cpu_dev __initdata = {
 	.c_vendor	= "UMC",
 	.c_ident 	= { "UMC UMC UMC" },
 	.c_models = {
@@ -31,3 +31,11 @@ int __init umc_init_cpu(void)
 }
 
 //early_arch_initcall(umc_init_cpu);
+
+int __init umc_exit_cpu(void)
+{
+	cpu_devs[X86_VENDOR_UMC] = NULL;
+	return 0;
+}
+
+late_initcall(umc_exit_cpu);
-- 
Chuck
