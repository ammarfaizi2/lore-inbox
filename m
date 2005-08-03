Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVHCMbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVHCMbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVHCMbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:31:03 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:7339 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262220AbVHCMaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:30:55 -0400
Subject: Re: [Question] arch-independent way to differentiate between user
	andkernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
In-Reply-To: <20050803120413.GA12317@elte.hu>
References: <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123065472.1590.84.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508030647140.9343@chaos.analogic.com>
	 <1123069449.1590.93.camel@localhost.localdomain>
	 <20050803120413.GA12317@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 03 Aug 2005 08:30:29 -0400
Message-Id: <1123072229.1590.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 14:04 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 2005-08-03 at 06:56 -0400, linux-os (Dick Johnson) wrote:
> > > On Wed, 3 Aug 2005, Steven Rostedt wrote:
> > > The interrupt handler gets a pointer to a structure called "struct pt_regs".
> > > That contains, amongst other things, the registers pushed onto the stack
> > > during the interrupt. If the segments were kernel segments, the interrupt
> > > occurred while in kernel mode. But..... If you have any code that
> > > needs to know, it's horribly and irreparably broken beyond all
> > > repair. Interrupts need to be handled NOW, without regard to what
> > > got interrupted.
> > > 
> > 
> > By the time you get to __do_IRQ there's already more stuff on the 
> > stack. And the pt_regs is arch specific so this doesn't help.
> 
> the actual layout of pt_regs is arch-specific, but user_mode(regs) is 
> pretty much generic across most arches.
> 

OK I did the following:

 find arch -name "*.c" ! -type d | xargs grep  "update_process_times" |grep -v user_mode
arch/arm/kernel/smp.c:  update_process_times(user);
arch/um/kernel/time_kern.c:     update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)), (regs)->skas.is_user));
arch/sparc64/kernel/smp.c:                      update_process_times(user);
arch/m32r/kernel/smp.c:         update_process_times(user);
arch/alpha/kernel/smp.c:                update_process_times(user);
arch/i386/kernel/apic.c:         * update_process_times() expects us to have done irq_enter().
arch/x86_64/kernel/apic.c:       * update_process_times() expects us to have done irq_enter().
arch/sparc/kernel/sun4d_smp.c:          update_process_times(user);
arch/sparc/kernel/sun4m_smp.c:          update_process_times(user);

I also did a find without the -v user_mode and here's some of the output
(filtered to only show what's relevant):

arch/arm/kernel/time.c: update_process_times(user_mode(regs));
arch/sparc64/kernel/time.c:             update_process_times(user_mode(regs));
arch/m32r/kernel/time.c:        update_process_times(user_mode(regs));
arch/alpha/kernel/time.c:               update_process_times(user_mode(regs));
arch/i386/kernel/apic.c:                update_process_times(user_mode_vm(regs));
arch/x86_64/kernel/time.c:      update_process_times(user_mode(regs));
arch/sparc/kernel/pcic.c:       update_process_times(user_mode(regs));

So all but (amusingly) user-mode-linux use the user_mode macro. So it
does look good. I'm not too worried right now for user-mode-linux, but
that sould be fixed too if need be.

So I'll add this to the patch I'll be sending you soon (after it's all
tested).

-- Steve


