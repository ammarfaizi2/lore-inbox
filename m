Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWHHPei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWHHPei (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWHHPei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:34:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:1205 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964926AbWHHPeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:34:37 -0400
X-Authenticated: #5039886
Date: Tue, 8 Aug 2006 17:34:35 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sys_getppid oopses on debug kernel
Message-ID: <20060808153435.GB2720@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44D865FD.1040806@sw.ru> <1155050817.19249.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155050817.19249.42.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.08 08:26:57 -0700, Dave Hansen wrote:
> On Tue, 2006-08-08 at 14:22 +0400, Kirill Korotaev wrote:
> > sys_getppid() optimization can access a freed memory.
> > On kernels with DEBUG_SLAB turned ON, this results in
> > Oops.
> ...
> > +#else
> > +	/*
> > +	 * ->real_parent could be released before dereference and
> > +	 * we accessed freed kernel memory, which faults with debugging on.
> > +	 * Keep it simple and stupid.
> > +	 */
> > +	read_lock(&tasklist_lock);
> > +	pid = current->group_leader->real_parent->tgid;
> > +	read_unlock(&tasklist_lock);
> > +#endif
> >  	return pid;
> >  }
> 
> Accessing freed memory is a bug, always, not just *only* when slab
> debugging is on, right?  Doesn't this mean we could get junk, or that
> the reader could potentially run off a bad pointer?
> 
> It seems that this patch only papers over the problem in the case when
> it is observed, but doesn't really even fix the normal case.
> 
> Could we use a seqlock to determine when real_parent is in flux, and
> re-read real_parent until we get a consistent one?  We could use in in
> lieu of the existing for() loop.

See this thread: http://lkml.org/lkml/2006/8/8/215

Björn
