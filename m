Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265851AbUFIRFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbUFIRFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbUFIRFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:05:37 -0400
Received: from holomorphy.com ([207.189.100.168]:55941 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265851AbUFIRFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:05:35 -0400
Date: Wed, 9 Jun 2004 10:05:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609170528.GR1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040609015001.31d249ca.akpm@osdl.org> <200406091335.15566.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406091335.15566.norberto+linux-kernel@bensa.ath.cx>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 01:35:15PM -0300, Norberto Bensa wrote:
>   CC      drivers/pci/msi.o
> drivers/pci/msi.c: In function `msi_address_init':
> drivers/pci/msi.c:265: error: invalid operands to binary <<
> make[2]: *** [drivers/pci/msi.o] Error 1
> make[1]: *** [drivers/pci] Error 2
> make: *** [drivers] Error 2
> The offending line is:
> 
>         msi_address->lo_address.value |= (MSI_TARGET_CPU << MSI_TARGET_CPU_SHIFT);

The MSI writers have a lot to answer for. Could you test this?

Thanks.

Index: mm1-2.6.7-rc3/drivers/pci/msi.c
===================================================================
--- mm1-2.6.7-rc3.orig/drivers/pci/msi.c	2004-06-07 12:14:59.000000000 -0700
+++ mm1-2.6.7-rc3/drivers/pci/msi.c	2004-06-09 10:04:21.000000000 -0700
@@ -254,7 +254,8 @@
 
 static void msi_address_init(struct msg_address *msi_address)
 {
-	unsigned int	dest_id;
+	unsigned int dest_id;
+	cpumask_t msi_target_cpu = MSI_TARGET_CPU;
 
 	memset(msi_address, 0, sizeof(struct msg_address));
 	msi_address->hi_address = (u32)0;
@@ -262,7 +263,7 @@
 	msi_address->lo_address.u.dest_mode = MSI_DEST_MODE;
 	msi_address->lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
 	msi_address->lo_address.u.dest_id = dest_id;
-	msi_address->lo_address.value |= (MSI_TARGET_CPU << MSI_TARGET_CPU_SHIFT);
+	msi_address->lo_address.value |= any_online_cpu(msi_target_cpu) << MSI_TARGET_CPU_SHIFT;
 }
 
 static int assign_msi_vector(void)
Index: mm1-2.6.7-rc3/include/asm-i386/msi.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/asm-i386/msi.h	2004-06-07 12:14:42.000000000 -0700
+++ mm1-2.6.7-rc3/include/asm-i386/msi.h	2004-06-09 09:50:04.000000000 -0700
@@ -14,7 +14,7 @@
 #define MSI_TARGET_CPU_SHIFT		12
 
 #ifdef CONFIG_SMP
-#define MSI_TARGET_CPU		logical_smp_processor_id()
+#define MSI_TARGET_CPU		cpumask_of_cpu(logical_smp_processor_id())
 #else
 #define MSI_TARGET_CPU		TARGET_CPUS
 #endif
