Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWEaQUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWEaQUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWEaQUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:20:05 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:49840 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750721AbWEaQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:20:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fzJOGyyFGY4E6VWUrX6rKsRI7owNwhtgrhFddDoHR87sQdAt69AuIlzd3q5PGz6xZ2SMMDIf+2yDWr19XXVFe4Sw5jtTe5qaCfAJXe+cY5KE28/wZIt2XVHbIV1VNBEGzN94AwS2SG/HhKGLRlgCPOX9Af6bvvsqSLzRJlDqBn0=  ;
Message-ID: <447DC22C.5070503@yahoo.com.au>
Date: Thu, 01 Jun 2006 02:19:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au> <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au> <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org> <447DB765.6030702@yahoo.com.au> <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Tell me WHERE you can unplug in that sequence. I will tell you where you 
> can NOT unplug:

...

>  - you can NOT just unplug in the path _after_ "readpage()", because the 
>    IO may have been started by SOMEBODY ELSE that just did read-ahead, and 
>    didn't unplug (on _purpose_ - the whole point of doing read-ahead is to 
>    allow concurrent IO execution, so a read-aheader that unplugs is broken 
>    by definition)

Umm, this happens with the current lock_page() after readpage. And
with per-task plugs, you do not unplug anybody else.

Sure it isn't perfect (you can still concoct a sequence of concurrent
tasks doing funny things that result in a slightly suboptimal request
pattern), but to me it sounds as good or better in some cases than
what we have now.

> So what is your alternative? Put the explicit unplug at every possible 
> occurrence of lock_page() (and keep in mind that some of them don't want 
> it: we only want it when the lock-page will block, which is not always 
> true. Some people lock the page not because it's under IO, and they're 
> waiting for it to be unlocked, but because it's dirty and they're going to 
> start IO on it - the lock_page() generally won't block on that, and if 
> it doesn't, we don't want to kick previous IO).

I keep telling you. Put the unplug after submission of IO. Not before
waiting for IO.

I'll give you one example of how it could be better (feel free to ask
for others too). Your sys_readahead(). Someone asks to readahead 1MB
of data, currently if the queue is empty, that's going to sit around
for 4ms before starting the read. 4ms later, the app comes back hoping
for the request to have finished. Unfortunately it takes another 4ms.
Throughput is halved.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
