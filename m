Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbTLRABy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 19:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTLRABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 19:01:54 -0500
Received: from ozlabs.org ([203.10.76.45]:16065 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264874AbTLRABw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 19:01:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16352.60889.726659.218445@cargo.ozlabs.ibm.com>
Date: Thu, 18 Dec 2003 10:59:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <aradorlinux@yahoo.es>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-mm1
In-Reply-To: <20031217140139.1ae616b4.akpm@osdl.org>
References: <20031217014350.028460b2.akpm@osdl.org>
	<20031217192225.58842400.aradorlinux@yahoo.es>
	<20031217140139.1ae616b4.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Diego Calleja García <aradorlinux@yahoo.es> wrote:
> 
> > local_bh_enable() was called in hard irq context.   This is probably a bug
> > Call Trace:
> >  [<c0127b96>] local_bh_enable+0x96/0xa0
> >  [<e08fc4d8>] ppp_asynctty_receive+0x78/0xd0 [ppp_async]
> >  [<c01cec6c>] flush_to_ldisc+0xdc/0x130
> >  [<c01ecc17>] receive_chars+0x227/0x240
> >  [<c01eccd5>] transmit_chars+0xa5/0xe0
> >  [<c01ecf7c>] serial8250_interrupt+0x12c/0x130
> >  [<c010c9f9>] handle_IRQ_event+0x49/0x80
> >  [<c010cdc8>] do_IRQ+0xb8/0x180
> >  [<c02ca760>] common_interrupt+0x18/0x20
> 
> 
> ppp_asynctty_receive() is called from hard IRQ context and hence may not use
> spin_unlock_bh().  The patch converts ppp to use an IRQ-safe spinlock.

... which only pushes the problem down one level, since
ppp_async_input eventually calls ppp_input with interrupts disabled,
which is not allowed.  The reason that it isn't allowed is that it
would mean that the ppp_generic code would have to disable interrupts
in its critical sections, which would be very bad for interrupt
latency, particularly if you are using compression or encryption on
the link.

Given the number of serial drivers that want to call the line
discipline receive_chars routine with interrupts hard-disabled, I
would consider a patch to ppp_async.c to make it use a tasklet so that
it calls ppp_input from softirq level.  But the currently proposed
patch is buggy.

Regards,
Paul.


