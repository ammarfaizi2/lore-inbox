Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUAYCg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 21:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUAYCg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 21:36:27 -0500
Received: from dp.samba.org ([66.70.73.150]:11675 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263448AbUAYCg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 21:36:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove More Unneccessary CPU Notifiers 
In-reply-to: Your message of "Sat, 24 Jan 2004 10:10:39 -0800."
             <20040124101039.296c34fd.akpm@osdl.org> 
Date: Sun, 25 Jan 2004 13:23:22 +1100
Message-Id: <20040125023641.1CB592C29E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040124101039.296c34fd.akpm@osdl.org> you write:
> Or are you saying that we should just leave the per-cpu accounting in a
> non-zero state when its CPU has gone away, and rely upon the stats
> gathering code iterating across all cpu_possible cpus?

In general, yes!  In general, if you cared about performance you
wouldn't be doing such iteration.

> That's a bit lame in the case of __get_page_state() at least.  We've had
> problems with excess CPU consumption in there at times and it would be good
> to be able to change that function to iterate across all online CPUs, not
> all possible ones.  We can do that if we have a notifier which spills the
> numbers from the gone-away CPU into the local CPU's slot.

Well, that's what's happening at the moment if you look at the code:

	while (cpu < NR_CPUS) {
		unsigned long *in, *out, off;

		if (!cpu_possible(cpu)) {
			cpu++;
			continue;
		}

Spilling the stats is a fine optimization, sure, but that can come
later.

Especially since it need only be done at CPU_DEAD time: the hotplug
CPU patch adds a convenient macro for such things.
"hotcpu_notifier()" compiles out when !CONFIG_HOTPLUG_CPU.

What's there at the moment really is just wasted code.
RUsty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
