Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755320AbWKMUqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbWKMUqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbWKMUqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:46:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24758 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755320AbWKMUqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:46:44 -0500
Subject: Re: 2.6.19-rc5: known regressions :SMP kernel can not generate ISA
	irq
From: Ingo Molnar <mingo@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	 <1162985578.8335.12.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de>
	 <7813413.118221162987983254.komurojun-mbn@nifty.com>
	 <11940937.327381163162570124.komurojun-mbn@nifty.com>
	 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	 <m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 21:44:37 +0100
Message-Id: <1163450677.7473.86.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 10:11 -0700, Eric W. Biederman wrote:
> > So when you "mask" an edge-triggered IRQ, you can't really mask it
> at all, 
> > because if you did that, you'd lose it forever if the IRQ comes in
> while 
> > you masked it. Instead, we're supposed to leave it active, and set a
> flag, 
> > and IF the IRQ comes in, we just remember it, and mask it at that
> point 
> > instead, and then on unmasking, we have to replay it by sending a 
> > self-IPI.
> >
> > Maybe that part got broken by some of the IRQ changes by Eric. 
> 
> Hmm.  The other possibility is that this is a genirq migration issue.
> 
> Yep.  That looks like it.   In the genirq migration the edge and
> level triggered cases got merged and previously disable_edge_ioapic
> was a noop.  Ouch.

hm, that should be solved by the generic edge-triggered flow handler as
well: we never mask an IRQ first time around, we only mask it if
we /already/ have the 'soft' IRQ_PENDING flag set. (in that case the
lost edge is not an issue because we have the information already - and
the masking will prevent a screaming edge source)

but maybe this concept has not been pushed through to the disable/enable
irq logic itself? (it's only present in the flow handler) Thomas, do you
concur?

	Ingo

