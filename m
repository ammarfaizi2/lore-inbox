Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbRGTCvh>; Thu, 19 Jul 2001 22:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266490AbRGTCv1>; Thu, 19 Jul 2001 22:51:27 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:4073 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S266507AbRGTCvR>; Thu, 19 Jul 2001 22:51:17 -0400
Message-ID: <3B579BEB.B5D68FCC@yahoo.co.uk>
Date: Thu, 19 Jul 2001 22:48:11 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
Reply-To: jdthood_A@T_yahoo.co.uk
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: acme@conectiva.com.br
Subject: [BUG] "unregister_netdevice: waiting for eth0 to become free. Usage 
 count = 2"
In-Reply-To: <20010214092251.D1144@e-trend.de> <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de> <20010214122244.H7859@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>Groan<   The "unregister_netdevice" bug is back.

I haven't been able to do extensive testing, but I have
just encountered the message
   unregister_netdevice: waiting for eth0 to become free. Usage count = 2
again.  Once it starts, it repeats ad infinitum, once per second.
The message starts spewing when I do a "cardctl eject"
on a Xircom CEM56 modem/ethernet card (driven by xirc2ps_cs.o, serial.o)
which was previously configured using DHCP with IPX enabled.  The cardctl
eject never completes and the OS will not shut down completely; it hangs
at the point where it tries to de-configure network interfaces. Disabling
IPX cured the problem for me the next time I tried.

I am running 2.4.6-ac2, but the bug could have been reintroduced
a while back.  I haven't been using Ethernet for a couple of
months.

Well, I'm no expert on the networking code, so I'll just suggest
some things that look odd to me.  I'm looking in net/ipx/af_ipx.c,
tracing through ipxitf_create().  This function exits with dev->refcnt
incremented ... unless something goes wrong, in which case the function
exits through via a goto to "out_dev" which decrements the refcnt again.
Likewise, ipxitf_auto_create() increments the dev refcnt (by doing a
dev_hold(dev)) if all goes well.  However when I look at ipxitf_delete(),
which I presume ought to undo what the *_create() functions do, I see
nothing that decrements the refcnt.

If this is where the bug lies then I would suggest that the functions
be documented to say that "this function exits with the refcnt incremented
if blah blah blah", etc.  

As an aside, I notice that __dev_get_by_name() is called from ipxitf_delete().
A comment preceding __dev_get_by_name() in net/core/dev.c says that this
function should be called "under RTNL semaphore or @dev_base_lock", but
it is actually called under the ipx_interfaces_lock.  Is this okay?
__dev_get_by_name() is also called from within ipxitf_ioctl(), seemingly
under no locks at all.  Also okay?

Thomas Hood
