Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWGHWuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWGHWuO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWGHWuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:50:14 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:37093 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1030412AbWGHWuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:50:12 -0400
Date: Sat, 8 Jul 2006 23:50:10 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060708225009.GA30560@linux-mips.org>
References: <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.64.0607061237300.3869@g5.osdl.org> <Pine.LNX.4.64.0607061333190.3869@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607061333190.3869@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 01:34:14PM -0700, Linus Torvalds wrote:

> On Thu, 6 Jul 2006, Linus Torvalds wrote:
> > 
> > So I _think_ that we should change the "=m" to the much more correct "+m" 
> > at the same time (or before - it's really a bug-fix regardless) as 
> > removing the "volatile".
> 
> Here's a first cut (UNTESTED!) for x86. I didn't check any other 
> architectures, I bet they have similar problems.

I tried the same on MIPS, for lazyness sake at first only in atomic.h.  With
gcc 3.3 the code size is exactly the same with both "=m" and "+m", so I
didn't look into details of the generated code.  With gcc 4.1 "+m" results
in a size increase of about 1K for the ip27_defconfig kernel.  For example:

<unlock_kernel>:
       df830000        ld      v1,0(gp)
       8c620028        lw      v0,40(v1)
       04400014        bltz    v0,a80000000029944c <unlock_kernel+0x5c>
       00000000        nop
       2442ffff        subiu   v0,v0,1
       ac620028        sw      v0,40(v1)	# current->lock_depth
       8c630028        lw      v1,40(v1)	# current->lock_depth
       0461000b        bgez    v1,a80000000029943c <unlock_kernel+0x4c>

The poinless load isn't generated with "=m".  The interesting thing is
that in all the instances of bloat I looked at it was actually happening
not as part of the asm statement itself, so maybe gcc's reload is getting
a little confused.

  Ralf
