Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUCRAYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUCRAYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:24:30 -0500
Received: from magic.adaptec.com ([216.52.22.17]:64912 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262139AbUCRAYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:24:12 -0500
Message-ID: <4058EBEC.8070309@adaptec.com>
Date: Wed, 17 Mar 2004 17:23:08 -0700
From: Scott Long <scott_long@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4) Gecko/20030817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jeff Garzik <jgarzik@pobox.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-raid@vger.kernel.org, "Gibbs, Justin" <justin_gibbs@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com> <4058C089.9060603@adaptec.com> <200403172245.31842.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403172245.31842.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 17 of March 2004 22:18, Scott Long wrote:
>  > Jeff Garzik wrote:
>  > > Justin T. Gibbs wrote:
>  > >  > [ I tried sending this last night from my Adaptec email address and
>  > >  > have yet to see it on the list.  Sorry if this is dup for any of 
> you.
>  > >  > ]
>  > >
>  > > Included linux-kernel in the CC (and also bounced this post there).
>  > >
>  > >  > For the past few months, Adaptec Inc, has been working to 
> enhance MD.
>  > >
>  > > The FAQ from several corners is going to be "why not DM?", so I would
>  > > humbly request that you (or Scott Long) re-post some of that rationale
>  > > here...
> 
> This is #1 question so... why not DM?  8)
> 
> Regards,
> Bartlomiej
> 


The primary feature of any RAID implementation is reliability. 
Reliability is a surprisingly hard goal.  Making sure that your
data is available and trustworthy under real-world scenarios is
a lot harder than it sounds.  This has been a significant focus
of ours on MD, and is the primary reason why we chose MD as the
foundation of our work.

Storage is the foundation of everything that you do with your
computer.  It needs to work regardless of what happened to your 
filesystem on the last crash, regardless of whether or not you
have the latest initrd tools, regardless of what rpms you've kept
up to date on, regardless if your userland works, regardless of
what libc you are using this week, etc.

With DM, what happens when your initrd gets accidentally corrupted?
What happens when the kernel and userland pieces get out of sync?
Maybe you are booting off of a single drive and only using DM arrays
for secondary storage, but maybe you're not.  If something goes wrong
with DM, how do you boot?

Secondly, our target here is to interoperate with hardware components
that run outside the scope of Linux.  The HostRAID or DDF BIOS is
going to create an array using it's own format.  It's not going to
have any knowledge of DM config files, initrd, ramfs, etc.  However,
the end user is still going to expect to be able to seamlessly install
onto that newly created array, maybe move that array to another system,
whatever, and have it all Just Work.  Has anyone heard of a hardware
RAID card that requires you to run OS-specific commands in order to
access the arrays on it?  Of course not.  The point here is to make
software raid just as easy to the end user.

The third, and arguably most important issue is the need for reliable
error recovery.  With the DM model, error recovery would be done in
userland.  Errors generated during I/O would be kicked to a userland
app that would then drive the recovery-spare activation-rebuild
sequence.  That's fine, but what if something happens that prevents
the userland tool from running?  Maybe it was a daemon that became
idle and got swapped out to disk, but now you can't swap it back in
because your I/O is failing.  Or maybe it needs to activate a helper
module or read a config file, but again it can't because i/o is
failing.  What if it crashes.  What if the source code gets out of sync
with the kernel interface.  What if you upgrade glibc and it stops
working for whatever unknown reason.

Some have suggested in the past that these userland tools get put into
ramfs and locked into memory.  If you do that, then it might as well be
part of the kernel anyways.  It's consuming the same memory, if not
more, than the equivalent code in the kernel (likely a lot more since
you'd  have to static link it).  And you still have the downsides of it
possibly getting out of date with the kernel.  So what are the upsides?

MD is not terribly heavy-weight.  As a monolithic module of
DDF+ASR+R0+R1 it's about 65k in size.  That's 1/2 the size of your
average SCSI driver these days, and no one is advocating putting those
into userland.  It just doesn't make sense to sacrifice reliability
for the phantom goal of 'reducing kernel bloat'.

Scott

