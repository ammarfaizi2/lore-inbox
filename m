Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBIFpH>; Fri, 9 Feb 2001 00:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBIFo5>; Fri, 9 Feb 2001 00:44:57 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:64772 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S129031AbRBIFol>;
	Fri, 9 Feb 2001 00:44:41 -0500
Message-ID: <3A8383B7.DDAF1B8C@yahoo.co.uk>
Date: Fri, 09 Feb 2001 00:44:23 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jschlst@turbolinux.com,
        Andrew Morton <andrewm@uow.edu.au>,
        "Bryan K. Walton" <bryan@bryansweb.com>,
        Russell Coker <russell@coker.com.au>, dahinds@sourceforge.net
Subject: Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I now know the cause of this problem.  It's a bug in
the ipx driver.  (This also closes pcmcia-cs bug #126563.)

Through copious use of printk()s I was able to track down
the point at which the dev->refcnt for my card was being
erroneously decremented.  It was being erroneously decremented
by "notifier_call_chain(&netdev_chain, NETDEV_DOWN, dev);"
near the end of the "dev_close()" function in net/core/dev.c.
This indicated that one of the registered notifiers
was doing an improper "dev_put()".  I rmmod-ed the ipx module
from my system and the problem magically disappeared.  The
refcnt is no longer inappropriately decremented and there
are no more inappropriate calls to netdev_finish_unregister()
in the absence of a prior call to unregister_netdevice()
(which is what resulted in the "Freeing alive device" messages).

Where is the bug?  It is in the ipx driver.  When I configure
eth0 for ipx, the device gets added to the ipx driver's linked
list of devices headed at "ipx_interfaces".  The ipx driver
registers the following function to be notified of net events.
It's clear that the ipx driver will do a __ipxitf_put (which
decrements dev-refcnt and does a dev_put() on dev) every time
eth0 is taken down with "ifconfig eth0 down"!  That would be
okay, I guess, if the opposite were done on an "ifconfig eth0 up"
but it isn't.  This needs to be fixed somehow.  I'll leave it
up to the maintainers and other gurus to figure out how.  In
the meantime I'll just avoid using ipx.

---------------- net/ipx/af_ipx.c ---------------------------
static int ipxitf_device_event(struct notifier_block *notifier,
                                unsigned long event, void *ptr)
{
        struct net_device *dev = ptr;
        ipx_interface *i, *tmp;

        if (event != NETDEV_DOWN)
                return NOTIFY_DONE;

        spin_lock_bh(&ipx_interfaces_lock);
        for (i = ipx_interfaces; i;) {
                tmp = i->if_next;
                if (i->if_dev == dev)
                        __ipxitf_put(i);
                i = tmp;

        }
        spin_unlock_bh(&ipx_interfaces_lock);
        return NOTIFY_DONE;
}
--------------------------------------------------------------

--
Thomas Hood
Please reply to me at:  jdthood_AT_yahoo.co.uk

I wrote:
> Earlier I reported error messages when I tried to eject 
> a Xircom CEM56 network card under Linux 2.4.x. (See below. 
> I also submitted this patch as a followup to that thread.) 
> 
> Here is a patch which may not solve the underlying 
> problem but which does prevent the kernel from generating 
> an infinite number of 
>     "unregister_netdevice: waiting for eth0 to become free. 
>      Usage count = -1" 
> messages on "cardctl eject" and from hanging up at shutdown. 
> 
> ----------------------------------------------------- 
> root@thanatos:/usr/src/kernel-source-2.4.1-ac3/net/core# diff -Naur dev.c_ORIG dev.c 
> --- dev.c_ORIG Mon Feb 5 17:39:31 2001 
> +++ dev.c Wed Feb 7 18:35:45 2001 
> @@ -2555,7 +2555,7 @@ 
>           */ 
>   
>          now = warning_time = jiffies; 
> - while (atomic_read(&dev->refcnt) != 1) { 
> + while (atomic_read(&dev->refcnt) > 1) { 
>                  if ((jiffies - now) > 1*HZ) { 
>                          /* Rebroadcast unregister notification */ 
>                          notifier_call_chain(&netdev_chain, NETDEV_UNREGISTER, dev); 
> --------------------------------------------------- 
> 
> The underlying problem seem so be that refcnt is zero or 
> less at this point. This is erroneous. The error in 
> maintaining the refcnt appears to occur only when 
> I configure the eth0 interface (using pump or dhclient). 
> The more times I "ifup eth0" and "ifdown eth0" before 
> ejecting the card, the lower the "usage count" is 
> reported to be (i.e., the larger the negative number!). 
> 
> Be that as it may, because of the erroneous refcnt, 
> the above while loop within unregister_netdevice() 
> loops forever in the original code. As modified it 
> falls through; and this makes the kernel usable for me. 
> 
> In order to avoid the 
>    "KERNEL: assertion(dev->ip_ptr==NULL)failed at 
>     dev.c(2422):netdev_finish_unregister" 
> message and the occasional 
>    "Freeing alive device" 
> message it seems to suffice that I kill the dhclient 
> process before running "ifdown eth0". Am I right in 
> assuming that the latter messages aren't serious? 
> 
> I hope the networking gurus can find the real bugs here. 
> 
> Thomas Hood
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
