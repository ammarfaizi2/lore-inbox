Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUI2SVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUI2SVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUI2SVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:21:33 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:22668 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268767AbUI2SVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:21:23 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE Hotswap
Date: Wed, 29 Sep 2004 20:20:24 +0200
User-Agent: KMail/1.6.2
Cc: Suresh Grandhi <Sureshg@ami.com>,
       "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com> <200409291408.55211.bzolnier@elka.pw.edu.pl> <1096468515.15905.43.camel@localhost.localdomain>
In-Reply-To: <1096468515.15905.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409292020.25192.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 16:35, Alan Cox wrote:
> On Mer, 2004-09-29 at 13:08, Bartlomiej Zolnierkiewicz wrote:
> > > Even in 2.4 ide drive hotplug was easy. The drive hotplug comes out
> > > trivially because your controllers are fairly constant. As we all know
> > > driver level hotplug is a bit trickier although the block layer has
> > > really made this vastly easier in 2.6
> > > 
> > > For drive level hotplug you don't actually need refcounting at all
> > > providing you've got a couple of locking issues dealt with.
> > 
> > These issues can't be solved without refcounting.
> 
> So you keep saying, but you refcount objects that are going away, you
> don't need to refcount objects that are staying put.
> 
> > Feel free to probe me wrong, you can start with fixing
> > ->open vs unregister race (drive->usage involved). :)
> 
> Doesn't occur in the 2.4 situation or the 2.6 stuff with the locking in
> the 2.6.8.1-ac patch.

I will verify this in a few days, I have some real work to do first.

> > > Firstly the drive never goes away as a high level object (in fact you
> > > don't want it to as then you can't ioctl it to make it come back!). That
> > > means the upper layers don't know anything about it.
> > 
> > ioctls on not present devices are layering VIOLATION
> 
> Oh dear then I guess most of Linux is misdesigned. You aren't thinking
> about the semantics at all. 
> 
> If /dev/hda is a CD-ROM drive I can issue commands to it with no CD 
> present. Thats not a layering violation, and its how the IDE code works.
> So whats the difference between hotplugging a drive and removing
> a CD. Both are removing the media but leaving the controller behind.

Removing a CD leaves you with a drive between controller and media.

1st case: ioctl -> IDE driver -> drive
(lack of refcounting workarounded by ide-default)

2nd case: ioctl -> IDE driver
(lack of refcounting)

> On that item I think you are talking out of your backside.
> 
> > > At the IDE layer the 2.4 code simply enforced the rule that you must be
> > > the only opener of the device in order to hot unplug it. That means we
> > 
> > "enforced" - there are a couple of races, sorry but ROTFL
> > 
> > > know its quiescent and not mounted. The only 2.4 race I know about is
> > 
> > - double unlock obvious mistake
> Details ?

2003/08/16 alan               | 	/* Drive shutdown sequence done */
2003/08/16 alan               | 	/* Prevent new opens ?? */
2003/08/16 alan               | 	spin_unlock_irqrestore(&io_request_lock, flags);
2003/08/16 alan               | 	/*
2003/08/16 alan               | 	 * Flush kernel side caches, and dump the /proc files
2003/08/16 alan               | 	 */
2003/08/16 alan               | 	spin_unlock_irqrestore(&io_request_lock, flags);

> > - ->open() vs unregister
> unregister is hot plug controller not drive and thats unfixable in 2.4

Doesn't matter. race is the same AFAICS, drive->usage
access is not protected by any lock.

> > - /proc races (the same you fixed in your 2.6 patch)
> yeah that lot postdates the 2.4 work. hotplug drives is not the cause
> however.
> > - ioctl races
> Details ?

OK BKL protects us against i.e. concurrent HDIO_GETGEO
and hotplug ioctl.  There is however no protection for controller
hotplug.

> > gendisk layer and block layer enforces you to make /dev/hda disappear.
> 
> No it does not. The block layer couldn't give a flying **** whether
> /dev/hda disappears or not. SCSI devices that are offlined don't need to
> disappear either you just hand back commands with an error. You know -
> like every CD-ROM does...
>
> > Does sysfs ring any bells?  Ask viro about static objects vs sysfs.
> > And yes not only gendisk and block enforces this, Patrick added basic,
> > premature sysfs support to IDE driver in the middle of 2.5 series.
> > 
> > We can get back to discussion when you get familiar with issues involved.
> 
> Ditto...
> 
> Alan
> 
> 
