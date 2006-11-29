Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758412AbWK2CWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412AbWK2CWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 21:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758418AbWK2CWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 21:22:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:954 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1758412AbWK2CWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 21:22:12 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Nov 2006 13:22:03 +1100
Message-ID: <19133.1164766923@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.19-rc6 with gcc version 4.1.0 (SUSE Linux),
wait_hpet_tick is optimized away to a never ending loop and the kernel
hangs on boot in timer setup.

0000001a <wait_hpet_tick>:
  1a:   55                      push   %ebp
  1b:   89 e5                   mov    %esp,%ebp
  1d:   eb fe                   jmp    1d <wait_hpet_tick+0x3>

This is not a problem with gcc 3.3.5.  Adding barrier() calls to
wait_hpet_tick does not help, making the variables volatile does.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

---
 arch/i386/kernel/time_hpet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/i386/kernel/time_hpet.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/time_hpet.c
+++ linux-2.6/arch/i386/kernel/time_hpet.c
@@ -51,7 +51,7 @@ static void hpet_writel(unsigned long d,
  */
 static void __devinit wait_hpet_tick(void)
 {
-	unsigned int start_cmp_val, end_cmp_val;
+	unsigned volatile int start_cmp_val, end_cmp_val;
 
 	start_cmp_val = hpet_readl(HPET_T0_CMP);
 	do {

