Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTEIJGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTEIJGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:06:25 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:13029 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262412AbTEIJGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:06:23 -0400
Date: Fri, 9 May 2003 02:19:21 -0700
From: Andrew Morton <akpm@digeo.com>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Message-Id: <20030509021921.166f82fc.akpm@digeo.com>
In-Reply-To: <200305090855.h498t4b12921@magilla.sf.frob.com>
References: <20030508213119.58dd490d.akpm@digeo.com>
	<200305090855.h498t4b12921@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2003 09:18:56.0444 (UTC) FILETIME=[04527FC0:01C3160C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> > This doesn't apply against Linus's current tree.
> 
> Ok.  I don't use bk, but I can update relative to the latest snapshot on
> kernel.org.

Yup.  The best place usually is the first link here:

	http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

the "Gzipped full patch".

> > Your patch increases the kernel text by nearly 1%.  That's rather a lot for
> > what is a fairly esoteric feature.
> 
> Agreed.  I hadn't thought about that angle.  I am open to suggestions on
> other ways to make it work.
> 
> > Would it be possible to avoid this by just taking the fault and fixing
> > things up in the exception handler?
> 
> There is no fault that would be taken.

oop, very true.

Nasty.  Maybe the best approach is to mostly uninline the access_ok()
check.  Do the check for constant-sized small copies first, so those guys
still do the access_ok() check inline; uninline the rest.

It'll hurt the microbenchmarks (again), but it's a general article of faith
that keeping the kernel's cache footprint small is a net win...

Let me think about that for a bit.

> > For some reason the patch causes gcc-2.95.3 to choke over the
> 
> You got me.  That version of gcc has many, many bugs and is long obsolete.
> Random meaningless perturbations of the code might change its behavior.

Turns out that it only happens with `-O1'.  -O2 is OK.  I use -O1 because
it is faster.  I use gcc-2.95.3 because gcc-3.x is unacceptably slow.

