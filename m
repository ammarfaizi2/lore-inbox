Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVA1GCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVA1GCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 01:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVA1GCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 01:02:09 -0500
Received: from one.firstfloor.org ([213.235.205.2]:65248 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261472AbVA1GB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 01:01:58 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, pwil3058@bigpond.net.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au>
	<20041116232827.GA842@elte.hu>
	<Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
	<20050127165330.6f388054.pj@sgi.com> <20050128042815.GA29751@elte.hu>
From: Andi Kleen <ak@muc.de>
Date: Fri, 28 Jan 2005 07:01:56 +0100
In-Reply-To: <20050128042815.GA29751@elte.hu> (Ingo Molnar's message of
 "Fri, 28 Jan 2005 05:28:15 +0100")
Message-ID: <m14qh23xd7.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
>
> interestingly, the x86 spinlock implementation uses a LOCK-ed
> instruction only on acquire - it uses a simple atomic write (and
> implicit barrier assumption) on the way out:
>
>  #define spin_unlock_string \
>          "movb $1,%0" \
>                  :"=m" (lock->slock) : : "memory"
>
> no LOCK prefix. Due to this spinlocks can sometimes be _cheaper_ than
> doing the same via atomic inc/dec.

Unfortunately kernels are often compiled for PPro and on those
an LOCK prefix is used anyways to work around some bugs in early 
steppings. This makes spinlocks considerably slower (there are some
lock intensive not even so micro benchmarks that show the difference clearly)

It uses then

#define spin_unlock_string \
        "xchgb %b0, %1" \
                :"=q" (oldval), "=m" (lock->lock) \
                :"0" (oldval) : "memory"


which has an implicit LOCK and is equally slow.

I looked some time ago at patching it at runtime using alternative(),
but it would have bloated the patch tables a lot. Another way would
be a CONFIG_PPRO_BUT_UP_ON_BUGGY_ONES, but it is hard to find the exact
steppings with the problems.

-Andi
