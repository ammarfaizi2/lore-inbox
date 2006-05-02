Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWEBPpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWEBPpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWEBPpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:45:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:54676 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964893AbWEBPpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:45:38 -0400
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Date: Tue, 2 May 2006 17:45:32 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20060419112130.GA22648@elte.hu> <200605021703.37195.ak@suse.de> <44577822.8050103@mbligh.org>
In-Reply-To: <44577822.8050103@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605021745.32907.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 17:17, Martin J. Bligh wrote:
> Andi Kleen wrote:
> > On Tuesday 02 May 2006 16:02, Martin J. Bligh wrote:
> > 
> >>>Oh that's a 32bit kernel. I don't think the 32bit NUMA has ever worked
> >>>anywhere but some Summit systems (at least every time I tried it it blew up 
> >>>on me and nobody seems to use it regularly). Maybe it would be finally time to mark it 
> >>>CONFIG_BROKEN though or just remove it (even by design it doesn't work very well) 
> >>
> >>Bollocks. It works fine, 
> > 
> > On what kind of box? Some summit system, right?
> 
> Summit and NUMA-Q, ie everything we originally created it for.

That's my point - it usually crashes everywhere else.

> 
> > I think I stand by my original statement.
> 
> If it works fine on some platforms and not on others, I would venture to
> suggest it's a platform-specific issue, and marking the whole thing as
> CONFIG_BROKEN would be an entirely inappropriate overreaction to what
> is probably a simple bug.

The problem is that it's not regression tested and quite complex and tends
to break often and stay broken.

If you don't want to mark it CONFIG_BROKEN then i would suggest a panic
early when the system isn't SUMMIT (I think NUMAQ does this already)

Something like the appended patch

-Andi

i386: Panic the system early when a NUMA kernel doesn't run on IBM NUMA

It has been broken forever anywhere else and is not too useful
anyways so best to disable it.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/srat.c
===================================================================
--- linux.orig/arch/i386/kernel/srat.c
+++ linux/arch/i386/kernel/srat.c
@@ -327,6 +327,14 @@ int __init get_memcfg_from_srat(void)
 	int tables = 0;
 	int i = 0;
 
+	extern int use_cyclone;
+	if (use_cyclone == 0) {
+		/* Make sure user sees something */
+		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
+		early_printk(s);
+		panic(s); 
+	}
+
 	if (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,
 						rsdp_address))) {
 		printk("%s: System description tables not found\n",
Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -517,6 +517,9 @@ config NUMA
 	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI))
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
+	help
+		NUMA support. Note this only works on IBM x440 or IBM NUMAQ.
+		Don't try to use it anywhere else.
 
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)


