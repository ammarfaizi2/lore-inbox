Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVCABJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVCABJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVCABJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:09:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55821
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261173AbVCABHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:07:32 -0500
Date: Tue, 1 Mar 2005 02:07:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [andrea@cpushare.com: Re: [Twisted-Python] linux kernel 2.6.11-rc broke twisted process pipes]
Message-ID: <20050301010728.GX8880@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a short update since I got feedback on the twisted side. The "r and
w" check that twisted does seems really correct and in sync with current
BK: POLLERR will make both of these bitmask trigger and this should lead
to the "r and w" condition being True.

#define POLLIN_SET (POLLRDNORM | POLLRDBAND | POLLIN | POLLHUP | POLLERR)
#define POLLOUT_SET (POLLWRBAND | POLLWRNORM | POLLOUT | POLLERR)

Previously "r and w" didn't mean disconnect because POLLIN was forced to
be set (or anyway it could be set in 2.6.11-rc5 if the buffer wasn't
empty).

So the select side of things matches what the twisted code think should
happen when a reader disconnects.

They also said at the end that the select call is only used with the
selectreactor, and the pollreactor should be just fine with POLLERR
being returned and POLLIN never being returned. So I think we should be
fine with it too already, but I asked to double check it just in case.
(my test however are successful with pollreactor, infact I've never
tested the selectreactor, to me it was the pollreactor breaking)

I tend to agree that previously it was working by luck, and I suspect
it's still working by luck in openbsd too, since openbsd seem to do very
similar to what linux was doing in 2.6.5-rc11 (and 2.6.5-rc11 made a lot
more sense than 2.6.9 and previous): that is to return poll information
relevant for both the reader and the writer at the same time. So the
assumption that "r and w" means "reader disconnected" may not be really
true on openbsd like it was not true for 2.6.5-rc11. I didn't check
other bsd implementations but you can find a link at the end of the
forward.

Perhaps the only thing we could change on top of the current code is to
set POLLIN|POLLRDNORM at the same time of POLLERR/POLLHUP, but that
makes no sense accoding to SUS poll specifications (they say POLLIN
means there's data to be read, and on a WRONLY fd nothing can be read),
and such a change would be a noop for select(2). So I find the current
kernel code more correct.

This is the SUS specs:

http://www.opengroup.org/onlinepubs/007908799/xsh/poll.html

POLLIN
 Data other than high-priority data may be read without blocking. [..]
POLLRDNORM
 Normal data (priority band equals 0) may be read without blocking. [..]

btw, I don't really know the difference of POLLIN and POLLRDNORM, I
suspect there's no difference for pipe(2) that has a single band (I
guess it probably matters only for protocols with multiple bands like
TCP that can send a out of band message and have it arrive to userland
first regardless of the window size already on the wire).

----- Forwarded message from Andrea Arcangeli <andrea@cpushare.com> -----

Date: Tue, 1 Mar 2005 01:37:23 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
Reply-To: Twisted general discussion <twisted-python@twistedmatrix.com>
To: Twisted general discussion <twisted-python@twistedmatrix.com>
Subject: Re: [Twisted-Python] linux kernel 2.6.11-rc broke twisted process
	pipes
X-BeenThere: twisted-python@twistedmatrix.com
X-Mailman-Version: 2.1.4
Errors-To: twisted-python-bounces@twistedmatrix.com

BTW, I'm sending as andrea@cpushare.com but this email is really meant
to be from andrea@suse.de, the lists are set so that I can't post unless
I'm subscribed and to avoid unnecessary email load, I'm avoiding to
subscribe two of my accounts to the same list.

On Mon, Feb 28, 2005 at 05:52:05PM -0500, James Y Knight wrote:
> I agree this code is somewhat suboptimal. However, I do not agree that 
> it works only by luck.

The thing is that readable and writeable (in select(2) terms) could be
returned from linux 2.6.9 and all previous kernels immediatly without
sleeping, even if there was no disconnect event. You only needed the
write buffer empty for it to return POLLIN|POLLOUT without sleeping.
That's what I mean with "by luck". It wasn't twisted mistake but a linux
mistake apparently.

That check of "r and w" definitely could be true even if the other side
of the pipe didn't disconnect in past linux.

> In response to your main question of "why is it checking for 
> readability at all", there is a good answer: to get the disconnect 
> event without trying to write data. Select doesn't have a "err" fdset, 

Ok, btw even linux always returns the fd in both readable and writeable
when the other side of the pipe disconnects. This because we raise a
POLLERR and this is the mask to check when a fd is readable/writeable

#define POLLIN_SET (POLLRDNORM | POLLRDBAND | POLLIN | POLLHUP | POLLERR)
#define POLLOUT_SET (POLLWRBAND | POLLWRNORM | POLLOUT | POLLERR)

So when POLLERR is raised, the fd is returned readable and writeable
from select.

Current kernel code is this:

