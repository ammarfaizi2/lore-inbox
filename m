Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVG2UwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVG2UwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVG2Uta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:49:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62090 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262840AbVG2Usi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:48:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 io_apic.c: Memorize at bootup where the i8259 is
 connected
References: <m11x5h2yv8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507291302360.3307@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 14:48:22 -0600
In-Reply-To: <Pine.LNX.4.58.0507291302360.3307@g5.osdl.org> (Linus
 Torvalds's message of "Fri, 29 Jul 2005 13:08:49 -0700 (PDT)")
Message-ID: <m1mzo51gq1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 29 Jul 2005, Eric W. Biederman wrote:
>> 
>> Since the acpi MADT table does not provide the location where the i8259
>> is connected we have to look at the hardware to figure it out.
>
> I'm not really happy with this.
>
> First off, it kind of assumes that extINT is always the 8259. Maybe that's
> true, maybe it's not. Maybe there is hardware out there that has a
> specialty interrupt controller that also uses extInt? 

I believe the definition of extInt is that it is an external
interrupt controller that sends interrupts like an 8259.

So it might be possible but it would be an extreme hardware.
And it would be an old hardware configuration because acpi
doesn't even allow you to setup that kind of thing.

> Secondly, why always just on IO-APIC 0? 

Good question the assumption was already in the code, but
it isn't hard to lift.

> This would make a lot more sense to do inside the
> loop-over-apics in enable_IO_APIC, no?

Probably.  It has to come before the call to clear_IO_APIC().
I was just be extra careful about that.

> Especially since that one already calculates the number of entries, and
> does it a lot more nicely than you do.. (ie no shifting and masking with
> magic constants).

:)

> Finally, the third issue I have is that _if_ the MP table is correct,
> we'll never know. Wouldn't it be better to query the MP table regardless,
> and see if it agrees with what we found, and if it doesn't, at least print
> a message so that it is easier to debug things if sh*t happens?

The reason I generated the patch is because reading the acpi
tables is the default no one is even using the MP table anymore.
The acpi MADT table can't represent the notion of an a pin
in ExtInt mode.  Even in the MP table has the information is pretty
much advisory as the OS doesn't use it except on very old systems.

The practical question is which is the better route.  Save
off all of the entries in the apic and ioapic and restore
them on reboot, or simply save off which pin the i8259 is
talking through and restore one pin in ExtInt mode.  I like
the latter because we have enough information that we can
and if there is a weird system we can specify it with a command
line parameter.  But the save/restore approach may be more general,
and less prone to coder error.

Eric

