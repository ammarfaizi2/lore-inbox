Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbRGXMja>; Tue, 24 Jul 2001 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbRGXMjT>; Tue, 24 Jul 2001 08:39:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2690 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267513AbRGXMjP>; Tue, 24 Jul 2001 08:39:15 -0400
Date: Tue, 24 Jul 2001 08:39:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russ Lewis <russ@deming-os.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Safely giving up a lock before sleeping
In-Reply-To: <3B5C9BFE.5BFB8BC7@deming-os.org>
Message-ID: <Pine.LNX.3.95.1010724082503.26144A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001, Russ Lewis wrote:
[SNIPPED...]

> Of course, since I need the lock to do anything, the first thing I do
> (after removing myself from the wait queue and checking for signals) is
> to relock the lock.
> 
> Is this a common problem?  Is there a more elegant solution to this?
> 

If you need to protect a piece of code, and the variables it
accesses are ONLY accessed by that code, investigate the use
of a simple spin-lock (no disabling interrupts). This can
prevent races such as you describe.

	spin_lock_irqsave(&big_lock, flags);
	do_critical_stuff();    /* Where global variables could change */
	spin_lock(&little_lock);  /* Simple spin for any other entry */
	spin_unlock_irqrestore(&big_lock, flags);  /* Interrupts now on */
	do_less_critical_stuff_including_sleep();
	spin_unlock(&little_lock);

Note that this turns a possible race into a possible CPU time-eating
spin so you need to carefully look at how the code is written. You
could turn that spin-wait into a sleep if you used a semaphore to
protect that section of code "up(), and down()".


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


