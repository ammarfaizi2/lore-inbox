Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVJAKCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVJAKCm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 06:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVJAKCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 06:02:41 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:23270 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750784AbVJAKCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 06:02:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [discuss] Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Sat, 1 Oct 2005 12:03:20 +0200
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, ak@suse.de, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200509281624.29256.rjw@sisk.pl> <20050930182530.E28092@unix-os.sc.intel.com> <200510010947.25841.rjw@sisk.pl>
In-Reply-To: <200510010947.25841.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510011203.20828.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 1 of October 2005 09:47, Rafael J. Wysocki wrote:
> On Saturday, 1 of October 2005 03:25, Siddha, Suresh B wrote:
]-- snip --[
> > I looked at init_apic_mappings() and didn't give me any clue.
> > alloc_bootmem_pages() don't use low direct mappings.
> 
> OK, I'll try to narrow this a bit more.

Done.

I got this from the early printk:

Bootdata ok (command line is root=/dev/hdc6 vga=792 selinux=0 noapic resume=/dev/hdc3 console=ttyS0,57600 console=tty0 debug earlyprintk=serial,tt
yS0,57600 init=/bin/bash)
Linux version 2.6.14-rc3 (rafael@chimera) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #3 PREEMPT Sat Oct 1 10:54:55 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ff40000 (usable)
 BIOS-e820: 000000002ff40000 - 000000002ff50000 (ACPI data)
 BIOS-e820: 000000002ff50000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
kernel direct mapping tables upto ffff8100fee01000 @ 8000-b000
  >>> ERROR: Invalid checksum
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
PANIC: early exception rip ffffffff804c7467 error 0 cr2 fbd90

Call Trace:<ffffffff804c7467>{get_smp_config+695} <ffffffff804c9891>{paging_init+161}
       <ffffffff804c3b37>{acpi_parse_fadt+135} <ffffffff804d0b3a>{acpi_table_parse+76}
       <ffffffff804c19b7>{setup_arch+2183} <ffffffff804ba5fd>{start_kernel+45}
       <ffffffff804ba260>{_sinittext+608}

It shows that there's something wrong with get_smp_config(), but it shouldn't
have been called in the first place, as it was a non-SMP kernel.

The appended patch fixes the issue for me, but still if I run an SMP kernel on this
box, it crashes in get_smp_config().

If you want me to debug this further, please tell me what to do next.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc3/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/x86_64/kernel/mpparse.c	2005-10-01 10:37:53.000000000 +0200
+++ linux-2.6.14-rc3/arch/x86_64/kernel/mpparse.c	2005-10-01 11:17:56.000000000 +0200
@@ -658,7 +658,7 @@
  */
 void __init find_smp_config (void)
 {
-#ifdef CONFIG_X86_LOCAL_APIC
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 	find_intel_smp();
 #endif
 }
