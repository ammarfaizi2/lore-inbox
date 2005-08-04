Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVHDPdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVHDPdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVHDPan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:30:43 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:13835 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262580AbVHDPaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:30:25 -0400
Message-ID: <42F2344D.1070209@vmware.com>
Date: Thu, 04 Aug 2005 08:29:17 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5 explicit-iopl
References: <200508040043.j740hi0R004184@zach-dev.vmware.com.suse.lists.linux.kernel> <p73k6j1rj1i.fsf@bragg.suse.de>
In-Reply-To: <p73k6j1rj1i.fsf@bragg.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Aug 2005 15:29:18.0234 (UTC) FILETIME=[47720FA0:01C59909]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>zach@vmware.com writes:
>  
>
>>Unfortunately, this added one field to the thread_struct.  But as a bonus, on
>>P4, the fastest time measured for switch_to() went from 312 to 260 cycles, a
>>win of about 17% in the fast case through this performance critical path.
>>    
>>
>
>Cool! Definitely want this on x86-64 too.
>  
>

Well... maybe.  On Opteron and/or Intel EMT it may not be a win.  The 
cost of the branch could overtake the cost of the POPF (that's the 
expensive one).  Grrr.

>Can we perhaps get rid of the PUSHF/POPF in the SYSENTER syscall path too?
>iirc they were only for single stepping. But SYSENTER doesn't disable
>single stepping, so the debug handler could detect this and set
>some magic flag that restores it on syscall exit.
>  
>

A context switch requires IRET, which requires the flags to be saved, so 
you can't eliminate the pushf (*) IIRC, the popf is already omitted.  
Many of these patches may be beneficial to x86-64, but. unfortunately 
the performance deltas may not translate.  Lets hope they do!  
Unfortunately, that requires re-measuring the cost of switch_to(), which 
was quite amusing to do.  I can send you diffs if you're interested, but 
using printk around this path turned out to be a really bad idea ;)  I 
really would like to bring some of the cleanup and performance work I've 
done on i386 over to x86_64 as well, but that is still probably a couple 
of weeks out.  If you can't wait, you're welcome to port pieces you 
like!  Let me know.

(*) Well, you could.  It's just that system calls would have to clobber 
flags - hmm.. sysenter based calls already do. But I'm not 100% sure 
there isn't some bogon case where kernel preemption could cause you a 
problem.  Keeping around the fake IRET frame still appears to be a good 
thing to do just for the benefit of ptrace / debug functionality.  PUSHF 
is cheap on every core I have measured on.

Zach
