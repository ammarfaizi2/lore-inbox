Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbTIJOhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTIJOhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:37:40 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:41946 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S264468AbTIJOhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:37:35 -0400
Message-Id: <200309101437.h8AEbV108262@brk-mail1.uk.sun.com>
Date: Wed, 10 Sep 2003 15:37:31 +0100 (BST)
From: Marco Bertoncin - Sun Microsystems UK - Platform OS
	 Development Engineer <Marco.Bertoncin@Sun.COM>
Reply-To: Marco Bertoncin - Sun Microsystems UK - Platform
	   OS Development Engineer <Marco.Bertoncin@Sun.COM>
Subject: NFS/MOUNT/sunrpc problem?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: pw8NPxjAhkQzmKn3sMsMUg==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.6_06 SunOS 5.8 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

I work for Sun Microsystems and we are currently doing some work to put Linux on 
Sun x86 Blades, but we have got a problem with PXE booting I am hoping someone 
could help us with:


Environment
- PXE booting x86 'headless' blades (2.0 Ghz 2P Xeon) to install RedHat 8.0 
(kernel 2.4.18).
- vmlinuz and modules in initrd.img were compiled for i386
- install server is a Sun box
- link is a BCM5704 (broadcom) 1Gbit chipset (tg3 driver) connected to a Gigabit 
switch.
How to reproduce
- During install a MOUNT (V2) request is sent to the install server
- the ACK is dropped
Symptom
- the blade, after 3 seconds, starts a storm of retransmit (MOUNT reqs) that 
won't stop, unless an ACK (one of the several ACKS sent for each retransmitted 
requests) has the chance to get through. This is sometimes after a few hundreds 
packets, sometimes after a lot more, causing an apparent hang of the 
installation process, and what's even worse, bringing to a grinding halt the  
server (bombarded by near 1Gbit/sec packets).

How I think I ruled out the h/w, the switch or any component other than the 
Linux network stack (I may be mistaken, in which case, please correct me):

I made a 'modified' version of the tg3 driver (driver for the BCM570x family of 
1Gbit controllers) that would:

- drop the ack (as a quick hack, it would actually just drop 1 every 2 packets, 
so I had 50% probability to reproduce the problem at every attempt)

- udelay 100th of a second every 100 packets sent. Also a hack, as my previous 
attempt at measuring the transmit frequency using a simple counter and the 
jiffies variable failed. This, by the way, might be indicative of the fact that 
the 'storm' is somehow generated in a tight loop where clock interrupts are 
disabled at least for a good part of the time?

Whilst with the unmodified version of the tg3 driver when the storm started it 
could last a very long time, with this version I could see the ACK go through 
after exactly 100 packets sent by the x86 blade, which would then recover and 
stop retransmitting the request ( I have a few snoop output files if any one 
wants to have a look).

I have looked in bugzilla and searched the linux kernel archive for a couple of 
days, but I did not notice anything related to this issue.

Ah, one last experiment I did was to try and reproduce the problem on an 
installed blade (same version of the kernel). No chance. I noticed, though that 
the MOUNT request sent by the 'installed linux' (it would be a proper i686-smp 
build instead of a up i386) is V3, whilst that during installation is V2. 
Thinking this might have been a hunch, I tried "mount -o nfsvers=2 
server:/export /mnt": I saw the requests, the dropped ack (on the server side, 
of course) but no storm ...!).

So, my question is: has anyome experienced a similar problem? Is anyone aware of 
any issue in the nfs/sunrpc retry mechanism that could lead to issue the retries 
at near wire speed instead of after the normal nfs timeout?

Thanks everyone in advance for you time.

Marco

