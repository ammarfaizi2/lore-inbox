Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315922AbSENRmP>; Tue, 14 May 2002 13:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSENRmO>; Tue, 14 May 2002 13:42:14 -0400
Received: from [168.159.40.71] ([168.159.40.71]:7177 "EHLO
	srexchimc2.lss.emc.com") by vger.kernel.org with ESMTP
	id <S315922AbSENRmK>; Tue, 14 May 2002 13:42:10 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A55@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Steve Whitehouse'" <Steve@ChyGwyn.com>
Cc: jes@wildopensource.com, linux-kernel@vger.kernel.org
Subject: RE: Kernel deadlock using nbd over acenic driver.
Date: Tue, 14 May 2002 13:42:03 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes. I am testing a single nbd device, thus single socket in this case.
There is no other heavy networking tasks on the testing machine.


-----Original Message-----
From: Steven Whitehouse [mailto:steve@gw.chygwyn.com]
Sent: Tuesday, May 14, 2002 12:32 PM
To: chen, xiangping
Cc: jes@wildopensource.com; linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.


Hi,

The TCP stack should auto-tune the amount of memory that it uses, so that
SO_SNDBUF, cat >/proc/sys/net/core/[rw]mem_default etc. is not required. The
important settings for TCP sockets are only /proc/sys/net/ipv4/tcp_[rw]mem
and tcp_mem I think (at least if I've understood the code correctly).

Since I think we are talking about only a single nbd device, there should
only be a single socket thats doing lots of I/O in this case, or is this
machine doing other heavy network tasks ?
> 
> But how to avoid system hangs due to running out of memory?
> Is there a safe guide line? Generally slow is tolerable, but
> crash is not.
> 
I agree. I also think your earlier comments about the buffer flushing are
correct as being the most likely cause.

I don't think the system has "run out" exactly, more just got itself into
a state where the code path writing out dirty blocks has been blocked
due to lack of freeable memory at that moment and where the process
freeing up memory has blocked waiting for the nbd device. It may well
be that there is freeable memory, just that for whatever reason no
process is trying to free it.

The LVM team has had a similar problem in dealing with I/O which needs
extra memory in order to complete, so I'll ask them for some ideas. Also
I'm going to try and come up with some patches to eliminate some of the
possible theories so that we can narrow down the options,

Steve
