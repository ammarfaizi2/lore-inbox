Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSJYKLq>; Fri, 25 Oct 2002 06:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSJYKLp>; Fri, 25 Oct 2002 06:11:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:54429 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261366AbSJYKLj>;
	Fri, 25 Oct 2002 06:11:39 -0400
Date: Fri, 25 Oct 2002 15:49:22 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: 2.5 Ready list - Kernel Hooks
Message-ID: <20021025154922.A2303@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <OF7660C6E6.D4E17A02-ON80256C5C.005B1F20@portsmouth.uk.ibm.com> <20021024170226.GI22654@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021024170226.GI22654@kroah.com>; from greg@kroah.com on Thu, Oct 24, 2002 at 05:06:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 05:06:44PM +0000, Greg KH wrote:
> On Thu, Oct 24, 2002 at 05:38:12PM +0100, Richard J Moore wrote:
> > 
> > A few weeks ago Suparna told me LSM had been enquiring about kernel
> > hooks - never heard the outcome though.
> 
> Wrong type of "hooks".  Ours would not work for what you are stating you
> need to do, sorry.

Backing up a bit, to the more basic question raised briefly 
at the kernel summit. Does it make sense to use a common underlying 
hooking mechanism for the various kinds of subsystems 
that use some form of hooks ? Or are the requirements radically 
different enough that it is better for each to devise its own ?

The main advantage of a common mechanism (needn't necessarily be 
kernel hooks, by the way) is scope for single source optimization 
(including arch specific optimizations where feasible) and a 
common scheme of management. These are reasons why LTT, for
example might make use kernel hooks.

The downside of course is that one solution may not suit all,
and in some cases (where the above aspects are not critical) 
people might prefer as a matter of taste to have explicit subsystem 
specific calls that clearly indicate the kind of component using the 
hooks. (Am wondering if this is one of the reasons why LSM  
would prefer not to link up with kernel hooks. Is that it ?)

A few clarifications with regard to Kernel hooks, Dprobes and LSM.

To reiterate Vamsi's point, Dprobes and Kernel Hooks are different.
Dprobes is meant for probing on demand and based on a breakpointing 
mechanism, and yes, it isn't at all meant for the kinds of things 
that LSM is doing. 

Kernel hooks are really more like notifiers meant for fast or 
frequently accessed paths, optimized for minimal overhead when 
the hooks are not active. These hooks can be placed at any code 
location and the hook operation can be passed local variables 
directly as arguments (no need to build up a structure etc). 

The component which registers operations could be part of the 
kernel or in a GPL'ed kernel module. Just like notifiers, the call
to the hooks has to be there beforehand in the kernel at necessary 
locations.

So this is really very similar in effect to invoking a function 
pointer (from a vector of hook operations), with a desired set of 
parameters. The main difference is in the mechanism underneath
in terms of how it performs when the operations are dummy (i.e.
not really active).

Given this, situations where one might investigate the kernel
hooks option:
1. Hooks/function pointers called in frequently hit paths
2. Hook operations that may largely be dummy/dormant in most 
   typical situations

BTW, if the function pointers are context based (i.e. object
specific where the object is a runtime parameter) then one
couldn't use kernel location hooks (LSM security operations 
are in their own table though, not object specific like inode 
operations, right ?)

At Ottawa, when LSM was being presented there was some mention
of optimized hooking. If I recall correctly the security_ops 
vector had around 60+ operations/hooks and it did seem like 
a given security module might not be using all the hooks 
(capability.c probably uses only one-fifth of the hooks). 

My perspective on LSM is limited, so could you tell me if this 
is the common pattern on most linux installations i.e. a large 
percentage of the hooks being inactive/dummy (condition 2
above) ?  Or do you expect all the 68 hooks to be in-use in 
general by some module or the other ? 

Richard, 
IIRC Chris Wright had (shortly after the kernel summit) 
asked me for a reference to the kernel hooks site, but we 
really didn't get to discuss anything subsequently.

Now, looking at the security hook operations themselves, the 
degree of optimization that kernel hooks try to provide 
appears to be unnecessary for all the security hooks 
e.g. some of the operations being mediated are more 
administrative in nature and do not happen frequently, and 
it is likely that many of the other hooks may not be very 
time critical (could someone confirm if this is correct ?). 
So kernel hooks could potentially be used AFAICT (I could be 
missing something, of course), at the same time, I'm not sure 
if condition 2 above applies in this case.

One situation where I see an important difference is in the 
stacking of security modules - kernel hooks do stacking only on 
a per-hook basis, while for LSM this needs to be done on a 
group of hooks owned by a module. Also the LSM design seems to 
leave the implementation of stacking to the discretion of the 
active security module.

Regards
Suparna

> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

