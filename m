Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVIPUh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVIPUh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVIPUh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:37:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49864 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751261AbVIPUh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:37:27 -0400
Date: Fri, 16 Sep 2005 21:37:24 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roland Dreier <rolandd@cisco.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] utterly bogus userland API in infinibad
Message-ID: <20050916203724.GH19626@ftp.linux.org.uk>
References: <20050916181132.GF19626@ftp.linux.org.uk> <52fys4lsh9.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fys4lsh9.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 12:31:30PM -0700, Roland Dreier wrote:
>  > Exhibit A:
>  > 
>  > 	opening uverbs... is done by ib_uverbs_open() (in
>  > drivers/infinib*d/core/uverbs_main.c).   Aside of a number of obvious
>  > leaks, it does a number of calls of ib_uverbs_event_init().  Each of
>  > those does something amazingly bogus:
>  > 	* allocates a descriptor
>  > 	* allocates struct file
>  > 	* associates that struct file with root of their pseudo-fs
>  > 	* inserts it into caller's descriptor table
>  > ... and leaves an unknown number of those if open() fails, while we
>  > are at it.  With zero indications for caller and no way to find out.
> 
> Sorry, but the obvious leaks aren't obvious to me.  Could you give
> more details?

        if (!try_module_get(dev->ib_dev->owner))
                return -ENODEV;

        file = kmalloc(sizeof *file +
                       (dev->num_comp - 1) * sizeof (struct ib_uverbs_event_file)
,
                       GFP_KERNEL);
        if (!file)
                return -ENOMEM;

Looks obvious enough.  The very beginning of the function...

> It is a good point that we might leak file descriptors if open() fails
> halfway through.  I guess we should wait to do the fd_install()s until
> we're sure that everything has succeeded.
> 
>  > 	What's more, you _can_ get those descriptors afterwards, if open()
>  > had succeeded.  All you need to do is...
> 
> Not sure I follow this.  The intention is that those file descriptors
> be available to userspace for poll(), read(), etc.

... only in the opener process?  And with insertion and reporting done
in separate syscalls?  FWIW, we do have an interface for passing a bunch
of files into descriptor table - SCM_RIGHTS datagrams.

>  > Exibit B:
>  > 	... write() to said descriptor.  Buffer should contain a struct
>  > that will be interpreted.  Results will be written to user memory, at the
>  > addresses contained in that struct.  Said results might include the
>  > descriptors shat upon by open().  Nice way to hide an ioctl(), folks...
> 
>  > Note that this "interface" assumes that only original opener will write
>  > to that file - for anybody else descriptors obviously will not make any
>  > sense.
> 
>  > BTW, due to the way we do opens, if another thread sharing descriptor
>  > table will guess the number of first additional descriptor to be opened
>  > and just loops doing close() on it, we'll actually get our ib_uverbs_file
>  > kfreed right under us.  
> 
> Good point.  What do other interfaces that create file descriptors do?

That one is trivial - call kref_get() before installing descriptor, not
after that...

> For example, in fs/eventpoll.c, I don't see anything obvious in
> sys_epoll_create() that protects the file descriptor from being closed
> between ep_getfd() and ep_file_init().

Oh, lovely - it's also b0rken.  General rule: you should never, ever
do removal from descriptor table as part of cleanup.  By the time you
get there you might have _anything_ in the entry you are about to close.
eventpoll, AFAICS, should simply move ep_file_init() prior to insertion
into descriptor table.  Even more general rule: initialize the object
before sticking a pointer to it into shared data structure...

BTW, here's another example of the same principle:
        file->ucontext = ibdev->alloc_ucontext(ibdev, &udata);
        if (IS_ERR(file->ucontext)) {
                ret = PTR_ERR(file->ucontext);
                file->ucontext = NULL;
                return ret;
        }
is broken - anything that checks for ->ucontext and assumes that non-NULL
means a valid value is going to be screwed by that.  Use of local variable
would at least deal with that; however, you need exclusion and check
to deal with multiple calls of that sucker, parallel or not.

Of course, initializing the contents of ->ucontext should also go before
the assignment...

Another one, in the same function:
        ibdev->dealloc_ucontext(file->ucontext);
        file->ucontext = NULL;
on failure exit is
	a) obviously wrong since you leave the pointer to freed object in
shared data structure for a while
	b) potentially nasty since somebody might have started to use
that object while we were messing with copy_to_user() (i.e. saner solution
would be to do copy_to_user() before anything else and mess with allocations
only if it had succeeded).

> It seems that waiting to do the fd_install()s until we're just about
> to return to userspace anyway would be good enough.

>  > May I ask who had come up with that insanity?  Aside of inherent ugliness
>  > and abuse of fs syscalls, it simply doesn't work.  E.g. leaks on failed
>  > open() are going to be fun to fix...
> 
> I'm the insane one.  I'm happy to fix it up, but do you have a
> preference for what the interface should look like?  I don't think we
> want 30+ new system calls for InfiniBand and I don't think we want a
> single horrible multiplexed system call.  I don't think ioctl() is any
> better or worse than write(), so I could go either way.  Anyway, what
> do you suggest?

First of all, this form of write() is no better than ioctl() - you get
exact same problems combined with lack of warning (ioctl() is a warning
enough - we all know that its arguments can be interpreted in arbitrary
ugly way; write() is not generally assumed to suffer from that).

Note that quite a few of these guys are simply read() in disguise, which
is particulary strange since you _do_ have extra file descriptors.  Using
write() to tell which stuff you would like to read and where in userland
should we put the read value is... odd.

Moreover, don't you have e.g. ib_query_port() accessible from sysfs as well?
ib_query_gid() too...

BTW,
        uobj = pd->uobject;

        ret = ib_dealloc_pd(pd);
        if (ret)
                goto out;

        idr_remove(&ib_uverbs_pd_idr, cmd.pd_handle);

        spin_lock_irq(&file->ucontext->lock);
        list_del(&uobj->list);
        spin_unlock_irq(&file->ucontext->lock);

        kfree(uobj);
looks funny - can anything else get to uobj via that list here?  If so,
we are asking for trouble with that kfree()...

OK, that can go on (and it definitely needs a review - we have enough
obvious races in there and that's just from cursory look, more along
the lines of "what do we do in that multiplexor"), but the points wrt
interface are simple:

	* you _did_ end up with a multiplexor; you've just got it piggybacked
on sys_write().
	* part of that stuff appears to be duplicating sysfs interfaces
	* a lot of that stuff looks much more like a read(2), not write(2).
	* documentation (however informal) of the list of things accessible
via said multiplexor is needed for further comments on the interface.
 
> Not to be peevish, but I actually described exactlyl this scheme in
> email to lkml, cc'ed to Al, in Message-ID: <52k6qn229h.fsf@topspin.com>
> back in January.  For some reason, this email doesn't seem to have
> been archived on the web (I'm happy to resend if anyone wants), but Al
> certainly replied to part of it (saying that yes, get_sb_pseudo()
> should be exported).

My apologies - looks like I've missed the context back then.  I certainly
had missed the descriptions of the operations you wanted to plug into
write(2).
