Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289154AbSAGJLp>; Mon, 7 Jan 2002 04:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289155AbSAGJLf>; Mon, 7 Jan 2002 04:11:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24747 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289154AbSAGJLR>;
	Mon, 7 Jan 2002 04:11:17 -0500
Date: Mon, 7 Jan 2002 04:11:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Yasuma Takeda <yasuma@miraclelinux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removed socket buffer in unix domain socket
In-Reply-To: <20020107173944.05623687.yasuma@miraclelinux.com>
Message-ID: <Pine.GSO.4.21.0201070400230.4370-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jan 2002, Yasuma Takeda wrote:

> 
> Hi,
> 
> I found a problem to unix domain socket.
> 
> The unix_gc function removes socket buffers of the socket
> which is connectted but not acceptted yet.
> 
> After one process executes "Mark phase" of unix_gc function,
> another process registers socket buffer by using sendmsg with SCM_RIGHTS.
> At the next moment, the socket buffer is removed.
> 
> I attached the test program.
> When I execute one server and two clients on SMP machine
> (kernel 2.4.16 and PentiumIII x 2), I can reporduce this problem.
> 
> Following is a patch to avoid this problem.

It looks bogus.  Are you sure that listening socket is not garbage at that
point in your testcase?

Your patch is definitely wrong - consider the case when we send fd1 to
ourselves (fd2 would be receiving end), then send fd2 (fd3 would be
receiving end), then close fd3.  We want _both_ packets (carrying fd1
and fd2 resp.) to be taken out of queues in that loop.  So added check
is broken.

We scan the queues of listening sockets, all right, but only if listening
socket itself becomes a garbage.  I.e. only if connection is never going
to be accepted...

