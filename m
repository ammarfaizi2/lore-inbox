Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280794AbRKLOE1>; Mon, 12 Nov 2001 09:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280789AbRKLOEK>; Mon, 12 Nov 2001 09:04:10 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8780 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280794AbRKLODx>; Mon, 12 Nov 2001 09:03:53 -0500
Date: Mon, 12 Nov 2001 15:03:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: mathijs@knoware.nl, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011112150342.R1381@athlon.random>
In-Reply-To: <20011112021142.O1381@athlon.random> <Pine.BSI.4.05L.10111120819290.9564-100000@utopia.knoware.nl> <20011111.235905.28785376.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011111.235905.28785376.davem@redhat.com>; from davem@redhat.com on Sun, Nov 11, 2001 at 11:59:05PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 11:59:05PM -0800, David S. Miller wrote:
>    From: Mathijs Mohlmann <mathijs@knoware.nl>
>    Date: Mon, 12 Nov 2001 08:42:27 +0100 (CET)
>    
>    Even if the timer irq is working fine, the sun should not enable the 
>    keyboard irq without the tasklet being enabled. Initializing the keyboard
>    tasklet enabled got the sun to boot just fine for me.
> 
> They come from the serial port, not from a normal "IRQ".
> This is why events arrive so early.
> 
> Linus's proposed solution will work just fine and frankly
> that's what I'm going to check into my tree. :-)  For
> reference this is:
> 
> 1) Kill DECLARE_TASKLET_DISABLED use DECLARE_TASKLET for
>    keyboard_tasklet. 
> 
> 2) In keyboard tasklet handler check a "keyboard_init_done"
>    boolean and just return immediately if it is clear.
> 
> 3) Where we currently do "tasklet_enable(&keyboard_tasklet);"
>    simply kill that line and check it to
>    "keyboard_init_done = 1;"

I recommend to fix the obvious sparc breakage, before changing the
softirq code in any way, to make sure not to hide the scheduler bug.

Ah, and let me bet, the sparc32 scheduler breakage is that it's not
running schedule_tail in ret_from_fork (you must
s/ret_from_smpfork/ret_from_fork/ as well). Since 2.4 it's not a SMP
thing any longer, it is _required_ on UP too or sched yield will break
badly!  This of course is a problem not just for spwan_ksoftirqd, but
it's a core bug that triggers all the time with the sparc32 userspace
too.

Andrea
