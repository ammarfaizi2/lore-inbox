Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266159AbUFIPQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266159AbUFIPQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUFIPQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:16:12 -0400
Received: from holomorphy.com ([207.189.100.168]:9349 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266159AbUFIPQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:16:06 -0400
Date: Wed, 9 Jun 2004 08:16:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>, Eric BEGOT <eric_begot@yahoo.fr>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609151602.GN1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@fsmlabs.com>,
	Eric BEGOT <eric_begot@yahoo.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040609015001.31d249ca.akpm@osdl.org> <40C6F3C3.9040401@yahoo.fr> <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com> <20040609133653.GH1444@holomorphy.com> <Pine.LNX.4.58.0406090942420.1838@montezuma.fsmlabs.com> <20040609144809.GK1444@holomorphy.com> <20040609145849.GL1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609145849.GL1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 07:58:49AM -0700, William Lee Irwin III wrote:
> Actually I think blowing it away immediately is best. Bounds checks
> don't work for everything.

(a) fix mach-default compile due to missing definition of BAD_APICID
(b) fix UP APIC sans IO-APIC link failure


Index: mm1-2.6.7-rc3/include/asm-i386/mach-default/mach_apic.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/asm-i386/mach-default/mach_apic.h	2004-06-09 08:08:00.000000000 -0700
+++ mm1-2.6.7-rc3/include/asm-i386/mach-default/mach_apic.h	2004-06-09 08:10:17.000000000 -0700
@@ -2,6 +2,7 @@
 #define __ASM_MACH_APIC_H
 
 #include <mach_apicdef.h>
+#include <asm/smp.h>
 
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
Index: mm1-2.6.7-rc3/arch/i386/kernel/io_apic.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/io_apic.c	2004-06-09 08:08:00.000000000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/io_apic.c	2004-06-09 08:13:05.000000000 -0700
@@ -722,17 +722,6 @@
 
 __setup("pirq=", ioapic_pirq_setup);
 
-int get_physical_broadcast(void)
-{
-	unsigned int lvr, version;
-	lvr = apic_read(APIC_LVR);
-	version = GET_APIC_VERSION(lvr);
-	if (version >= 0x14)
-		return 0xff;
-	else
-		return 0xf;
-}
-
 /*
  * Find the IRQ entry number of a certain pin.
  */
Index: mm1-2.6.7-rc3/arch/i386/kernel/apic.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/i386/kernel/apic.c	2004-06-09 08:06:44.000000000 -0700
+++ mm1-2.6.7-rc3/arch/i386/kernel/apic.c	2004-06-09 08:13:27.000000000 -0700
@@ -80,6 +80,17 @@
 	apic_write_around(APIC_LVT0, v);
 }
 
+int get_physical_broadcast(void)
+{
+	unsigned int lvr, version;
+	lvr = apic_read(APIC_LVR);
+	version = GET_APIC_VERSION(lvr);
+	if (version >= 0x14)
+		return 0xff;
+	else
+		return 0xf;
+}
+
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;
