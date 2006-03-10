Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWCJEzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWCJEzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWCJEzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:55:42 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:19135 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751378AbWCJEzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:55:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PhlSA3aIn8GANmqksvVYmuYF8ayZJJERy58sBC8P17Mvzh1KikW+xYv1Q+qA7u/RENotku+pTikRj+shR6YAXPFH+z/oaXiYFAzismbdv9p6R7euO6FIzTHvV0aI7MTqoneiG0KdN0a6+HaZlehJ7gL5JCB2VP+3hIji3pbfwTM=  ;
Message-ID: <441106C9.9040502@yahoo.com.au>
Date: Fri, 10 Mar 2006 15:55:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Magnus Damm <magnus@valinux.co.jp>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
In-Reply-To: <20060310034412.8340.90939.sendpatchset@cherry.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm wrote:
> Unmapped patches - Use two LRU:s per zone.
> 
> These patches break out the per-zone LRU into two separate LRU:s - one for
> mapped pages and one for unmapped pages. The patches also introduce guarantee 
> support, which allows the user to set how many percent of all pages per node
> that should be kept in memory for mapped or unmapped pages. This guarantee 
> makes it possible to adjust the VM behaviour depending on the workload.
> 
> Reasons behind the LRU separation:
> 
> - Avoid unnecessary page scanning.
>   The current VM implementation rotates mapped pages on the active list
>   until the number of mapped pages are high enough to start unmap and page out.
>   By using two LRU:s we can avoid this scanning and shrink/rotate unmapped 
>   pages only, not touching mapped pages until the threshold is reached.
> 
> - Make it possible to adjust the VM behaviour.
>   In some cases the user might want to guarantee that a certain amount of 
>   pages should be kept in memory, overriding the standard behaviour. Separating
>   pages into mapped and unmapped LRU:s allows guarantee with low overhead.
> 
> I've performed many tests on a Dual PIII machine while varying the amount of
> RAM available. Kernel compiles on a 64MB configuration gets a small speedup, 
> but the impact on other configurations and workloads seems to be unaffected.
> 
> Apply on top of 2.6.16-rc5.
> 
> Comments?
> 

I did something similar a while back which I called split active lists.
I think it is a good idea in general and I did see fairly large speedups
with heavy swapping kbuilds, but nobody else seemed to want it :P

So you split the inactive list as well - that's going to be a bit of
change in behaviour and I'm not sure whether you gain anything.

I don't think PageMapped is a very good name for the flag.

I test mapped lazily. Much better way to go IMO.

I had further patches that got rid of reclaim_mapped completely while
I was there. It is based on crazy metrics that basically completely
change meaning if there are changes in the memory configuration of
the system, or small changes in reclaim algorithms.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
