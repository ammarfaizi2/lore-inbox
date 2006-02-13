Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWBMIOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWBMIOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWBMIOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:14:52 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:15749 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751231AbWBMIOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:14:51 -0500
Message-ID: <43F04132.6090905@aitel.hist.no>
Date: Mon, 13 Feb 2006 09:20:02 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Linda Walsh <lkml@tlinx.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org> <20060212212504.GX27946@ftp.linux.org.uk> <43EFBCA9.1090501@tlinx.org> <20060213000803.GY27946@ftp.linux.org.uk> <43EFD8BF.1040205@tlinx.org> <20060213073746.GG11380@w.ods.org>
In-Reply-To: <20060213073746.GG11380@w.ods.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

>On Sun, Feb 12, 2006 at 04:54:23PM -0800, Linda Walsh wrote:
>  
>
>>Al Viro wrote:
>>    
>>
>>>On Sun, Feb 12, 2006 at 02:54:33PM -0800, Linda Walsh wrote:
>>> 
>>>      
>>>
>>>>Al Viro wrote:
>>>>   
>>>>        
>>>>
>>>>>Care to RTFS? I mean, really - at least to the point of seeing what's
>>>>>involved in that recursion.
>>>>>
>>>>>     
>>>>>          
>>>>>
>>>>Hmmm...that's where I got the original parameter numbers, but
>>>>I see it's not so straightforward.  I tried a limit of
>>>>40, but I quickly get an OS hang when trying to reference a
>>>>13th link.  Twelve works at the limit, but would take more testing
>>>>to find out the bottleneck.
>>>>   
>>>>        
>>>>
>>>Sigh...  12 works at the limit on your particular config, filesystems
>>>being used and syscall being issued (hint: amount of stuff on stack
>>>before we enter mutual recursion varies; so does the amount of stuff
>>>on stack we get from function that are not part of mutual recursion,
>>>but are called from the damn thing).
>>> 
>>>      
>>>
>>---
>>   Yeah, I sorta figured that.  Is there any easier way to
>>remove the recursion?  I dunno about you, but I was always taught
>>that recursion, while elegant, was not always the most efficient in
>>terms of time and space requirements and one could get similar
>>functionality using iteration and a stack.
>>    
>>
>
>I don't know exactly why recursion is used to follow symlinks,
>which at first thought seems like it could be iterated, but
>I've not checked the code, there certainly are specific reasons
>for this. However, there's often an alternative to recursion, it
>consists in implementing a local stack onto the stack. I mean,
>  
>
Sometimes, there are better ways than implementing your
own stack.  For example, not having any kind of stack.
That means memory usage don't increase with the number of
chained symlinks. 

>when you need recursion, it is because you want to be able to
>get back to where you were previously (eg: try another branch
>in a tree). 
>
Yes, but what if we don't need the ability to go back?

Consider this approach to symlinks:
1. We have a path component to resolve
2. It turns out to be a symlink.  So look it up, then
    loop back to (1)

This goes on until what we find isn't a symlink, or till some
overflow counter decides that we probably have a symlink loop.
With no memory of where we came from, there is no
recursive use of memory.  And no way of going back in
single steps, but I assume that isn't necessary here.
I could be wrong about that though.

Helge Hafting





