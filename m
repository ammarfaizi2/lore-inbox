Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVHCLrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVHCLrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVHCLoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:44:44 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:15034 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262229AbVHCLoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:44:32 -0400
Subject: Re: [Question] arch-independent way to differentiate between user
	andkernel
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.61.0508030647140.9343@chaos.analogic.com>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123065472.1590.84.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508030647140.9343@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 03 Aug 2005 07:44:09 -0400
Message-Id: <1123069449.1590.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 06:56 -0400, linux-os (Dick Johnson) wrote:
> On Wed, 3 Aug 2005, Steven Rostedt wrote:
> The interrupt handler gets a pointer to a structure called "struct pt_regs".
> That contains, amongst other things, the registers pushed onto the stack
> during the interrupt. If the segments were kernel segments, the interrupt
> occurred while in kernel mode. But..... If you have any code that
> needs to know, it's horribly and irreparably broken beyond all
> repair. Interrupts need to be handled NOW, without regard to what
> got interrupted.
> 

By the time you get to __do_IRQ there's already more stuff on the stack.
And the pt_regs is arch specific so this doesn't help.

This is for debugging, so please don't jump to conclusions that what I'm
doing is broken.  I'm writing code to look for soft deadlocks on a fully
preemptible kernel (Ingo's RT).  For example, there's a nasty location
in kjournald that goes into a busy loop waiting for a lock to be
released. In the mainline kernel this is OK since the holding of these
locks turn off preemption. But Ingo's kernel does not turn off
preemption here, and if the kjournald is an RT task, it will prevent all
tasks lower in priority than itself from running.  I'm writing code to
detect this.

Take a look at the 
"[patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01" thread.

-- Steve



