Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSLIQzx>; Mon, 9 Dec 2002 11:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLIQzw>; Mon, 9 Dec 2002 11:55:52 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:64729 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265830AbSLIQzv>;
	Mon, 9 Dec 2002 11:55:51 -0500
Message-ID: <3DF4CCCE.7040407@colorfullife.com>
Date: Mon, 09 Dec 2002 18:03:10 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: William Lee Irwin III <wli@holomorphy.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
References: <3DF3B7FB.9010902@colorfullife.com> 	<20021208212808.GY9882@holomorphy.com> <1039389778.13079.1.camel@rth.ninka.net>
In-Reply-To: <1039389778.13079.1.camel@rth.ninka.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Sun, 2002-12-08 at 13:28, William Lee Irwin III wrote:
>  
>
>>Hmm. What happened to that pipe buffer size increase patch? That sounds
>>like it might help here, but only if those things are trying to shove
>>more than 4KB through the pipe at a time.
>>    
>>
>
>You probably mean the zero-copy pipe patches, which I think really
>should go in.  The most recent version of the diffs I saw didn't
>use the zero copy bits unless the trasnfers were quite large so it
>should be ok and not pessimize small transfers.
>
>That patch has been gathering cobwebs for more than a year now when I
>first did it, let's push this in already :-)
>  
>
Unfortunately zero-copy doesn't help to avoid the schedules:
Zero copy just avoid the copy to kernel - you still need one schedule 
for each page to be transfered.

writer calls
    for(;;){
        prepare_data(buf);
        write(fd,buf,PAGE_SIZE);
    }
reader calls
    for(;;) {
        read(fd,buf,PAGE_SIZE);
        use_data(buf);
    }

What's needed is a large kernel buffer - I've seen buffers between 64 
and 256 kB in other unices.
zero copy only helps lmbench and other apps where the whole working set 
fits into the cpu cache.

The difference between
    main-mem->cache;cache->main_mem [non-zerocopy]
and
    main-mem->main-mem [zerocopy, the copy to kernel is skipped]
is small.

--
    Manfred

