Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274561AbRITQdS>; Thu, 20 Sep 2001 12:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274563AbRITQdI>; Thu, 20 Sep 2001 12:33:08 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:14403 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S274561AbRITQcz>; Thu, 20 Sep 2001 12:32:55 -0400
Date: Thu, 20 Sep 2001 11:33:09 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Thomas Sailer <sailer@scs.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio locking problems
In-Reply-To: <3BA9AB43.C26366BF@scs.ch>
Message-ID: <Pine.LNX.3.96.1010920112905.26319I-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Thomas Sailer wrote:

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
>    Dropping and reacquiring syscall_sem around interruptible_sleep_on
>    in via_dsp_do_read, via_dsp_do_write and via_dsp_drain_playback
>    should solve the problem. Does anyone see a problem with this?

Is there a possibility of do_read being re-entered during that window?
I agree its a problem but the solution sounds racy?

> 2) When some kind of error happens during read or write after
>    some samples have already been dequeued and copied to the user
>    buffer, the number of copied bytes should be returned instead
>    of the error code, to avoid loosing samples.

Very true

> 3) The use of interruptible_sleep_on results in a small race where
>    wake_ups may be lost. Unlikely to hit though.
> 
> 4) The down_trylock and returning -EAGAIN in via_down_syscall looks
>    questionable, EAGAIN with O_NONBLOCK normally means I/O has to
>    be completed first, not that there is contention on some internal
>    synchronisation primitive.

I disagree; I think the idea at aleast is correct:  if contention
exists, it implies that I/O needs to be completed.

> Jeff, do you object any of this? Would you accept a patch to ameliorate
> the situation? Or would you like to fix this yourself?

A fix patch would definitely be accepted...

	Jeff



