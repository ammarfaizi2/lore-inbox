Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbTJAHGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTJAHGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:06:22 -0400
Received: from ns.suse.de ([195.135.220.2]:40153 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261963AbTJAHGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:06:21 -0400
Date: Wed, 1 Oct 2003 09:06:20 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001070620.GK15853@wotan.suse.de>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel> <20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel> <20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel> <20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel> <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel> <p73k77pzc69.fsf@oldwotan.suse.de> <20031001000015.69007e85.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001000015.69007e85.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 12:00:15AM -0700, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > Looking at Andi's patch, it is also a dead box if the fault happens inside
> > > down_write(mmap_sem).  That should be fixed, methinks.
> > 
> > The only way to fix all that would be to move the instruction checks early
> > into the fast path.
> 
> Well the deadlock avoidance only needs to happen if the fault occured in
> kernel mode.  Presumably most faults are in userspace, so most of the
> overhead can be avoided.

Hmm.   I guess that's possible, but will be somewhat intrusive in 
do_page_fault()

Also you have to be very careful to avoid recursive faults (EIP unmapped) 
recursing further. In the original patch I did that for kernel mode by always
checking the exception table first to catch the __get_user in __is_prefetch
early.

Maybe it would be better to just use a down_read_timeout().

-Andi
