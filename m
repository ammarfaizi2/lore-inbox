Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWGIDJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWGIDJr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWGIDJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:09:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161070AbWGIDJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:09:46 -0400
Date: Sat, 8 Jul 2006 20:09:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <20060708225009.GA30560@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0607081851470.5623@g5.osdl.org>
References: <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.64.0607061237300.3869@g5.osdl.org>
 <Pine.LNX.4.64.0607061333190.3869@g5.osdl.org> <20060708225009.GA30560@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jul 2006, Ralf Baechle wrote:
> 
> I tried the same on MIPS, for lazyness sake at first only in atomic.h.  With
> gcc 3.3 the code size is exactly the same with both "=m" and "+m", so I
> didn't look into details of the generated code.  With gcc 4.1 "+m" results
> in a size increase of about 1K for the ip27_defconfig kernel.  For example:
> 
> <unlock_kernel>:
>        df830000        ld      v1,0(gp)
>        8c620028        lw      v0,40(v1)
>        04400014        bltz    v0,a80000000029944c <unlock_kernel+0x5c>
>        00000000        nop
>        2442ffff        subiu   v0,v0,1
>        ac620028        sw      v0,40(v1)	# current->lock_depth
>        8c630028        lw      v1,40(v1)	# current->lock_depth
>        0461000b        bgez    v1,a80000000029943c <unlock_kernel+0x4c>
> 
> The poinless load isn't generated with "=m".  The interesting thing is
> that in all the instances of bloat I looked at it was actually happening
> not as part of the asm statement itself, so maybe gcc's reload is getting
> a little confused.

Indeed, that looks like gcc confusion, because that pointless load is 
literally just re-loading the "task->lock_depth" that is all part of 
perfecly normal C code _before_ the inline assembly even is reached.

Of course, if a "+m" causes gcc confusion, that's bad in itself, and 
indicates that "=m" + "m" may actually be preferable due to some internal 
gcc buglet.

I do _not_ see the same extra load on ppc64 or indeed x86 (gcc-4.1.1 in 
both cases), so there seems to be something MIPS-specific here.

		Linus
