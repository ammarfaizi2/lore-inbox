Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290113AbSAKVPW>; Fri, 11 Jan 2002 16:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290116AbSAKVPO>; Fri, 11 Jan 2002 16:15:14 -0500
Received: from [195.66.192.167] ([195.66.192.167]:27912 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S290113AbSAKVO4>; Fri, 11 Jan 2002 16:14:56 -0500
Message-Id: <200201112113.g0BLDFE24964@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "M.H.VanLeeuwen" <vanl@megsinet.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] - Taming OOM killer, 2.4.17-rc1
Date: Fri, 11 Jan 2002 23:13:17 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, davej@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011212094246.O4801@athlon.random> <3C1AB4B4.A24A0A5@megsinet.net>
In-Reply-To: <3C1AB4B4.A24A0A5@megsinet.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 December 2001 00:25, M.H.VanLeeuwen wrote:
> The attached patch changes the attributes of the out_of_memory function to:
>
> 1. wait longer before attempting to kill processes;  "MB of cache" seconds.
> 2. OOM occurrences must be 10*(MB of cache) once "1." is satisfied.
>
> This allows the system to be less likely to kill processes when there is
> still cache memory available, i.e. the OOM killer is dynamic based on the
> system cache size.
>
> We probably should be killing processes without a least first shrinking
> cache size somewhat first.  It would be much better to have processes run
> at the expense of cache than the other way around, i.e.. a predictably slow
> system due to low memory thus little cache is better than a fast system
> that unpredictably keeps killing processes because large amount of memory
> are held in cache.

This patch does make OOM killer wait much longer before killing, thus system 
stays under mem pressure longer and cache shrinks fully:

bash-2.03# oom_trigger; free
Terminated
             total       used       free     shared    buffers     cached
Mem:        126208      69068      57140 <==         0          0      12876
-/+ buffers/cache:      56192      70016
Swap:            0          0          0
bash-2.03# oom_trigger; free
Terminated
             total       used       free     shared    buffers     cached
Mem:        126208      65568      60640 <==         0          0       9412
-/+ buffers/cache:      56156      70052
Swap:            0          0          0

Note that second free isn't less than first one. With stock kernel you'll get
'free' falling after each oom kill.

> I realize this patch is just chasing a symptom, but it is self tuning so
> seems to be a good change regardless.  Yes, it still kills ;)

Yes indeed :-)

> --------------------------------------------------------------------
> out_of_memory: cache size 41 Mb, since = 0.06
> out_of_memory: cache size 41 Mb, since = 0.11
> out_of_memory: cache size 41 Mb, since = 0.74
> out_of_memory: cache size 41 Mb, since = 0.83
> out_of_memory: cache size 40 Mb, since = 1.29
> out_of_memory: cache size 40 Mb, since = 1.48
> out_of_memory: cache size 40 Mb, since = 1.57
> out_of_memory: cache size 40 Mb, since = 2.37
   <<< snip >>>
> out_of_memory: cache size 40 Mb, since = 29.46
> out_of_memory: cache size 40 Mb, since = 29.52
> out_of_memory: cache size 40 Mb, since = 30.04
> out_of_memory: cache size 40 Mb, since = 30.41
> out_of_memory: cache size 40 Mb, since = 30.78 << ~29 SECONDS AND NO CACHE 
> SHRINKAGE!!??!! ***
> out_of_memory: cache size 39 Mb, since = 31.11
> out_of_memory: cache size 39 Mb, since = 31.25
> out_of_memory: cache size 39 Mb, since = 31.34
> out_of_memory: cache size 39 Mb, since = 31.44
> out_of_memory: cache size 39 Mb, since = 31.63

Same here. I modified the printk (# of pages instead of Mb):

-printk(KERN_DEBUG "out_of_memory: cache size %d Mb, since = 
%lu.%02lu\n",mega, since/HZ, since%HZ);
+printk(KERN_DEBUG "out_of_memory: page_cache_size=%d, 
since=%lu.%02lu\n",page_cache_size.counter, since/HZ, since%HZ);

out_of_memory: page_cache_size=6236, since=23.33
out_of_memory: page_cache_size=6220, since=23.49
out_of_memory: page_cache_size=6220, since=23.50
out_of_memory: page_cache_size=6220, since=23.55
out_of_memory: page_cache_size=6178, since=23.80
out_of_memory: page_cache_size=6178, since=23.88
Out of Memory: Killed process 1987 (a.out).
--
vda
