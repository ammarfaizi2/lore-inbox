Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSHFUAp>; Tue, 6 Aug 2002 16:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSHFUAo>; Tue, 6 Aug 2002 16:00:44 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:39296 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S315456AbSHFUAl>; Tue, 6 Aug 2002 16:00:41 -0400
Message-Id: <5.1.0.14.2.20020806125053.09751470@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 06 Aug 2002 13:03:48 -0700
To: "David S. Miller" <davem@redhat.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: "new style" netdevice allocation patch for TUN driver
  (2.4.18 kernel)
Cc: jajcus@bnet.pl, linux-kernel@vger.kernel.org
In-Reply-To: <20020806.100749.21530590.davem@redhat.com>
References: <5.1.0.14.2.20020806094253.09734790@mail1.qualcomm.com>
 <5.1.0.14.2.20020802164143.04da52f8@mail1.qualcomm.com>
 <20020803140858.GA5314@nic.nigdzie>
 <5.1.0.14.2.20020806094253.09734790@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
>    Date: Tue, 06 Aug 2002 10:07:49 -0700
>
>    Dave, how about this
>
>    --- net/core/dev.c.orig Mon Aug  5 21:48:54 2002
>    +++ net/core/dev.c      Mon Aug  5 21:54:01 2002
>    @@ -2577,6 +2577,11 @@
>
>First, the call-chain notifiers are probably not safe
>to run without rtnl_lock held.
Good point.

>Second, why not just fix the bug instead of applying band-aids
>to device unregistry?  I know it's nice in that it allows you
>to configure devices some more, but it doesn't make the real
>problem go away.
I completely agree. However sleeping and holding a lock that you
don't have to hold is a bug on it's own :).
Things like sockets drop the lock before calling schedule() and acquire
it on wakeup. I think we should do the same in unregister_netdevice().

How about this:

--- dev.c.orig  Tue Aug  6 00:58:46 2002
+++ dev.c       Tue Aug  6 01:00:00 2002
@@ -2584,9 +2584,12 @@
                         notifier_call_chain(&netdev_chain, 
NETDEV_UNREGISTER, dev);
                 }

+               rtnl_unlock();
                 current->state = TASK_INTERRUPTIBLE;
                 schedule_timeout(HZ/4);
                 current->state = TASK_RUNNING;
+               rtnl_lock();
+
                 if ((jiffies - warning_time) > 10*HZ) {
                         printk(KERN_EMERG "unregister_netdevice: waiting 
for %s to "
                                         "become free. Usage count = %d\n",
-----

Max

