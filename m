Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWFGQd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWFGQd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWFGQd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:33:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932317AbWFGQdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:33:25 -0400
Date: Wed, 7 Jun 2006 09:29:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: y-goto@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, mbligh@google.com,
       linux-kernel@vger.kernel.org, 76306.1226@compuserve.com
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060607092950.653db4cb.akpm@osdl.org>
In-Reply-To: <44869BAB.6070100@shadowen.org>
References: <20060605200727.374cbf05.akpm@osdl.org>
	<20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
	<20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
	<20060606002758.631118da.akpm@osdl.org>
	<44869BAB.6070100@shadowen.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 10:26:03 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> > btw Andy, that UNALIGNED_ZONE_BOUNDARIES message is useless.  Only 0.1% of
> > users even have the knowledge how to recompile their kernel, let alone the
> > inclination.  Can we do something smarter here?
> 
> Yes, valid point there.  The overall plan is that this should never come
> out as the option should be on unless the architecture is ensuring
> alignment.  Right now the only architecture which is so marked is x86.
> I wonder if we should also be tainting the kernel at that point so its
> obvious to 'us' that a kernel has this problem?

Better to make things just work if we can.

> The other option is to just turn the check on all the time.  It is two
> shift and mask + a compare on two cache lines that we definatly are
> examining anyhow to make the merge checks.

Sounds OK to me.

Note that the code can be optimised:

	if (page_zone_id(page) != page_zone_id(buddy))

...

static inline int page_zone_id(struct page *page)
{
	return (page->flags >> ZONETABLE_PGSHIFT) & ZONETABLE_MASK;
}

We don't need to perform the shift to make that comparison.  If the
compiler's sufficiently smart it will be able to optimise that for us.

<checks>

        shrl    $30, %edx       #, <variable>.flags
        shrl    $30, %eax       #, <variable>.flags
        cmpl    %eax, %edx      # <variable>.flags, <variable>.flags

Nope, not smart enough.
