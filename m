Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTH1Tn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbTH1Tn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:43:26 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:59046 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264296AbTH1TnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:43:23 -0400
Subject: Re: [RFC] /proc/ide/hdx/settings with ide-default pseudo-driver is
	a 2.6/2.7 show-stopper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <200308282039.39654.bzolnier@elka.pw.edu.pl>
References: <200308281646.16203.bzolnier@elka.pw.edu.pl>
	 <200308281747.11359.bzolnier@elka.pw.edu.pl>
	 <1062093967.25044.39.camel@dhcp23.swansea.linux.org.uk>
	 <200308282039.39654.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062099752.24978.45.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 28 Aug 2003 20:42:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-28 at 19:39, Bartlomiej Zolnierkiewicz wrote:
> > Because you need to manipulate drives not attached to a driver
> > currently. I guess you could go through hoops to avoid it, but the
> > old IDE driver was just full of bugs that ide_default removed,
> > and it removed rather more code than it added.
> 
> Heh.. bugs yes, code not :).

It removed code. I counted both lines and size when deciding to take
that path 8)

> > You also need to be able to open the device to talk to the empty
> 
> You can't open devices owned by ide-default in 2.6 because ide-default,
> probably because it doesnt call add_disk() for them.

ide_default in 2.6 has no open/close method. In the latest 2.4-ac (bits
I sent to Marcelo too) it has one because it now needs it.

> I think scsi does it without default driver.  procfs or sysfs

The scsi scheme is somewhat broken, it also fails with hotplug because
if I ask for a reprobe of "0 0 0" and we change controllers - we've just
rescanned the wrong bus. Its only a small race but its real.

> > You need the unplugged_ops for controller unplug, I'm more worried about
> > disk unplug (which I have working now). For controller unplug you either
> 
> So you can unplug disk in the middle of the transfer,
> replug and transfer is continued?

I can do

	umount /dev/hda
	hdparm -b0 /dev/hda
        hdparm -b1 /dev/hda
        mount /dev/hda

and mount a different disk/cd/dvd. Its very nice on the thinkpads

In the 2.4 case its a bit messier than I suspect you can do in 2.6
because I can't rely on sane behaviour if I remove queues etc, instead
I keep the queue around so that to the block layer nothing disappears
and is freed up causing race issues but to the IDE layer the right stuff
happens (I think ;))

Alan

