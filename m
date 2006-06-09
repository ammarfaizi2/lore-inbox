Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWFIMwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWFIMwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 08:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWFIMwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 08:52:18 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:10957 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965246AbWFIMwR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 08:52:17 -0400
Subject: Re: 2.6.17-rc6-rt1
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149855638.7413.8.camel@Homer.TheSimpsons.net>
References: <20060607211455.GA6132@elte.hu>
	 <1149842550.7585.27.camel@Homer.TheSimpsons.net>
	 <1149847951.3829.26.camel@frecb000686>
	 <1149852951.7421.7.camel@Homer.TheSimpsons.net>
	 <1149853468.3829.33.camel@frecb000686>
	 <1149855638.7413.8.camel@Homer.TheSimpsons.net>
Date: Fri, 09 Jun 2006 14:57:01 +0200
Message-Id: <1149857821.3829.42.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/06/2006 14:55:51,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/06/2006 14:55:54,
	Serialize complete at 09/06/2006 14:55:54
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 14:20 +0200, Mike Galbraith wrote:
> > 
> >   I'm starting to believe that it's network related. Pinging my box from
> > a remote host gives a ~.3 ms round trip whereas pinging localhost gives
> > ~500ms. Something real weird is going on here.
> 
> Wow.  I don't see anything near 500ms, but I am dropping packets, and
> recvmsg, when it isn't saying -EAGAIN, is indeed taking way too long.
> 
> 14:04:02.062550 sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, msg_iov(1)=[{"\10\0$@\217\36\0\2\262c\211D\35\364\0\0\10\t\n\v\f\r\16"..., 64}], msg_controllen=0, msg_flags=0}, 0) = 64 <0.000048>
> 14:04:02.062731 setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={10, 0}}, NULL) = 0 <0.000016>
> 14:04:02.062826 recvmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(19889), sin_addr=inet_addr("127.0.0.1")}, msg_iov(1)=[{"E\0\0T\177]\0\0@\1\375I\177\0\0\1\177\0\0\1\0\0,@\217\36"..., 192}], msg_controllen=20, {cmsg_len=20, cmsg_level=SOL_SOCKET, cmsg_type=0x1d /* SCM_??? */, ...}, msg_flags=0}, 0) = 84 <0.037660>
> 

  Even weirder:

$ping localhost
PING localhost.localdomain (127.0.0.1) 56(84) bytes of data.
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=1 ttl=64 time=0.157 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=2 ttl=64 time=107 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=3 ttl=64 time=94.7 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=4 ttl=64 time=741 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=5 ttl=64 time=179 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=6 ttl=64 time=732 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=7 ttl=64 time=728 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=8 ttl=64 time=725 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=9 ttl=64 time=178 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=10 ttl=64 time=96.0 ms
64 bytes from localhost.localdomain (127.0.0.1): icmp_seq=11 ttl=64 time=342 ms
...

$strace -tt -T ping localhost
14:48:07.764888 sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0), 
sin_addr=inet_addr("127.0.0.1")}, msg_iov(1)=[{"\10\0:\221\341\v\0\3\7n\211DU\25
2\v\0\10\t\n\v\f\r\16\17"..., 64}], msg_controllen=0, msg_flags=0}, MSG_CONFIRM)
 = 64 <0.000078>
14:48:07.765930 recvmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0), 
sin_addr=inet_addr("127.0.0.1")}, msg_iov(1)=[{"E\0\0T\\\241\0\0@\1 \6\177\0\0\1
\177\0\0\1\0\0B\221\341"..., 192}], msg_controllen=20, {cmsg_len=20, cmsg_level=
SOL_SOCKET, cmsg_type=0x1d /* SCM_??? */, ...}, msg_flags=0}, 0) = 84 <0.000402>
14:48:07.767598 write(1, "64 bytes from localhost.localdom"..., 8064 bytes from 
localhost.localdomain (127.0.0.1): icmp_seq=3 ttl=64 time=1.86 ms
) = 80 <0.000307>

All the round trips under strace are in the 2ms range.

  How on earth can it be that stracing the ping gives better
performance???

  Sébastien.







