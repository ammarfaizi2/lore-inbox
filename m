Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTEIIme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTEIIme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:42:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33314 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262379AbTEIImc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:42:32 -0400
Date: Fri, 9 May 2003 01:55:04 -0700
Message-Id: <200305090855.h498t4b12921@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@digeo.com>
X-Fcc: ~/Mail/linus
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
In-Reply-To: Andrew Morton's message of  Thursday, 8 May 2003 21:31:19 -0700 <20030508213119.58dd490d.akpm@digeo.com>
X-Zippy-Says: Youth of today!  Join me in a mass rally for traditional mental attitudes!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This doesn't apply against Linus's current tree.

Ok.  I don't use bk, but I can update relative to the latest snapshot on
kernel.org.

> Your patch increases the kernel text by nearly 1%.  That's rather a lot for
> what is a fairly esoteric feature.

Agreed.  I hadn't thought about that angle.  I am open to suggestions on
other ways to make it work.

> Would it be possible to avoid this by just taking the fault and fixing
> things up in the exception handler?

There is no fault that would be taken.  The address is valid, but above
TASK_SIZE.  The purpose of access_ok is to say that it's ok to try it and
let it fault, because it's a user-visible address and not the kernel memory
mapped into the high part of every process's address space.  The accesses
that follow are done in kernel mode, so there is no fault for pages marked
as not user-visible.  The fixmap addresses are > TASK_SIZE and so fail the
__range_ok test, heretofore making access_ok return false.  Those are the
code paths leading to EFAULT that I mentioned.

So far I can't think of a better way to do it.

> You'll be wanting to parenthesise `size' and `type' here.

I didn't bother because the existing macros do not consistently
parenthesize their arguments and so if there were really any problems they
would already show.  But I agree it's what should be done.

> For some reason the patch causes gcc-2.95.3 to choke over the

You got me.  That version of gcc has many, many bugs and is long obsolete.
Random meaningless perturbations of the code might change its behavior.


Thanks,
Roland
