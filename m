Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280133AbRK0PdG>; Tue, 27 Nov 2001 10:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280817AbRK0Pct>; Tue, 27 Nov 2001 10:32:49 -0500
Received: from [128.165.17.254] ([128.165.17.254]:27314 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S280133AbRK0Pcl>; Tue, 27 Nov 2001 10:32:41 -0500
Date: Tue, 27 Nov 2001 08:32:39 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Jordan Russell <jr-list-kernel@quo.to>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 TCP performance difference - feature or flaw?
Message-ID: <20011127083239.H22767@lanl.gov>
In-Reply-To: <00f201c1770c$b4418430$024d460a@neptune>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f201c1770c$b4418430$024d460a@neptune>
User-Agent: Mutt/1.3.18i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morning-

First, don't use 2.4.15, there's a known bug that causes "minor" FS corruption
on umount. Upgrade to 2.4.16 and force a fsck.

> The issue:
> I have my keyboard repeat rate set high (31 chars/sec). When I'm SSH'ed into
> Linux and I hold down a letter key (for example), it does not repeat
> "smoothly" with a 2.4 kernel installed. The characters seem to show up about
> 2 at a time. It's as if I'm going over a high-latency connection; I'm not.
This might be an issue with the Nagle algorithm; this basically sets a
time to wait for more input before sending a packet. That way fewer total
packets are sent over interactive connections (sending one byte payloads
with many-byte headers wastes BW) and generally it is a Good Idea. If this is
indeed the problem it might be because 2.2.20 doesn't implement the algorithm
quite the same way as 2.4.15  but that's beyond my knowledge.

If it really bugs you get the SSH client/server source and grep for where
the socket options are set `grep -r "setsockopt" *` and see if the TCP_NODELAY
flag is set in some call. If not just add code like:
	if (setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &i, sizeof(int))<0)
		fprintf(stderr, "Failed to turn of Nagle algorithm");
and see if that does anything.

If the code is already there, then there might actually be a minor bug in
the kernel.


-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
