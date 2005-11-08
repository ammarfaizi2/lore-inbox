Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbVKHNg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbVKHNg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVKHNg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:36:57 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:38928 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965181AbVKHNg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:36:56 -0500
Message-ID: <4370A9F5.4060103@vmware.com>
Date: Tue, 08 Nov 2005 05:36:53 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de>
In-Reply-To: <200511081412.05285.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2005 13:36:55.0139 (UTC) FILETIME=[7BE76B30:01C5E469]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Tuesday 08 November 2005 05:39, Zachary Amsden wrote:
>  
>
>>IA-32 linear address translation is loads of fun.
>>    
>>
>
>Thanks for doing that audit work. Can you please double check x86-64 code is
>ok? 
>
>Actually giving all that complexity maybe it would be better to just
>stop handling the case and remove all that. I'm not sure what kprobes needs it 
>for - it doesn't even handle user space yet and even if it ever does it is 
>unlikely that handling 16bit code makes much sense. And the prefetch 
>workaround does it, but 16bit DOS code is unlikely to contain prefetches 
>anyways. And for ptrace - well, who cares? I suppose dosemu has an own
>debugger anyways and it could be handled in user space (i suppose
>they still have that code from 2.4 anyways)
>  
>

I got the idea from the x86-64 code; prompted by you, I looked at it, 
and it appears correct, but I would like to give it a full audit as well 
(especially regarding 32-bit compatibility segments).

About the three cases here:

The prefetch workaround should be harmless, again because of limit 
checking, the kernel is safe even in the raceful cases.

One can imagine clever uses for ptrace to do, say user space 
virtualization (since I'm on the topic), or other neat things.  So there 
is nothing really wrong about having the fully correct EIP conversion 
(and here we shouldn't need to worry about races causing some issues 
with strict correctness, since there can be one external control thread).

But were kprobes even inteneded for userspace?  There are races here 
that are difficult to close without some heavy machinery, and I would 
rather not put the machinery in place if simplifying the code is the 
right answer.

Zach
