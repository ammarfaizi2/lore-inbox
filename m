Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318785AbSHBLom>; Fri, 2 Aug 2002 07:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318786AbSHBLol>; Fri, 2 Aug 2002 07:44:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:25590 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318785AbSHBLoj>; Fri, 2 Aug 2002 07:44:39 -0400
Subject: Re: adjust prefetch in free_one_pgd()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com
In-Reply-To: <200208020012.g720CdeJ017016@napali.hpl.hp.com>
References: <200208020012.g720CdeJ017016@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 14:04:21 +0100
Message-Id: <1028293461.18309.53.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 01:12, David Mosberger wrote:
> diff -Nru a/mm/memory.c b/mm/memory.c
> --- a/mm/memory.c	Thu Aug  1 17:02:14 2002
> +++ b/mm/memory.c	Thu Aug  1 17:02:14 2002
> @@ -110,7 +110,7 @@
>  	pmd = pmd_offset(dir, 0);
>  	pgd_clear(dir);
>  	for (j = 0; j < PTRS_PER_PMD ; j++) {
> -		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
> +		prefetchw(pmd + j + PREFETCH_STRIDE/sizeof(*pmd));
>

It isnt a case of PREFETCH_STRIDE - thats the optimal fetchahead. You
must never prefetch an address beyond the end of an object. So you
actually need two loops one prefetching, then one to finish the job off
which does not prefetch.

Otherwise one day your page ends up against the ISA or PCI address space
or something else undesirable and on some cpus the prefetch then
variously confuses the PCI device or corrupts the cache.

Prefetching stuff you don't need is bad manners anyway 8)

