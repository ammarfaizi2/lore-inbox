Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUHYP53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUHYP53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUHYP53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:57:29 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:53784 "EHLO
	mwinf0507.wanadoo.fr") by vger.kernel.org with ESMTP
	id S268121AbUHYP5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:57:07 -0400
Date: Wed, 25 Aug 2004 18:01:07 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: Zarakin <zarakin@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nmi_watchdog=2 - Oops with 2.6.8
Message-ID: <20040825160107.GA562@zaniah>
References: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 at 18:42 +0000, Zarakin wrote:

> Hi,
> 
> My Gentoo machine will not boot with nmi_watchdog=2 parameter - I get an
> oops at clear_msr_range.
> 
> Handwritten oops Info:
> CPU 0
> EIP:  0060: [<0xc0110d4b>] Not tainted
> EIP is at clear_msr_range+0x18/0x25
> eax: 0  ebx:1f  ecx: 3ba  edx: 0
> esi: 3a0  edi: 1a  ebp:0 esp: d7d83f74
> ds: 7b es: 7b ss: 68

> 0xc0110d4b <clear_msr_range+24>:        wrmsr

> model           : 3
> model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz

try this patch please.

--- linux-2.5/arch/i386/kernel/nmi.c~	2004-06-15 10:52:00.000000000 +0200
+++ linux-2.5/arch/i386/kernel/nmi.c	2004-08-25 17:33:45.000000000 +0200
@@ -376,7 +376,13 @@
 		clear_msr_range(0x3F1, 2);
 	/* MSR 0x3F0 seems to have a default value of 0xFC00, but current
 	   docs doesn't fully define it, so leave it alone for now. */
-	clear_msr_range(0x3A0, 31);
+	if (boot_cpu_data.x86_model >= 0x3) {
+		/* MSR_P4_IQ_ESCR0/1 (0x3ba/0x3bb) removed */
+		clear_msr_range(0x3A0, 26);
+		clear_msr_range(0x3BC, 3);
+	} else {
+		clear_msr_range(0x3A0, 31);
+	}
 	clear_msr_range(0x3C0, 6);
 	clear_msr_range(0x3C8, 6);
 	clear_msr_range(0x3E0, 2);
