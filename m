Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUH1PKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUH1PKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUH1PKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:10:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:42652 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266850AbUH1PKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:10:23 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040828073709.GA8990@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu>
	 <1093556379.5678.109.camel@krustophenia.net>
	 <1093625672.837.25.camel@krustophenia.net>  <20040828073709.GA8990@elte.hu>
Content-Type: text/plain
Message-Id: <1093705828.8611.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 11:10:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 03:37, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I am seeing large latencies (600-2000 usec) latencies in
> > dcache_readdir.  This started when the machine became a Samba server
> > and the dcache presumably got large.  Traces are at the above url (8
> > and 9 I believe).  I think this patch fixes it.
> > 
> > --- fs/libfs.c~	2004-08-14 06:54:47.000000000 -0400
> > +++ fs/libfs.c	2004-08-27 00:44:17.000000000 -0400
> > @@ -140,6 +140,7 @@
> >  			}
> >  			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
> >  				struct dentry *next;
> > +				voluntary_resched_lock(&dcache_lock);
> >  				next = list_entry(p, struct dentry, d_child);
> >  				if (d_unhashed(next) || !next->d_inode)
> >  					continue;
> 
> In this loop we are iterating over the child-directories of this
> directory. In the next line (not shown in this patch) we drop the
> dcache_lock - so the issue is the 'continue' - where we skip already
> deleted entries. Are you positive this fixes the latencies you are
> seeing? The 'deleted entries' situation ought to be relatively rare.

No, I am not sure this fixes the problem.  This is a pretty rare one, I
only saw it twice.  I have not seen it since making the above change,
but this doesn't mean anything.

Lee

