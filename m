Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262035AbTCLVEG>; Wed, 12 Mar 2003 16:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbTCLVEF>; Wed, 12 Mar 2003 16:04:05 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:65273 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262027AbTCLVDc>; Wed, 12 Mar 2003 16:03:32 -0500
Subject: Re: [PATCH] (1/8) Eliminate brlock in psnap
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: David Miller <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-kernel-owner@vger.kernel.org, "" <linux-net@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFBF5B58B4.EAFBC682-ON88256CE7.007043E7@us.ibm.com>
From: Paul McKenney <Paul.McKenney@us.ibm.com>
Date: Wed, 12 Mar 2003 12:28:12 -0800
X-MIMETrack: Serialize by Router on D03NM116/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 03/12/2003 14:13:25
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> On Tue, 11 Mar 2003, Stephen Hemminger wrote:
>
> >  void unregister_snap_client(struct datalink_proto *proto)
> >  {
> > -        br_write_lock_bh(BR_NETPROTO_LOCK);
> > +        static RCU_HEAD(snap_rcu);
> >
> > -        list_del(&proto->node);
> > -        kfree(proto);
> > +        spin_lock_bh(&snap_lock);
> > +        list_del_rcu(&proto->node);
> > +        spin_unlock_bh(&snap_lock);
> >
> > -        br_write_unlock_bh(BR_NETPROTO_LOCK);
> > +        call_rcu(&snap_rcu, (void (*)(void *)) kfree, proto);
> >  }
>
> Do we need the spin_lock_bh around the list_del_rcu? But also How
> about. This way we don't change the previous characteristic of block till
> done unregistering
>
> struct datalink_proto {
> ...
>            struct completion registration;
> };
>
> void __unregister_snap_client(void *__proto)
> {
>            struct datalink_proto *proto = __proto;
>            complete(&proto->registration);
> }
>
> unregister_snap_client(struct datalink_proto *proto)
> {
>            list_del_rcu(&proto->node);
>            call_rcu(&snap_rcu, __unregister_snap_client, proto);
>            wait_for_completion(&proto->registration);
>            kfree(proto);
> }

You are saying that we can omit locking because this is
called only from a module-exit function, and thus protected
by the module_mutex semaphore?  (I must defer to
others who have a better handle on modules...)

If in fact only one module-exit function can be
executing at a given time, then we should be able to
use the following approach:

void unregister_snap_client(struct datalink_proto *proto)
{
      list_del_rcu(&proto->node); /* protected by module_mutex. */
      synchronize_kernel();
      kfree(proto);
}

If multiple module-exit functions can somehow execute
concurrently, then something like the following would
be needed:

void unregister_snap_client(struct datalink_proto *proto)
{
      spin_lock_bh(&snap_lock);
      list_del_rcu(&proto->node);
      spin_unlock_bh(&snap_lock);
      synchronize_kernel();
      kfree(proto);
}

Module unloading should be rare enough to tolerate
the grace period under the module_mutex, right?

Thoughts?

                        Thanx, Paul

