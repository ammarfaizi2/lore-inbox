Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUGATIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUGATIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUGATIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:08:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8832 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266224AbUGATIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:08:17 -0400
Date: Thu, 1 Jul 2004 15:07:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sebastian Kuzminsky <seb@highlab.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: io priorities?
In-Reply-To: <E1Bg64T-0003MC-00@highlab.com>
Message-ID: <Pine.LNX.4.53.0407011456110.1241@chaos>
References: <E1Bg64T-0003MC-00@highlab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, Sebastian Kuzminsky wrote:

> Hi folks, i've got IO problems...
>
>
> I've got a computer with one IDE disk.  There are a couple of processes
> writing big telemetry logs, totally not time-critical.  Then there's one
> process periodically writing a tiny little state file, about 150 bytes.
> The process with the state file wants to sync its file to disk and then
> quickly be back and running.  When it calls fsync() it has to wait for
> other processes' less-important pending I/O before it gets to complete,
> and it's not unusual for this to take 30 seconds (CF over IDE), which
> is too slow for my application.
>
>
> This happens with both 2.4.23 and 2.6.6 (as, cfq, & deadline).  I havent
> tried to tune the schedulers at all, just using the default values.
>
>
> I've tried five methods of syncing the file: sync(), fsync(), fdatasync(),
> and opening with O_SYNC or O_DSYNC.  All take about the same amount
> of time.
>
>
> I've tried it on my target machine (Compact Flash via pio IDE) and on
> my development machine (regular hard drive via udma5 IDE).  Same results
> qualitatively speaking.
>
> I read Jens Axboe's thread about cfq + io priorities, and it sounds
> perfect!  I could give my one time-critical process high io priority
> and it should preempt the others and life would be fine.  But all the
> l-k traffic i've found about this is from back in November.  Did this
> work go anywhere?
>
> Any suggestions on fixes or workarounds?
>
>
> I'm stumped.
>

Periodically fsync() the logs so there isn't soooo much stuff to
write. In fact, a simple sync() call about once every few seconds
should make everything work, i.e. ...

main()
{
    for(;;)
    {
        sync();
        sleep(3);
    }
}

... in another task should fix it. We no longer have `update` running
like the old unixes. Now there is bdflush that cares only about
kernel buffers getting in short supply. If you want your files to
be sync(ed) quickly, you need to keep the in-kernel buffers short
which means you need to do it yourself.

Before everybody chimes in.... just try it. You'll probably like it.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


