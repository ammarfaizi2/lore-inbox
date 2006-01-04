Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWADJdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWADJdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWADJdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:33:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:26567 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751225AbWADJdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:33:39 -0500
Date: Wed, 4 Jan 2006 15:03:20 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>, Andi Kleen <ak@muc.de>
Subject: [PATCH 1/2] x86_64: ioapic virtual wire mode fix
Message-ID: <20060104093320.GA4995@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o Currently, during kexec reboot, IOAPIC is re-programmed back to virtual
  wire mode if there was an i8259 connected to it. This enables getting
  timer interrupts in second kernel in legacy mode.

o After putting into virtual wire mode, IOAPIC delivers the i8259 interrupts
  to CPU0. This works well for kexec but not for kdump as we might crash
  on a different CPU and second kernel will not see timer interrupts.

o This patch modifies the redirection table entry to deliver the timer 
  interrupts to the cpu we are rebooting (instead of hardcoding to zero).
  This ensures that second kernel receives timer interrupts even on a 
  non-boot cpu.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---


diff -puN arch/x86_64/kernel/io_apic.c~kdump-x86_64-program-ioapic-non-boot-cpu-timer-interrupts arch/x86_64/kernel/io_apic.c
--- linux-2.6.15/arch/x86_64/kernel/io_apic.c~kdump-x86_64-program-ioapic-non-boot-cpu-timer-interrupts	2006-01-04 05:12:48.000000000 -0800
+++ linux-2.6.15-root/arch/x86_64/kernel/io_apic.c	2006-01-04 06:55:42.000000000 -0800
@@ -1245,8 +1245,8 @@ void disable_IO_APIC(void)
 		entry.dest_mode       = 0; /* Physical */
 		entry.delivery_mode   = 7; /* ExtInt */
 		entry.vector          = 0;
-		entry.dest.physical.physical_dest = 0;
-
+		entry.dest.physical.physical_dest =
+					GET_APIC_ID(apic_read(APIC_ID));
 
 		/*
 		 * Add it to the IO-APIC irq-routing table:
_
