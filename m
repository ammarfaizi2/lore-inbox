Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267206AbUGMXDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267206AbUGMXDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267210AbUGMXDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:03:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:1721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267206AbUGMXDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:03:39 -0400
Date: Tue, 13 Jul 2004 16:06:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040713160628.596b96a3.akpm@osdl.org>
In-Reply-To: <20040713225305.GO974@dualathlon.random>
References: <200407130001.i6D01pkJ003489@localhost.localdomain>
	<20040712170844.6bd01712.akpm@osdl.org>
	<20040713162539.GD974@dualathlon.random>
	<20040713114829.705b9607.akpm@osdl.org>
	<20040713213847.GH974@dualathlon.random>
	<20040713145424.1217b67f.akpm@osdl.org>
	<20040713220103.GJ974@dualathlon.random>
	<20040713152532.6df4a163.akpm@osdl.org>
	<20040713223701.GM974@dualathlon.random>
	<20040713154448.4d29e004.akpm@osdl.org>
	<20040713225305.GO974@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> What I'm doing is basically to replace all might_sleep with cond_resched

I cannot see a lot of point in that.  They are semantically different
things and should look different in the source.

And it's currently OK to add a might_sleep() to (say) an inline path which
is expended a zillion times because we know it'll go away for production
builds.  If those things become cond_resched() calls instead, the code
increase will be permanent.

> cond_resched_lock is another story of course.

cond_resched_lock() doesn't work on SMP.  I'll probably be removing it in
favour of unconditionally dropping the lock every N times around the loop,
to allow the other CPU (the one with need_resched() true) to get in there
and take it.

And please let me repeat: preemption is the way in which we wish to provide
low-latency.  At this time, patches which sprinkle cond_resched() all over
the place are unwelcome.  After 2.7 forks we can look at it again.

I've yet to go through Arjan's patch - I suspect a lot of it is not needed.
