Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272083AbRHVSx7>; Wed, 22 Aug 2001 14:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272082AbRHVSxs>; Wed, 22 Aug 2001 14:53:48 -0400
Received: from web10904.mail.yahoo.com ([216.136.131.40]:62219 "HELO
	web10904.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272083AbRHVSxg>; Wed, 22 Aug 2001 14:53:36 -0400
Message-ID: <20010822185351.55288.qmail@web10904.mail.yahoo.com>
Date: Wed, 22 Aug 2001 11:53:51 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: brlock_is_locked()?
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010822.114735.128125464.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1366218918-998506431=:53206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1366218918-998506431=:53206
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Brad Chapman <kakadu_croc@yahoo.com>
>    Date: Wed, 22 Aug 2001 11:33:12 -0700 (PDT)
>    
>    	It almost isn't. The problem starts when a third-party protocol
>    module grabs BR_NETPROTO_LOCK, unloads itself from the networking stack,
>    and then tries to call ip6_conntrack_protocol_unregister(). Deadlock.
>    The problem is that we need TWO locks: the brlock to seal the network
> stack,
>    and the conntrack rwlock to delete the protocol struct. Sure, you can
>    always share the rwlock and leave it at that, but if all you need it for
>    is to load/unload your protocol functions, then why bother polluting
>    the symbol tables?
>    	What do you think? Share the rwlock and make everybody who has
>    the brlock just use the core function?
> 
> You are only showing me that there is potential a deficiency in the
> netfilter interfaces.  You ought to discuss with the netfilter people
> a way to make the interfaces work better.
> 
> This is exactly what I said needed to be done.
> 
> Later,
> David S. Miller
> davem@redhat.com

Mr. Miller,

	It's not really a deficiency. Rusty apparently decided that in
order to be SMP-compliant and to prevent Oopses, that the unregistration
function should grab the brlock so that all the packets would pass through
the protocol-handling functions. It doesn't necessarily _have_ to be done, 
because all the points which might make use of the protocol handlers are 
already locked or could be changed to use the lock, but if it should
be done, then you need a way to find out if the brlock is locked,
so that you can be fair to other people (I checked the brlock code and
didn't find any schedule()s; there's probably a reason for that).
	I suppose that if it really can't be done, then I'll remove the lock commands
for BR_NETPROTO_LOCK in the protocol API and just wait until people
report Evil Things(tm) happening when they unload. Besides, any netfilter
interface changes will have to wait until 2.5.

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
--0-1366218918-998506431=:53206--
