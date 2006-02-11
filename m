Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWBKA2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWBKA2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWBKA2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:28:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932272AbWBKA2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:28:11 -0500
Date: Fri, 10 Feb 2006 16:25:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: dada1@cosmosbay.com, ak@muc.de, ashok.raj@intel.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060210162555.32d225dc.akpm@osdl.org>
In-Reply-To: <20060211001045.GP18730@localhost.localdomain>
References: <20060209160808.GL18730@localhost.localdomain>
	<20060209090321.A9380@unix-os.sc.intel.com>
	<20060209100429.03f0b1c3.akpm@osdl.org>
	<200602101102.25437.ak@muc.de>
	<20060210024222.67db06f3.akpm@osdl.org>
	<43EC7473.20109@cosmosbay.com>
	<20060210032332.13ed3b67.akpm@osdl.org>
	<43EC9F89.7090809@cosmosbay.com>
	<20060211001045.GP18730@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <ntl@pobox.com> wrote:
>
> Eric Dumazet wrote:
> >
> > [PATCH] HOTPLUG_CPU : avoid hitting too many cachelines in recalc_bh_state()
> > 
> > Instead of using for_each_cpu(i), we can use for_each_online_cpu(i) : The 
> > difference matters if HOTPUG_CPU=y
> > 
> > When a CPU goes offline (ie removed from online map), it might have a non 
> > null bh_accounting.nr, so this patch adds a transfert of this counter to an 
> > online CPU counter.
> > 
> > We already have a hotcpu_notifier, (function buffer_cpu_notify()), where we 
> > can do this bh_accounting.nr transfert.
> > 
> > Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
> 
> > --- a/fs/buffer.c	2006-02-10 15:08:21.000000000 +0100
> > +++ b/fs/buffer.c	2006-02-10 15:47:55.000000000 +0100
> > @@ -3138,7 +3138,7 @@
> >  	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
> >  		return;
> >  	__get_cpu_var(bh_accounting).ratelimit = 0;
> > -	for_each_cpu(i)
> > +	for_each_online_cpu(i)
> >  		tot += per_cpu(bh_accounting, i).nr;
> >  	buffer_heads_over_limit = (tot > max_buffer_heads);
> >  }
> > @@ -3187,6 +3187,9 @@
> >  		brelse(b->bhs[i]);
> >  		b->bhs[i] = NULL;
> >  	}
> > +	get_cpu_var(bh_accounting).nr += per_cpu(bh_accounting, cpu).nr ;
> > +	per_cpu(bh_accounting, cpu).nr = 0;
> > +	put_cpu_var(bh_accounting);
> >  }
> 
> But now there is a window between the time the cpu is marked offline
> and the time its bh_accounting.nr is moved to another cpu.  So
> recalc_bh_state could fail to set buffer_heads_over_limit when it
> should.

Yes, there is a wee race there, but the consequences of a glitch or small
inaccuracy in buffer_heads_over_limit will be transient and negligibe.

