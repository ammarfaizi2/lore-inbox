Return-Path: <linux-kernel-owner+w=401wt.eu-S1751390AbWLLOrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWLLOrw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 09:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWLLOrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 09:47:52 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47324 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbWLLOrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 09:47:51 -0500
Message-ID: <457EC112.3020204@us.ibm.com>
Date: Tue, 12 Dec 2006 08:47:46 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke Browning <LukeBrowning@us.ibm.com>
CC: maynardj@linux.vnet.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
References: <OFD47C2157.B38B81D4-ON8325723E.00687BA3-8325723E.0069669F@us.ibm.com>
In-Reply-To: <OFD47C2157.B38B81D4-ON8325723E.00687BA3-8325723E.0069669F@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Browning wrote:
> maynardj@linux.vnet.ibm.com wrote on 08/12/2006 01:04:30 PM:
> 
>  > Arnd Bergmann wrote:
>  >
>  > >On Wednesday 06 December 2006 23:04, Maynard Johnson wrote:
>  > >  
>  > >No code should ever need to look at other SPUs when performing an
>  > >operation on a given SPU, so we don't need to hold a global lock
>  > >during normal operation.
>  > >
>  > >We have two cases that need to be handled:
>  > >
>  > >- on each context unload and load (both for a full switch operation),
>  > >  call to the profiling code with a pointer to the current context
>  > >  and spu (context is NULL when unloading).
>  > >
>  > >  If the new context is not know yet, scan its overlay table (expensive)
>  > >  and store information about it in an oprofile private object. 
> Otherwise
>  > >  just point to the currently active object, this should be really 
> cheap.
>  > >
>  > >- When enabling oprofile initially, scan all contexts that are currently
>  > >  running on one of the SPUs. This is also expensive, but should happen
>  > >  before the measurement starts so it does not impact the resulting 
> data.
>  > >
> 
> Agreed.  
> 
> <snip>
> 
>  > >>I'm not exactly sure what you're saying here.  Are you suggesting 
> that a
>  > >>user may only be interested in acitve SPU notification and, therefore,
>  > >>shouldn't have to be depenent on the "standard" notification
>  > >>registration succeeding?  There may be a case for adding a new
>  > >>registration function, I suppose; although, I'm not aware of any other
>  > >>users of the SPUFS notification mechanism besides OProfile and PDT, 
> and
>  > >>we need notification of both active and future SPU tasks.  But I would
>  > >>not object to a new function.
>  > >>
>  > >>    
>  > >>
>  > >I think what Luke was trying to get to is that notify_spus_active() 
> should
>  > >not call blocking_notifier_call_chain(), since it will notify other 
> users
>  > >as well as the newly registered one. Instead, it can simply call the
>  > >notifier function directly.
>  > >  
>  > >
>  > Ah, yes.  Thanks to both of you for pointing that out.  I'll fix that
>  > and re-post.
>  >
>  > -Maynard
>  >
> 
> I actually was hoping to take this one step further.  If the interface to
> the context switch handler is something like:
> 
> switch_handler(int spu_id, from_ctx, to_ctx)
The function prototype for the switch handler is set in concrete by the 
notification framework.  The parameters are: struct notifier_block *, 
unsigned long, void *.
> 
> The kernel extension can maintain an internal spu table of its own where it
> marks the named spuid as active or not.  You don't need to have a bunch of
> individual calls.  Internally, you can keep track of it yourself.
I think this would be nice to have, and I will look into it as I have 
time.  However, for the existing usage of the SPU switch notification, I 
don't think it's too critical, since most users are not going to be 
trying to do profiling or debugging with multiple SPU apps running 
simultaneously.
> 
> Luke
> 


