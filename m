Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWJ1EzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWJ1EzH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 00:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWJ1EzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 00:55:07 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:64182 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751032AbWJ1EzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 00:55:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tNzHnQq8ygdS9X9TbecVdwqELFuT4oJBQAljGV3hsD52KQHw6LaO+x1/0x9xXz+FeKtlgObLlBoEcgdUz8t53KliubujyfFQQ9aCr4HMVKL3YXhIbzA1gs5XWT/FTZUX3So/8yx0TLLyRDoGU3oXSVj8iQy8Tf/HAyv5LOle1To=  ;
Message-ID: <4542E2A4.2080400@yahoo.com.au>
Date: Sat, 28 Oct 2006 14:55:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@openedhand.com>
CC: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
References: <1161935995.5019.46.camel@localhost.localdomain>	 <4541C1B2.7070003@yahoo.com.au> <1161938694.5019.83.camel@localhost.localdomain>
In-Reply-To: <1161938694.5019.83.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> On Fri, 2006-10-27 at 18:22 +1000, Nick Piggin wrote:
> 
>>Richard Purdie wrote:
>>
>>>Comments and testing from people who know this area of code better than
>>>me would be appreciated!
>>
>>This is the right approach to handling swap write errors. However, you need
>>to cut down on the amount of code duplication. 
> 
> 
> The code is subtly different to the swapoff code but I'll take another
> look and see if I can refactor it now I have it all working.

Subtly different code is the worst kind of code to be duplicating. It
really needs improving, I think.

>>Also, if you hit that BUG_ON, then you probably have a bug, don't
>>remove it!
> 
> 
> I gave that a lot of thought. We are in a write handler and have to
> handle the write error from there so the page will be marked as
> writeback. That function appears to be safe to call with that set
> through the new code path I added (which wouldn't have happened in the
> past). I therefore decided it was safe and the simplest solution was to
> remove the BUG_ON. If anyone can see a problem with a page being in
> writeback in that function, please enlighten me though!

It's just the wrong thing to do if the page has been set writeback with
a valid mapping. Presently we don't do any mapping specific accounting
in that path, but we could.

But now that I look at your patch, I don't think it is going to work.
end_swap_bio_write can be called from interrupt context, so you can't
lock the page, and you can't take any of those swap specific spinlocks
either.

You say that SetPageError makes the processes die unexpectedly? How and
where? We use SetPageError for IO errors, and it doesn't mean the page
has errors AFAIK.

The best policy would probably be to keep the end_page_writeback path as
it is, and then detect the PageError in the swap out path somewhere.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
