Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVHQLus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVHQLus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVHQLus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:50:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41153 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751101AbVHQLus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:50:48 -0400
Date: Wed, 17 Aug 2005 13:50:41 +0200
From: Andi Kleen <ak@suse.de>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Undefined behaviour with get_cpu_vendor
Message-ID: <20050817115041.GK3996@wotan.suse.de>
References: <20050817095423.625.qmail@thales.mathematik.uni-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817095423.625.qmail@thales.mathematik.uni-ulm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 11:54:23AM +0200, Christian Ehrhardt wrote:
> 
> Hi,
> 
> Your Patch at (URL wrapped)
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git; \
> 		a=commit;h=99c6e60afff8a7bc6121aeb847dab27c556cf0c9
> 
> introduced an additional Parameter (int early) to get_cpu_vendor.
> However, the same function is called in arch/i386/kernel/apic.c (via
> an explicit extern declaration that doesn't have the new early parameter.

Sigh. All people adding externs like this should be ...

But it won't change anything - the only difference with
the flag being 0 is to read less fields, but since the function
has been called earlier and the data has not changed
the output is always the same.

Anyways, the correct change is to just remove this call because it's
not needed anymore because of the early CPU detection.

> I don't know if this can cause actual problems but I think something like
> the patch below is needed for correctness.

It's not needed for correctness. 

-Andi

Remove obsolete get_cpu_vendor call.

Since early CPU identify is in this information is already available

Signed-off-by: Andi Kleen <ak@suse.de>


Index: linux-2.6.13-rc6-misc/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.13-rc6-misc.orig/arch/i386/kernel/apic.c
+++ linux-2.6.13-rc6-misc/arch/i386/kernel/apic.c
@@ -726,15 +726,11 @@ __setup("apic=", apic_set_verbosity);
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
-	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
 	/* Disabled by kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
 
-	/* Workaround for us being called before identify_cpu(). */
-	get_cpu_vendor(&boot_cpu_data);
-
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
 		if ((boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model > 1) ||
