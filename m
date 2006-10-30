Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbWJ3JoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbWJ3JoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030532AbWJ3JoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:44:09 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:20475 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030531AbWJ3JoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:44:06 -0500
Date: Mon, 30 Oct 2006 10:44:35 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall
 levels
Message-ID: <20061030104435.623fd057@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061027160626.8ac4a910.akpm@osdl.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
	<20061027114144.f8a5addc.akpm@osdl.org>
	<20061027114237.d577c153.akpm@osdl.org>
	<1161989970.16839.45.camel@localhost.localdomain>
	<20061027160626.8ac4a910.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 16:06:26 -0700,
Andrew Morton <akpm@osdl.org> wrote:

> On Fri, 27 Oct 2006 23:59:30 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Ar Gwe, 2006-10-27 am 11:42 -0700, ysgrifennodd Andrew Morton:
> > > IOW, we want to be multithreaded _within_ an initcall level, but not between
> > > different levels.
> > 
> > Thats actually insufficient. We have link ordered init sequences in
> > large numbers of driver subtrees (ATA, watchdog, etc). We'll need
> > several more initcall layers to fix that.
> > 
> 
> It would be nice to express those dependencies in some clearer and less
> fragile manner than link order.  I guess finer-grained initcall levels
> would do that, but it doesn't scale very well.

Would it be sufficient just to make the busses wait until all their
devices are through with their setup? This is what the ccw bus on s390
does:
- Increase counter for device and start device recognition for it
- Continue for next device
- When async device recognition (and probable enablement) is finished,
  register device and decrease counter
- ccw bus init function waits till counter has dropped to 0

This has worked fine for us since 2.5. OTOH, s390 doesn't have such a
diverse set as hardware as a PC :)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
