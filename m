Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUI2CxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUI2CxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 22:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUI2CxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 22:53:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:46985 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268163AbUI2CxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 22:53:09 -0400
Subject: Re: IDE Hotswap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Suresh Grandhi <Sureshg@ami.com>,
       "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <200409290354.38440.bzolnier@elka.pw.edu.pl>
References: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com>
	 <200409282338.10456.bzolnier@elka.pw.edu.pl>
	 <1096407955.14083.45.camel@localhost.localdomain>
	 <200409290354.38440.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096422632.14637.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 02:50:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 02:54, Bartlomiej Zolnierkiewicz wrote:
> Your patch is a nice start but it don't solve main issues, not to even
> mention minor stuff like leaving /proc/ide/<chipset> around.
> Merging it now is asking for problems.

Oh I agree. There is a patch but it isn't the final answer. There is a
small resource bug (harmless but a bug) in the 2.6.8.1-ac patch. I
hadn't noticed proc/ide/<chipset> leaking but I'll take a look when I
get time to sort that out. 

> > For drive level hotplug its actually a lot easier and I guess that is
> > the case most users care about. The changes done for 2.6 clean up stuff
> 
> drive level hotplug is actually much harder
> and it is _required_ for controller level hotplug, no? :)

Actually its all a lot easier now than in 2.4 because the block layer is
designed to make it possible.

> > like suspend mean the nasties in 2.4 for sequencing have gone away. No
> > refcounting needed since the block and fs layer are doing it all for
> 
> It helps but you still get bunch of races.  Refcounting is _really_ needed.

Even in 2.4 ide drive hotplug was easy. The drive hotplug comes out
trivially because your controllers are fairly constant. As we all know
driver level hotplug is a bit trickier although the block layer has
really made this vastly easier in 2.6

For drive level hotplug you don't actually need refcounting at all
providing you've got a couple of locking issues dealt with.

Firstly the drive never goes away as a high level object (in fact you
don't want it to as then you can't ioctl it to make it come back!). That
means the upper layers don't know anything about it.

At the IDE layer the 2.4 code simply enforced the rule that you must be
the only opener of the device in order to hot unplug it. That means we
know its quiescent and not mounted. The only 2.4 race I know about is
suspend in parallel to hot unplug, and 2.6 has the mechanism to fix that
properly because suspend is a command state machine.

Providing hot unplug is about making drive->present stuff vary and
flipping to ide_default drivers the world is happy. The moment you want
to make /dev/hda 'disappear' to the block layer its fun, and on 2.4 its
as good as impossible.

Alan

