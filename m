Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWC3EME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWC3EME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 23:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWC3EME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 23:12:04 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:64339 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751315AbWC3EMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 23:12:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vWhTtZX2H0mYgAnGSZwnWDjnoD86A/M/P65cqd4k+7F+GJbI18Rt708vzdnAckXbv7o9xnbO2hwwPloU+tZ0hAqJwcoLNDzpMyNNTlpfz71A3VXqoKLs10lqws7hJREe0Exu6hsH5WQvStHcsIx3LfJOyuqARvYLeKibUzS6864=  ;
Message-ID: <442B3B27.3030802@yahoo.com.au>
Date: Thu, 30 Mar 2006 12:57:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
CC: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Zoltan.Menyhart@free.fr, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <Pine.LNX.4.64.0603271953150.7469@schroedinger.engr.sgi.com> <442AA13B.3050104@bull.net>
In-Reply-To: <442AA13B.3050104@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Menyhart wrote:

> Christoph Lameter wrote:
>
>> [...]
>>  void fastcall unlock_buffer(struct buffer_head *bh)
>>  {
>> +    smp_mb__before_clear_bit();
>>      clear_buffer_locked(bh);
>> -    smp_mb__after_clear_bit();
>>      wake_up_bit(&bh->b_state, BH_Lock);
>>  }
>
>
> The sequence:
>
>     smp_mb__before_clear_bit();
>     clear_buffer_locked(bh);
>
> is correct (yet not efficient for all architectures).
>

Yes, this is explicitly documented in the wake_up_bit interface. I
don't really think it needs to be changed, does it? Bill did most
of this work I think, so I've cc'ed him.

> We have got here two unrelated operations: ending a critical section
> and waking up the eventual waiters. What we need is a barrier between
> these two unrelated operations.
> It is not "smp_mb__after_clear_bit()" but a simple "smp_mb()".
> The correct code is:
>
> void fastcall unlock_buffer(struct buffer_head *bh)
> {
>   smp_mb__before_clear_bit();
>   clear_buffer_locked(bh);
>   smp_mb();
>   wake_up_bit(&bh->b_state, BH_Lock);
> }
>

If you were going to do that, I'd prefer my suggestion.

clear_buffer_locked(); /* clear_bit_unlock */
smp_mb__after_clear_bit_unlock();
wake_up_bit()

Nick

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
