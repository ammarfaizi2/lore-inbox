Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWH1Vcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWH1Vcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWH1Vcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:32:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57017 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932161AbWH1Vcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:32:45 -0400
Subject: [PATCH -mm] Fix faulty HPET clocksource usage (fix for bug #7062)
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, michael.olbrich@gmx.net
Content-Type: text/plain
Date: Mon, 28 Aug 2006 14:32:39 -0700
Message-Id: <1156800759.16398.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently some systems export valid HPET addresses, but hpet_enable()
fails. Then when the HPET clocksource starts up, it only checks for a
valid HPET address, and the result is a system where time does not
advance.

See http://bugme.osdl.org/show_bug.cgi?id=7062 for details.

This patch just makes sure we better check that the HPET is functional
before registering the HPET clocksource.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
index c6737c3..17647a5 100644
--- a/arch/i386/kernel/hpet.c
+++ b/arch/i386/kernel/hpet.c
@@ -35,7 +35,7 @@ static int __init init_hpet_clocksource(
 	void __iomem* hpet_base;
 	u64 tmp;
 
-	if (!hpet_address)
+	if (!is_hpet_enabled())
 		return -ENODEV;
 
 	/* calculate the hpet address: */


