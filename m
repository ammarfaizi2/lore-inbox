Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423211AbWF1Hkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423211AbWF1Hkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423212AbWF1Hkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:40:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423211AbWF1Hke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:40:34 -0400
Date: Wed, 28 Jun 2006 00:40:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zou Nan hai <nanhai.zou@intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-Id: <20060628004029.efcc8a03.akpm@osdl.org>
In-Reply-To: <1151473582.6052.28.camel@linux-znh>
References: <1151470123.6052.17.camel@linux-znh>
	<20060627234005.dda13686.akpm@osdl.org>
	<20060628063859.GA9726@elte.hu>
	<20060627235500.8c2c290e.akpm@osdl.org>
	<1151473582.6052.28.camel@linux-znh>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2006 13:46:22 +0800
Zou Nan hai <nanhai.zou@intel.com> wrote:

> On Wed, 2006-06-28 at 14:55, Andrew Morton wrote:
> > On Wed, 28 Jun 2006 08:38:59 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > 
> > > * Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > > We see system hang in ext3 jbd code
> > > > > when Linux install program anaconda copying 
> > > > > packages. 
> > > > > 
> > > > > That is because anaconda is invoked from linuxrc 
> > > > > in initrd when system_state is still SYSTEM_BOOTING.
> > > 
> > > [ argh ...! ]
> > 
> > That's what I thought  ;)
> > 
> > > > > Thus the cond_resched checks in  journal_commit_transaction 
> > > > > will always return 1 without actually schedule, 
> > > > > then the system fall into deadloop.
> > > > 
> > > > That's a bug in cond_resched().
> > > > 
> > > > Something like this..
> > > 
> > > Acked-by: Ingo Molnar <mingo@elte.hu>
> > > 
> > 
> > Thanks.  Zou, it'd be great if you could test this in your setup, please. 
> > I've tagged it as 2.6.17.x material.
> 
> Andrew, 
>    I am building the env to test.
>    The patch was my original idea, but I was afraid of breaking any code
> that rely on the OLD wrong cond_sched semantic.

We prefer the "right" fix, however painful or risky that might be.

> However later I did a
> grep found that there is very few code that checks the return value of
> cond_resched. So the patch should be safe. 

Hope so.

> However I think cond_resched_lock and cond_resched_softirq also need fix
> to make the semantic consistent.
> 
> Please check the following patch.
> 

Ah.  I think the return value from these functions should mean "something
disruptive happened", if you like.

See, the callers of cond_resched_lock() aren't interested in whether
cond_resched_lock() actually called schedule().  They want to know whether
cond_resched_lock() dropped the lock.  Because if the lock was dropped, the
caller needs to take some special action, regardless of whether schedule()
was finally called.

So I think the patch I queued is OK, agree?

