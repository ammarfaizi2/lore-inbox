Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbUKDULB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbUKDULB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUKDUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:07:23 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28804 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262276AbUKDUEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:04:31 -0500
Message-ID: <418A8BBF.8040901@tmr.com>
Date: Thu, 04 Nov 2004 15:06:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell Miller <rmiller@duskglow.com>
CC: Doug McNaught <doug@mcnaught.org>, Jim Nelson <james4765@verizon.net>,
       DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>,
       linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <87k6t24jsr.fsf@asmodeus.mcnaught.org><87k6t24jsr.fsf@asmodeus.mcnaught.org> <200411031733.30469.rmiller@duskglow.com>
In-Reply-To: <200411031733.30469.rmiller@duskglow.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller wrote:
> On Wednesday 03 November 2004 17:03, Doug McNaught wrote:
> 
> 
>>It was already mentioned in this thread that the bookkeeping required
>>to clean up properly from such an abort would add a lot of overhead
>>and slow down the normal, non-buggy case.
>>
> 
> I am going to continue pursuing this at the risk of making a bigger fool of 
> myself than I already am, but I want to make sure that I understand the 
> issues - and I did read the message you are referring to.
> 
> I think what you are saying is that there is kind of a race condition here.

At least in the usual sense, no. There is a condition from which there 
is no graceful way back, only forward.

> When something is on the wait queue, it has to be followed through to 
> completion.  An interrupt could be received at any time, and if it's taken 
> off of the wait queue prematurely, it'll crash the kernel, because the 
> interrupt has no way of telling that.

That's part of it, but in some cases there's also i/o in progress, the 
hardware may not have a way to HALT the transfer, so the memory in 
question can't be used for something else.
> 
> That's fine as it goes, I understand that.  But I submit that this is a 
> horrible design.  I've been bitten by this more than once - usually regarding 
> broken NFS connections.
> 
> But what I don't understand is why the bookkeeping would be so inefficient.  
> It seems to me that all that would be required is a bitfield of some sort.  
> If that position in the qait queue becomes invalid, when the interrupt is 
> received to process it, the kernel notes that a flag is set invalidating that 
> part of the wait queue, dumps the output to dave null, and goes on to the 
> next.  This doesn't seem inefficient to me, unless I'm missing something.
> A little more inefficient, yes, but not to near the cost that seems to be 
> implied.
> 
> And I also have to ask this question:  what is more inefficient, slowing down 
> processing of output waiting on the queue, or having to reboot when a process 
> gets stuck due to faulty drivers?  At the very least, a compile option seems 
> like it would be worthwhile for those that would like this behavior.
> 
> And I probably am.  Missing something, that is.

You are asking to program around a problem rather than fix it. These 
hangs (usually) happen because the hardware behaviour is either 
undocumented, incorrectly documented, or flat out broken. Second likely 
cause is a bug in the driver.

In the case of a real bug, adding code to bypass the error instead of 
fixing it is more effort, more complex in most cases, and therefore less 
reliable. Where the hardware does something unexpected, the driver needs 
to fit the behaviour rather than the spec. And where the hardware is 
broken, you fix or replace it. None of those cases suggest "pretend it 
didn't happen," because in most cases you can't.

What I think you are missing:

Processes hung in D state are the result of real problems, and ignoring 
rather than fixing them is like giving a cancer patient a face lift; it 
doesn't fix the problem, it just gives you a good looking corpse.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
