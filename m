Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWJXINl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWJXINl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJXINK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:10 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:45035 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932431AbWJXINF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:05 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 3/8] AVR32: Don't try to iounmap P2 segment addresses
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:41 +0200
Message-Id: <11616775661390-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11616775662194-git-send-email-hskinnemoen@atmel.com>
References: <1161677566706-git-send-email-hskinnemoen@atmel.com> <11616775663220-git-send-email-hskinnemoen@atmel.com> <11616775662194-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While ioremap() will happily map a physical address through the
P2 (uncached) segment when appropriate, iounmap() doesn't know how
to handle those mappings.

This patch makes iounmap() do the right thing, i.e. nothing, for
such mappings.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mm/ioremap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/mm/ioremap.c b/arch/avr32/mm/ioremap.c
index 8cfec65..3437c82 100644
--- a/arch/avr32/mm/ioremap.c
+++ b/arch/avr32/mm/ioremap.c
@@ -77,6 +77,8 @@ void __iounmap(void __iomem *addr)
 
 	if ((unsigned long)addr >= P4SEG)
 		return;
+	if (PXSEG(addr) == P2SEG)
+		return;
 
 	p = remove_vm_area((void *)(PAGE_MASK & (unsigned long __force)addr));
 	if (unlikely(!p)) {
-- 
1.4.1.1

