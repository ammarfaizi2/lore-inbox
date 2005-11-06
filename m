Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVKFIte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVKFIte (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVKFIte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:49:34 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:22929 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932336AbVKFIte (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:49:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rSAXy06E1f6rvvlOxUxpCUtZBx+J9/xHET8Dx2kbHUBhZdxQzD6epn60jylQrwsFt5m9zsdD72Wi9B1qOn/wuT9sPKZMDhfz7JfNLzmzVfAs+Wpio+lbeqf0UkqmACvj4VvyTChSTt3rWM5Pw1SXtE0+e/OEdstFvzrPjr+1T4A=  ;
Message-ID: <436DC41F.5040701@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:51:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 2/14] mm: pte prefetch
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au>	 <436DBCE2.4050502@yahoo.com.au> <1131266102.2826.3.camel@laptopd505.fenrus.org>
In-Reply-To: <1131266102.2826.3.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2005-11-06 at 19:20 +1100, Nick Piggin wrote:
> 
>>2/14
>>
>>plain text document attachment (mm-pte-prefetch.patch)
>>Prefetch ptes a line ahead. Worth 25% on ia64 when doing big forks.
>>
>>Index: linux-2.6/include/asm-generic/pgtable.h
>>===================================================================
>>--- linux-2.6.orig/include/asm-generic/pgtable.h
>>+++ linux-2.6/include/asm-generic/pgtable.h
>>@@ -196,6 +196,33 @@ static inline void ptep_set_wrprotect(st
>> })
>> #endif
>> 
>>+#ifndef __HAVE_ARCH_PTE_PREFETCH
>>+#define PTES_PER_LINE (L1_CACHE_BYTES / sizeof(pte_t))
>>+#define PTE_LINE_MASK (~(PTES_PER_LINE - 1))
>>+#define ADDR_PER_LINE (PTES_PER_LINE << PAGE_SHIFT)
>>+#define ADDR_LINE_MASK (~(ADDR_PER_LINE - 1))
>>+
>>+#define pte_prefetch(pte, addr, end)					\
>>+({									\
>>+	unsigned long __nextline = ((addr) + ADDR_PER_LINE) & ADDR_LINE_MASK; \
>>+	if (__nextline < (end))						\
>>+		prefetch(pte + PTES_PER_LINE);				\
>>+})
>>+
> 
> 
> are you sure this is right? at least on pc's having a branch predictor
> miss is very expensive and might well be more expensive than the gain
> you get from a prefetch
> 

Yeah, not 100% sure about this one, which is why it has been sitting
around for so long.

It gives about 25% on contrived fork workload on an ia64 system, which
is probably about its best case workload+architecture. I haven't found
any notable regressions but it definitely isn't going to be any faster
when the page tables are in cache.

So long as I haven't found a real-world workload that is improved with
the patch, I won't be trynig to get it merged.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
