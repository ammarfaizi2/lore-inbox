Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWAUCjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWAUCjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWAUCjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:39:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12745 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750797AbWAUCjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:39:36 -0500
Date: Fri, 20 Jan 2006 18:38:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Schwab <schwab@suse.de>
Cc: trond.myklebust@fys.uio.no, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, ak@suse.de, mingo@redhat.com,
       torvalds@osdl.org
Subject: Re: set_bit() is broken on i386?
Message-Id: <20060120183857.188ef516.akpm@osdl.org>
In-Reply-To: <jek6cu73jy.fsf@sykes.suse.de>
References: <200601201955_MC3-1-B649-DCF5@compuserve.com>
	<1137806107.8691.25.camel@lade.trondhjem.org>
	<jek6cu73jy.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> wrote:
>
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> > On Fri, 2006-01-20 at 19:53 -0500, Chuck Ebbert wrote:
> >
> >> #define ADDR (*(volatile long *) addr)
> >> static inline void set_bit(int nr, volatile unsigned long * addr)
> >> {
> >> 	__asm__ __volatile__( "lock ; "
> >> 		"btsl %1,%0"
> >> 		:"=m" (ADDR)
> >> 		:"Ir" (nr));
> >> }
> >
> > The asm needs a memory clobber in order to avoid reordering with the
> > assignment to b[1]:
> 
> Check out 2.6.16-rc1, this has already been fixed.
> 

No, that doesn't fix this testcase.

We need to somehow tell the compiler "this assembly statement altered
memory and you can't cache memory contents across it".  That's what
"memory" (ie: barrier()) does.  I don't think there's a way of telling gcc
_what_ memory was clobbered - just "all of memory".
