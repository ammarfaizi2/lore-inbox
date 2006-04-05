Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWDFGbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWDFGbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 02:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDFGbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 02:31:03 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:33892 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751103AbWDFGbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 02:31:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=quWhmelFxhUYkCoKlh1/p9Y2+/gzhLJAWIHlu7a9yBWnbuvaHmJPn6lT7oCPA1kxMpWUc4Z9sXlA3gPyJwGAyD5SXMoLxBrjW02eJ6YAunoQoZJ0n/EKJ8BdDs1iBVeEFu3n/sq2ltz+dam4U355t4F0tb1/d+yFgilIevO8Ssk=  ;
Message-ID: <44338EA9.3020102@yahoo.com.au>
Date: Wed, 05 Apr 2006 19:32:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] Fix memory barrier docs wrt atomic ops
References: <29800.1144228639@warthog.cambridge.redhat.com>
In-Reply-To: <29800.1144228639@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>  ATOMIC OPERATIONS
>  -----------------
>  
> -Though they are technically interprocessor interaction considerations, atomic
> -operations are noted specially as they do _not_ generally imply memory
> -barriers.  The possible offenders include:
> +Whilst they are technically interprocessor interaction considerations, atomic
> +operations are noted specially as some of them imply full memory barriers and
> +some don't, but they're very heavily relied on as a group throughout the
> +kernel.
> +
> +Any atomic_t operation, for instance, that returns a value implies an
> +SMP-conditional general memory barrier (smp_mb()) on each side of the actual
> +operation.  These include:

Actually: this only applies to operations which _both_ modify their atomic_t
operand and return a value. Eg. atomic_read() does not have barrier semantics.

>  
> -	xchg();
> -	cmpxchg();
> -	test_and_set_bit();
> -	test_and_clear_bit();
> -	test_and_change_bit();
>  	atomic_cmpxchg();
>  	atomic_inc_return();
>  	atomic_dec_return();
> @@ -1283,20 +1283,30 @@ barriers.  The possible offenders includ
>  	atomic_add_negative();
>  	atomic_add_unless();
>  
> -These may be used for such things as implementing LOCK operations or controlling
> -the lifetime of objects by decreasing their reference counts.  In such cases
> -they need preceding memory barriers.
>  
> -The following may also be possible offenders as they may be used as UNLOCK
> -operations.
> +The following, however, do _not_ imply memory barrier effects:
> +
> +	xchg();
> +	cmpxchg();
> +	test_and_set_bit();
> +	test_and_clear_bit();
> +	test_and_change_bit();
> +
> +These may be used for such things as implementing LOCK-class operations.  In
> +such cases they need explicit memory barriers.
> +

I believe all the bitops are essentially the same as the atomic semantics.
That is, if they change their operand and return something, they are full
barriers both ways.

atomic_ops.txt says of them:
   "These routines, like the atomic_t counter operations returning values,
    require explicit memory barrier semantics around their execution."

I think we'd have problems at least with TestSetPageLocked if this were
not the case.

I'm not sure if I like the words imply, explicit, implicit, etc. They're
a bit confusing. provide, semantics may be better?

> +The following are also potential offenders as they may be used as UNLOCK-class
> +operations, amongst other things, but do _not_ imply memory barriers either:
>  
>  	set_bit();
>  	clear_bit();
>  	change_bit();
>  	atomic_set();
>  
> +With these the appropriate explicit memory barrier should be used if necessary.
> +
>  

In particular, when clearing a bit to signal the end of a critical section,
clear_bit must be preceeded by smp_mb__before_clear_bit();

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
