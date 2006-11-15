Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030707AbWKOQ7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030707AbWKOQ7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030708AbWKOQ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:59:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55203 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030707AbWKOQ7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:59:05 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use delayed disable mode of ioapic edge triggered interrupts
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	<1162985578.8335.12.camel@localhost.localdomain>
	<Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<7813413.118221162987983254.komurojun-mbn@nifty.com>
	<11940937.327381163162570124.komurojun-mbn@nifty.com>
	<Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	<m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
	<1163450677.7473.86.camel@earth>
	<m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
	<1163492040.28401.76.camel@earth>
	<Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
	<m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611141706300.3349@woody.osdl.org>
	<m17ixxjnpc.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611150754120.3349@woody.osdl.org>
Date: Wed, 15 Nov 2006 09:58:12 -0700
In-Reply-To: <Pine.LNX.4.64.0611150754120.3349@woody.osdl.org> (Linus
	Torvalds's message of "Wed, 15 Nov 2006 08:06:13 -0800 (PST)")
Message-ID: <m1psbo4pgb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 14 Nov 2006, Eric W. Biederman wrote:
>
>> The truth is in practice I don't think it matters because I don't
>> think anyone actually disables MSI or hypertransport interrupts.
>
> Fair enough, at least for a 2.6.19 kind of release timeframe (and that is 
> what I worry about most, at least right now).
>
>> At this point I have two questions.
>> - What is the easiest path to get us to a stable 2.6.19 where
>>   everything works?
>
> If people don't expect HT and MSI interrupts to be masked (and I can well 
> imagine that), then I think your two-liner patch is good to go. Komuro 
> seems to have acked it already, and in many ways that's the "minimal 
> change" for 2.6.19 right now.

Well I just doubled checked this assertion.  The one driver that uses
the hypertransport irqs doesn't call disable_irq.  On the msi side
at least the forcedeth driver does call disable_irq when in msi mode.

I just doubled checked the historical behavior of the msi code and
it has never done the delayed disable thing.  So not doing it there
is not a regression.

The MSI case is different.  MSI is fundamentally about non-shared
interrupts, and interrupts that don't race with your DMAs.  So with
MSI you don't need a status register read to process the interrupt.

In the context of Ingo's patch I don't like the idea of saddling MSI
interrupts down with the best in class work arounds for a completely
different hardware interrupt model.  Although I don't doubt MSI will
get it's own set of work arounds as we come to know it better.

> I do like Ingo's patch because it seems "safe" (even if I think it might 
> be a bit _overly_ safe), but it changes semantics enough that I don't like 
> it for 2.6.19. Even his second version definitely changes semantics for 
> level-triggered PCI interrupts, even though he fixed ExtInt/i8259 ones.
>
> So I think I'll go with your patch for now, and we can re-visit Ingo's 
> thing after 2.6.19.

Sounds like a plan.

Eric
