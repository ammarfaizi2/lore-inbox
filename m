Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSGLVty>; Fri, 12 Jul 2002 17:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318010AbSGLVtx>; Fri, 12 Jul 2002 17:49:53 -0400
Received: from fungus.teststation.com ([212.32.186.211]:27908 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S318009AbSGLVtw>; Fri, 12 Jul 2002 17:49:52 -0400
Date: Fri, 12 Jul 2002 23:52:15 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: linux-kernel@vger.kernel.org
Subject: [PATCH] smbfs - smbiod
Message-ID: <Pine.LNX.4.44.0207122236350.7728-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm about to send the following patch to Linus. 31k gzip'ed so the list
will have to manage with an URL:

http://www.hojdpunkten.ac.se/054/samba/queue/00-smbfs-2.5.25-async.patch.gz

It changes how smbfs builds its requests and touches a lot of smbfs code.
Most of it is just changing "server" for "req" ... but I don't know how to
split it into separate parts in a meaningful way.

I'll point out some things I think someone may react to, so that you know 
what to look for if you bother to download it:
- Adds a kernel thread (smbiod.c)
- Uses sock->user_data to store private data (these sockets should never
  reach the RPC layer so that should be ok, I think)
- Uses sleep_on because there is no wait_event_interruptible_timeout.
  (yet)


The old code uses one buffer per mount, for both send and receive. This
means that only one request can be active at the same time. Here the
different code paths allocate request's and buffers as needed and this in
turn allows the lock for the "server" struct to be held for shorter times.

Other benefits:
+ User processes can always be interrupted. A common problem with the old
  smbfs sock.c is that sometimes things will stop and wait for tcp or 
  something to timeout. A very common complaint.

+ Error reporting for the common case of "the server disconnected us" 
  should be improved. Hopefully reducing the number of user questions 
  regarding this event.

+ The queues for requests are much more fair when there are multiple
  simultaneous processes. iozone shows improved performance for multiple
  processes and no reduction for a single process.

+ The smbiod makes it easy to handle oplock breaks. More on why one would 
  want to do that in later patches.

+ The smaller server locking areas make it more interesting to look at 
  removing the BKL from smbfs.

/Urban

