Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWHCHDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWHCHDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWHCHDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:03:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932273AbWHCHDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:03:44 -0400
Date: Thu, 3 Aug 2006 00:03:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       jes@sgi.com, csturtiv@sgi.com, tee@sgi.com,
       guillaume.thouvenin@bull.net
Subject: Re: [patch 3/3] convert CONFIG tag for extended accounting routines
Message-Id: <20060803000331.22fcb4c0.akpm@osdl.org>
In-Reply-To: <44D17A47.4010302@engr.sgi.com>
References: <44D17A47.4010302@engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 21:23:35 -0700
Jay Lan <jlan@engr.sgi.com> wrote:

> +/**
> + * acct_update_integrals - update mm integral fields in task_struct
> + * @tsk: task_struct for accounting
> + */
> +void acct_update_integrals(struct task_struct *tsk)
> +{
> +	if (likely(tsk->mm)) {
> +		long delta =
> +			cputime_to_jiffies(tsk->stime) - tsk->acct_stimexpd;

If a 32 architecture chooses to implement a 64-bit cputime_t, this
expression might go wrong for very long-running tasks and high HZ.

Perhaps we should do all this in terms of cputime_t and export everything
to userspace as u64?

> +		if (delta == 0)
> +			return;
> +		tsk->acct_stimexpd = tsk->stime;
> +		tsk->acct_rss_mem1 += delta * get_mm_rss(tsk->mm);
> +		tsk->acct_vm_mem1 += delta * tsk->mm->total_vm;

It's a bit weird to be multiplying RSS by time.  What unit is a "byte
second"?

If this is not a bug then I guess this is an intermediate term for
additional downstream processing.  There is information loss here and I'd
have thought that it would be better to simply send `delta' and the rss
straight to userspace, let userspace work out what math it wants to perform
on it.  If that makes sense?

I see that the code has been like this for a long time, so treat this as a
"please educate me about BSD accounting" email ;)

