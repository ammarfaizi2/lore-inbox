Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWFMTxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWFMTxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWFMTxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:53:54 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:65502 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932083AbWFMTxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:53:54 -0400
Date: Tue, 13 Jun 2006 21:53:52 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] i386: cpu_relax() smp.c (was: [RFC -mm] more cpu_relax() places?)
Message-ID: <20060613195352.GA24167@rhlx01.fht-esslingen.de>
References: <20060612183743.GA28610@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612183743.GA28610@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 12, 2006 at 08:37:43PM +0200, Andreas Mohr wrote:
> Hi all,
> 
> while reviewing 2.6.17-rc6-mm1, I found some places that might
> want to make use of cpu_relax() in order to not block secondary
> pipelines while busy-polling (probably especially useful on SMT CPUs):

OK, no replies arguing against anything, thus patch follow-up. ;)
(no. 1 of 3)

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc6-mm2.orig/arch/i386/kernel/smp.c linux-2.6.17-rc6-mm2.my/arch/i386/kernel/smp.c
--- linux-2.6.17-rc6-mm2.orig/arch/i386/kernel/smp.c	2006-06-08 10:38:04.000000000 +0200
+++ linux-2.6.17-rc6-mm2.my/arch/i386/kernel/smp.c	2006-06-13 19:33:22.000000000 +0200
@@ -388,9 +388,11 @@
 	 */
 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
 
-	while (!cpus_empty(flush_cpumask))
+	while (!cpus_empty(flush_cpumask)) {
+		cpu_relax();
 		/* nothing. lockup detection does not belong here */
 		mb();
+	}
 
 	flush_mm = NULL;
 	flush_va = 0;
