Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUJDVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUJDVsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268657AbUJDVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:47:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:37819 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268646AbUJDVgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:36:04 -0400
Date: Mon, 4 Oct 2004 14:39:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: gww@btinternet.com, s.rivoir@gts.it, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041004143953.10e6d764.akpm@osdl.org>
In-Reply-To: <20041004143253.50a82050.akpm@osdl.org>
References: <20041004020207.4f168876.akpm@osdl.org>
	<4161462A.5040806@gts.it>
	<20041004121805.2bffcd99.akpm@osdl.org>
	<4161BCCB.4080302@btinternet.com>
	<20041004143253.50a82050.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Could you try this patch?  It'll locate the bug for us.

Don't worry about this - Ingo found it.

You could try these instead:

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


--- 25/include/net/neighbour.h~neigh_stat-preempt-fix-fix	Mon Oct  4 14:39:22 2004
+++ 25-akpm/include/net/neighbour.h	Mon Oct  4 14:39:22 2004
@@ -113,8 +113,9 @@ struct neigh_statistics
 
 #define NEIGH_CACHE_STAT_INC(tbl, field)				\
 	do {								\
-		(per_cpu_ptr((tbl)->stats, get_cpu())->field)++;	\
-		put_cpu();						\
+		preempt_disable();					\
+		(per_cpu_ptr((tbl)->stats, smp_processor_id())->field)++; \
+		preempt_enable();					\
 	} while (0)
 
 struct neighbour
_

