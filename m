Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUECTZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUECTZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 15:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbUECTZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 15:25:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:44194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263895AbUECTZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 15:25:46 -0400
Date: Mon, 3 May 2004 12:25:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-Id: <20040503122520.1e02e861.akpm@osdl.org>
In-Reply-To: <20040503122316.GA7143@in.ibm.com>
References: <20040430113751.GA18296@in.ibm.com>
	<20040430192712.2e085895.akpm@osdl.org>
	<20040503122316.GA7143@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
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

Well that create_workqueue_thread() will basically never fail - it's not a
path we need to be optimising.

And from inspection, cleanup_workqueue_thread() will handle the
non-existent thread quite happily.

