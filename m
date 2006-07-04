Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWGDAo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWGDAo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWGDAo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:44:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751261AbWGDAo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:44:28 -0400
Date: Mon, 3 Jul 2006 17:38:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060703173843.d2e3eae9.akpm@osdl.org>
In-Reply-To: <44A9B2B0.3000205@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<44A57310.3010208@watson.ibm.com>
	<44A5770F.3080206@watson.ibm.com>
	<20060630155030.5ea1faba.akpm@osdl.org>
	<44A5DBE7.2020704@watson.ibm.com>
	<44A5EDE6.3010605@watson.ibm.com>
	<20060630205148.4f66b125.akpm@osdl.org>
	<44A9881F.7030103@watson.ibm.com>
	<20060703144106.cc5bd6f6.akpm@osdl.org>
	<44A9B2B0.3000205@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 20:13:36 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> >>+			if (!s)
> >>+				return -ENOMEM;
> >>+			s->pid = pid;
> >>+			INIT_LIST_HEAD(&s->list);
> >>+
> >>+			down_write(sem);
> >>+			list_add(&s->list, head);
> >>+			up_write(sem);
> >>+
> >>+			if (cpu == mycpu)
> >>+				preempt_enable();
> >>    
> >>
> >
> >Actually, I don't understand the tricks which are going on with the local CPU here. 
> >What's it all for?
> >  
> >
> I was wanting to do a  get_cpu_var  for listener_list & sem
> for the current cpu and per_cpu otherwise (since thats what I thought 
> was the recommendation
> for accessing the local cpu's variable). Perhaps the preempt_disable is 
> uncalled for ?

Well we have a problem.  You want to grab this CPU's list, and then lock a
semaphore.  But taking a semaphore is a sleeping operation.

Fortunately, there's really no need to stay on-CPU at all.  When userspace
is setting or clearing entries in the map, userspace _told_ us which CPU to
manipulate, so this code can be running on any CPU at all.  So just go grab
the Nth entry in the array and acquire the lock.

And when the time comes to send some statistics, just use
raw_smp_processor_id() and don't use preempt_disable() at all.  If we end
up hopping over to another CPU, well at least we tried.  All we can do here
is to run raw_smp_processor_id() as early as possible to reduce the
possibility that we'll get a different CPU from the one which this task
really exited on.

IOW: in all cases we were provided with explicit CPU numbers from other
sources.  So no preemption disabling is required.

