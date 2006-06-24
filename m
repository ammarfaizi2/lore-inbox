Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWFXEjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWFXEjV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 00:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWFXEjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 00:39:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932198AbWFXEjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 00:39:20 -0400
Date: Fri, 23 Jun 2006 21:39:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: jlan@engr.sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060623213912.96056b02.akpm@osdl.org>
In-Reply-To: <449CAA78.4080902@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<20060609010057.e454a14f.akpm@osdl.org>
	<448952C2.1060708@in.ibm.com>
	<20060609042129.ae97018c.akpm@osdl.org>
	<4489EE7C.3080007@watson.ibm.com>
	<449999D1.7000403@engr.sgi.com>
	<44999A98.8030406@engr.sgi.com>
	<44999F5A.2080809@watson.ibm.com>
	<4499D7CD.1020303@engr.sgi.com>
	<449C2181.6000007@watson.ibm.com>
	<20060623141926.b28a5fc0.akpm@osdl.org>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 22:59:04 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> >>It was due to a loop in fill_tgid() when per-TG stats
> >>data are assembled for netlink:
> >>        do {
> >>                rc = delayacct_add_tsk(stats, tsk);
> >>                if (rc)
> >>                        break;
> >>
> >>        } while_each_thread(first, tsk);
> >>
> >>and it is executed inside a lock.
> >>Fortunately single threaded appls do not hit this code.
> >>    
> >>
> >
> >Am I reading this right?  We do that loop when each thread within the
> >thread group exits?
> >
> Yes.
> 
> > How come?
> >  
> >
> To get the sum of all per-tid data for threads that are currently alive.
> This is returned to userspace with each thread exit.

I realise that.  How about we stop doing it?

When a thread exits it only makes sense to send up the stats for that
thread.  Why does the kernel assume that userspace is also interested in
the accumulated stats of its siblings?  And if userspace _is_ interested in
that info, it's still present in-kernel and can be queried for.

> >Is there some better lock we can use in there?  It only has to be
> >threadgroup-wide rather than kernel-wide.
> >  
> >
> The lock we're holding is the tasklist_lock. To go through all the 
> threads of a thread group
> thats the only lock that can protect integrity of while_each_thread afaics.

At present, yes.  That's persumably not impossible to fix.
