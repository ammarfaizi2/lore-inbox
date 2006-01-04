Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWADJVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWADJVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWADJVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:21:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26568 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932496AbWADJV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:21:29 -0500
Date: Wed, 4 Jan 2006 01:21:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mitch@sfgoth.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect remove_proc_entry
Message-Id: <20060104012105.64e0e5cf.akpm@osdl.org>
In-Reply-To: <1135981124.6039.90.camel@localhost.localdomain>
References: <1135973075.6039.63.camel@localhost.localdomain>
	<1135978110.6039.81.camel@localhost.localdomain>
	<20051230215544.GI27284@gaz.sfgoth.com>
	<1135980542.6039.84.camel@localhost.localdomain>
	<1135981124.6039.90.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 2005-12-30 at 17:09 -0500, Steven Rostedt wrote:
> 
> > Index: linux-2.6.15-rc7/fs/proc/generic.c
> > ===================================================================
> > --- linux-2.6.15-rc7.orig/fs/proc/generic.c	2005-12-30 14:19:39.000000000 -0500
> > +++ linux-2.6.15-rc7/fs/proc/generic.c	2005-12-30 17:05:56.000000000 -0500
> > @@ -693,6 +693,8 @@
> >  	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
> >  		goto out;
> >  	len = strlen(fn);
> > +
> > +	lock_kernel();
> >  	for (p = &parent->subdir; *p; p=&(*p)->next ) {
> >  		if (!proc_match(len, fn, *p))
> >  			continue;
> > @@ -713,6 +715,7 @@
> >  		}
> >  		break;
> >  	}
> > +	unlock_kernel();
> >  out:
> >  	return;
> >  }
> > 
> 
> FYI, to make sure that this solves the problem, I'm removing my locking
> in my kernel and using this instead.  It usually crashes in a day or
> two, so I can say this works if it makes it three days.
> 

I guess the lock_kernel() approach is the way to go.  Fixing a race and
de-BKLing procfs are separate exercises...

Did the patch work?
