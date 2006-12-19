Return-Path: <linux-kernel-owner+w=401wt.eu-S932725AbWLSJlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWLSJlc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWLSJlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:41:32 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:37965 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932725AbWLSJlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:41:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UYJRFDq9+dmlMEihtIYRBYjXhsw2NyiPpmix7mR88CdvzBWrKoCoX/AdfcvvGsVKC6uHK3lHDN7Na6Qu5HriDD04I6EGeJGZdrO4kVl+NCywes0GgwvFkqctZ3RJMReghvtujNim3vA0zKuaQx8R06m+PqHby83ANnusIskHWEY=  ;
X-YMail-OSG: QYLIUqgVM1kCJ81E.0aIx7Ls15WlC0KVRV.3a_SCRl6uvl97aUpMNX5ti2J4X_A_DBuqGRc7WBrGpIjng3tWioVVmMo.zsbafeS1pcrlrzdXDqki2WTBmaIoL3HwFZ8vgMoMjgpPOZVpz3s-
Message-ID: <4587B3A4.1000605@yahoo.com.au>
Date: Tue, 19 Dec 2006 20:40:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>  <45876C65.7010301@yahoo.com.au> <1166512923.10372.114.camel@twins> <45879BEF.9060001@yahoo.com.au> <Pine.LNX.4.64.0612190011170.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612190011170.3479@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 19 Dec 2006, Nick Piggin wrote:
> 
>>>Anyway it has the same issues as the others. See what happens when you
>>>run two test_clear_page_dirty_sync_ptes() consecutively, you still loose
>>>PG_dirty even though the page might actually be dirty.
>>
>>How can this happen? We'll only test_clear_page_dirty_sync_ptes again
>>after buffers have been reattached, and subsequently cleaned. And in
>>that case if the ptes are still clean at this point then the page really
>>is clean.
> 
> 
> Why do you talk about buffers being reattached? Are you still in some 
> world where "try_to_free_buffers()" matters? Have you not followed the 

I'm talking about fixing just the race Andrew noticed via inspection. No
it doesn't appear to fix Andrei's problem, unfortunately. But it needs
to be fixed all the same, doesn't it?

> discussion? Why do you ignore my MUCH SIMPLER patch that just removed all 
> this crap ENTIRELY from "try_to_free_buffers()", and the exact same 
> corruption happened?
> 
> Forget about "try_to_free_buffers()". Please apply this patch to your tree 
> first. That gets rid of _one_ copy of totally insane code that did all the 
> wrong things.
> 
> Only after you have applied this patch should you look at the code again. 
> Realizing that the corruption still happens.
> 
> So forget about buffers already. That piece of code was crap.

Now I'm not exactly sure how ext3 (or any other) filesystems make use
of this particular feature of try_to_free_buffers(), but it is clear
from the comments what it is for. So your patch isn't really a minimal
fix (ie. it would require an OK from all filesystems, wouldn't it?)

Or did I miss a mail where you reasoned that it is safe to make this
change (/me goes to reread the thread)...

> 
> 		Linus
> 
> ---
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d1f1b54..263f88e 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2834,7 +2834,7 @@ int try_to_free_buffers(struct page *page)
>  	int ret = 0;
>  
>  	BUG_ON(!PageLocked(page));
> -	if (PageWriteback(page))
> +	if (PageDirty(page) || PageWriteback(page))
>  		return 0;
>  
>  	if (mapping == NULL) {		/* can this still happen? */
> @@ -2845,22 +2845,6 @@ int try_to_free_buffers(struct page *page)
>  	spin_lock(&mapping->private_lock);
>  	ret = drop_buffers(page, &buffers_to_free);
>  	spin_unlock(&mapping->private_lock);
> -	if (ret) {
> -		/*
> -		 * If the filesystem writes its buffers by hand (eg ext3)
> -		 * then we can have clean buffers against a dirty page.  We
> -		 * clean the page here; otherwise later reattachment of buffers
> -		 * could encounter a non-uptodate page, which is unresolvable.
> -		 * This only applies in the rare case where try_to_free_buffers
> -		 * succeeds but the page is not freed.
> -		 *
> -		 * Also, during truncate, discard_buffer will have marked all
> -		 * the page's buffers clean.  We discover that here and clean
> -		 * the page also.
> -		 */
> -		if (test_clear_page_dirty(page))
> -			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
> -	}
>  out:
>  	if (buffers_to_free) {
>  		struct buffer_head *bh = buffers_to_free;
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
