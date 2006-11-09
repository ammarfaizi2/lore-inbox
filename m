Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754568AbWKIDKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbWKIDKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 22:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbWKIDKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 22:10:21 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:666 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1754568AbWKIDKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 22:10:20 -0500
Date: Wed, 8 Nov 2006 19:09:44 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Reuben Farrelly <reuben-linuxkernel@reub.net>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] cpufreq: select consistently (Re: 2.6.19-rc5-mm1)
Message-Id: <20061108190944.6849b8d4.randy.dunlap@oracle.com>
In-Reply-To: <20061108201539.GB32721@redhat.com>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<4551BB5E.6090602@reub.net>
	<20061108120547.78048229.akpm@osdl.org>
	<20061108201539.GB32721@redhat.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 15:15:39 -0500 Dave Jones wrote:

> On Wed, Nov 08, 2006 at 12:05:47PM -0800, Andrew Morton wrote:
> 
>  > The problem is that you have 
>  > 
>  > > CONFIG_CPU_FREQ_TABLE=m
>  > > CONFIG_X86_ACPI_CPUFREQ=y
>  > 
>  > but acpi-cpufreq needs the stuff in freq_table.c.
>  > 
>  > This happens again and again and again and again.  I wish people would just
>  > stop using `select'.  It.  Doesn't.  Work.
>  > 
>  > Either we fix select or we stop using the damn thing.
> 
> So, why doesn't select set the symbol it's selecting to the
> same value as the symbol being configured ?
> That would solve the issue no?

Why does arch/i386/kernel/cpu/cpufreq/Kconfig say:

config X86_ACPI_CPUFREQ
	tristate "ACPI Processor P-States driver"
	select CPU_FREQ_TABLE
	depends on ACPI_PROCESSOR

but arch/x86_64/kernel/cpufreq/Kconfig say:

config X86_ACPI_CPUFREQ
	tristate "ACPI Processor P-States driver"
	depends on ACPI_PROCESSOR

# NOTE: no "select" on the latter one.  // Randy


Let's see.  Does that one-line patch fix anything?  <builds>

make oldconfig

< CONFIG_CPU_FREQ_TABLE=m
> CONFIG_CPU_FREQ_TABLE=y

Builds cleanly now.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Make x86_64 ACPI_CPU_FREQ select CPU_FREQ_TABLE like other methods do.
(although we should still eliminate as much use of 'select' as possible)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/x86_64/kernel/cpufreq/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19-rc5-mm1.orig/arch/x86_64/kernel/cpufreq/Kconfig
+++ linux-2.6.19-rc5-mm1/arch/x86_64/kernel/cpufreq/Kconfig
@@ -49,6 +49,7 @@ config X86_SPEEDSTEP_CENTRINO_ACPI
 
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
+	select CPU_FREQ_TABLE
 	depends on ACPI_PROCESSOR
 	help
 	  This driver adds a CPUFreq driver which utilizes the ACPI

