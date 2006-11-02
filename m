Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWKBUzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWKBUzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWKBUzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:55:50 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:53442 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750991AbWKBUzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:55:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: Freeze filesystems during suspend (rev. 2)
Date: Thu, 2 Nov 2006 21:53:56 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>
References: <200611011200.18438.rjw@sisk.pl> <200611012127.17943.rjw@sisk.pl> <20061101132121.3ef5716c.akpm@osdl.org>
In-Reply-To: <20061101132121.3ef5716c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611022153.57406.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 1 November 2006 22:21, Andrew Morton wrote:
> On Wed, 1 Nov 2006 21:27:17 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Wednesday, 1 November 2006 20:45, Andrew Morton wrote:
> > > On Wed, 1 Nov 2006 18:53:07 +0100
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > +void thaw_processes(void)
> > > > +{
> > > > +	printk("Restarting tasks ... ");
> > > > +	__thaw_tasks(FREEZER_KERNEL_THREADS);
> > > > +	thaw_filesystems();
> > > > +	__thaw_tasks(FREEZER_USER_SPACE);
> > > > +	schedule();
> > > > +	printk("done.\n");
> > > > +}
> > > >  
> > > > -	read_unlock(&tasklist_lock);
> > > > +void thaw_kernel_threads(void)
> > > > +{
> > > > +	printk("Restarting kernel threads ... ");
> > > > +	__thaw_tasks(FREEZER_KERNEL_THREADS);
> > > >  	schedule();
> > > >  	printk("done.\n");
> > > >  }
> > > 
> > > what do these random-looking schedule()s do??
> > 
> > My understanding is that they allow the thawed tasks to actually exit
> > the refrigerator, because __thaw_tasks() only changes their states.
> 
> I'd be surprised if this is doing what we thing it's doing.  Calling
> schedule() in state TASK_RUNNING is usually a no-op.  It'll only actually
> switch to another task if the scheduler decides that this task has expired
> its timeslice, or another higher-priority task has become runnable, etc.

This actually can happen, it seems, because __thaw_tasks() calls
wake_up_process() for each frozen task which may call resched_task() for
current.
