Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966611AbWKOBVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966611AbWKOBVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 20:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966612AbWKOBVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 20:21:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27078 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966611AbWKOBVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 20:21:41 -0500
Date: Tue, 14 Nov 2006 17:17:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Ingo Molnar <mingo@redhat.com>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use delayed disable mode of ioapic edge triggered
 interrupts
In-Reply-To: <m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0611141706300.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
 <1162985578.8335.12.camel@localhost.localdomain> <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
 <20061108085235.GT4729@stusta.de> <7813413.118221162987983254.komurojun-mbn@nifty.com>
 <11940937.327381163162570124.komurojun-mbn@nifty.com>
 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org> <m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
 <1163450677.7473.86.camel@earth> <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
 <1163492040.28401.76.camel@earth> <Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
 <m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, Eric W. Biederman wrote:
> 
> Hopefully this is the trivial patch that solves the problem.

Ok, having looked more at this, I have to say that the whole 
"IRQ_DELAYED_DISABLE" thing seems very fragile indeed.

It looks like we should do it not only for APIC edge-triggered interrupts, 
but for HT and MSI interrupts too, as far as I can tell (at least they 
also use the "handle_edge_irq" routine)

So I'm wondering how many other cases there are that are missing this.

In that sense, Ingo's patch was a lot safer, although I still dislike it 
for all the other reasons I mentioned - it's simply wrong to re-send a 
level-triggered irq.

I don't know MSI and HT interrupts well enough to tell whether they will 
re-trigger on their own when we unmask them, but the point is, this 
_looks_ like it might be incomplete.

I think part of the problem is a bad interface. We should simply never set 
the IRQ handler on its own. It should be a field in the "irq_chip" 
structure, and we should use _different_ irq chip structures for level and 
edge-triggered. Then we should also add the "flags" thing there, and you 
could do something like

	static struct irq_chip level_ioapic_chip = {
		..

instead of making the insane decision to use the "same" chip for all 
ioapic things.

Ingo? Eric? Comments?

		Linus

