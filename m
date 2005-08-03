Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVHCBOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVHCBOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 21:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVHCBOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 21:14:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21753 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261895AbVHCBOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 21:14:30 -0400
Message-ID: <42F019FB.1030200@mvista.com>
Date: Tue, 02 Aug 2005 18:12:27 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
References: <20050730160345.GA3584@elte.hu>	 <1122920564.6759.15.camel@localhost.localdomain>	 <1122931238.4623.17.camel@dhcp153.mvista.com>	 <1122944010.6759.64.camel@localhost.localdomain>	 <20050802101920.GA25759@elte.hu>	 <1123011928.1590.43.camel@localhost.localdomain>	 <1123025895.25712.7.camel@dhcp153.mvista.com> <1123027226.1590.59.camel@localhost.localdomain>
In-Reply-To: <1123027226.1590.59.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Tue, 2005-08-02 at 16:38 -0700, Daniel Walker wrote:
> 
>>Couldn't you just do some math off current->timestamp to see how long
>>the task has been running? This per arch stuff seems a bit invasive..
> 
> 
> The thing is, I'm tracking how long the task is running in the kernel
> without doing a schedule.  That's actually easy, but I don't want to
> count when the task is in userspace. The per-arch is only updating so
> that we don't count user space, otherwise the count could be in the
> task_struct.  If there is an arch-independent way to tell if a task is
> running in user-space or kernel when an interrupt goes off then I would
> use it.  The per arch is actually easy, and I would write it, but I
> don't have the hardware now to test it.  I could at least do PPC and
> MIPS since I'm quite familiar with both, but I don't currently have a
> cross compiler to compile it.
> 
> I understand your point, I would really prefer an arch independent
> solution, but the timestamp from current just wont cut it.  Have another
> idea, I'm all open for it.

How about something like:
	if (current + THREAD_SIZE/sizeof(long) - (regs + sizeof(pt_regs)) > MAGIC)

The idea is that an interrupt from user space will be the ONLY thing on 
the stack while an interrupt from the kernel will have kernel stack 
under it.  Current is the bottom end of the kernel stack and regs + 
sizeof(pt_regs) is where the interrupt context started.  Assumptions a) 
stack grows down, b) no switch stack at interrupt.
MAGIC is some small number.  For x86 user it is actually zero, don't 
know about others but the saved context should be the first thing on the 
stack so a minimun frame size should do.


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
