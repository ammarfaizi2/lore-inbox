Return-Path: <linux-kernel-owner+w=401wt.eu-S932256AbXADFH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbXADFH5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 00:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbXADFH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 00:07:57 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:43821 "HELO
	smtp107.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932256AbXADFH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 00:07:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VJ6UewWl4sNn30eUmMiwUcz7Tucuu2bWxailen9rYSdxW+Au6PPpaYbujTJ0Ht1U2BZswjoP4YQtlz8hRODGDI4n1Y5QfaAHkXmMqg29VgVI108wgyLw20OfOKVna0Sx6DrWFrP2CjbrHkI3qXVw9LBiVbHBXl3YSsEv3pjrVEU=  ;
X-YMail-OSG: _KyXKxoVM1kQ8sUwblO78v4r34KdwA2A2J.CAE4nIvIvTLlFnhWTGlAN9k07.YWvi_fvLdKJMy.P7EntENTaFsvjq.WMKejalo5efvQgxpQSSDxXOkmTgd29iC.jAvujdr2F4Nmf3shiqq4-
Message-ID: <459C8B86.2050905@yahoo.com.au>
Date: Thu, 04 Jan 2007 16:07:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrea Gelmini <gelma@gelma.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net> <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 4 Jan 2007, Nick Piggin wrote:
> 
>>Yhat's when the bug was introduced -- 2.6.19. 2.6.18 does not have
>>this bug, so it cannot be years old.
> 
> 
> Actually, I think 2.6.18 may have a subtle variation on it. 
> 
> In particular, I look back at the try_to_free_buffers() thing that I hated 
> so much, and it makes me wonder.. It used to do:
> 
> 	spin_lock(&mapping->private_lock);
> 	ret = drop_buffers(page, &buffers_to_free);
> 	spin_unlock(&mapping->private_lock);
> 	if (ret) {
> 		.. crappy comment ..
> 		if (test_clear_page_dirty(page))
> 			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
> 	}
> 
> and I think that at least on SMP, we had a race with another CPU doing the 
> "mark page dirty if it was dirty in the PTE" at the same time. Because the 
> marking dirty would come in, find no buffers (they just got dropped), and 
> then mark the page dirty (ignoring the lack of any buffers), but then the 
> above would do the "test_clear_page_dirty()" thing on it.
> 
> Ie the race, I think, existed where that crappy comment was.
> 
> But that much older race would only trigger on SMP (or possibly UP with 
> preempt).

Oh yes the try_to_free_buffers race, I think, does exist in older kernels.
Yes according to our earlier analysis it would trigger with UP+preempt and
SMP.

But the patch that Andrea was pointing to was your last patch (The Fix),
which stopped page_mkclean caller throwing out dirty bits. You probably
didn't see that in the mail I cc'ed you on.

So yes it would be interesting to see whether fixing try_to_free_buffers
fixes Andrea's problem on older kernels.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
