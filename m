Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVDHMjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVDHMjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVDHMjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:39:18 -0400
Received: from [195.23.16.24] ([195.23.16.24]:33697 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262802AbVDHMil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:38:41 -0400
Message-ID: <42567B3E.8010403@grupopie.com>
Date: Fri, 08 Apr 2005 13:38:22 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
References: <4252BC37.8030306@grupopie.com> <20050407214747.GD4325@stusta.de>
In-Reply-To: <20050407214747.GD4325@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Apr 05, 2005 at 05:26:31PM +0100, Paulo Marques wrote:
>>[...]
> 
> Hi Paulo,

Hi Adrian,

>>[...]
>>pros:
>>  - smaller kernel image size
>>  - smaller (and more readable) source code
> 
> Which is better readable depends on what you are used to.

That's true to some degree, but look at code like this (in 
drivers/usb/input/hid-core.c):

> 	if (!(field = kmalloc(sizeof(struct hid_field) + usages * sizeof(struct hid_usage)
> 		+ values * sizeof(unsigned), GFP_KERNEL))) return NULL;
> 
> 	memset(field, 0, sizeof(struct hid_field) + usages * sizeof(struct hid_usage)
> 		+ values * sizeof(unsigned));

and compare to this:

> 	field = kzalloc(sizeof(struct hid_field) + usages * sizeof(struct hid_usage)
> 			+ values * sizeof(unsigned), GFP_KERNEL);
> 	if (!field) 
> 		return NULL;

In the first case you have to read carefully to make sure that the size 
argument in both the kmalloc and the memset are the same. Even more, if 
the size needs to be updated to include something more, a mistake can be 
made by inserting the extra size just in the kmalloc call. Also, you are 
assuming that the compiler is smart enough to notice that the two 
expressions are the same and cache the result, but this is probably true 
for gcc, anyway.

I think most will agree that the second piece of code is more "readable".

>>cons:
>>  - the NULL test is done twice
>>  - memset will not be optimized for constant sizes
>>...
>>Would this be a good thing to clean up, or isn't it worth the effort at all?
> 
> You do plan to patch 1200 places in the kernel for this 
> micro-optimization? 

I was actually planning on sending a patch at a time for a reasonably 
sized subsection. Like "use kzalloc in usb/serial drivers", or "use 
kzalloc in sound/core", etc.

This way, it shouldn't be more than 1150 patches ;)

> This sounds like a really big overhead for a pretty small gain.

Yes it is. But at least it will remove 1000+ lines of redundant kernel code.

I really don't see this as a priority at all. I'll probably submit a 
patch shortly to create the kzalloc function. This way developers become 
aware that it exists and that it should be used, and we don't get a lot 
of new code with the same constructs.

The cleanup can then progress at a slowly pace, without breaking things 
and without producing too much merging problems.

> There are tasks of higher value that can be done.

I couldn't agree more :)

> E.g. read my "Stack usage tasks" email. The benefits would only be 
> present for people using GNU gcc 3.4 or SuSE gcc 3.3 on i386, but this 
> is a reasonable subset of the kernel users - and it brings them a
> 2% kernel size improvement.

I've read that thread, but it seems that it is at a dead end right now, 
since we don't have a good tool to find out which functions are abusing 
the stack with unit-at-a-time.

Is there some way to even limit the search, like using a stack usage log 
from a compilation without unit-at-a-time, and going over the hotspots 
to check for problems?

If we can get a list, even if it contains a lot of false positives, I 
would more than happy to help out...

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
