Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUDAUlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUDAUlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:41:51 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:58771 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263157AbUDAUlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:41:36 -0500
Subject: Re: [PATCH] mask ADT: replace cpumask_t implementation [3/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040401072232.798d98c8.pj@sgi.com>
References: <20040329041256.0f27e8c4.pj@sgi.com>
	 <1080611340.6742.147.camel@arrakis>  <20040401072232.798d98c8.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080852024.9787.87.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Apr 2004 12:40:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 07:22, Paul Jackson wrote:
> > >  #define	cpu_online_map			cpumask_of_cpu(0)
> > >  #define	cpu_possible_map		cpumask_of_cpu(0)
> > >  ...
> > Might it make more sense to actually define a cpu_online_map &
> > cpu_possible_map for UP, rather than generating this code:
> > 
> > #define mask_of_bit(bit, T)                                            \
> > ({                                                                     \
> >        typeof(T) m;                                                    \
> >        mask_clearall(m);                                               \
> >        mask_setbit((bit), m);                                          \
> >        m;                                                              \
> > })
> > 
> > every time some code references cpu_online_map?  It'll only cost us 2
> > unsigned longs on 32-bit == 8 bytes...
> 
> Perhaps.
> 
> When I looked at the code just now, this only seemed to take a
> couple of instructions.  Do you think that there is much to gain?
> Better a couple of inline instructions than a possible uncached
> memory reference, I suspect.

Yeah, you may be right about that.

On UP it should compile as such:

cpu_online_map => cpumask_of_cpu(0) => 
mask_of_bit(0, _unused_cpumask_arg_) => 
({ typeof(_unused_cpumask_arg_) m; mask_clearall(m); mask_setbit(0, m);
m; }) => 
({ cpumask_t m; m._m[0] = 0UL; set_bit(0, m._m); m; }) 

Maybe we could #define it better on UP.  Something along the lines of:

#define cpu_online_map	({ cpumask_t up_cpu_map = { 1UL }; })

That way we'll get this inlined, plus very little code to execute?

Cheers!

-Matt

