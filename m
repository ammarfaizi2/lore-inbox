Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbULFDXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbULFDXO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 22:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbULFDXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 22:23:14 -0500
Received: from ozlabs.org ([203.10.76.45]:7370 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261462AbULFDXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 22:23:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16819.53892.21800.432263@cargo.ozlabs.ibm.com>
Date: Mon, 6 Dec 2004 14:31:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Close firmware stdin
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew & Linus,

We recently found a problem that was causing memory corruption during
boot on IBM POWER5 machines.  The problem was that the if you have a
USB keyboard and it is set to the input device for the firmware, it
will still be active when the kernel is started.  That means that the
OHCI controller has pointers to various memory areas that it polls for
transfers to do.  When we start using that same memory in the kernel,
bad things can happen.  (This isn't a problem on powermacs because the
Apple OF implements a "quiesce" call which turns off all the devices
it is using.)

This patch fixes the problem by calling the Open Firmware "close"
method for the input device.  Stephen Rothwell and I have verified
that doing this fixes the problem on the POWER5 machine where we
observed it.  I verified that this patch doesn't cause any problems on
powermacs.

I think this patch should go into 2.6.10 since it fixes a nasty memory
corruption bug that can cause rather subtle and hard-to-diagnose
problems during boot.  (The symptom on the POWER5 machine with the
particular kernel that we were using was that reading /proc/net/tcp
would oops, due to one of the pointers in tcp_ehash being corrupted.)

Signed-off-by: Paul Mackerras <paulus@samba.org>

--- linux-2.5/arch/ppc64/kernel/prom_init.c	2004-11-26 20:40:32.000000000 +1100
+++ g5-ppc64/arch/ppc64/kernel/prom_init.c	2004-12-04 14:54:08.000000000 +1100
@@ -1108,6 +1108,16 @@
 	}
 }
 
+static void __init prom_close_stdin(void)
+{
+	unsigned long offset = reloc_offset();
+	struct prom_t *_prom = PTRRELOC(&prom);
+	ihandle val;
+
+	if (prom_getprop(_prom->chosen, "stdin", &val, sizeof(val)) > 0)
+		call_prom("close", 1, 0, val);
+}
+
 static int __init prom_find_machine_type(void)
 {
 	unsigned long offset = reloc_offset();
@@ -1686,6 +1696,9 @@
        	prom_printf("copying OF device tree ...\n");
        	flatten_device_tree();
 
+	/* in case stdin is USB and still active on IBM machines... */
+	prom_close_stdin();
+
 	/*
 	 * Call OF "quiesce" method to shut down pending DMA's from
 	 * devices etc...
