Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWA1OnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWA1OnP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 09:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWA1OnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 09:43:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:5553 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932103AbWA1OnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 09:43:15 -0500
Date: Sat, 28 Jan 2006 15:43:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] warn on release_region() from irq context
Message-ID: <20060128144357.GA6881@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it is not legal to call release_region() from hardirq/softirq context.  
Add a WARN_ON() so that we find such cases.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/resource.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux/kernel/resource.c
===================================================================
--- linux.orig/kernel/resource.c
+++ linux/kernel/resource.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 
 
@@ -486,6 +487,8 @@ void __release_region(struct resource *p
 	struct resource **p;
 	unsigned long end;
 
+	WARN_ON(in_interrupt());
+
 	p = &parent->child;
 	end = start + n - 1;
 
