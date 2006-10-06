Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422839AbWJFSve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422839AbWJFSve (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWJFSve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:51:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44248 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422839AbWJFSvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:51:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610060855220.3952@g5.osdl.org>
	<m1hcyh1hqz.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610061102010.3952@g5.osdl.org>
Date: Fri, 06 Oct 2006 12:48:55 -0600
In-Reply-To: <Pine.LNX.4.64.0610061102010.3952@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 6 Oct 2006 11:08:08 -0700 (PDT)")
Message-ID: <m1r6xlz3e0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 6 Oct 2006, Eric W. Biederman wrote:
>> 
>> Forcing irqs to specific cpus is not something this patch adds.  That
>> is the way the ioapic routes irqs.
>
> What that patch adds is to make it an ERROR if some irq goes to an 
> unexpected cpu.
>
> And that very much is wrong. 

Agreed. Not recovering from an irq that hits the wrong cpu if we
can recover from it is a problem.   That part must be fixed.

>> Yes.  A single problem over several months of testing has been found.
>
> Umm. It got found the moment it became part of the standard tree.
>
> The fact is, "months of testing" is not actually very much, if it's the 
> -mm tree. That's at best a "good vetting", but it really doesn't prove 
> anything.

I'm not trying to prove anything just saying that I tried.
All it shows is that there are an interesting subset of systems that
work.

The fact that the system that failed has a comparatively low volume
chipset from IBM let's me entertain my an atypical hardware hypothesis.

>> So this is fairly fundamentally an irq migration problem.  If you
>> never change which cpu an irq is pointed at you don't have problems,
>> as there are no races.
>
> So? Does that change the issue that this new model seems inherently racy?

If it is inherently racy, (i.e. it cannot be fixed) I don't have a
problem removing the code.

>> The current irq migration logic does everything in the irq handler
>> after an irq has been received so we can avoid various kinds of races.
>
> No. You don't understand, or you refuse to face the issue.
>
> The races are in _hardware_, outside the CPU. The fact that we do things 
> in an irq handler doesn't seem to change a lot.

(as an aside the problem does not appear on the irq migration path
 because the kernel has not made it far enough for that to be
 possible)

I think I don't understand the race you see.  I believe the premise
the irq migration code works under is that while an irq is pending
a second irq will not be sent from the ioapic.

If that premise is true, and we disable that irq on the ioapic,
while the irq is still pending that should successfully prevent
the hardware from sending any further instances of that irq while we
manipulate it's routing.

There are a few more details but that is why I think that path is
safe.

> And what do you intend to do if it turns out that the reason it doesn't 
> work on x366 is that the _hardware_ just is incompatible with your
> model?

If the code is fundamentally unfixable the code must go.

> I'm not saying that's the case, and maybe there's some stupid bug that has 
> been overlooked, and maybe it can all work fine. But the new model _does_ 
> seem to be at least _potentially_ fundamentally broken.

The BUG_ON certainly is, I will work up a patch to get rid of that.
I'm hoping to understand how it could possibly happen before I fix
that now that I have a reproducer of that condition, because it may
influence the fix.  But dropping an irq on the floor is certainly
better then crashing the entire system. 

Eric
