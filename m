Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265206AbSJaHd0>; Thu, 31 Oct 2002 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265207AbSJaHd0>; Thu, 31 Oct 2002 02:33:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39953 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265206AbSJaHdZ>;
	Thu, 31 Oct 2002 02:33:25 -0500
Date: Wed, 30 Oct 2002 23:36:56 -0800
From: Greg KH <greg@kroah.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: 2.5 Ready list - Kernel Hooks
Message-ID: <20021031073656.GH6406@kroah.com>
References: <OF7660C6E6.D4E17A02-ON80256C5C.005B1F20@portsmouth.uk.ibm.com> <20021024170226.GI22654@kroah.com> <20021025154922.A2303@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025154922.A2303@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, forgot to answer your other questions...

On Fri, Oct 25, 2002 at 03:49:22PM +0530, Suparna Bhattacharya wrote:
> 
> So this is really very similar in effect to invoking a function 
> pointer (from a vector of hook operations), with a desired set of 
> parameters. The main difference is in the mechanism underneath
> in terms of how it performs when the operations are dummy (i.e.
> not really active).
> 
> Given this, situations where one might investigate the kernel
> hooks option:
> 1. Hooks/function pointers called in frequently hit paths
> 2. Hook operations that may largely be dummy/dormant in most 
>    typical situations
> 
> BTW, if the function pointers are context based (i.e. object
> specific where the object is a runtime parameter) then one
> couldn't use kernel location hooks (LSM security operations 
> are in their own table though, not object specific like inode 
> operations, right ?)

Yes they are in their own table.

> At Ottawa, when LSM was being presented there was some mention
> of optimized hooking. If I recall correctly the security_ops 
> vector had around 60+ operations/hooks and it did seem like 
> a given security module might not be using all the hooks 
> (capability.c probably uses only one-fifth of the hooks). 
> 
> My perspective on LSM is limited, so could you tell me if this 
> is the common pattern on most linux installations i.e. a large 
> percentage of the hooks being inactive/dummy (condition 2
> above) ?  Or do you expect all the 68 hooks to be in-use in 
> general by some module or the other ? 

I've created simple, useful modules that only use one hook.  But SELinux
uses allmost all of them.  So there is no simple answer for this
question, sorry.

> Now, looking at the security hook operations themselves, the 
> degree of optimization that kernel hooks try to provide 
> appears to be unnecessary for all the security hooks 
> e.g. some of the operations being mediated are more 
> administrative in nature and do not happen frequently, and 
> it is likely that many of the other hooks may not be very 
> time critical (could someone confirm if this is correct ?). 

Many of the LSM hooks are _very_ time critical (every read() call for
example.)

> So kernel hooks could potentially be used AFAICT (I could be 
> missing something, of course), at the same time, I'm not sure 
> if condition 2 above applies in this case.
> 
> One situation where I see an important difference is in the 
> stacking of security modules - kernel hooks do stacking only on 
> a per-hook basis, while for LSM this needs to be done on a 
> group of hooks owned by a module. Also the LSM design seems to 
> leave the implementation of stacking to the discretion of the 
> active security module.

Yes, that is a place of active disagreement among the different LSM
developers.  Some people like it, others don't.  Right now the current
implementation allows you to stack LSM modules if you want to, but you
are not forced to if you don't.

Also, I really don't like the use of the term "hook" for describing the
LSM functions, as you can see how people get confused about this :)
Some other term, like "callback" might be a better term.

thanks,

greg k-h
