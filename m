Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUHEMPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUHEMPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267657AbUHEMPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:15:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:54230 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267612AbUHEMPl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:15:41 -0400
Date: Thu, 5 Aug 2004 17:54:31 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: prasanna@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [1/3] kprobes-func-args-268-rc3.patch
Message-ID: <20040805122431.GA4411@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <2pMJz-13N-9@gated-at.bofh.it> <m3acx9yh6t.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3acx9yh6t.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 01:09:46PM +0200, Andi Kleen wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:
> > traps again to restore processor state and switch back to the
> > probed function. Linus noted correctly at KS that we need to be 
> > careful as gcc assumes that the callee owns arguments. For the
> > time being we try to avoid tailcalls in the probe function; in 
> > the long run we should probably also save and restore enough 
> > stack bytes to cover argument space.
> >
> > Sample Usage:
> > 	static int jip_queue_xmit(struct sk_buff *skb, int ipfragok)
> > 	{
> > 		... whatever ...
> > 		jprobe_return();
> > 		/*No tailcalls please */
> > 		return 0;
> > 	}
> 
> I think you misunderstood Linus' suggestion.  The problem with
> modifying arguments on the stack frame is always there because the C
> ABI allows it. One suggested solution was to use a second function

I did realise that it is the ABI which allows this, but I thought
that the only situation in which we know gcc to actually clobber
arguments from the callee in practice is for tailcall optimization. 
So I was looking for ways to avoid that ... assuming the way we code
the probe function is under our control. 

I'm not sure if that can be guaranteed and yes saving bytes from
stack would avoid the problem totally (hence the comment) and make
it less tied to expected innards of the compiler. The only issue 
with that is deciding the maximum number of arguments so it is 
generic enough. 

> call that passes the arguments again to get a private copy. But the
> compiler's tail call optimization could sabotate that when you a
> are not careful.
> 
> That's all quite hackish and compiler dependent. I would suggest an 
> assembly wrapper that copies the arguments when !CONFIG_REGPARM.
> Just assume the function doesn't have more than a fixed number
> of arguments, that should be good enough.
> 
> This way you avoid any subtle compiler dependencies.
> With CONFIG_REGPARM it's enough to just save/restore pt_regs,
> which kprobes will do anyways.
> >  

Even with CONFIG_REGPARM, if you have a large 
number of arguments for example, is spill over into stack 
a possibility ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

