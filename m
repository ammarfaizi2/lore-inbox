Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274720AbRIYXgt>; Tue, 25 Sep 2001 19:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274732AbRIYXgb>; Tue, 25 Sep 2001 19:36:31 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:45340 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274720AbRIYXgX>; Tue, 25 Sep 2001 19:36:23 -0400
Subject: [PATCH][RFC] Allow net devices to contribute to /dev/random
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@alex.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 25 Sep 2001 19:36:41 -0400
Message-Id: <1001461026.9352.156.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated versions of my netdev-random patch are out.  The patchset is two
piece: one containing the core code and two containing the updated
drivers.

2.4.9-ac15:
http://tech9.net/rml/linux/patch-rml-2.4.9-ac15-netdev-random-1
http://tech9.net/rml/linux/patch-rml-2.4.9-ac15-netdev-random-2

2.4.10:
http://tech9.net/rml/linux/patch-rml-2.4.10-netdev-random-1
http://tech9.net/rml/linux/patch-rml-2.4.10-netdev-random-2

ChangeLog and more information:
http://tech9.net/rml/linux/

Quick summary:  This patch enables a new configure option that allows
users to allow whether network devices can contribute to /dev/random. 
Normally block devices and the keyboard contribute, although very few
network devices do.  This patch makes a user-configurable policy out of
the issue: either allow them all or disallow them all.  Some users, such
as those on a headless or diskless system, have little or no entropy. 
This patch will give them that entropy.  Summarizing the discussion on
the issue, as long as SHA-1 is secure or your network traffic is secure,
this is safe.  For those who don't want the option, leave the setting
disabled and no NIC will contribute.

How it works:  defines a new flag for each architecture,
SA_SAMPLE_NET_RANDOM which defines to 0 or SA_SAMPLE_RANDOM depending on
the value of the configure statement.

All architectures and all network devices are supported.  The lastest
patch fixes a few typos and the like.

[You can ignore further if you just wanted the newest patch]

Now, why this I ask for comments.  An alternative approach to this is to
not have a configure setting but instead have a /proc interface.  When
disabled, interrupts will not contribute, and when enabled, they will.

The code is something like this:

define SA_SAMPLE_NET_RANDOM to be our new SA_SAMPLE_RANDOM for NICs
(like with the normal patch).

let random_netdev_contribute be 0 or 1 set from the /proc interface.

in setup_irq and handle_IRQ_event() we change:

if (status & SA_SAMPLE_RANDOM)

to

if ((status & SA_SAMPLE_RANDOM) ||
	   ((status & SA_SAMPLE_NET_RANDOM) && random_netdev_contrib))

That's about it.  Most of the code I have is for the proc interface.

One problem, and one concern.

The problem: setup_irq is called on device setup.  this means that
in-kernel drivers and modules loaded before the /proc interface is set
will have the wrong value registered in setup_irq.  I am not too sure
what this entails

Ie, if random_netdev_contrib=0 when we call setup_irq, we won't call
rand_initialize_irq() but then if random_netdev_contrib is set to 1, we
will all of a sudden start calling add_interrupt_randomness()!  You can
see the reverse of this, too, where we will initialize it but not call
add.

Changing the proc entry on the fly and/or loading/unloading modules just
adds to this mess.

I just don't think this will work cleanly.

Finally, my concern is that the if statement is not the cleanest.  We
have to check for the normal SA_SAMPLE_RANDOM flag, and then we need to
check for the other possibility of the NET version of the flag. If it
exists, we need to see if random_netdev_contrib is set.  Not very
clean.  A cleaner design, anyone?

I am happy to just leave the patch as is, and right now I am thinking I
will do just that.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

