Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWC0Kwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWC0Kwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWC0Kwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:52:41 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:31910 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750700AbWC0Kwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:52:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Lb2m0KqmZqgktdHeFNGE2yIFbED66fXd3Kl9PptldIDZb14YKzGM/J+XgtMY95dELQgmM0CgC2s973cs4xrG0ZM5kWy3p4m4tFpXpYUTRukwQnf2XJH/kcyq4zGc2N7VRSlBN1I177QAz1OltrgycnhuewjmS3uXNfZO48LZ40I=  ;
Message-ID: <4427C284.3020206@yahoo.com.au>
Date: Mon, 27 Mar 2006 20:46:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: unlock_buffer() and clear_bit()
References: <44247FAB.3040202@free.fr>	<20060325040233.1f95b30d.akpm@osdl.org>	<4427A817.4060905@bull.net> <20060327010739.027d410d.akpm@osdl.org> <4427B292.3080204@bull.net>
In-Reply-To: <4427B292.3080204@bull.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Menyhart wrote:
> Andrew Morton wrote:
> 
>> This is, I think, a rather inefficient thing we're doing there.  For most
>> architectures, that amounts to:
>>
>>     mb();
>>     clear_bit()
>>     mb();
>>
>> which is probably more than is needed.  We'd need to get some other
>> architecture people involved to see if there's a way of improving 
>> this, and
>> unlock_page().
> 
> 
> This is why I proposed also:
> 
>>>> Or a new bit clearing service needs to be added that includes
>>>>   the "rel" semantics, say "release_N_clear_bit()"
> 
> 
> The architecture dependent "release_N_clear_bit()" should include what
> is necessary for the correct unlocking semantics (and it leaves the freedom
> for the "stand alone" bit operations implementations).
> 
> Note that "lock_buffer()" works on ia64 "by chance", because all the
> atomic bit operations are implemented "by chance" by use of the "acq"
> semantics.
> 
> I'd like to split the bit operations according to their purposes:
> - e.g. "test_and_set_bit_N_acquire()" for lock acquisition
> - "test_and_set_bit()", "clear_bit()" as they are today
> - "release_N_clear_bit()"...
> 

Now I could be wrong here, but it looks like ia64's
smp_mb__after_clear_bit is broken.

There is nothing in any of the memory barrier, bitop, or atomic
operations that says anything about aquire or release semantics.
The only memory barriers with those semantics currently are those
implied by locking operations.

smp_mb__after_clear_bit() is supposed to, when run directly after
a clear_bit operation, provide the equivalent of an smp_mb().

If you actually need a memory barrier _before_ the clear_bit
(ie. that orders the clear_bit with previous stores) operation,
then you have to issue a seperate barrier completely. Likewise
for a barrier after clear_bit.

The problem with ia64 is that its atomic operations always either
imply aquire or relese semantics, so acquire is simply chosen
arbitrarily. So what I think you should do is make both
smp_mb__before and after_clear_bit issue at least a release
consistency instruction -- combined I think they provide a full
barrier, regardless of their order?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
