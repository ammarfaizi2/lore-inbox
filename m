Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264807AbUD1OGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264807AbUD1OGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264805AbUD1OEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:04:31 -0400
Received: from waste.org ([209.173.204.2]:38122 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264789AbUD1OEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:04:01 -0400
Date: Wed, 28 Apr 2004 09:03:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
Message-ID: <20040428140353.GC28459@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com> <20040425191543.GV28459@waste.org> <16527.42815.447695.474344@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16527.42815.447695.474344@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 08:44:47AM -0400, Jeff Moyer wrote:
> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:
> 
> mpm> On Thu, Apr 22, 2004 at 11:29:33AM -0400, Jeff Moyer wrote:
> >> If netconsole is enabled, and you hit Alt-Sysrq-t, then it will print a
> >> small amount of output to the console(s) and then hang the system.  In
> >> this case, I'm using the e100 driver, and we end up exhausting the
> >> available cbs.  Since we are in interrupt context, the driver's poll
> >> routine is never run, and we loop infinitely waiting for resources to
> >> free up that never will.  Kernel version is 2.6.5.
> 
> mpm> Can you try 2.6.6-rc2? It has a fix to congestion handling that should
> mpm> address this.
> 
> Is the attached patch the change you are referring to?  If so, I don't see
> how this would fix the problem.  I ended up deferring netpoll writes to
> process context, which has been working fine for me.  Have I missed
> something?

Well process context defeats the purpose. Ok, I've more closely read
your report and if I understand correctly, you're using the NAPI
version of e100? There's some magic NAPI bits in netpoll_poll that
might help here:

        if(trapped && np->dev->poll &&
           test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
                np->dev->poll(np->dev, &budget);

Perhaps we need to pull the trapped test out of there. Then with any
luck, dev->hard_start_xmit will return non-zero in netpoll_send_skb,
we'll call netpoll_poll to pump the card, and we'll be able to flush
it.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
