Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSHFREf>; Tue, 6 Aug 2002 13:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSHFREf>; Tue, 6 Aug 2002 13:04:35 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:24808 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S313711AbSHFREe>; Tue, 6 Aug 2002 13:04:34 -0400
Message-Id: <5.1.0.14.2.20020806094253.09734790@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 06 Aug 2002 10:07:49 -0700
To: Jacek Konieczny <jajcus@bnet.pl>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: "new style" netdevice allocation patch for TUN driver
  (2.4.18 kernel)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020803140858.GA5314@nic.nigdzie>
References: <5.1.0.14.2.20020802164143.04da52f8@mail1.qualcomm.com>
 <20020801133506.GA22073@serwus.bnet.pl>
 <5.1.0.14.2.20020802164143.04da52f8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Fri, Aug 02, 2002 at 04:54:02PM -0700, Maksim (Max) Krasnyanskiy wrote:
> > You're fixing the wrong problem.
>Probably I am. Alexey Kuznietzov told be the same :-)
>
> >It seems that some subsystem is not  releasing
> > tun device during shutdown/deregistration. (See comment in
> > net/core/dev.c:unregister_netdev).
> > You're not gonna see "waiting for" warning anymore if you change to new
> > style allocation.
>I will not see "waiting for" warning, but I will also be able to control
>all other network devices. Without this "fix" I am not able to shutdown
>network at all. Every "ip" command just hangs forever.
Yeah, this should be fixed. unregister_netdevice() sleeps under rtnl_lock().
Which means that any other activity that needs this lock will be blocked.

Dave, how about this

--- net/core/dev.c.orig Mon Aug  5 21:48:54 2002
+++ net/core/dev.c      Mon Aug  5 21:54:01 2002
@@ -2577,6 +2577,11 @@

          */

+       /* We don't have to hold rtnl semaphore while we're waiting for
+          device to become free.
+        */
+       rtnl_unlock();
+
         now = warning_time = jiffies;
         while (atomic_read(&dev->refcnt) != 1) {
                 if ((jiffies - now) > 1*HZ) {
@@ -2593,6 +2598,10 @@
                         warning_time = jiffies;
                 }
         }
+
+       /* Our caller expects it to be locked */
+       rtnl_lock();
+
         dev_put(dev);
         return 0;
  }

----
We don't have to hold rtnl look while sleeping. Device is already unlinked
from the list so nobody can grab and bump refcount.

> > But you're gonna leak tun devices because destructor is not called unless
> > refcount is zero.
>But it seems it is eventually called. The refcount eventually goes to 0
>(1 in factm - selfreference). Without this patch it never went to 0, as
>system shutdown was stopped "waitnig for...".
It'd be nice to trace what part of the kernel is actually holding refcount.

>I don't have enough time and probably knowledge to write a proper fix
>for the problem, however my patch fixes it well enough for me.
>All this "new style" device allocation would be useless if the kernel
>was bug-free. With this patch it is more bug-proof.
:) No, the point of device destructors is not to hide kernel bugs.

>On protuction system it is sometimes even more important, because kernel
>(or any other big piece of software) will never be bug-free.
That why it's important to trace and fix the subsystem that is holding devices
for a long time after deregistration. I may very well be doing it for a 
good reason
but warning is helpful anyway.
And we should fix sleep in unregister_netdevice() (ie patch above).

Max

