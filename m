Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129214AbRBHArq>; Wed, 7 Feb 2001 19:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130682AbRBHArh>; Wed, 7 Feb 2001 19:47:37 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:19978 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S129214AbRBHArV>;
	Wed, 7 Feb 2001 19:47:21 -0500
Message-ID: <3A81EC74.8E4D9B7F@yahoo.co.uk>
Date: Wed, 07 Feb 2001 19:46:44 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
CC: "Bryan K. Walton" <bryan@bryansweb.com>,
        Russell Coker <russell@coker.com.au>
Subject: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier I reported error messages when I tried to eject
a Xircom CEM56 network card under Linux 2.4.x.  (See below.
I also submitted this patch as a followup to that thread.)

Here is a patch which may not solve the underlying
problem but which does prevent the kernel from generating
an infinite number of 
    "unregister_netdevice: waiting for eth0 to become free.
     Usage count = -1"
messages on "cardctl eject" and from hanging up at shutdown.

-----------------------------------------------------
root@thanatos:/usr/src/kernel-source-2.4.1-ac3/net/core# diff -Naur dev.c_ORIG dev.c
--- dev.c_ORIG	Mon Feb  5 17:39:31 2001
+++ dev.c	Wed Feb  7 18:35:45 2001
@@ -2555,7 +2555,7 @@
 	 */
 
 	now = warning_time = jiffies;
-	while (atomic_read(&dev->refcnt) != 1) {
+	while (atomic_read(&dev->refcnt) > 1) {
 		if ((jiffies - now) > 1*HZ) {
 			/* Rebroadcast unregister notification */
 			notifier_call_chain(&netdev_chain, NETDEV_UNREGISTER, dev);
---------------------------------------------------

The underlying problem seem so be that refcnt is zero or
less at this point.  This is erroneous.  The error in 
maintaining the refcnt appears to occur only when 
I configure the eth0 interface (using pump or dhclient).
The more times I "ifup eth0" and "ifdown eth0" before
ejecting the card, the lower the "usage count" is 
reported to be (i.e., the larger the negative number!).

Be that as it may, because of the erroneous refcnt,
the above while loop within unregister_netdevice()
loops forever in the original code.  As modified it
falls through; and this makes the kernel usable for me.

In order to avoid the 
   "KERNEL: assertion(dev->ip_ptr==NULL)failed at
    dev.c(2422):netdev_finish_unregister"
message and the occasional
   "Freeing alive device"
message it seems to suffice that I kill the dhclient
process before running "ifdown eth0".  Am I right in
assuming that the latter messages aren't serious?

I hope the networking gurus can find the real bugs here.

Thomas Hood

> I have a bit more information about this bug now.
> The message "assertion(yadda) failed ..." occurs only
> if the eth0 interface has been configured using pump
> or dhclient.  If the card isn't connected to the network
> the message never occurs.  If eth0 is merely brought up
> and down using ifconfig the message doesn't occur.  Only
> if pump or dhclient has configured eth0 does the message
> occur.  Sometimes it occurs on "ifdown eth0", sometimes
> on "cardctl eject" and sometimes during the shutdown
> sequence.
> 
> Thomas
> 
> > 
> > Dear l-k.
> > 
> > I'm still having this problem with kernel 2.4.0:
> > 
> > Conditions:
> > Linux 2.4.0 compiled on an IBM ThinkPad 600 51U (Pentium II)
> > laptop with PCMCIA support.  Same behavior with integral kernel
> > PCMCIA, modular kernel PCMCIA and modular Hinds PCMCIA.  System
> > is Progeny Debian beta II.
> > 
> > I have a Xircom modem/ethernet card which works correctly using
> > the serial_cs, xirc2ps_cs, ds, i82365 and pcmcia_core modules;
> > however when I try to "cardctl eject" or "reboot" I get first,
> >    "KERNEL: assertion(dev->ip_ptr==NULL)failed at
> >     dev.c(2422):netdev_finish_unregister"
> > (not exact since I had to copy it down on paper ... doesn't
> > show up in the logs) then a perpetual series of:
> >    "unregister_netdevice: waiting for eth0 to become free.
> >     Usage count = -1"
> > messages every five seconds or so.  "ps -A" reveals that
> > modprobe is running; it can't be killed even with "kill -9".
> > The "ifconfig" command locks up.  Shutdown won't complete
> > so I end up having to use SysRq-S-U-B to reboot.
> > 
> > This problem only occurs if the Xircom card is connected to
> > the Ethernet (in which case it is configured using DHCP).
> > If the card is left unconnected to the network, the problem
> > does not occur---the card can be ejected.
> >
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
