Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265408AbUEUHoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265408AbUEUHoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUEUHoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:44:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265433AbUEUHoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:44:03 -0400
Date: Fri, 21 May 2004 03:43:58 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040521074358.GG30909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520155217.7afad53b.akpm@osdl.org> <40AD9C5E.1020603@redhat.com> <20040520233639.126125ef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520233639.126125ef.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 11:36:39PM -0700, Andrew Morton wrote:
> > > It'll work OK on x86 because of the stack layout but is the same true of
> > > all other supported architectures?
> > 
> > We add parameters at the end.  This does not influence how previous
> > values are passed.  And especially for syscalls it makes no difference.
> > 
> 
> what we're effectively doing is:
> 
> void foo(int a, int b, int c)
> {
> }
> 
> and from another compilation unit:
> 
> 	foo(a, b);
> 
> and we're expecting the a's and b's to line up across all architectures and
> compiler options.  I thought that on some architectures that only works out
> if the function has a vararg declaration.

The kernel syscall ABI is on many arches different from the compiler ABI.
Adding an argument this way certainly works on the architectures I'm
familiar with (i386, x86_64, ia64, ppc, ppc64, s390, s390x, sparc, sparc64,
alpha).  I believe arm will work too, don't keep track of the rest of
arches.

Well, for s390/s390x there is a problem that it doesn't allow (yet) 6
argument syscalls at all, so one possibility for s390* is adding a wrapper around
sys_futex which will take the 5th and 6th arguments for FUTEX_CMP_REQUEUE
from a structure pointed to by 5th argument and pass that to sys_futex.

If some weirdo arch has problems with this, it can certainly deal with it in
its architecture wrapper.

	Jakub
