Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271638AbRHVSdr>; Wed, 22 Aug 2001 14:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271975AbRHVSdb>; Wed, 22 Aug 2001 14:33:31 -0400
Received: from web10908.mail.yahoo.com ([216.136.131.44]:23303 "HELO
	web10908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272074AbRHVSc5>; Wed, 22 Aug 2001 14:32:57 -0400
Message-ID: <20010822183312.11829.qmail@web10908.mail.yahoo.com>
Date: Wed, 22 Aug 2001 11:33:12 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: brlock_is_locked()?
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010822.112619.62651200.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1098571825-998505192=:11773"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1098571825-998505192=:11773
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Brad Chapman <kakadu_croc@yahoo.com>
>    Date: Wed, 22 Aug 2001 11:17:55 -0700 (PDT)
> 
>    	At this section of the code, it doesn't really matter who in the
>    netfilter/network stack has BR_NETPROTO_LOCK, just that we need to know if
>    it's already locked by someone else, or unlocked for us to use. Is what
> I'm
>    asking for physically possible?
> 
> As a reader, the BR_NETPROTO_LOCK nests.  So no deadlock.
> 
> If the situation involves a writer, you must make sure that locking
> rules are well defined and abided by.  No matter what you do, if you
> try to conditionalize locking by testing if the lock is held, another
> SMP can always get in there after you check it and corrupt your data.
> The lock is basically pointless if you start testing it's locked
> state.
> 
> Basically, "fix your code" ;-)
> 
> It's often easy to do this.  If you have two paths, one which is going
> to already have the lock and one which won't, just make two functions
> like so:
> 
> void __func(void)
> {
> 	do_stuff();
> }
> 
> void func(void)
> {
> 	lock();
> 	__func();
> 	unlock();
> }
> 
> I don't see why this is such a big problem.
> 
> Later,
> David S. Miller
> davem@redhat.com

Mr. Miller,

	It almost isn't. The problem starts when a third-party protocol
module grabs BR_NETPROTO_LOCK, unloads itself from the networking stack,
and then tries to call ip6_conntrack_protocol_unregister(). Deadlock.
The problem is that we need TWO locks: the brlock to seal the network stack,
and the conntrack rwlock to delete the protocol struct. Sure, you can
always share the rwlock and leave it at that, but if all you need it for
is to load/unload your protocol functions, then why bother polluting
the symbol tables?
	What do you think? Share the rwlock and make everybody who has
the brlock just use the core function?

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net

Reply to the address I used in the message to you,
please!

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
--0-1098571825-998505192=:11773--
