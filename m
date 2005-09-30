Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVI3Gug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVI3Gug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVI3Gug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:50:36 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:26081 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932563AbVI3Guf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:50:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Fri, 30 Sep 2005 08:51:08 +0200
User-Agent: KMail/1.8.2
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200509281624.29256.rjw@sisk.pl> <20050929165905.B15943@unix-os.sc.intel.com> <200509300726.20528.rjw@sisk.pl>
In-Reply-To: <200509300726.20528.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509300851.09327.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 30 of September 2005 07:26, Rafael J. Wysocki wrote:
> On Friday, 30 of September 2005 01:59, Siddha, Suresh B wrote:
> > On Fri, Sep 30, 2005 at 01:04:35AM +0200, Rafael J. Wysocki wrote:
> > > On Friday, 30 of September 2005 00:29, Siddha, Suresh B wrote:
> > > > Did you try just only my patch on top of 2.6.14-rc2? You can get that
> > > > patch from http://www.x86-64.org/lists/discuss/msg07313.html
> > > 
> > > The patch that I tested is attached.  I think it's the same one.  I've just applied
> > > it on top of 2.6.14-rc2-git7, and it doesn't boot.
> > 
> > It works fine for me. Only thing I see though is a warning for UP configuration.
> > Other than that UP, SMP(with and without hotplug) kernels boot fine. I will
> > send the warning fix to Andrew.
> > 
> > > The problem (as I see it) is this:
> > > In x86_64_start_kernel() you copy boot_level4_pgt[] into init_level4_pgt[],
> > > and you make the latter your current PGD by loading cr3 with its address.
> > > Fine.  With this PGD you call start_kernel() which calls setup_arch(), which
> > > calls zap_low_mappings(0) that fills init_level4_pgt[] (which at this moment
> > > is still your current PGD) with zeros ...
> > 
> > It clears only the zeroth entry. Not the whole pgd.
> 
> You are absolutely right.  I have misread this, sorry.
> 
> > Please send me your .config so that I can try reproducing the issue locally
> > here.
> 
> Of course.  The .config is attached.  Generally, it's a non-SMP box, and commenting
> out the zap_low_mappings((0) in setup_arch() makes the box boot again.

One more datapoint: The box boots if I move the zap_low_mappings((0)
in the following way:

--- linux-2.6.14-rc2-git7.orig/arch/x86_64/kernel/setup.c	2005-09-30 07:39:35.000000000 +0200
+++ linux-2.6.14-rc2-git7/arch/x86_64/kernel/setup.c	2005-09-30 08:31:20.000000000 +0200
@@ -571,8 +571,6 @@
 
 	init_memory_mapping(0, (end_pfn_map << PAGE_SHIFT));
 
-	zap_low_mappings(0);
-
 #ifdef CONFIG_ACPI
 	/*
 	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
@@ -680,6 +678,8 @@
 		get_smp_config();
 	init_apic_mappings();
 #endif
+	zap_low_mappings(0);
+
 
 	/*
 	 * Request address space for all standard RAM and ROM resources

iHowever, if I place the zap_low_mappings((0) before the
#define CONFIG_X86_LOCAL_APIC in line 673, it doesn't boot.

Certainly init_apic_mappings() is at fault.  Could that be a reult of a call to
alloc_bootmem_pages()?.

And one more: I have to boot with "noapic".

Greetings,
Rafael
