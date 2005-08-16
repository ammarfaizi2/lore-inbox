Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVHPR4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVHPR4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVHPR4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:56:03 -0400
Received: from smtpout.mac.com ([17.250.248.71]:32200 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030265AbVHPR4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:56:02 -0400
In-Reply-To: <1124213674.9316.15.camel@w2>
References: <1123868902.10923.5.camel@w2> <20050813221148.GA20060@kroah.com> <1124213674.9316.15.camel@w2>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C7501292-0CC1-4351-B562-3B271E054B0E@mac.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
Date: Tue, 16 Aug 2005 13:55:44 -0400
To: e8607062@student.tuwien.ac.at
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 16, 2005, at 13:34:34, Wieland Gmeiner wrote:
> On Sat, 2005-08-13 at 15:11 -0700, Greg KH wrote:
>> On Fri, Aug 12, 2005 at 07:48:22PM +0200, Wieland Gmeiner wrote:
>>
>>> @@ -294,3 +294,4 @@ ENTRY(sys_call_table)
>>>      .long sys_inotify_init
>>>      .long sys_inotify_add_watch
>>>      .long sys_inotify_rm_watch
>>> +        .long sys_getprlimit
>>>
>>
>> Please follow the proper kernel coding style when writing new kernel
>> code...
>
> Hm, Documentation/CodingStyle suggests using descriptive names, so
> something like getrlimit(...)/getrlimit_per_process(pid_t pid, ...)
> would be more appropriate?

I think he was commenting more on the code indentation and braces  
placement
than any naming issue.  There was also a good guide to kernel whitespace
posted to the LKML a week or so ago, please check the archives and  
review
that as well.

I have one small comment on something you stated in your original mail:
> Otherwise some checking on the validity of the given pid is
> done and if the given process is found access is granted if
>
> - the calling process holds the CAP_SYS_RESOURCE capability or
> - the calling process uid equals the uid of the process whose rlimit
>   is being read or
> - the calling process uid equals the suid of the process whose rlimit
>   is being read or
> - the calling process euid equals the uid of the process whose rlimit
>   is being read or
> - the calling process euid equals the suid of the process whose
>   rlimit is being read

I suggest that you revise this list to the following:
> If the calling process can ptrace the target process, then allow  
> rlimits to be
> read and written such that the hard limits may not be raised unless  
> one of the
> two processes possesses the CAP_SYS_RESOURCE capability

ptrace implies the ability to execute arbitrary code in the given  
process, which
means that even without this new function the calling process  
theoretically
could obtain and set rlimits for that process anyways, subject to its  
own
CAP_SYS_RESOURCE capability.  Such a situation would guarantee that  
there are
no new security holes, and would limit the number of inter-process  
access rules
which kernel developers need to understand.  I believe some simple  
Googling and
grepping through the kernel code should reveal the necessary ptrace- 
related
process checks.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so
simple that there are obviously no deficiencies. And the other way is  
to make
it so complicated that there are no obvious deficiencies.  The first  
method is
far more difficult.
   -- C.A.R. Hoare


