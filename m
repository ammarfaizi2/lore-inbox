Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWFIMRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWFIMRf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 08:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbWFIMRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 08:17:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:2974 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965245AbWFIMRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 08:17:35 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc6-rt1
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149853468.3829.33.camel@frecb000686>
References: <20060607211455.GA6132@elte.hu>
	 <1149842550.7585.27.camel@Homer.TheSimpsons.net>
	 <1149847951.3829.26.camel@frecb000686>
	 <1149852951.7421.7.camel@Homer.TheSimpsons.net>
	 <1149853468.3829.33.camel@frecb000686>
Content-Type: text/plain; charset=utf-8
Date: Fri, 09 Jun 2006 14:20:38 +0200
Message-Id: <1149855638.7413.8.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 13:44 +0200, Sébastien Dugué wrote:
> On Fri, 2006-06-09 at 13:35 +0200, Mike Galbraith wrote:
> > 
> > I found xmms problem.
> > 
> > [pid  8498] 12:53:49.936186 socket(PF_INET, SOCK_STREAM, IPPROTO_IP <unfinished ...>
> > [pid  8498] 12:53:49.936551 <... socket resumed> ) = 9 <0.000301>
> > [pid  8498] 12:53:49.936774 fcntl64(9, F_SETFD, FD_CLOEXEC <unfinished ...>
> > [pid  8498] 12:53:49.937287 <... fcntl64 resumed> ) = 0 <0.000465>
> > [pid  8498] 12:53:49.937451 setsockopt(9, SOL_SOCKET, SO_REUSEADDR, [1], 4 <unfinished ...>
> > [pid  8498] 12:53:49.937630 <... setsockopt resumed> ) = 0 <0.000110>
> > [pid  8498] 12:53:49.937893 connect(9, {sa_family=AF_INET, sin_port=htons(16001), sin_addr=inet_addr("127.0.0.1")}, 16 <unfinished ...>
> > [pid  8498] 12:56:58.902958 <... connect resumed> ) = -1 ETIMEDOUT (Connection timed out) <188.964934>
> > 
> > which should have been...
> > 
> > [pid  7385] 13:21:38.715146 socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 9 <0.000011>
> > [pid  7385] 13:21:38.715192 fcntl64(9, F_SETFD, FD_CLOEXEC) = 0 <0.000007>
> > [pid  7385] 13:21:38.715237 setsockopt(9, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000008>
> > [pid  7385] 13:21:38.715283 connect(9, {sa_family=AF_INET, sin_port=htons(16001), sin_addr=inet_addr("127.0.0.1")}, 16) = -1 ECONNREFUSED (Connection refused) <0.000060>
> > 
> > So much for the easy part.
> > 
> 
>   I'm starting to believe that it's network related. Pinging my box from
> a remote host gives a ~.3 ms round trip whereas pinging localhost gives
> ~500ms. Something real weird is going on here.

Wow.  I don't see anything near 500ms, but I am dropping packets, and
recvmsg, when it isn't saying -EAGAIN, is indeed taking way too long.

14:04:02.062550 sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, msg_iov(1)=[{"\10\0$@\217\36\0\2\262c\211D\35\364\0\0\10\t\n\v\f\r\16"..., 64}], msg_controllen=0, msg_flags=0}, 0) = 64 <0.000048>
14:04:02.062731 setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={10, 0}}, NULL) = 0 <0.000016>
14:04:02.062826 recvmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(19889), sin_addr=inet_addr("127.0.0.1")}, msg_iov(1)=[{"E\0\0T\177]\0\0@\1\375I\177\0\0\1\177\0\0\1\0\0,@\217\36"..., 192}], msg_controllen=20, {cmsg_len=20, cmsg_level=SOL_SOCKET, cmsg_type=0x1d /* SCM_??? */, ...}, msg_flags=0}, 0) = 84 <0.037660>


