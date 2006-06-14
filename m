Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWFNCKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWFNCKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 22:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWFNCKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 22:10:23 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:30363 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964893AbWFNCKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 22:10:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dnmvpWe4aXts8khK9mtaP5+/meuDTuVV1gzGwBBTOiZ7JMjVQwpxr/vkAIs9e3aeLxMtzMD+TLcT8MGqaRibHIt3N9Bw+X/yMpdZmjYxdD9aYwXEAAXKg82xs+Pkzc2GtvXJM0gcfyknxBXGsxBhs0KFMMU+DfI/Z0gT2LB33Z0=  ;
Message-ID: <448F7008.3010702@yahoo.com.au>
Date: Wed, 14 Jun 2006 12:10:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] i386: cpu_relax() smp.c
References: <20060612183743.GA28610@rhlx01.fht-esslingen.de> <20060613195352.GA24167@rhlx01.fht-esslingen.de>
In-Reply-To: <20060613195352.GA24167@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:

>Hi,
>
>On Mon, Jun 12, 2006 at 08:37:43PM +0200, Andreas Mohr wrote:
>
>>Hi all,
>>
>>while reviewing 2.6.17-rc6-mm1, I found some places that might
>>want to make use of cpu_relax() in order to not block secondary
>>pipelines while busy-polling (probably especially useful on SMT CPUs):
>>
>
>OK, no replies arguing against anything, thus patch follow-up. ;)
>(no. 1 of 3)
>

The other two look fine. This one should remove the mb(). cpu_relax
IIRC already includes a barrier(), and we are not concerned about
consistency here, only coherency, which the hardware takes care of
for us.

The flush_cpumask is guaranteed to be cleared *after* all other
variables (eg. flush_mm) have been used... that happens in the IPI
handler of course.

Aside, if we *were* worried about consistency here, smp_mb would
have been the more correct barrier to use.

>
>Signed-off-by: Andreas Mohr <andi@lisas.de>
>
>
>diff -urN linux-2.6.17-rc6-mm2.orig/arch/i386/kernel/smp.c linux-2.6.17-rc6-mm2.my/arch/i386/kernel/smp.c
>--- linux-2.6.17-rc6-mm2.orig/arch/i386/kernel/smp.c	2006-06-08 10:38:04.000000000 +0200
>+++ linux-2.6.17-rc6-mm2.my/arch/i386/kernel/smp.c	2006-06-13 19:33:22.000000000 +0200
>@@ -388,9 +388,11 @@
> 	 */
> 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
> 
>-	while (!cpus_empty(flush_cpumask))
>+	while (!cpus_empty(flush_cpumask)) {
>+		cpu_relax();
> 		/* nothing. lockup detection does not belong here */
> 		mb();
>+	}
> 
> 	flush_mm = NULL;
> 	flush_va = 0;
>

Send instant messages to your online friends http://au.messenger.yahoo.com 
