Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWE3WiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWE3WiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWE3WiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:38:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:27526 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932531AbWE3WiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:38:10 -0400
Subject: Re: [git patch] libata resume fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
References: <20060528203419.GA15087@havoc.gtf.org>
	 <1148938482.5959.27.camel@localhost.localdomain> <447C4718.6090802@rtr.ca>
	 <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 31 May 2006 08:37:54 +1000
Message-Id: <1149028674.9986.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 11:26 -0700, Linus Torvalds wrote:
> 
> On Tue, 30 May 2006, Mark Lord wrote:
> > 
> > Not in a suspend/resume capable notebook, though.
> > 
> > I don't know of *any* notebook drives that take longer
> > than perhaps five seconds to spin-up and accept commands.
> > Such a slow drive wouldn't really be tolerated by end-users,
> > which is why they don't exist.
> 
> Indeed. In fact, I'd be surprised to see it in a desktop too.

Seen some drives at one point (I think those were maxtor) that take
_exactly_ 30 seconds to stop asserting BUSY after a HW reset.

> At least at one point, in order to get a M$ hw qualification (whatever 
> it's called - but every single hw manufacturer wants it, because some 
> vendors won't use your hardware if you don't have it), a laptop needed to 
> boot up in less than 30 seconds or something.
> 
> And that wasn't the disk spin-up time. That was the time until the Windows 
> desktop was visible.

Doesn't window spin drives asynchronously ? The main problem I've seen
in practice (appart from the above maxtor drives) are ATAPI CD/DVD
drives. There are whole generations of those that will happily drive
your bus to some crazy state (even when only slave and not selected) for
a long time while they spin up and try to identify the disk in them on a
hard reset (and if they have trouble identifying the disk, like a
scratched disk, that can take a loooong time).
  
> Desktops could do a bit longer, and I think servers didn't have any time 
> limits, but the point is that selling a disk that takes a long time to 
> start working is actually not that easy. 
> 
> The market that has accepted slow bootup times is historically the server 
> market (don't ask me why - you'd think that with five-nines uptime 
> guarantees you'd want fast bootup), and so you'll find large SCSI disks in 
> particular with long spin-up times. In the laptop and desktop space I'd be 
> very surprised to see anythign longer than a few seconds.

It's only a timeout. If you drives are fast, it will come up fast... if
you drives are slow, it will come up slow, and if your drives are
broken, you'll wait at most 31 seconds. Seems ok to me... It would be
nicer in the long run if libata could resume asynchronously (by keeping
the request queue blocked until full resume and polling the BUSY from a
thread or a timer), but I don't think we should lower the timeout.

Ben.


