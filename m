Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274430AbRITLfG>; Thu, 20 Sep 2001 07:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274427AbRITLez>; Thu, 20 Sep 2001 07:34:55 -0400
Received: from [24.254.60.25] ([24.254.60.25]:46785 "EHLO
	femail35.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274330AbRITLeo>; Thu, 20 Sep 2001 07:34:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: t.sailer@alumni.ethz.ch, Thomas Sailer <sailer@scs.ch>,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio locking problems
Date: Thu, 20 Sep 2001 04:33:35 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <3BA9AB43.C26366BF@scs.ch>
In-Reply-To: <3BA9AB43.C26366BF@scs.ch>
Cc: adrian@humboldt.co.uk
MIME-Version: 1.0
Message-Id: <01092004333500.00182@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 September 2001 01:39 am, Thomas Sailer wrote:
> This applies to version 1.1.5 as well as the version in
> linux-2.4.10-pre12 and linux-2.4.9-ac12.
>
> 1) There is one semaphore (syscall_sem) that is held during
>    calls from userspace. It is even kept while going to sleep
>    during read and write syscalls. This locks out other users,
>    eg. mixers, for a potentially very long time, seconds are
>    common but it may almost be arbitrarily long. Try changing
>    the volume with eg. gmix while playing something with eg. xmms.
>

thankyouthankyouthankyouthankyouthankyou
Adrian Cox was working on this after I raised the issue on the list, but 
nobody got anywhere. All we knew was that there were temporary lockups 
appearing when anything was using the mixer.

>    Dropping and reacquiring syscall_sem around interruptible_sleep_on
>    in via_dsp_do_read, via_dsp_do_write and via_dsp_drain_playback
>    should solve the problem. Does anyone see a problem with this?
>
> 2) When some kind of error happens during read or write after
>    some samples have already been dequeued and copied to the user
>    buffer, the number of copied bytes should be returned instead
>    of the error code, to avoid loosing samples.
>
> 3) The use of interruptible_sleep_on results in a small race where
>    wake_ups may be lost. Unlikely to hit though.
>
> 4) The down_trylock and returning -EAGAIN in via_down_syscall looks
>    questionable, EAGAIN with O_NONBLOCK normally means I/O has to
>    be completed first, not that there is contention on some internal
>    synchronisation primitive.
>
> Jeff, do you object any of this? Would you accept a patch to ameliorate
> the situation? Or would you like to fix this yourself?

I've emailed Jeff 2 or 3 times about the lock/freezes related to 
volume/mixer control, and never got a response, I'm not sure he's 
actually maintaining the driver. The last release of it from him was all 
fixes from someone else.

Adrian Cox was helping to track this down before, and is probably the 
best bet, I've CC'd Adrian to this. Unfortunitely I haven't seen any 
messages from him on lk in a while, so I'm not sure if he's on vacation 
or what.

My advice is, give us a patch! :) Since Jeff hasn't been heard from for a 
while, I can't see anyone, including Jeff, having a problem with this.

Is there anyone out there that could start maintaining the driver? 
Inactive drivers are kind of a pain :(

>
> Tom
>
> PS: Is there any better publicly available chip documentation than
> the 120 page PDF file?
