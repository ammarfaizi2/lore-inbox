Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVKIQsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVKIQsw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVKIQsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:48:51 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:14354 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932075AbVKIQsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:48:51 -0500
Message-ID: <437227FD.6040905@vmware.com>
Date: Wed, 09 Nov 2005 08:46:53 -0800
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
       Ingo Molnar <mingo@elte.hu>, prasanna@in.ibm.com, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de> <4370A9F5.4060103@vmware.com> <200511091438.11848.ak@suse.de>
In-Reply-To: <200511091438.11848.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2005 16:46:55.0351 (UTC) FILETIME=[315F7870:01C5E54D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Tuesday 08 November 2005 14:36, Zachary Amsden wrote:
>
>  
>
>>One can imagine clever uses for ptrace to do, say user space
>>virtualization (since I'm on the topic), or other neat things.  So there
>>is nothing really wrong about having the fully correct EIP conversion
>>(and here we shouldn't need to worry about races causing some issues
>>with strict correctness, since there can be one external control thread).
>>    
>>
>
>Well, the code still scaries me a bit, but ok. x86-64 left at least one case 
>intentionally out.
>
>  
>
>>But were kprobes even inteneded for userspace?  There are races here
>>that are difficult to close without some heavy machinery, and I would
>>rather not put the machinery in place if simplifying the code is the
>>right answer.
>>    
>>
>
>I believe user space kprobes are being worked on by some IBM India folks yes.
>  
>

I'm convinced this is pointless.  What does it buy you over a ptrace 
based debugger?  Why would you want extra code running in the kernel 
that can be done perfectly well in userspace?

Let me stress that if you are running on modified segment state, you 
have no way to safely determine the virtual address on which you took an 
instruction trap (int3, general protection, etc..).  If you can't 
determine the virtual address safely, you can't back out your code patch 
to remove the breakpoint.  At this point, you can't execute the next 
instruction; you must wait for a _policy_ decision to be made.  Adding 
policy decisions like this to the kernel surely seems like a bad idea.  
If the fallback is to have a debugger running in userspace that has a 
user or script attached that can make the interactive decision, then why 
not solve the entire problem in userspace from the start?  It's a lot 
safer, it simplifies the kernel kprobes code a lot, and it leaves the 
debugger implementation free to do anything it chooses, as well as not 
locking the solution to a particular kernel.

Zach
