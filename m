Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUHaIxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUHaIxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUHaIvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:51:39 -0400
Received: from colin2.muc.de ([193.149.48.15]:44550 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267487AbUHaIuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:50:00 -0400
Date: 31 Aug 2004 10:49:53 +0200
Date: Tue, 31 Aug 2004 10:49:53 +0200
From: Andi Kleen <ak@muc.de>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]atomic_inc_return() for i386/x86_64 (Re: RCU issue with SELinux)
Message-ID: <20040831084953.GA11113@muc.de>
References: <2wJxj-7g2-23@gated-at.bofh.it> <2x2JC-3Uu-11@gated-at.bofh.it> <m3k6vjco9e.fsf@averell.firstfloor.org> <01b401c48f33$3fb05000$f97d220a@linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b401c48f33$3fb05000$f97d220a@linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 05:19:34PM +0900, Kaigai Kohei wrote:
> Hi Andi, thanks for your comment.
> Sorry, I have not noticed your mail in the flood of Linux-Kernel ML.
> 
> > > atomic_inc_return() is not defined for arm,arm26,i386,x86_64 and um archtectures.
> > > This attached patch adds atomic_inc_return() and atomic_dec_return() to arm,i386 and x86_64.
> > >
> > > It is implemented by 'xaddl' operation with LOCK prefix for i386 and x86_64.
> > > But this operation is permitted after i486 processor only.
> > > Another implementation may be necessary for i386SX/DX processor.
> > > But 'xaddl' operation is used in 'include/asm-i386/rwsem.h' unconditionally.
> > > I think it has agreed on using 'xaddl' operation in past days.
> > 
> > We don't support SMP on 386 boxes. What you can do for 386 is to use 
> > alternative() and just use an non SMP safe version for 386 and xadd 
> > for 486+ 
> 
> We can avoid the problem by the simple solution, since SMP
> on 386 boxes isn't supported. It is to disable interrupt
> while updating atomic_t variable.

The patch is wrong.  A CONFIG_M386 kernel can run on non
386 SMP boxes. Your patch would be racy then. The only thing 
that's not supported is a real 386 with multiple CPUs.

You either have to check boot_cpu_data.x86 == 3 at runtime or 
use alternative() like I earlier suggested.

> By the way, do you know why 'xadd' operation is used
> unconditionally in 'include/asm-i386/rwsem.h'?

386 compatible kernels use a different rwsem implementation
that doesn't use this include.

-Andi