static unsigned int
pipe_poll(struct file *filp, poll_table *wait)
{
        unsigned int mask;
        struct inode *inode = filp->f_dentry->d_inode;
        struct pipe_inode_info *info = inode->i_pipe;
        int nrbufs;

        poll_wait(filp, PIPE_WAIT(*inode), wait);

        /* Reading only -- no need for acquiring the semaphore.  */
        nrbufs = info->nrbufs;
        mask = 0;
        if (filp->f_mode & FMODE_READ) {
                mask = (nrbufs > 0) ? POLLIN | POLLRDNORM : 0;
                if (!PIPE_WRITERS(*inode) && filp->f_version != PIPE_WCOUNTER(*inode))
                        mask |= POLLHUP;
        }

        if (filp->f_mode & FMODE_WRITE) {
                mask |= (nrbufs < PIPE_BUFFERS) ? POLLOUT | POLLWRNORM : 0;
                if (!PIPE_READERS(*inode))
                        mask |= POLLERR;
        }

        return mask;
}

With this new kernel code, a write pipe will _never_ return readable,
unless it's disconnected, and it will match the the current twisted code
as far as I can tell.

As you can see we never set POLLOUT for a write-pipe (opened in WRONLY
mode), and in turn the only way to end up in the POLLIN_SET is that
POLLERR is set.

> so you have to select for either readability or writability. You can't 
> select for writability when you have no data to write, or else you'll 
> be continuously waking up. On all UNIX OSes that I know of, write pipes 
> show up as readable in select when the other side has closed, for just 
> this reason. I don't know if it's documented in any specs, but as far 
> as I can tell, it's universally true.
> Breaking this would be a Bad Thing, for I suspect more apps than just 
> Twisted.

Linux never returned any information about the status of the other side
of the pipe via the readable information, because readable was always
returned true, since POLLIN was set unconditionally by the pipe_poll
code. So we're not going to break anything in that sense, it was already
broken and infact we're fixing it right now ;).

POLLIN was providing absolutely zero information because it was always
set unconditionally for both readers and writers. That was wrong and
that's why I changed it and this seem to make the doRead code valid for
the first time in linux.

> Of course, if it were that simple, doRead would just be implemented as 
> "return CONNECTION_LOST". From my testing, that'd even work on BSDs. 
> However, linux adds its own little wrinkle to the problem.
> On linux, the observed behavior seems to be that only one write can be 
> outstanding at a time -- if there is data in the buffer, writable will 
> be false and readable will be true. Otherwise, the inverse. This is 

It's never the inverse since pollin was always forced to be set, both
for readers and writers, so a write fd was always returned as readable
unconditionally. 

But you're perfectly right that if there is data in the buffer
writeable was false and readable was true. (readable provides no info in
linux)

> quite silly...but it's what happens. As far as I can tell, at no time 
> are both true, except when the pipe is disconnected. On BSD, a write 
> pipe is simply never readable until the reader is closed, which is a 
> lot more sensible.
> Also note, that bit of code is unnecessary if you're using pollreactor 
> rather than selectreactor. That is, I think it should be fine with 

This is great news. However note that the 2.6.11-rc5 official kernel
broke my app with the pollreactor too. So something else must have been
broken for the pollreactor too making the same assumption that doRead
did, and it's working fine again with my pipe patch infact.

> twisted if the pipe is just POLLHUP when it is disconnected rather than 
> POLLHUP|POLLIN|POLLOUT.

It's POLLERR not POLLHUP. POLLHUP is set only when the "writer" side
disconnected and you're listening to a reader fd. POLLERR is instead
returned when the "reader" disconnected and you're listening to a
writer fd.

In select terms it means when the reader disconnects the fd will be both
readable and writeable. And when the writer disconnects the fd will be
reported only as readable.

In poll terms it means with linux _only_ POLLERR will be set when the
read disconnects, and POLLIN will never ever be set on a WRONLY pipe.

So with the new fixes it seems linux does the right thing, and we at
leats mimic the select behaviour that twisted expects, I hope we mimic
the poll behaviour that twisted expects too.

I found the openbsd implementation of pipe_poll here:

	http://fxr.watson.org/fxr/source/kern/sys_pipe.c?v=OPENBSD#L661

671         if (events & (POLLIN | POLLRDNORM)) {
672                 if ((rpipe->pipe_buffer.cnt > 0) ||
673                     (rpipe->pipe_state & PIPE_EOF))
674                         revents |= events & (POLLIN | POLLRDNORM);
675         }

The way I read it, even openbsd will report the fd as readable
regardless if the channel is disconnected, if the buffer has something
into it.

Anyway linux won't do that anymore, a write fd will be now reported as
readable only if the reader has disconnected, and so you're safe to
assume the reader disconnected if selects returns readable && writeable.
So I think we should be fine now and no changes are required in twisted
at least for the select reactor side.

Please double check the pollreactor side too, we'll never return POLLIN
anymore for a WRONLY pipe fd.

I'm going to update a semi-productive system running twisted servers
using processes too, with the new pipe_poll code too to see what happens
(that's the good thing of not being fully productive yet, so I can
experiment a bit more ;).

_______________________________________________
Twisted-Python mailing list
Twisted-Python@twistedmatrix.com
http://twistedmatrix.com/cgi-bin/mailman/listinfo/twisted-python

----- End forwarded message -----
