Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264056AbUEEIhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbUEEIhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbUEEIhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:37:34 -0400
Received: from ozlabs.org ([203.10.76.45]:1206 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264056AbUEEIhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:37:31 -0400
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
From: Rusty Russell <rusty@rustcorp.com.au>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040503122316.GA7143@in.ibm.com>
References: <20040430113751.GA18296@in.ibm.com>
	 <20040430192712.2e085895.akpm@osdl.org>  <20040503122316.GA7143@in.ibm.com>
Content-Type: text/plain
Message-Id: <1083746224.14112.7.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 18:37:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 22:23, Srivatsa Vaddagiri wrote:
> On Fri, Apr 30, 2004 at 07:27:12PM -0700, Andrew Morton wrote:
> > Can we not simply do:
> > 
> > 
> > diff -puN kernel/workqueue.c~a kernel/workqueue.c
> > --- 25/kernel/workqueue.c~a	2004-04-30 19:26:32.003303600 -0700
> > +++ 25-akpm/kernel/workqueue.c	2004-04-30 19:26:44.492404968 -0700
> > @@ -334,6 +334,7 @@ struct workqueue_struct *__create_workqu
> >  				destroy = 1;
> >  		}
> >  	}
> > +	unlock_cpu_hotplug();
> >  
> >  	/*
> >  	 * Was there any error during startup? If yes then clean up:
> > @@ -342,7 +343,6 @@ struct workqueue_struct *__create_workqu
> >  		destroy_workqueue(wq);
> >  		wq = NULL;
> >  	}
> > -	unlock_cpu_hotplug();
> >  	return wq;
> >  }
> 
> I didn't do this because I introduced a break at the first instance
> when create_workqueue_thread failed. Breaking out of the loop
> like that appeared to be more efficient rather than going back and
> trying to create threads for rest of the online cpus, because most
> likely thread creation will fail for other cpus also and anyway
> the workqueue will be destroyed down the line.

The logic was not the way I would have done it, but it *is* neater.  I
prefer the akpm fix I think.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

