Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTJaXAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 18:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTJaXAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 18:00:25 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:48269 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263688AbTJaXAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 18:00:21 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 31 Oct 2003 15:00:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben Mansell <ben@zeus.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll gives broken results when interrupted with a signal
In-Reply-To: <Pine.LNX.4.58.0310301425090.1597@stones.cam.zeus.com>
Message-ID: <Pine.LNX.4.56.0310311456180.1028@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0310291439110.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310290923100.2049@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310291729310.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310291121560.973@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310301102470.1597@stones.cam.zeus.com>
 <Pine.LNX.4.58.0310301425090.1597@stones.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Ben Mansell wrote:

> On Thu, 30 Oct 2003, Ben Mansell wrote:
>
> > On Wed, 29 Oct 2003, Davide Libenzi wrote:
> >
> > > Can you try the patch below and show me a dmesg when this happen?
> >
> > Ok, patch applied. (I changed DEBUG_EPOLL to 10 however, otherwise
> > nothing would be printed). Now, epoll appears to behave perfectly and I
> > can't re-create the problem :(
>
> Got it! I was missing the problem because I had removed some debug
> messages in my own code. Here's another run, this time the
> final epoll_wait() call of the child process brings back 2 events:
>  Event 0 fd: 7 events: 17
>  Event 1 fd: -2095926561 events: 0

It is really strage. If you look what epoll sees:

> [0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
> [0000010002ba7520] eventpoll: pollres file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80 events=17
> [0000010002ba7520] eventpoll: polling file=000001000615d980 ep=000001001f928000 epi=000001000d9c69c0
> [0000010002ba7520] eventpoll: pollres file=000001000615d980 ep=000001001f928000 epi=000001000d9c69c0 events=16
> [0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000) = 2
> [0000010002ba7520] eventpoll: eventpoll_release_file(00000100099822c0)
> [0000010002ba7520] eventpoll: remove ep=000001001f928000 epi=000001000d9c6a80
> [0000010002ba7520] eventpoll: ep_unlink(000001001f928000, 00000100099822c0) = 0
> [0000010002ba7520] eventpoll: ep_remove(000001001f928000, 00000100099822c0) = 0
> [0000010002ba7520] eventpoll: eventpoll_release_file(000001000615d980)
> [0000010002ba7520] eventpoll: remove ep=000001001f928000 epi=000001000d9c69c0
> [0000010002ba7520] eventpoll: ep_unlink(000001001f928000, 000001000615d980) = 0
> [0000010002ba7520] eventpoll: ep_remove(000001001f928000, 000001000615d980) = 0
> [0000010002ba7520] eventpoll: close() ep=000001001f928000

It clearly sees two events with masks 16 and 17. And at this points events
are already inside a buffer ready to be pushed to usespace with a
copy_to_user().



- Davide

