Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTKCLHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 06:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTKCLHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 06:07:37 -0500
Received: from mailgate.zeus.co.uk ([62.254.209.70]:10513 "EHLO
	mailgate.zeus.co.uk") by vger.kernel.org with ESMTP id S261585AbTKCLHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 06:07:36 -0500
Date: Mon, 3 Nov 2003 11:07:29 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll gives broken results when interrupted with a signal
In-Reply-To: <Pine.LNX.4.56.0310301534330.1136@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0311031044480.30431@stones.cam.zeus.com>
References: <Pine.LNX.4.58.0310291439110.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310290923100.2049@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310291729310.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310291121560.973@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310301102470.1597@stones.cam.zeus.com>
 <Pine.LNX.4.58.0310301425090.1597@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310301534330.1136@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1AGcYT-00042H-00*vnhp8faU0I6* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Davide Libenzi wrote:

> Could you try to poison the event buffer before an epoll_wait() to see how
> many bytes are effectively written by the function?
>
> 	memset(events, 'e', num * sizeof(epoll_event));

aha! This is interesting. When epoll seems to go wrong, the
epoll_event.data of the second event is unwritten, but the .events field
is zeroed. Sometimes though, the final call to epoll_wait() returns just
one event instead of the two, and in that case, the high 32 bits of the
first epoll_event.data are unwritten. The lower 32 bits contain the
right data, and as the code treats this as a (int) FD, the top 32 bits
are discarded anyway.

Drat! I've just looked back at the kernel headers and noticed the
following, prior to the epoll_event definition:

/*
 * On x86-64 make the 64bit structure have the same alignment as the
 * 32bit structure. This makes 32bit emulation easier.
 */
#ifdef __x86_64__
#define EPOLL_PACKED __attribute__((packed))
#else
#define EPOLL_PACKED
#endif

struct epoll_event {
        __u32 events;
        __u64 data;
} EPOLL_PACKED;


Now, my code can't pull in the kernel headers so it has its own
epoll_event definition, which is missing the packed attribute. D'oh!
Guess what, everything works properly when I add it in. Looks like this
bug has been of my own making all along...

Sorry for taking up your time!


Ben

-- 
Ben Mansell, <ben@zeus.com>                       Zeus Technology Ltd
Download the world's fastest webserver!   Universally Serving the Net
T:+44(0)1223 525000 F:+44(0)1223 525100           http://www.zeus.com
Zeus House, Cowley Road, Cambridge, CB4 0ZT, ENGLAND
