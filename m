Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316830AbSFARGl>; Sat, 1 Jun 2002 13:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSFARGk>; Sat, 1 Jun 2002 13:06:40 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:30640 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316830AbSFARGj>; Sat, 1 Jun 2002 13:06:39 -0400
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, icollinson@imerge.co.uk, andrea@suse.de
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C992@imgserv04> <20020531112847.B1529@w-mikek2.des.beaverton.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: 01 Jun 2002 19:05:47 +0200
Message-ID: <m37kljkjys.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <kravetz@us.ibm.com> writes:

> This works fine for me on 2.4.17 with a SERIAL console.  Could this
> be related to some differences (new features) in the VGA console?
> I am totally ignorant of how the consoles work.

One possibility is that something relies on schedule_task() - keventd
doesn't run with realtime priority and can be starved.

Seems to be the case indeed: 

/usr/src/linux/drivers/char% grep schedule_task *.c
console.c:      schedule_task(&console_callback_tq);
...

the console switch does.

Fixing it would require boosting keventd's priority either globally 
or temporarily. E.g. if the original reporter could put this
(untested/uncompiled) at the beginning of kernel/context.c:context_thread():

    current->policy = SCHED_RR;
    current->rt_priority = 99;

it could fix his problem.

-Andi
