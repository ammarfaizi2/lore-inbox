Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423223AbWF1Ipu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423223AbWF1Ipu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423224AbWF1Ipu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:45:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423223AbWF1Ipt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:45:49 -0400
Date: Wed, 28 Jun 2006 01:45:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zou Nan hai <nanhai.zou@intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-Id: <20060628014544.198b9eb4.akpm@osdl.org>
In-Reply-To: <1151477429.6052.42.camel@linux-znh>
References: <1151470123.6052.17.camel@linux-znh>
	<20060627234005.dda13686.akpm@osdl.org>
	<20060628063859.GA9726@elte.hu>
	<20060627235500.8c2c290e.akpm@osdl.org>
	<1151473582.6052.28.camel@linux-znh>
	<20060628004029.efcc8a03.akpm@osdl.org>
	<1151474577.6052.33.camel@linux-znh>
	<20060628010422.dc73b7e9.akpm@osdl.org>
	<1151477429.6052.42.camel@linux-znh>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2006 14:50:29 +0800
Zou Nan hai <nanhai.zou@intel.com> wrote:

> On Wed, 2006-06-28 at 16:04, Andrew Morton wrote:
> > On 28 Jun 2006 14:02:57 +0800
> > Zou Nan hai <nanhai.zou@intel.com> wrote:
> > 
> > > > > However I think cond_resched_lock and cond_resched_softirq also need fix
> > > > > to make the semantic consistent.
> > > > > 
> > > > > Please check the following patch.
> > > > > 
> > > > 
> > > > Ah.  I think the return value from these functions should mean "something
> > > > disruptive happened", if you like.
> > > > 
> > > > See, the callers of cond_resched_lock() aren't interested in whether
> > > > cond_resched_lock() actually called schedule().  They want to know whether
> > > > cond_resched_lock() dropped the lock.  Because if the lock was dropped, the
> > > > caller needs to take some special action, regardless of whether schedule()
> > > > was finally called.
> > > > 
> > > > So I think the patch I queued is OK, agree?
> > > 
> > >   I am afraid the code like cond_resched_lock check in
> > > fs/jbd/checkpoint.c log_do_checkpoint may fall into endless retry in
> > > some condition, will it?
> > 
> > Oh crap, yes.  If need_resched() and system_state==SYSTEM_BOOTING then
> > cond_resched_lock() will drop the lock but won't schedule.  So it'll return
> > true but won't clear need_resched() and the caller will lock up.
> > 
> > So if cond_resched_foo() ends up dropping the lock it _must_ call
> > schedule() to clear need_resched().
> > 
> > So, how about this (it needs some code comments!)
> > 
> > 
> 
>  The patch works for the install test env.

Thanks.

>  However I still have some concern on cond_resched_lock(), on an UP 
> kernel it will return 1 if schedule happen, but actually it does not
> drop any lock, that semantic seems to be different to SMP kernel. 

That's OK (I think - I don't have a good track record in this thread).

If the kernel is non-preemptible and UP, we want to return true from
cond_resched_foo() if we called schedule().  Because schedule() might allow
a different thread into the kernel which might modify the locked data.

And if the kernel is preemptible and UP, we want to return true from
cond_resched_foo() if we dropped the lock, because that internally does a
preempt_enable().

And the patch (hopefully) satisfies those requirements.  Does that all
sound solid?

