Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTLWFsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 00:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTLWFsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 00:48:14 -0500
Received: from csbd.org ([66.220.23.20]:46755 "EHLO csbd.org")
	by vger.kernel.org with ESMTP id S264957AbTLWFsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 00:48:09 -0500
To: ambx1@neo.rr.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop (frame buffer problem?)
Date: Mon Dec 22 21:41:15 2003
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: 7bit
Message-Id: <20031223054115.32A791E030CA3@csbd.org>
From: atp@csbd.org (Alexander Poquet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, sorry it took me so long to reply.  I live in Asia and I didn't get
your message until this morning, and I didn't want to reply without
a little extra information.

On Sun, 21 Dec 2003 23:29:56 +0000, Adam Belay wrote:
> In this system, isapnp is probably not necessary.

Yes, I think so too.  But don't worry, Adam, your code is not the problem;
my methods of identifying it were flawed.

> Agreed.  In what kernel version did you first see this problem?

Unfortunately, on this laptop I am upgrading directly from 2.4.18, so I
can't answer this question usefully, but FWIW, it worked fine in 2.4.18 :)

> Hmm, it doesn't seem possible for it to be occuring on that exact line.
> Perhaps there is a delay between the bad code and the time the lcd actually
> blanks. ISAPnP uses legacy probing techniques.  It is possible that it is
> writting to one of your laptop's configuration interfaces during the probe.
> 
> Could you provide more information as to how you isolated the problem to 
> this line?

Certainly.  I simply began doing a binary search in do_initcalls, successively
inserting a while (1) {} loop at the midpoint of each iteration, and thus
converging on the call that I thought was producing it.  Unfortunately, my
approach was somewhat naive -- I'm not a kernel hacker, just a hobbyist -- and
I didn't allow for the possibility of multiple threading.  I simply noticed
that if I put a while (1) {} loop at the beginning of isapnp initiation,
I never lost the console; but that the end of the same function, I did.  I
thereby narrowed it down to the release_region call.  This turned out to be
the wrong conclusion, however.

> Could you please ensure that ISAPnP is indeed the culprit by passing the 
> "noisapnp" kernel parameter.

I did this, as you requested, and as Jim McCloskey reported in his earlier
message in this thread, disabling isapnp has no effect on the problem.  So
I set out (using the same, flawed logic) to attempt to figure out where the
console was blanking out.  It happens a few initcalls later, in
fbcon_startup() (located in drivers/video/console/fbcon.c), which makes a
lot more sense than isapnp being culprit, given the jump into a video mode.

I noticed that between the 'isapnp disabled' message and invocation of
fbcon_startup() there are no printk calls, so it occured to me that
perhaps the isapnp release_region call was in a thread, and invocation of
that particular function clued the scheduler to (temporarily) return
control to the parent thread.  To test this, I booted without the noisapnp
parameter (but with a while (1) {} hang in fbcon_startup) and found that
isapnp exits happily, and the reason I never saw the printk saying that
no isapnp devices were found was simply due to the main initcall thread
reaching fbcon_startup before the printk hits the console, so to speak.

I'm being verbose here, in case you're wondering, because writing it out
helps me understand it better.  Not to mention that it exposes any bugs in
my thinking to an army of people who will no doubt be quick to correct me
if I'm wrong :)

So anyway, Adam, your code appears to work fine on my system and I see no
reason to think that it has anything to do with my problem, other than the
misfortune of being executed so close to the actual bug.  Thanks a lot
for your pointers, though.  I would like to understand the exact mechanism
of context switching for kernel threads though, where can I find some
documentation on that?  release_region() didn't seem to do anything I could
interpret as a flag to "switch executing threads now" or whatever.  It called
kfree(), but I didn't look at that function's source yet.  Anyway...

> The PnPBIOS is reserving ACPI configuration space.  PCI is surprised when it
> finds it already reserved.  Usually this isn't a problem.  It is interesting,
> however, that the the PCI bridge and the PnP BIOS are reporting slightly
> different ranges.

Interesting as in Alice (curious acceptance of unanticipated events) or
interesting as in Oppenheimer (that's a big explosion)?

Anyway, thanks again.
Alexander
