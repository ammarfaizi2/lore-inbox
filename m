Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVDKJzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVDKJzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 05:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVDKJzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 05:55:55 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:18288 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261750AbVDKJzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 05:55:46 -0400
Message-ID: <425A4999.9010209@yahoo.com.au>
Date: Mon, 11 Apr 2005 19:55:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504100328.53762.ctpm@rnl.ist.utl.pt> <20050409194746.69cfa230.akpm@osdl.org> <200504110138.51872.ctpm@rnl.ist.utl.pt>
In-Reply-To: <200504110138.51872.ctpm@rnl.ist.utl.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Martins wrote:
> On Sunday 10 April 2005 03:47, Andrew Morton wrote:
> 
>>Suggest you boot with `nmi_watchdog=0' to prevent the nmi watchdog from
>>cutting in during long sysrq traces.
>>
>>Also, capture the `sysrq-m' output so we can see if the thing is out of
>>memory.
> 
> 
>   Hi Andrew,
> 
>   Thanks for the tip. I booted with nmi_watchdog=0 and was able to get a full 
> sysrq-t as well as a sysrq-m. Since it might be a little too big for the 
> list, I've put it on a text file at:
> 
>  http://193.136.132.235/dl145/dump1-2.6.12-rc2.txt
> 

OK, you _may_ be out of memory here (depending on what the lower zone
protection for DMA ends up as), however you are well above all the
"emergency watermarks" in ZONE_NORMAL. Also:

>  I also made a run with the mempool-can-fail patch from Nick Piggin. With this 
> I got some nice memory allocation errors from the md threads when the trouble 
> started. The dump (with sysrq-t and sysrq-m included) is at:
> 
>  http://193.136.132.235/dl145/dump2-2.6.12-rc2-nick1.txt
> 

This one shows plenty of memory. The allocation failure messages are
actually a good thing, and show that my patch is sort of working. I
have reworked it a bit so they won't show up though.

So probably not your common or garden memory deadlock.

The common theme seems to be: try_to_free_pages, swap_writepage,
mempool_alloc, down/down_failed in .text.lock.md. Next I would suspect
md/raid1 - maybe some deadlock in an uncommon memory allocation
failure path?

I'll see if I can reproduce it here.

-- 
SUSE Labs, Novell Inc.

