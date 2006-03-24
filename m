Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423176AbWCXGMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423176AbWCXGMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWCXGMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:22 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:7532 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S1423163AbWCXGMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:12:01 -0500
Message-ID: <44238DAC.2020402@cosmosbay.com>
Date: Fri, 24 Mar 2006 07:11:56 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesper Dangaard Brouer <hawk@diku.dk>
Cc: "David S. Miller" <davem@davemloft.net>,
       Robert Olsson <Robert.Olsson@data.slu.se>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
References: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk> <20060321.023705.26111240.davem@davemloft.net> <Pine.LNX.4.61.0603211538280.28173@ask.diku.dk> <20060321.132514.24407022.davem@davemloft.net> <Pine.LNX.4.61.0603231536180.29788@ask.diku.dk> <Pine.LNX.4.61.0603231637360.29788@ask.diku.dk> <4422C9BC.3090400@cosmosbay.com> <Pine.LNX.4.61.0603232128400.3500@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.61.0603232128400.3500@ask.diku.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer a écrit :
> 
> On Thu, 23 Mar 2006, Eric Dumazet wrote:
> 
>> Jesper Dangaard Brouer a écrit :
>>
>>>> grep . /proc/sys/net/ipv4/route/*
>>>> /proc/sys/net/ipv4/route/error_burst:5000
>>>> /proc/sys/net/ipv4/route/error_cost:1000
>>>> grep: /proc/sys/net/ipv4/route/flush: Operation not permitted
>>>> /proc/sys/net/ipv4/route/gc_elasticity:8
>>>> /proc/sys/net/ipv4/route/gc_interval:60
>>>> /proc/sys/net/ipv4/route/gc_min_interval:0
>>>> /proc/sys/net/ipv4/route/gc_min_interval_ms:500
>>>> /proc/sys/net/ipv4/route/gc_thresh:65536
>>>> /proc/sys/net/ipv4/route/gc_timeout:300
>>>> /proc/sys/net/ipv4/route/max_delay:10
>>>> /proc/sys/net/ipv4/route/max_size:1048576
>>>> /proc/sys/net/ipv4/route/min_adv_mss:256
>>>> /proc/sys/net/ipv4/route/min_delay:2
>>>> /proc/sys/net/ipv4/route/min_pmtu:552
>>>> /proc/sys/net/ipv4/route/mtu_expires:600
>>>> /proc/sys/net/ipv4/route/redirect_load:20
>>>> /proc/sys/net/ipv4/route/redirect_number:9
>>>> /proc/sys/net/ipv4/route/redirect_silence:20480
>>>> /proc/sys/net/ipv4/route/secret_interval:600
>>
>> I would say : Change the settings :)
>>
>> echo 2 > /proc/sys/net/ipv4/route/gc_elasticity
>> echo 1 > /proc/sys/net/ipv4/route/gc_interval
>> echo 131072 > /proc/sys/net/ipv4/route/gc_thresh
> 
> These parameters do not solve the problem. I think you missed my 
> previous point.  The parameter that needs adjustment is:
> 
>  /proc/sys/net/ipv4/route/max_size
> 
> The garbage collector will not be activated before the number of entries 
> are above "max_size" (see: function rt_garbage_collect).
> 
> I have set:
>  /proc/sys/net/ipv4/route/gc_thresh:30000
>  /proc/sys/net/ipv4/route/max_size:30000
> 
> Which solves the problem of the route cache growing too large too fast.
> 
> 
> I have read the route.c code again, to see if I missed something. Are 
> you trying to make the function "rt_check_expire" to do the cleanup?
> 
> I have tried your parameters, and it does not have the desired effect.
> 

I was just guessing, since you didnt give us your rtstat output.

If you start to hit max_size then you have really a problem.

And no, I was not trying to make the garbage collector starts. This cost way 
too much cpu, the router drops packets.

On my routers, I try to size the rt hash table appropriatly (boot param : 
rhash_entries=1048575 for example), and keep the chains small, to avoid 
spending too much cpu time (and too much memory cache lines touched) in 
{soft}irq processing.

But yes it uses some memory.

# rtstat -c10 -i1
rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|rt_cache|
  entries|  in_hit|in_slow_|in_slow_|in_no_ro|  in_brd|in_marti|in_marti| 
out_hit|out_slow|out_slow|gc_total|gc_ignor|gc_goal_|gc_dst_o|in_hlist|out_hlis|
         |        |     tot|      mc|     ute|        |  an_dst|  an_src| 
    |    _tot|     _mc|        |      ed|    miss| verflow| _search|t_search|

  1672276|   32062|    4688|       0|       0|       0|       0|       0| 
2124|    2176|       0|       0|       0|       0|       0|   26020|    4385|

  1671142|   31826|    4626|       0|       0|       0|       0|       0| 
2055|    1906|       0|       0|       0|       0|       0|   25617|    4124|

  1670424|   31473|    4702|       0|       0|       0|       0|       0| 
2221|    2144|       0|       0|       0|       0|       0|   25348|    4340|

  1670928|   31671|    7600|       0|       0|       0|       0|       0| 
2037|    2152|       0|       0|       0|       0|       0|   30354|    4245|

  1670444|   31704|    4818|       0|       0|       0|       0|       0| 
2037|    1927|       0|       0|       0|       0|       0|   25424|    3871|

  1670133|   31785|    4598|       0|       0|       0|       0|       0| 
1988|    2184|       0|       0|       0|       0|       0|   24946|    4302|

  1669990|   31544|    4700|       0|       0|       0|       0|       0| 
2022|    2188|       0|       0|       0|       0|       0|   25092|    4357|

  1669880|   31930|    4750|       0|       0|       0|       0|       0| 
2054|    2002|       0|       0|       0|       0|       0|   25703|    4214|


Eric
