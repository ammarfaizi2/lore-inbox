Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWCDIUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWCDIUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 03:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWCDIUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 03:20:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751415AbWCDIUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 03:20:17 -0500
Date: Sat, 4 Mar 2006 00:18:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       johnstul@us.ibm.com, ak@muc.de, Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
Message-Id: <20060304001834.0476e8e9.akpm@osdl.org>
In-Reply-To: <20060304.013153.71086081.anemo@mba.ocn.ne.jp>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
	<20060304.013153.71086081.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> akpm> I'm not sure how to resolve this, really.  Worried.  Have you
> akpm> socialised those changes with architecture maintainers?  If so,
> akpm> what was the feedback?
> 
> For a short term fix, barrier() might be a safe option.
> 
> 
> Add an optimization barrier to prevent prefetching jiffies before
> incrementing jiffies_64.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/kernel/timer.c b/kernel/timer.c
> index fc6646f..fdd12a5 100644
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -925,6 +925,7 @@ static inline void update_times(void)
>  void do_timer(struct pt_regs *regs)
>  {
>  	jiffies_64++;
> +	barrier();
>  	update_times();
>  	softlockup_tick(regs);
>  }

a) Please never ever add any form of barrier without adding a comment
   explaining why it's there.  Unless it's extremely obvious (and it rarely
   is), it's hard for the reader to work out what on earth it's doing
   there.

   Example?  Take a look at the smp_rmb() in ext3_get_inode_block(),
   work out why it's there.  Time yourself.

b) On 64-bit machines jiffies and jiffies_64 always have the same
   address (don't they?) Is the compiler really going to move a read of an
   absolute address ahead of a modification of the same address?

   <looks>

   The address of jiffies isn't known until link time, so yup, the risk
   is there.

c) jiffies is declared volatile.  In practice, if I know my gcc, it's
   just not going to play these reordering games with a volatile.

   If that's true, and if some standard (presumably c99) says that it
   must be true then I don't think we need the patch.

