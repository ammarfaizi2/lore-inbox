Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTFDR32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTFDR32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:29:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20741 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263680AbTFDR30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:29:26 -0400
Date: Wed, 4 Jun 2003 10:41:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hua Zhong <hzhong@cisco.com>
cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'P. Benie'" <pjb1008@eng.cam.ac.uk>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <019801c32abc$c233d1a0$ca41cb3f@amer.cisco.com>
Message-ID: <Pine.LNX.4.44.0306041019570.14465-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jun 2003, Hua Zhong wrote:
>
> We ran into this problem here in an embedded environment. It causes
> syslogd to hang and when this happens, everybody who talks to syslogd
> hangs. Which means you may not even be able to login. In the end we used
> exactly the same fix which seems to work.
> 
> I am curious to know the correct fix.

[ First off: your embedded syslog problem is fixed by making sure that
  syslog doesn't try to write to a tty that somebody else might be
  blocked. In other words, to me it sounds like a "well, don't do that
  then" schenario, rather than a real kernel problem. ]

[ Secondly, you should all realize that O_NONBLOCK has _never_ meant that 
  the IO can't ever block. Even O_NONBLOCK reads and writes will always 
  block on things like having page faults on the user buffer, and a lot of 
  drivers still use the kernel lock and will block on that. O_NONBLOCK is 
  not an absolute "this is atomic" thing, it's a "don't wait for data if 
  there is none" thing ]

With that in mind, if you feel strongly about this particular path, then I
can only warn you that the correct fix actually looks fairly hard, as far
as I can tell. Yes, the posted patch is a small part of it, but the more
complex side is how to make poll() agree with the write semantics that the 
posted patch changed.

If you have a write() that returns -EAGAIN, and a poll() function that 
says "it's ok to write", any select-loop based application will start 
busy-looping calling poll/write, and use up 100% CPU time.

Which may be acceptable for some users, of course, but what you're doing
with the simple patch is just replacing one bug with another one. And I
personally think the bug you're introducing is the worse one.

But which bug you "prefer" ends up depending entirely on the machine load
and usage - the current behaviour has clearly not ended up in very many
complaints, and even if the patch fixes it for those few people didn't
like the historical behaviour, it may well end up breaking a hell of a lot
more distributions that until now were perfectly happy.

For example: what happens when your real-time application starts
busy-looping due to this?  Right. The system is totally _dead_, since the
application that is busy writing to the tty will never be scheduled.

And yes, something like syslogd could easily be marked high-priority in 
some setup. You do NOT want to make it busy-loop.

As to how to expand the patch to avoid the busy-loop: it's definitely 
non-trivial. Semaphores do not have poll() qualities, and I don't see a 
good way to get them. Something like

   static unsigned int tty_poll(struct file * filp, poll_table * wait)
   {
	struct tty_struct * tty;
	struct semaphore *sem;
	int retval;

	tty = (struct tty_struct *)filp->private_data;
	if (tty_paranoia_check(tty, filp->f_dentry->d_inode->i_rdev, "tty_poll"))
		return 0;

	sem = &tty->atomic_write;
	if (!down_trylock(sem)) {
		poll_wait(filp, sem->wait, wait);
		if (!down_trylock(sem))
			return 0;
	}
	retval = 0;
	if (tty->ldisc.poll)
		retval = tty->ldisc.poll(tty, filp, wait);
	up(sem);
	return retval;
   }

MIGHT work, but as you can see it actually now depends on knowing the 
internals of the semaphore implementation, and quite frankly I don't know 
if it works at all. As a result, I'm not horribly keen on the idea.

And as I tried to explain, I'm also not horribly keen on having a write()  
that doesn't match poll() and can cause busy looping. 

		Linus

