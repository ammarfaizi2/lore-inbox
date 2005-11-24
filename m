Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVKWX4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVKWX4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVKWXz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:55:57 -0500
Received: from fmr16.intel.com ([192.55.52.70]:52613 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030524AbVKWXrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:47:22 -0500
Subject: [PATCH] disable LAPIC completely for offline CPU
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Raj, Ashok" <ashok.raj@intel.com>, akpm <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 23:07:58 -0800
Message-Id: <1132816078.9686.12.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling LAPIC timer isn't sufficient. In some situations, such as we
enabled NMI watchdog, there is still unexpected interrupt (such as NMI)
invoked in offline CPU. This also avoids offline CPU receives spurious
interrupt and anything similar.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.14-root/arch/i386/kernel/smpboot.c   |    3 +--
 linux-2.6.14-root/arch/x86_64/kernel/smpboot.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/x86_64/kernel/smpboot.c~cpuhp-disable-lapic arch/x86_64/kernel/smpboot.c
--- linux-2.6.14/arch/x86_64/kernel/smpboot.c~cpuhp-disable-lapic	2005-11-23 19:27:36.000000000 -0800
+++ linux-2.6.14-root/arch/x86_64/kernel/smpboot.c	2005-11-23 19:28:27.000000000 -0800
@@ -1181,7 +1181,7 @@ int __cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
-	disable_APIC_timer();
+	disable_local_APIC();
 
 	/*
 	 * HACK:
diff -puN arch/i386/kernel/smpboot.c~cpuhp-disable-lapic arch/i386/kernel/smpboot.c
--- linux-2.6.14/arch/i386/kernel/smpboot.c~cpuhp-disable-lapic	2005-11-23 19:28:38.000000000 -0800
+++ linux-2.6.14-root/arch/i386/kernel/smpboot.c	2005-11-23 19:30:05.000000000 -0800
@@ -1338,8 +1338,7 @@ int __cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
-	/* We enable the timer again on the exit path of the death loop */
-	disable_APIC_timer();
+	disable_local_APIC();
 	/* Allow any queued timer interrupts to get serviced */
 	local_irq_enable();
 	mdelay(1);
_


