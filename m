Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286360AbRLJTrG>; Mon, 10 Dec 2001 14:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286363AbRLJTq5>; Mon, 10 Dec 2001 14:46:57 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:49086 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S286360AbRLJTqu>;
	Mon, 10 Dec 2001 14:46:50 -0500
Message-ID: <3C151128.5080109@candelatech.com>
Date: Mon, 10 Dec 2001 12:46:48 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: min-write-size for a UDP socket to be POLLOUT cannot be set. (proposed fixes)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This relates to my earlier question about setting the threshold
at which select returns that a (UDP) socket is writable.

It appears that UDP sockets are hardwired at 2048 bytes...

 From linux/include/net/sock.h:

....
#define SOCK_MIN_SNDBUF 2048
#define SOCK_MIN_RCVBUF 256
/* Must be less or equal SOCK_MIN_SNDBUF */
#define SOCK_MIN_WRITE_SPACE	SOCK_MIN_SNDBUF

/*
  *	Default write policy as shown to user space via poll/select/SIGIO
  *	Kernel internally doesn't use the MIN_WRITE_SPACE threshold.
  */
static inline int sock_writeable(struct sock *sk)
{
	return sock_wspace(sk) >= SOCK_MIN_WRITE_SPACE;
}


It appears that this issue could be fixed in several ways.  One would be to
make SOCK_MIN_WRITE_SPACE a global variable and set it through the proc
file system (or an IOCTL, etc...).  That is not very flexible, but
easy.  It sounds more likely to break existing programs though..

A more flexible way would be to set the value on a per sock basis (in the sock structure),
which is probably the right way, but may require a new IOCTL defined
in user-space...  This way should be completely backwards compatible, as the
default value can be 2048 as it is now.

Fixing this little problem will be very useful for anyone using larger UDP packet
sizes and poll/select.  Remember that GigE supports >>2048 MTU, so using larger UDP
packets becomes a more useful thing, even in the real world :)


As a side note, it appears that TCP is much smarter about this, taking the
current load into account:  If there is very little in the current write
queue, then it will say the socket is writable at a very small threshold.
However, if the write queue is almost full, tcp will make select/poll wait
longer.  This type of thing could also work for UDP, and the user can indirectly
determine the behaviour by setting the write-queue size appropriately large...

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


