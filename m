Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbTBSOUv>; Wed, 19 Feb 2003 09:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268915AbTBSOUv>; Wed, 19 Feb 2003 09:20:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10509 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268901AbTBSOUt>;
	Wed, 19 Feb 2003 09:20:49 -0500
Date: Wed, 19 Feb 2003 14:30:52 +0000
From: Matthew Wilcox <willy@debian.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH][2.5] convert atm_dev_lock from spinlock to semaphore
Message-ID: <20030219143052.G22992@parcelfarce.linux.theplanet.co.uk>
References: <20030219025347.D22992@parcelfarce.linux.theplanet.co.uk> <200302190452.h1J4qoGi002198@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302190452.h1J4qoGi002198@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Tue, Feb 18, 2003 at 11:52:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 11:52:50PM -0500, chas williams wrote:
> yes, atm_dev_lock is wrapped around large chunks of the code. however,
> it should probably never have been a spinlock--it certainly doesnt need
> to be one.  as a mutex its far less offensive.  i am willing to take
> suggestions as to what would need to be done to fix atm properly?

well, I'm no networking guru, but here are some of the things that seem
useful to me:

Try to use `struct sock' where you can.  For example, using sk->stamp
would allow the SIOCGSTAMP ioctl to be dealt with at a higher level.
Right now, atm uses a timestamp embedded in vcc.  (Actually, I think
I see how to do this one.  I'll send you a patch for your review and
testing, OK?)

Figure out what actually needs to be locked and lock only that.
spinlocks are, by and large, the right solution -- having a Big ATM Lock
isn't a good thing (though I do recognise that you may want to do this
temporarily while you work on fixing it properly).

You should probably do away with SOCKOPS_WRAP / SOCKOPS_WRAPPED.  The
BKL doesn't really protect you from much any more.

Might want to consider converting the proc files to the seqfile interface.

There seems to be some custom doubly-linked-list handling going on in
atm/resources.c.  Should probably be switched to use <linux/list.h>.

I don't like the look of the locking in ipcommon.c:skb_migrate().
If there's really no better way of doing it, I'd recommend something like:

	spinlock_t *first, *second;
	if ((unsigned long)from < (unsigned long) to)) {
		first = &from->lock;
		second = &to->lock;
	} else {
		first = &to->lock;
		second = &from->lock;
	}

	local_irq_save(flags);
	spin_lock(&first);
	spin_lock(&second);

(note that you can leave the spin_unlock and spin_unlock_irqrestore
calls as they are).


That's just a quick survey... I'm sure someone who actually uses ATM
could find more things to look at ;-)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
