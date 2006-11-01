Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423979AbWKAMHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423979AbWKAMHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423975AbWKAMHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:07:55 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:9648 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423979AbWKAMHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:07:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] swsusp: Freeze filesystems during suspend
Date: Wed, 1 Nov 2006 13:05:57 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>
References: <200611011200.18438.rjw@sisk.pl> <20061101114707.GA22079@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20061101114707.GA22079@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011305.57657.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 1 November 2006 12:47, Pavel Machek wrote:
> Hi!
> 
> > Freeze all filesystems during the suspend by calling freeze_bdev() for each of
> > them and thaw them during the resume using thaw_bdev().
> > 
> > This is needed by swsusp, because some filesystems (eg. XFS) use work queues
> > and worker_threads run with PF_NOFREEZE set, so they can cause some writes
> > to be performed after the suspend image has been created which may corrupt
> > the filesystem.  The additional benefit of it is that if the resume fails, the
> > filesystems will be in a consistent state and there won't be any journal replays
> > needed.
> > 
> > The freezing of filesystems is carried out when processes are being frozen, so
> > on the majority of architectures it also will happen during a
> > suspend to RAM.
> 
> 
> > @@ -119,7 +120,7 @@ int freeze_processes(void)
> >  		read_unlock(&tasklist_lock);
> >  		todo += nr_user;
> >  		if (!user_frozen && !nr_user) {
> > -			sys_sync();
> > +			freeze_filesystems();
> >  			start_time = jiffies;
> >  		}
> >  		user_frozen = !nr_user;
> 
> 
> Do all filesystems implement freeze?

I think so.

> If not, we may want to keep that sync...

But the sync() won't hurt anyway I think.

> 
> 
> > @@ -156,28 +157,43 @@ int freeze_processes(void)
> >  void thaw_some_processes(int all)
> >  {
> >  	struct task_struct *g, *p;
> > -	int pass = 0; /* Pass 0 = Kernel space, 1 = Userspace */
> >  
> >  	printk("Restarting tasks... ");
> >  	read_lock(&tasklist_lock);
> > -	do {
> > -		do_each_thread(g, p) {
> > -			/*
> > -			 * is_user = 0 if kernel thread or borrowed mm,
> > -			 * 1 otherwise.
> > -			 */
> > -			int is_user = !!(p->mm && !(p->flags & PF_BORROWED_MM));
> > -			if (!freezeable(p) || (is_user != pass))
> > -				continue;
> > -			if (!thaw_process(p))
> > -				printk(KERN_INFO
> > -					"Strange, %s not stopped\n", p->comm);
> > -		} while_each_thread(g, p);
> >  
> > -		pass++;
> > -	} while (pass < 2 && all);
> > +	do_each_thread(g, p) {
> > +		if (!freezeable(p))
> > +			continue;
> > +
> > +		/* Don't thaw userland processes, for now */
> > +		if (p->mm && !(p->flags & PF_BORROWED_MM))
> > +			continue;
> > +
> > +		if (!thaw_process(p))
> > +			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> > +	} while_each_thread(g, p);
> > +
> > +	read_unlock(&tasklist_lock);
> > +	if (!all)
> > +		goto Exit;
> > +
> > +	thaw_filesystems();
> > +	read_lock(&tasklist_lock);
> > +
> > +	do_each_thread(g, p) {
> > +		if (!freezeable(p))
> > +			continue;
> > +
> > +		/* Kernel threads should have been thawed already */
> > +		if (!p->mm || (p->flags & PF_BORROWED_MM))
> > +			continue;
> > +
> > +		if (!thaw_process(p))
> > +			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> > +	} while_each_thread(g, p);
> >  
> >  	read_unlock(&tasklist_lock);
> > +Exit:
> >  	schedule();
> >  	printk("done.\n");
> 
> 
> Could we do without the code duplication?

Okay, I'll move the loop(s) into a separate function.

> > +/**
> > + * freeze_filesystems - lock all filesystems and force them into a consistent
> > + * state
> > + */
> > +void freeze_filesystems(void)
> > +{
> > +	struct super_block *sb;
> > +
> > +	lockdep_off();
> 
> You should not just turn off lockdep because you don't like its
> output.
> 
> Perhaps tasklist_lock does not nest with whatever freeze_bdev needs?

The locks taken in one call to freeze_bdev() nest with analogous locks
taken in the other calls to freeze_bdev().  Actually we take several locks of
the same (I think) class in a row and keep them all until thaw_filesystems()
is called, which is quite unusual.  I don't think there's any way in which we
can convince lockdep that it's all okay other than switching it off.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
