Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbVIPAJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbVIPAJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbVIPAJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:09:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65267 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965279AbVIPAJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:09:32 -0400
Message-ID: <432A0D01.7010303@mvista.com>
Date: Thu, 15 Sep 2005 17:08:33 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dwalker@mvista.com
CC: tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: 2.6.13-rt6, ktimer subsystem
References: <20050913100040.GA13103@elte.hu>  <43287C52.7050002@mvista.com>	 <1126751140.6509.474.camel@tglx.tec.linutronix.de>	 <4329F733.2090604@mvista.com> <1126825796.4576.31.camel@dhcp153.mvista.com>
In-Reply-To: <1126825796.4576.31.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Thu, 2005-09-15 at 15:35 -0700, George Anzinger wrote:
> 
>>In the early HRT patches the whole timer list was replaced with a hashed 
>>list.  It was O(N/M) on insertion where we could easily choose M (for a 
>>while it was even a config option).  Removal was just an unlink, same as 
>>the cascade list.
>>
>>To be clear on my take on this, as I understand it the rblist is 
>>something like O(N*somelog 2).  What is left out here is the fixed 
>>overhead of F which is there even if N = 1.  So we have something like 
>>(F+O(f(N)) for a list.  For the most part we don't look at F, but as 
>>list complexity grows, it gets larger thus pushing out the cross over 
>>point to a higher "N" when comparing two lists.  I considered the rbtree 
>>when doing the secondary list for HRT and concluded that "N" was small 
>>enough that a simple O(N/2) list would do just fine as it would only 
>>contain timers set to expire in the next jiffie.
> 
> 
> The fact that we know in advance that a system is only going to a very
> small number of these timers should be noted. You could just use a
> regular list , and limit the total number of timers . I would hesitate
> to stick a big data structure in when your only dealing with one or two
> timers on average..
> 
> George, what's largest number of highres timers that someone might
> need/want?
> 
Well, the interesting thing is that, unless you change something, the 
system has a current limit of 1000 posix timers.  This can be changed, 
but, I suspect it is not changed very often.  And this handles all posix 
timers, low and high res.  Sleep is another thing, with a max of one 
sleep timer per task.  The ktimer list is also doing itimers, which are 
also limited to the number of tasks.

As for data structures, a hashed list requires a "list head" for each 
bucket while, I think the rblist only has one list head, but requires an 
additional list head (or is it two) in the entry data structure so this 
is a pay as you go list.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
