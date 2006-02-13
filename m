Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWBMXpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWBMXpQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWBMXpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:45:16 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:32689
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030297AbWBMXpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:45:14 -0500
Message-ID: <43F119FC.10900@microgate.com>
Date: Mon, 13 Feb 2006 17:45:00 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Baron <jbaron@redhat.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "jesper.juhl@gmail.com" <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty reference count fix
References: <1139861610.3573.24.camel@amdx2.microgate.com> <Pine.LNX.4.61.0602131747570.19384@dhcp83-105.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0602131747570.19384@dhcp83-105.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron wrote:
> patch looks good to me. Or you could even drop the tty_sem completely from 
> the release_dev path (patch below) since lock_kernel() is held in both 
> tty_open() and the release_dev paths()

The historical posts on locking in release_dev()
I looked at suggest that a move from BKL to more
fine grained synchronization (tty_sem) was a goal.

The code looks like it originally relied on the BKL.
The later addition of tty_sem was done in a way
that allowed sleeping between setting tty_closing
and TTY_CLOSING flag:

down(&tty_sem)
if (tty->count == 1)
	tty_closing = 1;
up(&tty_sem)
...
down(&tty_sem) <<<< can sleep, open can increase count
tty->count--
up(&tty_sem)
...
if (tty_closing)
	set_bit(TTY_CLOSING)

 > (and there is no sleeping b/w setting the tty_closing
 > flag and setting the TTY_CLOSING bit).

Your patch leaves the schedule() call at the bottom of
the while loop between setting tty_closing and
setting TTY_CLOSING flag.

Thanks,
Paul

--
Paul Fulghum
Microgate Systems, Ltd

