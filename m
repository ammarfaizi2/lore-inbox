Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUGDKFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUGDKFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 06:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUGDKFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 06:05:09 -0400
Received: from ozlabs.org ([203.10.76.45]:59018 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265489AbUGDKFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 06:05:02 -0400
Date: Sun, 4 Jul 2004 20:04:07 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fix power3 boot
Message-ID: <20040704100407.GE4923@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We were calling init_pci_config_tokens too late in eeh_init. POWER3
(which doesnt have EEH) would fall out of eeh_init before calling it.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/eeh.c~fix_power3 arch/ppc64/kernel/eeh.c
--- foobar2/arch/ppc64/kernel/eeh.c~fix_power3	2004-07-04 19:40:57.528231647 +1000
+++ foobar2-anton/arch/ppc64/kernel/eeh.c	2004-07-04 19:42:26.439823930 +1000
@@ -574,6 +574,8 @@ void __init eeh_init(void)
 	struct eeh_early_enable_info info;
 	char *eeh_force_off = strstr(saved_command_line, "eeh-force-off");
 
+	init_pci_config_tokens();
+
 	ibm_set_eeh_option = rtas_token("ibm,set-eeh-option");
 	ibm_set_slot_reset = rtas_token("ibm,set-slot-reset");
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
@@ -588,7 +590,6 @@ void __init eeh_init(void)
 	}
 
 	/* Enable EEH for all adapters.  Note that eeh requires buid's */
-	init_pci_config_tokens();
 	for (phb = of_find_node_by_name(NULL, "pci"); phb;
 	     phb = of_find_node_by_name(phb, "pci")) {
 		unsigned long buid;

_
