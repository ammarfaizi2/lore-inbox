Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWHUMOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWHUMOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWHUMOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:14:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54999 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030405AbWHUMON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:14:13 -0400
Subject: Re: [take12 3/3] kevent: Timer notifications.
From: Arjan van de Ven <arjan@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>, tglx@linutronix.de
In-Reply-To: <20060821115947.GE8608@2ka.mipt.ru>
References: <11561555893621@2ka.mipt.ru> <1156155589287@2ka.mipt.ru>
	 <20060821111239.GA30945@infradead.org> <20060821111848.GB8608@2ka.mipt.ru>
	 <1156159642.23756.144.camel@laptopd505.fenrus.org>
	 <20060821115947.GE8608@2ka.mipt.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 21 Aug 2006 14:13:49 +0200
Message-Id: <1156162429.23756.150.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 15:59 +0400, Evgeniy Polyakov wrote:
> On Mon, Aug 21, 2006 at 01:27:22PM +0200, Arjan van de Ven (arjan@infradead.org) wrote:
> > On Mon, 2006-08-21 at 15:18 +0400, Evgeniy Polyakov wrote:
> > > ]> > +	lockdep_set_class(&t->ktimer_storage.lock, &kevent_timer_key);
> > > > 
> > > > When looking at the kevent_storage_init callers most need to do
> > > > those lockdep_set_class class.  Shouldn't kevent_storage_init just
> > > > get a "struct lock_class_key *" argument?
> > > 
> > > It will not work, since inode is used for both socket and inode
> > > notifications (to save some space in struct sock), lockdep initalization
> > > is performed on the highest level, so I put it alone.
> > 
> > Call me a cynic, but I'm always a bit sceptical about needing lockdep
> > annotations like this... Can you explain why you need it in this case,
> > including the proof that it's safe?
> 
> Ok, again :)
> Kevent uses meaning of storage of kevents without any special knowledge
> what is is (inode, socket, file, timer - anything), so it's
> initalization function among other things calls spin_lock_init().
> Lockdep inserts static variable just before real spinlock
> initialization, and since all locks are initialized in the same place,
> all of them get the same static magic.
> Later those locks are used in different context (for example inode
> notificatins only in process context, but socket can be called from BH
> context), since lockdep thinks they are the same, it screams.
> Obviously the same inode can not be used for sockets and files, so I
> added above lockdep initialization.

ok... but since kevent doesn't know what is in it, wouldn't the locking
rules need to be such that it can deal with the "worst case" event? Eg
do you really have both no knowledge of what is inside, and specific
locking implementations for the different types of content??? That
sounds rather error prone.....
(if you had consistent locking rules lockdep would be perfectly fine
with that)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

