Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTESVIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTESVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:08:49 -0400
Received: from ns.suse.de ([213.95.15.193]:45324 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262942AbTESVIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:08:46 -0400
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org, plars@austin.ibm.com, akpm@digeo.com
Subject: Re: [PATCH] Exception trace for i386
References: <20030519192814.GA975@averell.suse.lists.linux.kernel>
	<1053377808.588720@palladium.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 May 2003 23:21:42 +0200
In-Reply-To: <1053377808.588720@palladium.transmeta.com.suse.lists.linux.kernel>
Message-ID: <p73k7cmzl7d.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:

> Please don't do it this way. For one thing, there are valid uses where
> you want to enable tracing for just one process. For another, there are
> actually cases where you may want to trace all page faults, even the
> ones that don't cause signals - kind of like normal system calls. After

x86-64 has this, (pagefault_trace), but it's usually hidden in a debug
CONFIG and not too useful in normal operation (because it generates too
much output), so I didn't port this. At one point I also did a sysctl
to echo a string into and strcmp the process ->comm against this, 
but it was a bit ugly so I removed it again.

> all, from a behavioural standpoint, that is what they are: implied
> system calls.
> 
> So I think you want to make it per-process, and expose it as a ptrace
> thing (imaging seeing all the page faults a process is taking with
> "strace". Potentially quite useful for performance tuning).

Probably, but that's not the intention of this patch. From my
experience page fault tracing is too much for printk because it
produces too much information. It needs some specialized logging
module that is optimized for high frequency logging like SGI ktrace.
It could be surely implemented, but I didn't plan to do this work
currently. If you wanted it I would suggest considering kprobes or dprobes
instead which allows to define logging macros for such things nicely already.

> I don't think it's ever really valid to expose it as a global option, as
> some programs use page faults (even the signalling kind) to do their own
> memory management, and making it a global option just makes it hard to
> work with such programs.

I especially like it being a global option. It has catched bugs on x86-64 
that were never noticed before (e.g. subprocesses silently segfaulting 
that nobody noticed doing the same on i386). Clearly it's an debugging 
thing and you definitely want an option to turn it off. But having 
the global option is useful.

Also programs that break with this are much less frequent than you
probably think.

-Andi
