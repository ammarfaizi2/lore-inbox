Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSGSXYH>; Fri, 19 Jul 2002 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSGSXYH>; Fri, 19 Jul 2002 19:24:07 -0400
Received: from armitage.toyota.com ([63.87.74.3]:16026 "EHLO
	armitage.toyota.com") by vger.kernel.org with ESMTP
	id <S317214AbSGSXYG>; Fri, 19 Jul 2002 19:24:06 -0400
Message-ID: <3D38A046.5080008@lexus.com>
Date: Fri, 19 Jul 2002 16:27:02 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: Austin Gonyou <austin@digitalroadkill.net>,
       David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
References: <20020719163350.D28941@sventech.com> <20020719135225.A4048@greenhydrant.com> <20020719170359.E28941@sventech.com> <1027117945.7776.11.camel@UberGeek> <20020719190452.H28941@sventech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen several mentions of 2.4.19-rc1aa2 -

FYI, 2.4.19-rc2aa1 came out a few days ago -

I've been running it and it seems to perform
even better under pressure than 2.4.19-rc1aa2,
at least in my workloads...

Joe

Johannes Erdfelt wrote:

>On Fri, Jul 19, 2002, Austin Gonyou <austin@digitalroadkill.net> wrote:
>  
>
>>On Fri, 2002-07-19 at 16:03, Johannes Erdfelt wrote:
>>    
>>
>>>Web server. The only writing is for the log files, which is relatively
>>>minimal.
>>>      
>>>
>>But IMHO, you are using prefork, and not a threaded model correct?
>>    
>>
>
>Yes, it's a prefork.
>
>  
>
>>>One thing also, is there is lots of process creation in this example.
>>>For a variety of reasons, PHP programs are forked often from the Apache
>>>server.
>>>      
>>>
>>Also, here, even as a DSO, which I think you may not be running PHP as,
>>(cgi vs. dso), you will use a bit of memory, on top of apache, every
>>time the new child is created by apache to handle incoming requests.
>>    
>>
>
>Use both, but for legacy reasons there's still a signficant amount of
>children being forked for the CGI like version (caused by SSI).
>
>The memory size for these children is about 40MB (which is strange in
>itself), and a couple per second get executed. However, they are very
>quick and typically won't see any in ps, but occassionally 1 or 2 will
>be seen.
>
>  
>
>>>The systems running an older kernel (like RedHat's 2.4.9-21) are much
>>>more consistent in their usage of memory. There are no 150MB swings in
>>>cache utiliziation, etc.
>>>      
>>>
>>Hrrmmm....I'd suggest a 2.4.17 or 2.4.19-rc1-aa2 in that case. I promise
>>you'll see drastic improvements over that kernel.
>>    
>>
>
>2.4.17 wasn't good last time I tried it, but I've have much better results
>from Andrea's patches. I'll create 2.4.19-rc1-aa2 kernel and see how
>that fares.
>
>  
>
>>>What's really odd in the vmstat output is the fact that there is no disk
>>>I/O that follows these wild swings. Where is this cache memory coming
>>>from? Or is the accounting just wrong?
>>>      
>>>
>>I think the accounting is quite correct. Let's look real quick. 
>>    
>>
>
>I suspect it's correct as well, but that doesn't mean something else
>isn't wrong :)
>
>  
>
>><vmstat>
>>    
>>
>>>>>   procs                      memory    swap          io     system  cpu
>>>>> 3  0  0 106036 502288  10812  67236   0   0     0     0  802   494  46  37  17
>>>>> 5  0  2 106032 476188  10844  91496   0   0     4   316  905   573  54  37   8
>>>>>16  0  2 106032 355400  10844 203880   0   0     4     0  909   540  51  49   0
>>>>>10  0  2 106024 340108  10852 221548   0   0    28     0  975   659  36  64   0
>>>>> 0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
>>>>> 0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14 
>>>>>          
>>>>>
>></vmstat>
>>
>>Now let's take a closer look....
>>
>><vmstat2>
>>    
>>
>>>>>16  0  2 106032 355400  10844 203880   0   0     4     0  909   540  51  49   0
>>>>>10  0  2 106024 340108  10852 221548   0   0    28     0  975   659  36  64   0
>>>>>          
>>>>>
>></vmstat2>
>>
>>Notice you're memory utilization jumps here as your free is given to
>>cache.
>>    
>>
>
>Are you saying that the cache value is the amount of memory available to
>be used by the cache, or actually used by the cache?
>
>It was my understanding that it's the memory actually used by the cache.
>If that's the case, I don't understand where the data to fill the cache
>is coming from with these blips.
>
>  
>
>><vmstat3>
>>    
>>
>>>>> 0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
>>>>> 0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14 
>>>>>          
>>>>>
>></vmstat3>
>>
>>And then back again, probably on process termination.
>>    
>>
>
>There are couple per second of those processes, so I would expect this
>to happen all of the time or atleast much more often.
>
>  
>
>>At that rate, it's all in-memory shuffling going on, and for preforks,
>>that very likely is the case.
>>    
>>
>
>One thing to note as well is a significant amount of system time spent
>during these situations as well. It looks like a lot of time is spent
>managing something.
>
>It's obvious the workload is inefficient, but it's constantly
>inefficient which is why these blips are strange.
>
>JE
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

