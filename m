Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRHTSvO>; Mon, 20 Aug 2001 14:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbRHTSvE>; Mon, 20 Aug 2001 14:51:04 -0400
Received: from UNASSIGNED.SKYNETWEB.COM ([64.23.55.10]:14377 "HELO
	mx.webmailstation.com") by vger.kernel.org with SMTP
	id <S268342AbRHTSuv> convert rfc822-to-8bit; Mon, 20 Aug 2001 14:50:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
Organization: AcademSoft
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: Problems with kernel-2.2.19-6.2.7 from RH update for 6.2
Date: Tue, 21 Aug 2001 01:52:04 +0700
X-Mailer: KMail [version 1.3.5]
In-Reply-To: <200108200211.GAA00342@mops.inr.ac.ru>
In-Reply-To: <200108200211.GAA00342@mops.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820155450.777C91FD74@mx.webmailstation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 August 2001 09:11, you wrote:
> Hello!
>
> > socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 40
> > fcntl(40, F_GETFL)                      = 0x2 (flags O_RDWR)
> > fcntl(40, F_SETFL, O_RDWR|O_NONBLOCK)   = 0
> > setsockopt(40, SOL_SOCKET, SO_LINGER, [1], 8) = 0
> > connect(40, {sin_family=AF_INET, sin_port=htons(2030),
> > sin_addr=inet_addr("127.0.0.1")}}, 16) = -1 EINPROGRESS (Operation now in
> > progress)
> > select(41, NULL, [40], NULL, {180, 0})  = 1 (out [40], left {180, 0})
> > getsockopt(40, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
> > select(41, [40], NULL, NULL, {180, 0})  = 1 (in [40], left {175, 550000})
> > ioctl(4, FIONREAD, [0])                 = 0
> > select(41, [40], NULL, NULL, {180, 0})  = 1 (in [40], left {180, 0})
> > recv(4, 0x806aa28, 1, 0x4000)           = -1 EAGAIN (Resource temporarily
> > unavailable)
> >
> > As far as you can see select say that socket is writable after connect.
> > This mean that connection is completed... But later before read we do
> > select on read, and get OK. But recv fails with EAGAIN. This situation is
> > repeated constantly. The program stucks in the loop trying to connect,
> > but fails.
> >
> > Any ideas what can this be?

> F.e. this can be recv() on wrong descriptor, which is seen from strace
> above.
>
> :-)

Oups... I should sleep for at least 9 hours when I wrote it. :-(( It looks 
like a bug.

> BTW why do you use funny getsockopt instead of canonical non-blocking
> connect?

Hmmm... If I know what canonical non-blocking connect is, I would use it I 
think...

Also I use getsockopt to get an error. I set non-blocking with fcntl.

> Does standard way have some drawbacks or it is just legal desire
> to "think different"? :-)

No. Just usual lameness. I read lot of FAQs, play with the code, and this is 
the combination which works. Actually thttpd also uses this (if I am not 
mistaken).

> The question is very interesting: it is big
> puzzle for me what does motivate people to invent such strange combinations
> of selct/ioctl/getsockopt (f.e. qmail did another bizarre thing:
> getpeername() in the place where you use getsockopt(), so strace
> looks like a shizophrenic dialogue to itself: "I am Bob!", ...
> "Am I really Bob?" ... "Am I still Bob?" and so on for 3 minutes. :-))

Eeerrhhh... Let's not touch Berstein, or he will rfuse answering my 
bugreports if I will ever change Postfix to QMail. He is a special guy. QMail 
is the only software I can not read like a book...

> And the second note: the whole sequence is equivalent to plain blocking
> connect, only with lots of overhead. In all the OSes standard connect
> timeout is of order 2-4 minutes. Yes, Linux-2.2 is unfortunate exception
> (13 minutes), but the difference is purely quantitative yet and for any
> installation this should be changed to smaller value via sysctl in any
> case.

The problem here is that I need to tune timeout for: each connection, and for 
connect, and read/write separately. If you could give me an advise how to do 
this more effective, I would be really glad.

Actually the problem was anyway in my app. I have fixed it.

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
