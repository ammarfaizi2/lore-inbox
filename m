Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266811AbUFYRfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266811AbUFYRfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266812AbUFYRfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:35:46 -0400
Received: from chnmfw01.eth.net ([202.9.145.21]:24070 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S266811AbUFYRfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:35:38 -0400
Message-ID: <40DC625F.3010403@eth.net>
Date: Fri, 25 Jun 2004 23:05:27 +0530
From: Amit Gud <gud@eth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan <alan@clueserver.org>
CC: Pavel Machek <pavel@ucw.cz>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <004e01c45abd$35f8c0b0$b18309ca@home>	 <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>	 <20040625162537.GA6201@elf.ucw.cz> <1088181893.6558.12.camel@zontar.fnordora.org>
In-Reply-To: <1088181893.6558.12.camel@zontar.fnordora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2004 17:27:53.0703 (UTC) FILETIME=[BF4BB770:01C45AD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:

>On Fri, 2004-06-25 at 09:25, Pavel Machek wrote:
>  
>
>>Hi!
>>
>>    
>>
>>>Case closed, anyway. It belongs in the kernel only if there is no
>>>reasonable way to do it in userspace.
>>>      
>>>
>>But... there's no reasonable way to do this in userspace.
>>
>>Two pieces of kernel support are needed:
>>
>>1) some way to indicate "this file is elastic" (okay perhaps xattrs
>>can do this already)
>>
>>and either
>>
>>2a) file selection/deletion in kernel
>>
>>or
>>
>>2b) assume that disk does not fill up faster than 1GB/sec, allways
>>keep 1GB free, make "deleting" daemon poll each second [ugly,
>>unreliable]
>>
>>or
>>
>>2c) just before returning -ENOSPC, synchronously tell userspace to
>>free space, and retry the operation.
>>
>>BTW 2c) would be also usefull for undelete. Unfortunately 2c looks
>>very complex, too; it might be easier to do 2a than 2c.
>>    
>>
>
>Why does the kernel have to get involved with file deletion?
>
>  
>
Involvement of the kernel depends on  how we are treating the elastic 
files:

    -   when files are made elastic, are we increasing the user's quota? 
if so kernel becomes neccessary for if
       -   elastic file is deleted: decrement the user's quota
       -   elastic file is chowned: do the needfull (decrement previous 
owners and increment new owners quota)
   
    -   when files are made elastic, we are just not accounting the file 
size for the user's quota. In this case I dont see any involvement of 
the kernel,  but will need some other hacks.


>All it needs is to run at sufficient privs.
>
>If you are overflowing drives that easily, it is time to buy a bigger
>drive.  It is not the time to start deleting stuff at random.  Data is
>usually put on a drive for a reason.  Having a human decide what to
>delete is *much* better than letting some automated process do it in
>background.
>
>  
>
Admin assigns quotas to the user with using some case studies, like he 
won't be allocating 500 Mb for a C language course students. We are 
trying to harness some user behavior here. I wish I had some Gartner or 
Forrestor figures to show you that how often _all_ the users use up 
their 100% quota at any given point of time. I'm assuming that this 
*does* happen very rarely and I also assume that my assumption is very 
close to correct. The point is their is some 'free' space available for 
the users who use up all their quotas. Of course this free space is 
likely to be someday fall short for the over-spilling users, but then 
its time to increase quotas of all the users, and its then admin's duty 
to look at this. Perhaps this could become a good indication for the 
admin for increasing the quota of all the users.

>This sounds like a hack to get around a badly designed system with too
>few resources.
>
>Windows has an option to delete files "that are not needed".  It tends
>to delete things that you wanted, but had not thought about in a while.
>
>This really strikes me as a bad idea.  It has lots of "special" things
>that programs will have to deal with for this particular case. 
>This makes things much more complex in userspace for a problem that
>needs to be dealt with in meatspace.
>
>  
>
I do believe that this system can be done in userspace, but it has its 
own flaws then. Suppose theres a daemon, call it eqfsd. It forks parent 
listens a char device, child watches the disk space usage. A kernel 
module reports the file deletes, chowns to the char device, parent does 
the needfull. Child 'periodically' checks that the threshold is not 
reached. Here what can be done is suppose a user can transfer data with  
say 5 Mbps speed to his account....then we can easily get the minimum 
time required to fill up the remaining free space. Child sleeps for this 
much time minus some value for safety.  i.e. child sleeps for: ( (D - 
Ui) / 5 ) - safety_value seconds.

I'm sure this gotta be slow and *will* slow down the system, so I still 
insist that this should be in kspace.

It cannot be denied that there _are_ applications for such a system that 
we already discussed and theres a class of users who will find the 
system useful.


AG

