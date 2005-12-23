Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVLWDNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVLWDNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 22:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbVLWDNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 22:13:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42880 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030385AbVLWDND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 22:13:03 -0500
Date: Thu, 22 Dec 2005 22:11:42 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: remove incorrect dependancy on CONFIG_APM
Message-ID: <20051223031142.GA23891@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051220212127.GA6833@redhat.com> <20051223021813.GH27525@stusta.de> <20051223022227.GB27537@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223022227.GB27537@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 09:22:27PM -0500, Dave Jones wrote:

 >  >   CC      arch/i386/kernel/apm.o
 >  > arch/i386/kernel/apm.c: In function 'apm_init':
 >  > arch/i386/kernel/apm.c:2304: error: 'pm_active' undeclared (first use in this function)
 >  > arch/i386/kernel/apm.c:2304: error: (Each undeclared identifier is reported only once
 >  > arch/i386/kernel/apm.c:2304: error: for each function it appears in.)
 >  > arch/i386/kernel/apm.c: In function 'apm_exit':
 >  > arch/i386/kernel/apm.c:2410: error: 'pm_active' undeclared (first use in this function)
 >  > make[1]: *** [arch/i386/kernel/apm.o] Error 1
 >  > 
 >  > <--  snip  -->
 >  > 
 >  > If PM_LEGACY causes user confusion for APM users, commit 
 >  > bca73e4bf8563d83f7856164caa44d5f42e44cca should be reverted.
 > 
 > Yeah, I realised that earlier too, my change was untested.
 > 
 > Hrmph.  For now I've enabled PM_LEGACY, but silently taking options
 > away like this is what surprises users.

Living dangerously with another not-compile-tested patch.
(It's building right now, but I'm about to go eat, and
 with my goldfish like attention span, I'll forget about it later)

The ifdef's are a bit ugly, but given it's a legacy interface,
maybe pm_active & co will all go away completely one day.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/arch/i386/Kconfig~	2005-12-22 22:06:10.000000000 -0500
+++ linux-2.6.14/arch/i386/Kconfig	2005-12-22 22:06:16.000000000 -0500
@@ -710,7 +710,7 @@ depends on PM && !X86_VISWS
 
 config APM
 	tristate "APM (Advanced Power Management) BIOS support"
-	depends on PM && PM_LEGACY
+	depends on PM
 	---help---
 	  APM is a BIOS specification for saving power using several different
 	  techniques. This is mostly useful for battery powered laptops with
--- linux-2.6.14/arch/i386/kernel/apm.c~	2005-12-22 21:53:43.000000000 -0500
+++ linux-2.6.14/arch/i386/kernel/apm.c	2005-12-22 21:54:02.000000000 -0500
@@ -2301,7 +2301,9 @@ static int __init apm_init(void)
 		apm_info.disabled = 1;
 		return -ENODEV;
 	}
+#ifdef CONFIG_PM_LEGACY
 	pm_active = 1;
+#endif
 
 	/*
 	 * Set up a segment that references the real mode segment 0x40
@@ -2407,7 +2409,9 @@ static void __exit apm_exit(void)
 	exit_kapmd = 1;
 	while (kapmd_running)
 		schedule();
+#ifdef CONFIG_PM_LEGACY
 	pm_active = 0;
+#endif
 }
 
 module_init(apm_init);
