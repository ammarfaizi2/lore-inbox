Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWBJQbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWBJQbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWBJQbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:31:15 -0500
Received: from smtpout.mac.com ([17.250.248.44]:46079 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932159AbWBJQbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:31:12 -0500
In-Reply-To: <728201270602100650q22938b88x237b8fb043c82408@mail.gmail.com>
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com> <1139526447.6692.7.camel@localhost.localdomain> <728201270602100650q22938b88x237b8fb043c82408@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87DAB6BD-536F-4772-8496-12ED56700468@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RSS Limit implementation issue
Date: Fri, 10 Feb 2006 11:31:01 -0500
To: Ram Gupta <ram.gupta5@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2006, at 09:50, Ram Gupta wrote:
> On 2/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> That is what I would expect. Or perhaps even allowing the process  
>> to exceed the RSS but using the RSS limit as a swapper target so  
>> that the process is victimised early. No point forcing swapping  
>> and the RSS limit when there is free memory, only where the  
>> resource is contended ..
>
> So we will need some kind of free memory threshold . If free memory  
> is more than it than we can let RSS exceed & scheduler can also  
> schedule it in this situation but not if free memory is less than  
> the threshhold. Also we need to figure out a way for swapper to  
> target pages based on RSS limit. One possible  disadvantage I can  
> think is that  as the swapper swaps out a page based on RSS limit ,  
> the process's rss will become within the rss limit & then scheduler  
> will schedule this process again & hence possibly same page might  
> have to be brought in. This may cause increase in swapping. What do  
> you think how much realistic is this scenario?

Just use a basic hysteresis device:

When allocating resources:
if (resource > limit + delta)
	disable_process();

When freeing resources:
if (resource < limit - delta)
	enable_process();

If the delta is set to something reasonable (say 1 or 2 pages), then  
the process will only be rescheduled when it gets enough free RSS  
(one page to satisfy its latest request and a few spare).  Even  
better, you could use a running average of "time between RSS- 
triggered-pauses" to figure out how much memory you should keep free.  
Pseudocode below:

[Tuneables]
unsigned int time_quantum_factor;
unsigned int limit;
unsigned int max_delta;

[Per-process state]
unsigned int pages;
unsigned int delta;
unsigned long long last_limit_time;

[When allocating resources]
if (pages > limit + delta) {
	int time_factor = log2(now - last_limit_time)
		- time_quantum_factor;
	last_limit_time = now;
	
	if (time_factor < 0 && delta < max_delta)
		delta <<= 1;
	else if (time_factor > 0 && delta > 1)
		delta >>= 1;
	
	put_process_to_sleep();
}

[When freeing resources]
if (resource < limit - delta)
	enable_process();

The effect of this code would be that the RSS code would avoid  
rescheduling a process more often than every 1<<time_quantum_factor  
microseconds.  It would attempt to provide a safe hysteresis delta  
such that the process would have enough pages free that it could  
probably run for at least the minimum amount of time.  Note that the  
code would _only_ have an effect if the process is already about to  
sleep on an RSS limit, otherwise that code path would never get hit.   
Obviously it's possible to adjust this algorithm to react more slowly  
or quickly by adjusting the shift values, but it should work well  
enough for a beta as-is.

Cheers,
Kyle Moffett

--
I didn't say it would work as a defense, just that they can spin that  
out for years in court if it came to it.
   -- Rob Landley



