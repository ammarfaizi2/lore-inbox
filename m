Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934138AbWKWXuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934138AbWKWXuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 18:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757508AbWKWXuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 18:50:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:54595 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1757505AbWKWXuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 18:50:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qQywAKxT1Mx2HX7gAWiY83z9BvVbqztuf/I+B6pgf2Bheysqy81TbBt8JQ5AYOGnH1RH3zGndD1Y1QWHHSG6kkL2aD93ILuHeMnh4AoXIWUqS5moSreUWtcDS1VNiO/xeu3zJu8/2rbPjbM1RmZE0G6cn+KMFao6Ti65WXo2qlk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Simple script that locks up my box with recent kernels
Date: Fri, 24 Nov 2006 00:52:13 +0100
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
References: <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com> <20061122110740.GA8055@kernel.dk>
In-Reply-To: <20061122110740.GA8055@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611240052.13719.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 12:07, Jens Axboe wrote:
> On Wed, Nov 22 2006, Jesper Juhl wrote:
> > On 22/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > >On Wed, Nov 22 2006, Jesper Juhl wrote:
> > >> On 22/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> > >> >On Tue, Nov 21 2006, Linus Torvalds wrote:
> > >> >> I don't think we use any irq-disable locking in the VM itself, but I
> > >> >could
> > >> >> imagine some nasty situation with the block device layer getting into 
> > >a
> > >> >> deadlock with interrupts disabled when it runs out of queue entries 
> > >and
> > >> >> cannot allocate more memory..
> > >> >
> > >> >Not likely. Request allocation is done with GFP_NOIO and backed by a
> > >> >memory pool, so as long the vm doesn't go totally nuts because
> > >> >__GFP_WAIT is set, we should be safe there. If it did go crazy, I
> > >> >suspect a sysrq-t would still work.
> > >> >
> > >> >If bouncing is involved for swap, we do have a potential deadlock issue
> > >> >that isn't fixed yet. I just whipped up this completely untested patch,
> > >> >it should shed some light on that issue.
> > >> >
> > >> Thanks Jens, I'll apply that later tonight and force a few lockups and
> > >> see if I get any extra details with that patch.
> > >
> > >Can you post a full dmesg too, as well as clarify which device holds the
> > >swap space?
> > >
> > Sure. I'll post a full dmesg as soon as I get home.
> > 
> > The swap partition is on a IBM Ultrastar U160 10K RPM SCSI disk,
> > hooked up to an Adaptec 29160N controller, using the aic7xxx driver.
> > That disk holds all my filesystems as well and the controller also has
> > a SCSI DVD drive and a SCSI CD writer attached to it.  No SATA/PATA
> > devices in the box, in case that matters.
> 
> Does the box survive io intensive workloads? 

It seems to. It does get sluggish as hell when there is lots of disk I/O but
it seems to be able to survive.  
I'll try some more, with some IO benchmarks + various other stuff to see 
if I can get it to die that way.

> Have you tried using net or 
> serial console to see if it spits out any info before it crashes?

Lacking a second box at the moment, so that's not an option currently :(


> I 
> would not be too surprised if it's the aic7xxx driver taking a dive, I'd
> be a lot more surprised if it's actually the bouncing (I don't think you
> do any, can you post cat /proc/meminfo | grep -i bounce on that box?) or
> a generic vm/block bug causing you problems.
> 
$ cat /proc/meminfo | grep -i bounce
Bounce:              0 kB


-- 
Jesper Juhl <jesper.juhl@gmail.com>


