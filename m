Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272075AbRHVS01>; Wed, 22 Aug 2001 14:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272073AbRHVS0H>; Wed, 22 Aug 2001 14:26:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26284 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272074AbRHVS0F>;
	Wed, 22 Aug 2001 14:26:05 -0400
Date: Wed, 22 Aug 2001 11:26:19 -0700 (PDT)
Message-Id: <20010822.112619.62651200.davem@redhat.com>
To: kakadu_croc@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: brlock_is_locked()?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010822181755.39925.qmail@web10905.mail.yahoo.com>
In-Reply-To: <20010822.110316.57459277.davem@redhat.com>
	<20010822181755.39925.qmail@web10905.mail.yahoo.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brad Chapman <kakadu_croc@yahoo.com>
   Date: Wed, 22 Aug 2001 11:17:55 -0700 (PDT)

   	At this section of the code, it doesn't really matter who in the
   netfilter/network stack has BR_NETPROTO_LOCK, just that we need to know if
   it's already locked by someone else, or unlocked for us to use. Is what I'm
   asking for physically possible?

As a reader, the BR_NETPROTO_LOCK nests.  So no deadlock.

If the situation involves a writer, you must make sure that locking
rules are well defined and abided by.  No matter what you do, if you
try to conditionalize locking by testing if the lock is held, another
SMP can always get in there after you check it and corrupt your data.
The lock is basically pointless if you start testing it's locked
state.

Basically, "fix your code" ;-)

It's often easy to do this.  If you have two paths, one which is going
to already have the lock and one which won't, just make two functions
like so:

void __func(void)
{
	do_stuff();
}

void func(void)
{
	lock();
	__func();
	unlock();
}

I don't see why this is such a big problem.

Later,
David S. Miller
davem@redhat.com
