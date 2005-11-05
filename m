Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVKEJIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVKEJIt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 04:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVKEJIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 04:08:48 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:13457 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751305AbVKEJIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 04:08:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qdRWyolgHGl17MFX3Xg8XfVIcIbr+6AskzDZF75BHALKPig4TV4LizqmVfM/DGG9e2aWAFF4rNJtzvUWqOs5lpAw2FB5iqlG6GCHhIQz3+eoTp3F2oKGaBXDcx26l1NADFD1TM9qaXS90RydKQFMWGFxfzGcbsDhWG0N+rktYIg=  ;
Message-ID: <436C771D.8040703@yahoo.com.au>
Date: Sat, 05 Nov 2005 20:10:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2/5] atomic: cmpxchg
References: <436C655F.2080703@yahoo.com.au> <436C65B1.5020508@yahoo.com.au> <436C65E8.8080501@yahoo.com.au> <20051105090010.GA18926@flint.arm.linux.org.uk>
In-Reply-To: <20051105090010.GA18926@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sat, Nov 05, 2005 at 06:57:28PM +1100, Nick Piggin wrote:
> 
>>Index: linux-2.6/include/asm-arm/atomic.h
>>===================================================================
>>--- linux-2.6.orig/include/asm-arm/atomic.h
>>+++ linux-2.6/include/asm-arm/atomic.h
>>@@ -80,6 +80,23 @@ static inline int atomic_sub_return(int 
>> 	return result;
>> }
>> 
>>+static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
>>+{
>>+	u32 oldval, res;
>>+
>>+	do {
>>+		__asm__ __volatile__("@ atomic_cmpxchg\n"
>>+		"ldrex	%1, [%2]\n"
>>+		"teq	%1, %3\n"
>>+		"strexeq %0, %4, [%2]\n"
>>+		    : "=&r" (res), "=&r" (oldval)
>>+		    : "r" (&ptr->counter), "r" (old), "r" (new)
>>+		    : "cc");
>>+	} while (res);
>>+
>>+	return oldval;
>>+}
>>+
>> static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
>> {
>> 	unsigned long tmp, tmp2;
>>@@ -131,6 +148,21 @@ static inline int atomic_sub_return(int 
>> 	return val;
>> }
>> 
>>+static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
>>+{
>>+	int ret;
>>+	unsigned long flags;
>>+
>>+	local_irq_save(flags);
>>+	ret = v->counter;
>>+	if (likely(ret == old))
>>+		v->counter = new;
>>+	local_irq_restore(flags);
>>+
>>+	return ret;
>>+}
>>+
>>+static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
>> static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
> 
> 
> This is obviously going to break ARM...
> 

Ah dang sorry. Must be a cut-n-paste-o.

While you're here, does the assembly code for the SMP version look
OK? You basically provided me with it but I don't think you saw its
final form.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
