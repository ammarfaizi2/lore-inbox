Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277924AbRJIT1y>; Tue, 9 Oct 2001 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277925AbRJIT1p>; Tue, 9 Oct 2001 15:27:45 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:49172 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277924AbRJIT1b>; Tue, 9 Oct 2001 15:27:31 -0400
Date: Tue, 9 Oct 2001 14:27:46 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Rui Sousa <rui.p.m.sousa@clix.pt>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        emu10k1-devel@opensource.creative.com
Subject: Re: [Emu10k1-devel] Re: Emu10k1 driver update
In-Reply-To: <Pine.LNX.4.33.0110092100040.3012-100000@sophia-sousar2.nice.mindspeed.com>
Message-ID: <Pine.LNX.3.96.1011009142129.9171H-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Rui Sousa wrote:
> On Tue, 9 Oct 2001, Jeff Garzik wrote:
> From what I see doing locking with a spinlock is quite tricky.
> 
>  codec->read_mixer = ac97_read_mixer;  //can be called holding spinlock
>  codec->write_mixer = ac97_write_mixer; //can be called holding spinlock
>  codec->recmask_io = ac97_recmask_io;
>  codec->mixer_ioctl = ac97_mixer_ioctl; //in general can't be called
> holding spinlock
> 
> and ac97_mixer_ioctl() itself calls ac97_read/write_mixer().
> 
> A semaphore on the mixer device open function would do just fine If I
> didn't had an interrupt handler also touching the ac97_codec...

Yep, that's how the via audio problem was solved, with a mixer
semaphore.  Having your interrupt handler touch ac97_codec definitely
complicates things beyond that simple solution, though.  If your only
concern is the intr handler you could create a dont-touch-ac97-in-intr
flag, and set that flag (only) via spin_lock_irq.  Then you don't
have to stay inside a spinlock the entire time.

	Jeff



