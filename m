Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbUJZEqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbUJZEqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUJZBhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:37:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:985 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262103AbUJZBYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:24:13 -0400
Date: Mon, 25 Oct 2004 15:47:08 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
In-Reply-To: <clgc6m$u72$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.60.0410251544040.24256@dlang.diginsite.com>
References: <200410221613.35913.ks@cs.aau.dk><200410221613.35913.ks@cs.aau.dk>
 <Pine.LNX.4.60.0410221743590.20604@dlang.diginsite.com> <clgc6m$u72$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004, Bill Davidsen wrote:

> David Lang wrote:
>
>> This puts the cost of zeroing out and freeing memory on new programs that 
>> are allocating memory, which tends to scatter the work over time rather 
>> then having a large burst of work kick in when a program exits (it seems 
>> odd to think that if a large computer exits the machine would be pegged 
>> for a little while while it frees up and zeros the memory, not exactly 
>> what you would expect when you killed a program :-)
>
> Any this partially explains why response is bad every morning when starting 
> daily operation. Instead of using the totally unproductive time in the idle 
> loop to zero and free those pages when it would not hurt response, the kernel 
> saves that work for the next time the memory is needed lest it do work which 
> might not be needed before the system is shutdown.

actually, what useually has happened is that updatedb ran overnight and 
used all your memory for it's work so all your application stuff got 
thrown away or swapped out as it appeared to be less useful then the 
then-active process. so first thing in the morning you need to do a lot of 
disk reads to get your desktop working set into memory. the cost of 
zeroing the pages is minor compared to the disk IO

> With all the work Nick, Ingo,Con and others are putting into latency and 
> responsiveness, I don't understand why anyone thinks this is desirable 
> behavior. The idle loop is the perfect place to perform things like this, to 
> convert non-productive cycles into performing tasks which will directly 
> improve response and performance when the task MUST be done. Things like 
> zeroing these pages, perhaps defragmenting memory, anything which can be done 
> in small parts.
>
> It would seem that doing things like this in small inefficient steps in idle 
> moments is still better than doing them efficiently while a process is 
> waiting for the resources being freed.

the problem is that you don't know that you need to throw away the data. 
the next thing that you try to do could re-use the data that's in the ram, 
how can the system know?

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
