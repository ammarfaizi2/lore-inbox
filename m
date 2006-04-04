Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWDDV6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWDDV6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWDDV6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:58:42 -0400
Received: from zrtps0kn.nortel.com ([47.140.192.55]:30848 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1750733AbWDDV6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:58:41 -0400
Message-ID: <4432EC08.4010104@nortel.com>
Date: Tue, 04 Apr 2006 15:58:32 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_FRAME_POINTER and module vermagic
References: <442ACAD6.6@nortel.com> <Pine.LNX.4.61.0603291308240.28274@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603291308240.28274@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2006 21:58:33.0357 (UTC) FILETIME=[EA9043D0:01C65832]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A while back there was a post that CONFIG_FRAME_POINTER doesn't affect 
calling conventions and doesn't need to be in vermagic.

One of my coworkers seems to think otherwise, and I don't know enough 
about the issue to know for sure.  Could someone with i386 knowledge 
comment on his thoughts?

Here's what he's currently thinking:

1) regs->ebp hold a copy of the stack frame pointer. It's value is 
conserved through any function that are compiled with FRAME_POINTER on.

2) (unsigned long *)(regs->ebp + 4) is the "pc" of the caller (like the 
link register on PPC which is relative to "fp")

3) The profile_pc function usually look directly at "pc" to do it's 
profiling magic but sometimes (when the current "pc" is inside a 
lock_function, we're SMP, and CONFIG_FRAME_POINTER is enabled) it uses 
"regs->ebp+4" to be more accurate on the profiling. In other word 
profile_pc doesn't want to create a profiling entry that would show 
redundant information about being stuck into a spin_lock...

So, if the kernel was built with SMP and FRAME_POINTER, a module wasn't, 
the module used ebp as a general register, then blocked in a spinlock 
when profile_pc started...then a regs->ebp value of something 
interesting (like "0", for instance) could cause interesting behaviour.

Seems reasonable to me, but like I said, I'm not an expert on i386.

Chris
