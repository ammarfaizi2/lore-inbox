Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263958AbTEWIy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263964AbTEWIy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:54:59 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15881 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263958AbTEWIy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:54:57 -0400
Message-ID: <3ECDE4B4.8010005@aitel.hist.no>
Date: Fri, 23 May 2003 11:07:00 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
References: <3ECC4C3A.9000903@cyberone.com.au>	<PEEPIDHAKMCGHDBJLHKGEEKJCMAA.rwhite@casabyte.com> <16077.52259.718519.389903@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> Consider two loops:
> 
> (1)
> 
> spin_lock(&lock);
> list_for_each_entry(item, ...) {
>   do something with item;
> }
> spin_unlock(&lock);
> 
> versus
> 
> (2)
> 
> list_for_each_entry(item, ...) {
>   spin_lock(&lock);
>   do something with item;
>   spin_unlock(&lock);
> }
> 
> and suppose they both are equally correct. Now, in (2) total amount of
> time &lock is held is smaller than in (1), but (2) will usually perform
> worse on SMP, because:
> 
> . spin_lock() is an optimization barrier
> 
> . taking even un-contended spin lock is an expensive operation, because
> of the cache coherency issues.


This is a tradeoff.  If the total running time is "short", use (1) for 
performance.
If the running time is "long" use (2) to avoid lock contention.

"long" time happens when the time wasted by other processors spinning
typically exceed the time wasted by repeated lock+unlock, or there
is excessive latency on some irq-blocking lock.

You can get the best of both worlds (low latency and few lock operations)
like this:

while(more work to do) {
   spin_lock(&lock);
   process one suitably sized batch of items
   spin_unlock(&lock);
}

This sort of thing certainly helped the VM system.

Helge Hafting

