Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264804AbUD1OMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264804AbUD1OMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbUD1OJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:09:24 -0400
Received: from mx2.redhat.com ([66.187.237.31]:4509 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264804AbUD1OIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:08:50 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16527.47765.286783.249944@segfault.boston.redhat.com>
Date: Wed, 28 Apr 2004 10:07:17 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
In-Reply-To: <20040428140353.GC28459@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com>
	<20040425191543.GV28459@waste.org>
	<16527.42815.447695.474344@segfault.boston.redhat.com>
	<20040428140353.GC28459@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

mpm> On Wed, Apr 28, 2004 at 08:44:47AM -0400, Jeff Moyer wrote:
>> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall
>> <mpm@selenic.com> adds:
>> 
mpm> On Thu, Apr 22, 2004 at 11:29:33AM -0400, Jeff Moyer wrote:
>> >> If netconsole is enabled, and you hit Alt-Sysrq-t, then it will print
>> a >> small amount of output to the console(s) and then hang the system.
>> In >> this case, I'm using the e100 driver, and we end up exhausting the
>> >> available cbs.  Since we are in interrupt context, the driver's poll
>> >> routine is never run, and we loop infinitely waiting for resources to
>> >> free up that never will.  Kernel version is 2.6.5.
>> 
mpm> Can you try 2.6.6-rc2? It has a fix to congestion handling that should
mpm> address this.
>> Is the attached patch the change you are referring to?  If so, I don't
>> see how this would fix the problem.  I ended up deferring netpoll writes
>> to process context, which has been working fine for me.  Have I missed
>> something?

mpm> Well process context defeats the purpose. Ok, I've more closely read
mpm> your report and if I understand correctly, you're using the NAPI
mpm> version of e100? There's some magic NAPI bits in netpoll_poll that
mpm> might help here:

Yes, sorry I didn't specify that earlier.

mpm>         if(trapped && np->dev->poll && test_bit(__LINK_STATE_RX_SCHED,
mpm> &np->dev->state))
np-> dev->poll(np->dev, &budget);

mpm> Perhaps we need to pull the trapped test out of there. Then with any
mpm> luck, dev->hard_start_xmit will return non-zero in netpoll_send_skb,
mpm> we'll call netpoll_poll to pump the card, and we'll be able to flush
mpm> it.

I don't think so.  You can end up in code running in interrupt context that
is not designed to (ip routing code, etc).  I've been down that path
already.  I only defer to process context if irqs_disabled().

Other suggestions?

-Jeff
