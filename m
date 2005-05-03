Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVECXrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVECXrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 19:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVECXrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 19:47:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:1463 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261925AbVECXr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 19:47:28 -0400
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Paul Mackerras <paulus@samba.org>, jk@blackdown.de, akpm@osdl.org,
       oleg@tv-sign.ru, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
In-Reply-To: <20050503115103.7461ae5e.davem@davemloft.net>
References: <42748B75.D6CBF829@tv-sign.ru>
	 <20050501023149.6908c573.akpm@osdl.org> <87vf61kztb.fsf@blackdown.de>
	 <1115079230.6155.35.camel@gaston> <873bt5xf9v.fsf@blackdown.de>
	 <17014.59016.336852.31119@cargo.ozlabs.ibm.com>
	 <20050503115103.7461ae5e.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 04 May 2005 09:44:53 +1000
Message-Id: <1115163893.7568.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 11:51 -0700, David S. Miller wrote:
> On Tue, 3 May 2005 12:48:40 +1000
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > Juergen Kreileder writes:
> > 
> > > BTW, xmon doesn't work for me.  'echo x > /proc/sysrq-trigger' gives
> > > me a :mon> prompt but I can't enter any commands.
> > 
> > We don't have polled interrupts-off input methods for USB keyboards.
> 
> There is nothing in the USB nor INPUT layers really blocking an
> implementation of this BTW.
> 
> I need this on Sparc64 as well, so that PROM command line input
> works after booting with USB keyboards.

Nothing prevents it ? well, I wouldn't be that optimistic :) The USB
stuff is a bit complex, it inlcudes doing DMAs, so manipulating the
iommu, dealing with URB queues (and thus allocating/releasing them)
etc... and especially in the context of xmon, that mean letting the
driver do a lot of these at any time whatever state the system is...

So it's possible, but will probably be difficult and not very reliable.

An alternative is to take over the OHCI chip completely and implement a
micro-stack that only does interrupt pipe polling and hard decodes kbd
data based on a standard boot protocol layout... Handing the controller
back to normal USB operations may prove a bit difficult here though.

Ben.


