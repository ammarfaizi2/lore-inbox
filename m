Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268602AbUI2PU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268602AbUI2PU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUI2PUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:20:02 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:34294 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268633AbUI2PSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:18:49 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE Hotswap
Date: Wed, 29 Sep 2004 14:08:55 +0200
User-Agent: KMail/1.6.2
Cc: Suresh Grandhi <Sureshg@ami.com>,
       "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com> <200409290354.38440.bzolnier@elka.pw.edu.pl> <1096422632.14637.30.camel@localhost.localdomain>
In-Reply-To: <1096422632.14637.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409291408.55211.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 03:50, Alan Cox wrote:
> On Mer, 2004-09-29 at 02:54, Bartlomiej Zolnierkiewicz wrote:
> > Your patch is a nice start but it don't solve main issues, not to even
> > mention minor stuff like leaving /proc/ide/<chipset> around.
> > Merging it now is asking for problems.
> 
> Oh I agree. There is a patch but it isn't the final answer. There is a
> small resource bug (harmless but a bug) in the 2.6.8.1-ac patch. I
> hadn't noticed proc/ide/<chipset> leaking but I'll take a look when I
> get time to sort that out. 

/proc/ide/<chipset> is the smallest problem

Don't waste your time on it, I've almost killed this bloat in my tree.

> > > like suspend mean the nasties in 2.4 for sequencing have gone away. No
> > > refcounting needed since the block and fs layer are doing it all for
> > 
> > It helps but you still get bunch of races.  Refcounting is _really_ needed.
> 
> Even in 2.4 ide drive hotplug was easy. The drive hotplug comes out
> trivially because your controllers are fairly constant. As we all know
> driver level hotplug is a bit trickier although the block layer has
> really made this vastly easier in 2.6
> 
> For drive level hotplug you don't actually need refcounting at all
> providing you've got a couple of locking issues dealt with.

These issues can't be solved without refcounting.

Feel free to probe me wrong, you can start with fixing
->open vs unregister race (drive->usage involved). :)

> Firstly the drive never goes away as a high level object (in fact you
> don't want it to as then you can't ioctl it to make it come back!). That
> means the upper layers don't know anything about it.

ioctls on not present devices are layering VIOLATION

> At the IDE layer the 2.4 code simply enforced the rule that you must be
> the only opener of the device in order to hot unplug it. That means we

"enforced" - there are a couple of races, sorry but ROTFL

> know its quiescent and not mounted. The only 2.4 race I know about is

- double unlock obvious mistake
- ->open() vs unregister
- /proc races (the same you fixed in your 2.6 patch)
- ioctl races

I'm sure there is more.

> suspend in parallel to hot unplug, and 2.6 has the mechanism to fix that
> properly because suspend is a command state machine.
> 
> Providing hot unplug is about making drive->present stuff vary and
> flipping to ide_default drivers the world is happy. The moment you want
> to make /dev/hda 'disappear' to the block layer its fun, and on 2.4 its
> as good as impossible.

gendisk layer and block layer enforces you to make /dev/hda disappear.
Does sysfs ring any bells?  Ask viro about static objects vs sysfs.
And yes not only gendisk and block enforces this, Patrick added basic,
premature sysfs support to IDE driver in the middle of 2.5 series.

We can get back to discussion when you get familiar with issues involved.

Bartlomiej
