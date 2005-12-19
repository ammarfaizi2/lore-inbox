Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVLSLFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVLSLFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 06:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVLSLFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 06:05:30 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:27297 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932313AbVLSLFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 06:05:30 -0500
Message-ID: <43A694DF.8040209@aitel.hist.no>
Date: Mon, 19 Dec 2005 12:09:19 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de> <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net>
In-Reply-To: <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:

>
> On Dec 18, 2005, at 12:43 AM, Andi Kleen wrote:
>
>> You can catch the obvious ones, but the really hard ones
>> that only occur under high load in obscure exceptional
>> circumstances with large configurations and suitable nesting you  won't.
>> These would be only found at real world users.
>
>
> Yep, as it all depends on code complexity, some of these cases might  
> not be "errors" at all - instead for that kind of functionality they  
> might _require_ bigger stacks.
>
No complex problem ever requires a big stack.  It may require a large amount
of memory - which can be allocated explicitly outside the stack.

> If you have 64 bit machines common place and memory a lot cheaper I  
> don't see how it is beneficial to force smaller stack sizes without  
> giving consideration to the code complexity, architecture and  
> requirements.
> (Solaris for example, seems to be going to have 16Kb kernel stacks on  
> 64 bit machines.)
>
> So, please let's leave stack size as an option for users to choose  
> and stop this 4Kb stack war. May be after a little rest I will start  
> another one demanding 16Kb stacks :)

I suggest a little experiment for you.  Make a kernel module which do 
nothing
except try to allocate 16k of _contigous_ kernel memory, and
printk whether it succeeded or failed before exiting.  Have cron run that
every 5 minutes.  After a few weeks of running this low-impact test on
a busy loaded server, look at statistics about how often the 16k allocation
worked - and how often it failed. 

Whatever failure rate you get, expect the same failure rate for server
processes forking to handle new connections while running with 16k stacks.
Failing one out of a hundred times would probably not be tolerated
for a webserver, and I suspect the failure rate for this will be higher - if
the machine has a reasonable memory load and the usual fragmentation.

On the other hand, if you can surprise us about how this works very
well - then you have a strong argument!

Helge Hafting
