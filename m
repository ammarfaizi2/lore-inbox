Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWFNTcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWFNTcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWFNTcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:32:51 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:43136 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751105AbWFNTcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:32:51 -0400
Date: Wed, 14 Jun 2006 21:32:50 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] i386: cpu_relax() smp.c
Message-ID: <20060614193250.GA20086@rhlx01.fht-esslingen.de>
References: <20060612183743.GA28610@rhlx01.fht-esslingen.de> <20060613195352.GA24167@rhlx01.fht-esslingen.de> <448F7008.3010702@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448F7008.3010702@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2006 at 12:10:16PM +1000, Nick Piggin wrote:
> Andreas Mohr wrote:
> 
> >Hi,
> >
> >On Mon, Jun 12, 2006 at 08:37:43PM +0200, Andreas Mohr wrote:
> >
> >>Hi all,
> >>
> >>while reviewing 2.6.17-rc6-mm1, I found some places that might
> >>want to make use of cpu_relax() in order to not block secondary
> >>pipelines while busy-polling (probably especially useful on SMT CPUs):
> >>
> >
> >OK, no replies arguing against anything, thus patch follow-up. ;)
> >(no. 1 of 3)
> >
> 
> The other two look fine. This one should remove the mb(). cpu_relax
> IIRC already includes a barrier(), and we are not concerned about
> consistency here, only coherency, which the hardware takes care of
> for us.
> 
> The flush_cpumask is guaranteed to be cleared *after* all other
> variables (eg. flush_mm) have been used... that happens in the IPI
> handler of course.
> 
> Aside, if we *were* worried about consistency here, smp_mb would
> have been the more correct barrier to use.

Thanks, updated patch to omit mb().

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc6-mm2.orig/arch/i386/kernel/smp.c linux-2.6.17-rc6-mm2.my/arch/i386/kernel/smp.c
--- linux-2.6.17-rc6-mm2.orig/arch/i386/kernel/smp.c	2006-06-08 10:38:04.000000000 +0200
+++ linux-2.6.17-rc6-mm2.my/arch/i386/kernel/smp.c	2006-06-14 20:30:46.000000000 +0200
@@ -388,9 +388,10 @@
 	 */
 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
 
-	while (!cpus_empty(flush_cpumask))
+	while (!cpus_empty(flush_cpumask)) {
 		/* nothing. lockup detection does not belong here */
-		mb();
+		cpu_relax();
+	}
 
 	flush_mm = NULL;
 	flush_va = 0;
