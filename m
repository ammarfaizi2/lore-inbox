Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268650AbUJDWaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268650AbUJDWaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268541AbUJDW1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:27:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:62647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268670AbUJDVdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:33:45 -0400
Date: Mon, 4 Oct 2004 14:37:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: annabellesgarden@yahoo.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041004143738.5ca9c43f.akpm@osdl.org>
In-Reply-To: <20041004212633.GA13527@elte.hu>
References: <200410041634.24937.annabellesgarden@yahoo.de>
	<20041004122304.4f545f3c.akpm@osdl.org>
	<20041004122533.0a85a1ad.akpm@osdl.org>
	<20041004212633.GA13527@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> Must not put side-effects into a macro that is NOP on
> !SMP.

This one, too:

diff -puN include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preempt-safety-fix include/linux/netfilter_ipv4/ip_conntrack.h
--- 25/include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preempt-safety-fix	Mon Oct  4 14:36:19 2004
+++ 25-akpm/include/linux/netfilter_ipv4/ip_conntrack.h	Mon Oct  4 14:37:02 2004
@@ -311,10 +311,11 @@ struct ip_conntrack_stat
 	unsigned int expect_delete;
 };
 
-#define CONNTRACK_STAT_INC(count)				\
-	do {							\
-		per_cpu(ip_conntrack_stat, get_cpu()).count++;	\
-		put_cpu();					\
+#define CONNTRACK_STAT_INC(count)					\
+	do {								\
+		preempt_disable();					\
+		per_cpu(ip_conntrack_stat, smp_processor_id()).count++;	\
+		preempt_disable();					\
 	} while (0)
 
 /* eg. PROVIDES_CONNTRACK(ftp); */
_

