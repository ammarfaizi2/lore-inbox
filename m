Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWEJHW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWEJHW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWEJHW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:22:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:10714 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964836AbWEJHW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:22:26 -0400
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: paulus@samba.org, olof@lixom.net, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060509.233958.73723993.davem@davemloft.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	 <20060510051649.GD1794@lixom.net>
	 <17505.34919.750295.170941@cargo.ozlabs.ibm.com>
	 <20060509.233958.73723993.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 10 May 2006 17:21:49 +1000
Message-Id: <1147245709.32448.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 23:39 -0700, David S. Miller wrote:
> From: Paul Mackerras <paulus@samba.org>
> Date: Wed, 10 May 2006 16:29:59 +1000
> 
> > I have moved current, smp_processor_id and a couple of other things to
> > per-cpu variables, and that results in the kernel text being about 8k
> > smaller than without any of these __thread patches.  Performance seems
> > to be very slightly better but it's hard to be sure that the change is
> > statistically significant, from the measurements I've done so far.
> 
> That first cache line of current_thread_info() should be so hot that
> it's probably just fine to use current_thread_info()->task since
> you're just doing a mask on a fixed register (r1) to implement that.

Iirc, he tried that, though it did bloat the kernel size a bit due the
the amount of occurences of current-> in there. We are now thinking
about either dedicating a register to current (that would avoid the
problem of printk() using it in start_kernel before we get the per-cpu
areas setup) in addition to __thread (heh, we have lots of registers on
ppc :) or maybe putting current back in the paca...

It's a bit sad that we can't get rid of the PACA because it has to be in
the RMA (for those who don't know that it is, the RMA is an area of
memory that is accessible in real mode on LPAR machines, that is the
hypervisor guarantees a bunch of physically contiguous memory that is
made accessible to the partition for use in real mode). We could have
put the per-cpu infos in the RMA but I'm a bit freaked out by the idea
of having those not be node-local...

Ben.


