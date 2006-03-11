Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752432AbWCKIsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbWCKIsb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWCKIsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:48:31 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:62337 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752432AbWCKIsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:48:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jXe5V3dB07OwBws6TozHyg11iRe7We/YY6Xb3bcR0wcoNYYOKU2aPKiIEIvY3QTzHN0zVeFJb9180ggF12bsKbqdV0mW9SQa97v9QRTImqWK/2YR9WhYpi8YoHd8XxMb+5jnrB1xFWSXnfQvCVnbWeEoBnh2afHbOupinWLt7/o=  ;
Message-ID: <44128EDA.6010105@yahoo.com.au>
Date: Sat, 11 Mar 2006 19:48:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Nick Piggin <npiggin@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 1/3] radix tree: RCU lockless read-side
References: <20060207021822.10002.30448.sendpatchset@linux.site>	 <20060207021831.10002.84268.sendpatchset@linux.site> <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com>
In-Reply-To: <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> <snip>
> 
>>                if (slot->slots[i]) {
>>-                       results[nr_found++] = slot->slots[i];
>>+                       results[nr_found++] = &slot->slots[i];
>>                        if (nr_found == max_items)
>>                                goto out;
>>                }
> 
> 
> A quick clarification - Shouldn't accesses to slot->slots[i] above be
> protected using rcu_derefence()?
> 

I think we're safe here -- this is the _address_ of the pointer.
However, when dereferencing this address in _gang_lookup,
I think we do need rcu_dereference indeed.

Note that _gang_lookup_slot doesn't do this for us, however --
the caller must do that when dereferencing the pointer to the
item (eg. see page_cache_get_speculative in 2/3).

That said, I'm not 100% sure I have the rcu memory barriers in
the right places (well I'm sure I don't, given the _gang_lookup
bug you exposed!).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
