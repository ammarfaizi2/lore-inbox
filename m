Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSKKXFp>; Mon, 11 Nov 2002 18:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSKKXFp>; Mon, 11 Nov 2002 18:05:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45465 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261612AbSKKXFn>; Mon, 11 Nov 2002 18:05:43 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: john stultz <johnstul@us.ibm.com>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200211112249.gABMnux21337@localhost.localdomain>
References: <200211112249.gABMnux21337@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1037056339.6831.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Nov 2002 15:12:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 14:49, J.E.J. Bottomley wrote:
> johnstul@us.ibm.com said:
> > We'd still need to go back and yank out the #ifdef CONFIG_X86_TSC'ed
> > macros in profile.h and pksched.h or replace them w/ inlines that wrap
> > the rdtsc calls w/ if(cpu_has_tsc && !tsc_disable) or some such line.
> 
> Actually, the best way to do this might be to vector the rdtsc calls through a 
> function pointer (i.e. they return zero always if the TSC is disabled, or the 
> TSC value if it's OK).  I think this might be better than checking the 
> cpu_has_tsc flag in the code (well it's more expandable anyway, it won't be 
> faster...)

Sounds good, I'm planning on moving get_cycles to timer_opts, so how
about using that?

> When the TSC code is sorted out on a per cpu basis, consumers are probably 
> going to expect rdtsc to return usable values whatever CPU it is called on, so 
> vectoring the calls now may help this.

Yea, this is an ugly topic. I'm really not very enthusiastic about
per-cpu tsc, because it doesn't necessarilly solve the problem on the
few machines that can't use the global tsc implementation (such as the
x440). True, many of the points Linus made about the current timer_tsc
implementation are valid. It does need to be cleaned up further, and I
have some patches to do so (I'll resend tomorrow, as I'm out sick
today). We should be looking towards multi-frequency systems, and seeing
what we can do to clean things up (ie: cpu_khz is global, etc). 

If you are deadset on doing the percpu method, I'd strongly suggest
creating a new timer_per_cpu_tsc timer_opt struct and implementing it
there, rather then munging the existing code, which works well for most
systems. 

thanks
-john

