Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWBQLrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWBQLrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWBQLrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:47:05 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:49655 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751396AbWBQLrE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:47:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GxvZygKZXkqZiAqUConHofiNajb8hZ8hLja23thmEaXNS7mXT9u6flPdDdant2YzQRVI5xTgytnaoP6c9O6mMAL6WOzcPO7ZZfYrXKBsIn7lYtCIZwuaghoDUXeJEjZSVvWq78UvIYNDjMKB6DEg8d6fkSxrUoIqh9PjGFY3gyA=
Message-ID: <58cb370e0602170347qeddb390u680895fd2f0aab7d@mail.gmail.com>
Date: Fri, 17 Feb 2006 12:47:02 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
Cc: ce@ruault.com, linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <20060216122045.7a664bc6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org>
	 <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com>
	 <20060216122045.7a664bc6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/06, Andrew Morton <akpm@osdl.org> wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> >
> > On 2/16/06, Andrew Morton <akpm@osdl.org> wrote:
> > > Charles-Edouard Ruault <ce@ruault.com> wrote:
> > > >
> > > > i was trying to rip a CD when the whole machine started to freeze
> > > >  periodicaly, i then looked at the logs and found the following :
> > > >
> > > >  Feb 12 19:23:39 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
> > > >  Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> > > >  Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
> > > >  Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> > > >  Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command
> > >
> > > No idea what caused that.
> > >
> > > >  Feb 12 19:23:39 ruault kernel: BUG: soft lockup detected on CPU#0!
> > >
> > > The following was merged today.  Hopefully it suppresses this false
> > > positive.
> >
> > Unfortunately it won't.  Charles' problem is different (and the BUG
> > output is different!) - soft lockup got triggered for PIO handling in
> > ide-cd driver.  This patch fixes the problem only for generic ATA PIO
> > routines (disks and [P]IDENTIFY), ATAPI PIO still needs fixing
> > (ide-cd/floppy/tape/scsi drivers).
>
> argh.  We do need to bop that warning on the head - it's consuming people's
> time and causing unneeded concern.

Yes, it is definitely consuming time...
this is 3-rd time we hit false-positive in IDE subsystem.

"soft lockup during probe" problem was fixed by touching
watchdog.  I believe proper fix would require using msleep() instead
of mdelay() and we knew this before soft lockup issue.

So from my IDE work POV it was just wasted time...

"ATA PIO" problem was handled in the same way.
I'm still not 100% sure if it was false positive - it looked like
from the trace but I find it hard to believe that users wouldn't
complain about 10sec stalls [ Soft lockup detector claims to
trigger if after 10sec it hasn't been touched - is it really working
as advertised?  How can we verify this? ].

Again it only wasted time from IDE POV.

And now ATAPI PIO issues requires me to audit all ATAPI
device drivers to quiet soft lockup detector...

> > Andrew, there is no "high level" function for ATAPI PIO as
> > ide_pio_datablock() for ATA PIO so fixing soft lockup false positives
> > would require going through all drivers and adding bunch of
> > touch_softlockup_watchdog() or using sledge-hammer approach
> > and touching watchdog in ide-iops.c:atapi_[input,output]_bytes().
>
> Send fixup patch, please?

Other things have much bigger priority than quieting soft lockup
detector because somebody decided upon driver maintainers that
soft lockup during hardware access is a _major_ problem (-> system
stays locked) and needs to be fixed ASAP (-> it is enabled by default).

This feature could be useful but why driver maintainers are _forced_ to
pay maintenance cost for it?

I can send you another sledge-hammer fix which is quite disgusting as
it touches watchdog on every ATAPI related PIO access (i.e. many times
in ATAPI PIO IRQ handlers, during packet command transfer).

Alternatively I can send you patch making soft lockup detector depend on
"CONFIG_IDE=n".

Bartlomiej
