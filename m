Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWHQQOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWHQQOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWHQQOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:14:11 -0400
Received: from [62.205.161.221] ([62.205.161.221]:19105 "EHLO kir.sacred.ru")
	by vger.kernel.org with ESMTP id S932552AbWHQQOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:14:09 -0400
Message-ID: <44E4956E.8050503@openvz.org>
Date: Thu, 17 Aug 2006 20:12:30 +0400
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060802)
MIME-Version: 1.0
To: devel@openvz.org
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Devel] Re: [RFC][PATCH 7/7] UBC: proc interface
References: <44E33893.6020700@sw.ru> <44E33D5E.7000205@sw.ru>	<20060816171328.GA27898@kroah.com> <44E47274.70506@sw.ru> <20060817154023.GA7070@kroah.com>
In-Reply-To: <20060817154023.GA7070@kroah.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (kir.sacred.ru [62.205.161.221]); Thu, 17 Aug 2006 20:11:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Aug 17, 2006 at 05:43:16PM +0400, Kirill Korotaev wrote:
>   
>>> On Wed, Aug 16, 2006 at 07:44:30PM +0400, Kirill Korotaev wrote:
>>>
>>>       
>>>> Add proc interface (/proc/user_beancounters) allowing to see current
>>>> state (usage/limits/fails for each UB). Implemented via seq files.
>>>>         
>>> Ugh, why /proc?  This doesn't have anything to do with processes, just
>>> users, right?  What's wrong with /sys/kernel/ instead?
>>>       
>> We can move it, if there are much objections.
>>     
>
> I am objecting.  /proc is for processes so do not add any new files
> there that do not deal with processes.
>
>   
>>> Or /sys/kernel/debug/user_beancounters/ in debugfs as this is just a
>>> debugging thing, right?
>>>       
>> debugfs is usually OFF imho.
>>     
>
> No, distros enable it.
>
>   
>> you don't export meminfo information in debugfs, correct?
>>     
>
> That is because the meminfo is tied to processes, or was added to proc
> before debugfs came about.
>
> Then how about just /sys/kernel/ instead and use sysfs?  Just remember,
> one value per file please.
>   
I see two problems with that. But let me first describe the current 
/proc/user_beancounters.  This is how it looks like from inside a container:

# cat /proc/user_beancounters
Version: 2.5
       uid  resource           held    maxheld    barrier      limit    failcnt
       123: kmemsize         836919    1005343    2752512    2936012          0
            lockedpages           0          0         32         32          0
            privvmpages        4587       7289      49152      53575          0
............(more lines like that).........................................


I.e. a container owner can take a glance over the current parameters, 
their usage and (the thing that is really important) fail counters. Fail 
counter increases each time a parameter hits the limit. This is very 
straightforward way for container's owner to see if everything is OK or not.

So, the problems with /sys are:

(1) Gettng such info from 40+ files requires at least some script, while 
now cat is just fine.

(2) Do we want to virtualize sysfs and enable /sys for every container? 
Note that user_beancounters statistics is really needed for container's 
owner to see. At the same time, container's owner should not be able to 
modify it -- so we should end up with read/write ubc entries for the 
host system and read-only ones for the container.

Taking into account those two issues, current /proc/user_beancounters 
might be not that bad.
