Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbRHTSAf>; Mon, 20 Aug 2001 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268916AbRHTSA0>; Mon, 20 Aug 2001 14:00:26 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:32776 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268675AbRHTSAS>;
	Mon, 20 Aug 2001 14:00:18 -0400
Message-Id: <200108200211.GAA00342@mops.inr.ac.ru>
Subject: Re: Problems with kernel-2.2.19-6.2.7 from RH update for 6.2
To: dyp@perchine.COM (Denis Perchine)
Date: Mon, 20 Aug 2001 06:11:40 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010819150344.AFC87204DB@mx.webmailstation.com> from "Denis Perchine" at Aug 19, 1 10:15:00 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 40
> fcntl(40, F_GETFL)                      = 0x2 (flags O_RDWR)
> fcntl(40, F_SETFL, O_RDWR|O_NONBLOCK)   = 0
> setsockopt(40, SOL_SOCKET, SO_LINGER, [1], 8) = 0
> connect(40, {sin_family=AF_INET, sin_port=htons(2030), 
> sin_addr=inet_addr("127.0.0.1")}}, 16) = -1 EINPROGRESS (Operation now in 
> progress)
> select(41, NULL, [40], NULL, {180, 0})  = 1 (out [40], left {180, 0})
> getsockopt(40, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
> select(41, [40], NULL, NULL, {180, 0})  = 1 (in [40], left {175, 550000})
> ioctl(4, FIONREAD, [0])                 = 0
> select(41, [40], NULL, NULL, {180, 0})  = 1 (in [40], left {180, 0})
> recv(4, 0x806aa28, 1, 0x4000)           = -1 EAGAIN (Resource temporarily 
> unavailable)
> 
> As far as you can see select say that socket is writable after connect. This 
> mean that connection is completed... But later before read we do select on 
> read, and get OK. But recv fails with EAGAIN. This situation is repeated 
> constantly. The program stucks in the loop trying to connect, but fails.
> 
> Any ideas what can this be?

F.e. this can be recv() on wrong descriptor, which is seen from strace above.
:-)


BTW why do you use funny getsockopt instead of canonical non-blocking connect?
Does standard way have some drawbacks or it is just legal desire
to "think different"? :-) The question is very interesting: it is big puzzle
for me what does motivate people to invent such strange combinations
of selct/ioctl/getsockopt (f.e. qmail did another bizarre thing:
getpeername() in the place where you use getsockopt(), so strace
looks like a shizophrenic dialogue to itself: "I am Bob!", ...
"Am I really Bob?" ... "Am I still Bob?" and so on for 3 minutes. :-))

And the second note: the whole sequence is equivalent to plain blocking
connect, only with lots of overhead. In all the OSes standard connect timeout
is of order 2-4 minutes. Yes, Linux-2.2 is unfortunate exception (13 minutes),
but the difference is purely quantitative yet and for any installation
this should be changed to smaller value via sysctl in any case.
Seems, no reasons to worry.

Alexey
