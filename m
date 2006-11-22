Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967105AbWKVLHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967105AbWKVLHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967107AbWKVLHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:07:50 -0500
Received: from brick.kernel.dk ([62.242.22.158]:27146 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S967105AbWKVLHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:07:49 -0500
Date: Wed, 22 Nov 2006 12:07:40 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Message-ID: <20061122110740.GA8055@kernel.dk>
References: <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org> <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com> <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com> <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com> <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org> <20061122080312.GL8055@kernel.dk> <9a8748490611220255v53bc667y74b05e2b69281f25@mail.gmail.com> <20061122105703.GZ8055@kernel.dk> <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22 2006, Jesper Juhl wrote:
> On 22/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> >On Wed, Nov 22 2006, Jesper Juhl wrote:
> >> On 22/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> >> >On Tue, Nov 21 2006, Linus Torvalds wrote:
> >> >> I don't think we use any irq-disable locking in the VM itself, but I
> >> >could
> >> >> imagine some nasty situation with the block device layer getting into 
> >a
> >> >> deadlock with interrupts disabled when it runs out of queue entries 
> >and
> >> >> cannot allocate more memory..
> >> >
> >> >Not likely. Request allocation is done with GFP_NOIO and backed by a
> >> >memory pool, so as long the vm doesn't go totally nuts because
> >> >__GFP_WAIT is set, we should be safe there. If it did go crazy, I
> >> >suspect a sysrq-t would still work.
> >> >
> >> >If bouncing is involved for swap, we do have a potential deadlock issue
> >> >that isn't fixed yet. I just whipped up this completely untested patch,
> >> >it should shed some light on that issue.
> >> >
> >> Thanks Jens, I'll apply that later tonight and force a few lockups and
> >> see if I get any extra details with that patch.
> >
> >Can you post a full dmesg too, as well as clarify which device holds the
> >swap space?
> >
> Sure. I'll post a full dmesg as soon as I get home.
> 
> The swap partition is on a IBM Ultrastar U160 10K RPM SCSI disk,
> hooked up to an Adaptec 29160N controller, using the aic7xxx driver.
> That disk holds all my filesystems as well and the controller also has
> a SCSI DVD drive and a SCSI CD writer attached to it.  No SATA/PATA
> devices in the box, in case that matters.

Does the box survive io intensive workloads? Have you tried using net or
serial console to see if it spits out any info before it crashes? I
would not be too surprised if it's the aic7xxx driver taking a dive, I'd
be a lot more surprised if it's actually the bouncing (I don't think you
do any, can you post cat /proc/meminfo | grep -i bounce on that box?) or
a generic vm/block bug causing you problems.

-- 
Jens Axboe

