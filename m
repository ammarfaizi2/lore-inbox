Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSHZN1U>; Mon, 26 Aug 2002 09:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSHZN1U>; Mon, 26 Aug 2002 09:27:20 -0400
Received: from harrier.cohaesio.com ([212.97.128.50]:55825 "EHLO
	harrier.cohaesio.com") by vger.kernel.org with ESMTP
	id <S317468AbSHZN1T>; Mon, 26 Aug 2002 09:27:19 -0400
From: "Anders K. Pedersen" <akp@cohaesio.com>
Subject: setsockopt() doubles SO_RCVBUF
Date: Mon, 26 Aug 2002 15:31:34 +0200
Organization: Cohaesio A/S
Message-ID: <3D6A2DB6.E7DE78DD@cohaesio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: harrier.cohaesio.com 1030368694 19770 212.97.128.160 (26 Aug 2002 13:31:34 GMT)
X-Complaints-To: newsmaster@news.cohaesio.com
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In a project, I'm working on, I need to set the socket receive buffer
size, so I used
setsockopt(fd, SOL_SOCKET, SO_RCVBUF, ...). To make sure, it worked
properly, I read the size back with getsockopt(fd, SOL_SOCKET,
SO_RCVBUF, ...). I was surprised to find, that the value read back was
always twice the size of, what I (tried to) set it to - up to twice the
size of rmem_max.

I found the cause of this behaviour in net/core/sock.c, which contains
the following lines of code in sock_setsockopt:

                case SO_RCVBUF:
                        /* Don't error on this BSD doesn't and if you
think
                           about it this is right. Otherwise apps have
to
                           play 'guess the biggest size' games.
RCVBUF/SNDBUF
                           are treated in BSD as hints */
                          
                        if (val > sysctl_rmem_max)
                                val = sysctl_rmem_max;

                        sk->userlocks |= SOCK_RCVBUF_LOCK;
                        /* FIXME: is this lower bound the right one? */
                        if ((val * 2) < SOCK_MIN_RCVBUF)
                                sk->rcvbuf = SOCK_MIN_RCVBUF;
                        else
                                sk->rcvbuf = (val * 2);
                        break;

Is it intentional, that val is doubled?

Regards,
Anders K. Pedersen
