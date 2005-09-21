Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVIUUw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVIUUw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVIUUw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:52:57 -0400
Received: from fmr24.intel.com ([143.183.121.16]:25748 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S964825AbVIUUw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:52:56 -0400
Date: Wed, 21 Sep 2005 13:52:16 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@muc.de, discuss@x86-64.org
Subject: Dont use shortcut when using send_IPI_all in flat mode
Message-ID: <20050921135215.A14439@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This got missed during the previous update for not doing shortcut 
since it introduces race in IPI, when using flat mode.

The earlier patches addressed send_IPI_allbutself, this one
take care of the sendall() case as well.

Andrew: Please consider for -mm

-- 
Cheers,
Ashok Raj
- Open Source Technology Center



Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------------------------
 arch/x86_64/kernel/genapic_flat.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.14-rc1-mm1/arch/x86_64/kernel/genapic_flat.c
===================================================================
--- linux-2.6.14-rc1-mm1.orig/arch/x86_64/kernel/genapic_flat.c
+++ linux-2.6.14-rc1-mm1/arch/x86_64/kernel/genapic_flat.c
@@ -94,7 +94,11 @@ static void flat_send_IPI_allbutself(int
 
 static void flat_send_IPI_all(int vector)
 {
+#ifndef CONFIG_HOTPLUG_CPU
 	__send_IPI_shortcut(APIC_DEST_ALLINC, vector, APIC_DEST_LOGICAL);
+#else
+	flat_send_IPI_mask(cpu_online_map, vector);
+#endif
 }
 
 static int flat_apic_id_registered(void)
