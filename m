Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130095AbQLJM6o>; Sun, 10 Dec 2000 07:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130874AbQLJM6e>; Sun, 10 Dec 2000 07:58:34 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:14006 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130095AbQLJM6S>; Sun, 10 Dec 2000 07:58:18 -0500
Message-ID: <3A3377B3.FDCBE4AD@uow.edu.au>
Date: Sun, 10 Dec 2000 23:31:47 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>,
        "linux-usb-devel@lists.sourceforge.net" 
	<linux-usb-devel@lists.sourceforge.net>
Subject: hotplug mopup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A compendium of questions and misc stuff concerning hotplug:

- Is everyone happy with call_usermodehelper() being asynchronous? It
  _could_ be given a `synchronous' option, but that's a fair bit of
  obfuscation and it does expose us to deadlocks if the caller has any
  semaphores held.

- One person who definitely needs synchronous semantics is
  drivers/net/hamradio/baycom_epp.c.  The poor thing is currently doing
  the kernel_thread()/waitpid() stuff itself.  So there's a datum.

  hmm..  It's running a usermode app with the rtnl lock held. 
  There's a counter-datum.

- The three USB netdevice drivers look a bit racey in the probe()
  function.  Some can be fixed inline, but it may be better to just
  call dev_probe_lock()/dev_probe_unlock() in
  usb_find_interface_driver().  That's if dev_probe_lock() makes its
  way to kernel.org...

- On the unregister/removal path, the netdevice layer ensures that
  the interface is removed from the kernel namespace prior to launching
  `/sbin/hotplug net unregister eth0'.

  This means that when handling netdevice unregistration
  /sbin/hotplug cannot and must not attempt to do anything with eth0!
  Generally it'll fail to find an interface with this name.  If it does
  find eth0, it'll be the wrong one due to a race.

- I don't think we can say that the kernel hotplug interface is
  complete until we have real, working, tested userspace tools.  David,
  could you please summarise the state of play here? In particular,
  what still needs to be done?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
