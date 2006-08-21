Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWHUM05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWHUM05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWHUM05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:26:57 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:16779 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965066AbWHUM04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:26:56 -0400
Date: Mon, 21 Aug 2006 16:25:43 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>, tglx@linutronix.de
Subject: Re: [take12 3/3] kevent: Timer notifications.
Message-ID: <20060821122542.GA24519@2ka.mipt.ru>
References: <11561555893621@2ka.mipt.ru> <1156155589287@2ka.mipt.ru> <20060821111239.GA30945@infradead.org> <20060821111848.GB8608@2ka.mipt.ru> <1156159642.23756.144.camel@laptopd505.fenrus.org> <20060821115947.GE8608@2ka.mipt.ru> <1156162429.23756.150.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1156162429.23756.150.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 21 Aug 2006 16:25:46 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 02:13:49PM +0200, Arjan van de Ven (arjan@infradead.org) wrote:
> > > Call me a cynic, but I'm always a bit sceptical about needing lockdep
> > > annotations like this... Can you explain why you need it in this case,
> > > including the proof that it's safe?
> > 
> > Ok, again :)
> > Kevent uses meaning of storage of kevents without any special knowledge
> > what is is (inode, socket, file, timer - anything), so it's
> > initalization function among other things calls spin_lock_init().
> > Lockdep inserts static variable just before real spinlock
> > initialization, and since all locks are initialized in the same place,
> > all of them get the same static magic.
> > Later those locks are used in different context (for example inode
> > notificatins only in process context, but socket can be called from BH
> > context), since lockdep thinks they are the same, it screams.
> > Obviously the same inode can not be used for sockets and files, so I
> > added above lockdep initialization.
> 
> ok... but since kevent doesn't know what is in it, wouldn't the locking
> rules need to be such that it can deal with the "worst case" event? Eg
> do you really have both no knowledge of what is inside, and specific
> locking implementations for the different types of content??? That
> sounds rather error prone.....
> (if you had consistent locking rules lockdep would be perfectly fine
> with that)

It is tricky - currently there is RCU protection for storage list
traversal from each origin, i.e. the that path takes a lock when
kevent is really ready (to put it into ready list) and to check kevent's
flags (actually event that could be replced by more strict callback's 
return values).
No existing origins call kevent_storage_ready() from context where it
can be reentered (it guarantees from other side that locks will not be
reentered), so in theory that lockdep tricks are not needed right now
(they were added before I moved list traversal to RCU).

In the current code storage->lock is safe and correct from lockdep point 
of view (since different origins are never crossed), so I have not
changed reinit.

> -- 
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com

-- 
	Evgeniy Polyakov
