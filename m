Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTJ3Oss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 09:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbTJ3Osr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 09:48:47 -0500
Received: from mailgate.zeus.co.uk ([62.254.209.70]:11281 "EHLO
	mailgate.zeus.co.uk") by vger.kernel.org with ESMTP id S262546AbTJ3Oso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 09:48:44 -0500
Date: Thu, 30 Oct 2003 14:48:35 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll gives broken results when interrupted with a signal
In-Reply-To: <Pine.LNX.4.58.0310301102470.1597@stones.cam.zeus.com>
Message-ID: <Pine.LNX.4.58.0310301425090.1597@stones.cam.zeus.com>
References: <Pine.LNX.4.58.0310291439110.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310290923100.2049@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310291729310.2982@stones.cam.zeus.com>
 <Pine.LNX.4.56.0310291121560.973@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0310301102470.1597@stones.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1AFE6F-0001KZ-00*vcsRl5PCTYc* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Ben Mansell wrote:

> On Wed, 29 Oct 2003, Davide Libenzi wrote:
>
> > Can you try the patch below and show me a dmesg when this happen?
>
> Ok, patch applied. (I changed DEBUG_EPOLL to 10 however, otherwise
> nothing would be printed). Now, epoll appears to behave perfectly and I
> can't re-create the problem :(

Got it! I was missing the problem because I had removed some debug
messages in my own code. Here's another run, this time the
final epoll_wait() call of the child process brings back 2 events:
 Event 0 fd: 7 events: 17
 Event 1 fd: -2095926561 events: 0

I've added the debug to the end of this message.

If I modify the code so there are several 'child' processes, all
monitoring the same sockets with their own epolls, they all seem to get
the same results from epoll_wait().

> > Also, it shouldn't change a whit, but are you able to try on a x86 UP?

On a UP x86, 2.6.0-test9, I can't reproduce the problem at all.

[0000010017126e50] eventpoll: sys_epoll_create(10)
[0000010017126e50] eventpoll: ep_file_init() ep=0000010008964000
[0000010017126e50] eventpoll: sys_epoll_create(10) = 4
[0000010017126e50] eventpoll: close() ep=0000010008964000
[0000010017126e50] eventpoll: sys_epoll_create(256)
[0000010017126e50] eventpoll: ep_file_init() ep=0000010008964000
[0000010017126e50] eventpoll: sys_epoll_create(256) = 4
[0000010017126e50] eventpoll: sys_epoll_ctl(4, 1, 5, 0000007fbffff070)
[0000010017126e50] eventpoll: ep_find(0000010005e2cc80) -> 0000000000000000
[0000010017126e50] eventpoll: ep_insert(0000010008964000, 0000010005e2cc80, 5)
[0000010017126e50] eventpoll: sys_epoll_ctl(4, 1, 5, 0000007fbffff070) = 0
[0000010017126e50] eventpoll: sys_epoll_ctl(4, 1, 6, 0000007fbffff290)
[0000010017126e50] eventpoll: ep_find(000001000402b2c0) -> 0000000000000000
[0000010017126e50] eventpoll: ep_insert(0000010008964000, 000001000402b2c0, 6)
[0000010017126e50] eventpoll: sys_epoll_ctl(4, 1, 6, 0000007fbffff290) = 0
[0000010002ba7520] eventpoll: sys_epoll_create(1024)
[0000010002ba7520] eventpoll: ep_file_init() ep=000001001f928000
[0000010002ba7520] eventpoll: sys_epoll_create(1024) = 3
[0000010002ba7520] eventpoll: sys_epoll_ctl(3, 1, 7, 0000007fbffff1c0)
[0000010002ba7520] eventpoll: ep_find(00000100099822c0) -> 0000000000000000
[0000010002ba7520] eventpoll: ep_insert(000001001f928000, 00000100099822c0, 7)
[0000010002ba7520] eventpoll: sys_epoll_ctl(3, 1, 7, 0000007fbffff1c0) = 0
[0000010002ba7520] eventpoll: sys_epoll_ctl(3, 3, 7, 000000000070fd80)
[0000010002ba7520] eventpoll: ep_find(00000100099822c0) -> 000001000d9c6a80
[0000010002ba7520] eventpoll: sys_epoll_ctl(3, 3, 7, 000000000070fd80) = 0
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000)
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010002ba7520] eventpoll: pollres file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80 events=1
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000) = 1
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000)
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010017126e50] eventpoll: sys_epoll_ctl(4, 3, 6, 000000000070fd80)
[0000010017126e50] eventpoll: ep_find(000001000402b2c0) -> 000001000d9c6b40
[0000010017126e50] eventpoll: sys_epoll_ctl(4, 3, 6, 000000000070fd80) = 0
[0000010017126e50] eventpoll: sys_epoll_ctl(4, 3, 5, 000000000070fd80)
[0000010017126e50] eventpoll: ep_find(0000010005e2cc80) -> 000001000d9c6c00
[0000010017126e50] eventpoll: sys_epoll_ctl(4, 3, 5, 000000000070fd80) = 0
[0000010017126e50] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 0)
[0000010017126e50] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 0) = 0
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010002ba7520] eventpoll: pollres file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80 events=1
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000) = 1
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000)
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010002ba7520] eventpoll: pollres file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80 events=1
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000) = 1
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000)
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010002ba7520] eventpoll: pollres file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80 events=1
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000) = 1
[0000010002ba7520] eventpoll: sys_epoll_ctl(3, 1, 4, 0000007fbfffe850)
[0000010002ba7520] eventpoll: ep_find(000001000615d980) -> 0000000000000000
[0000010002ba7520] eventpoll: ep_insert(000001001f928000, 000001000615d980, 4)
[0000010002ba7520] eventpoll: sys_epoll_ctl(3, 1, 4, 0000007fbfffe850) = 0
[0000010002ba7520] eventpoll: sys_epoll_ctl(3, 3, 4, 000000000070fd80)
[0000010002ba7520] eventpoll: ep_find(000001000615d980) -> 000001000d9c69c0
[0000010002ba7520] eventpoll: sys_epoll_ctl(3, 3, 4, 000000000070fd80) = 0
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000)
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010017126e50] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 3000)
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010017126e50] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 3000) = -4
[0000010017126e50] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 2000)
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000) = 0
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000)
[0000010017126e50] eventpoll: sys_epoll_wait(4, 0000000000734510, 32, 2000) = -4
[0000010017126e50] eventpoll: poll_callback(000001000615d980) epi=000001000d9c69c0 ep=000001001f928000
[0000010017126e50] eventpoll: poll_callback(000001000615d980) epi=000001000d9c69c0 ep=000001001f928000
[0000010017126e50] eventpoll: poll_callback(0000010005e2cc80) epi=000001000d9c6c00 ep=0000010008964000
[0000010017126e50] eventpoll: poll_callback(0000010005e2cc80) epi=000001000d9c6c00 ep=0000010008964000
[0000010017126e50] eventpoll: eventpoll_release_file(0000010005e2cc80)
[0000010017126e50] eventpoll: remove ep=0000010008964000 epi=000001000d9c6c00
[0000010017126e50] eventpoll: ep_unlink(0000010008964000, 0000010005e2cc80) = 0
[0000010017126e50] eventpoll: ep_remove(0000010008964000, 0000010005e2cc80) = 0
[0000010017126e50] eventpoll: eventpoll_release_file(000001000402b2c0)
[0000010017126e50] eventpoll: remove ep=0000010008964000 epi=000001000d9c6b40
[0000010017126e50] eventpoll: ep_unlink(0000010008964000, 000001000402b2c0) = 0
[0000010017126e50] eventpoll: ep_remove(0000010008964000, 000001000402b2c0) = 0
[0000010017126e50] eventpoll: close() ep=0000010008964000
[0000010017126e50] eventpoll: poll_callback(00000100099822c0) epi=000001000d9c6a80 ep=000001001f928000
[0000010002ba7520] eventpoll: polling file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80
[0000010002ba7520] eventpoll: pollres file=00000100099822c0 ep=000001001f928000 epi=000001000d9c6a80 events=17
[0000010002ba7520] eventpoll: polling file=000001000615d980 ep=000001001f928000 epi=000001000d9c69c0
[0000010002ba7520] eventpoll: pollres file=000001000615d980 ep=000001001f928000 epi=000001000d9c69c0 events=16
[0000010002ba7520] eventpoll: sys_epoll_wait(3, 000000000073e390, 32, 1000) = 2
[0000010002ba7520] eventpoll: eventpoll_release_file(00000100099822c0)
[0000010002ba7520] eventpoll: remove ep=000001001f928000 epi=000001000d9c6a80
[0000010002ba7520] eventpoll: ep_unlink(000001001f928000, 00000100099822c0) = 0
[0000010002ba7520] eventpoll: ep_remove(000001001f928000, 00000100099822c0) = 0
[0000010002ba7520] eventpoll: eventpoll_release_file(000001000615d980)
[0000010002ba7520] eventpoll: remove ep=000001001f928000 epi=000001000d9c69c0
[0000010002ba7520] eventpoll: ep_unlink(000001001f928000, 000001000615d980) = 0
[0000010002ba7520] eventpoll: ep_remove(000001001f928000, 000001000615d980) = 0
[0000010002ba7520] eventpoll: close() ep=000001001f928000


-- 
Ben Mansell, <ben@zeus.com>                       Zeus Technology Ltd
Download the world's fastest webserver!   Universally Serving the Net
T:+44(0)1223 525000 F:+44(0)1223 525100           http://www.zeus.com
Zeus House, Cowley Road, Cambridge, CB4 0ZT, ENGLAND

