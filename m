Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132957AbRANSp5>; Sun, 14 Jan 2001 13:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133013AbRANSpr>; Sun, 14 Jan 2001 13:45:47 -0500
Received: from pat.uio.no ([129.240.130.16]:23004 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S132957AbRANSpi>;
	Sun, 14 Jan 2001 13:45:38 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS devel <nfs-devel@linux.kernel.org>
Subject: Re: Spinlocking patch for in xprt.c
In-Reply-To: <14942.64595.157544.350302@charged.uio.no> <14944.57417.917410.380225@pizda.ninka.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 14 Jan 2001 19:45:20 +0100
In-Reply-To: "David S. Miller"'s message of "Sat, 13 Jan 2001 15:10:01 -0800 (PST)"
Message-ID: <shs1yu60y7z.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David S Miller <davem@redhat.com> writes:

     > Trond, did you actually look at how this code works before you
     > made modifications to my fixes?

     > xprt_lock serializes sleep/wakeup sequences in the xprt code,
     > so you cannot remove xprt_lock from the sections where I added
     > holding of xprt_sock_lock to protect the state of
     > xprt->snd_task.  So for example, this part of your patch is
     > completely bogus and will create new corruptions and crashes:

IIRC xprt_lock is there for 2 purposes:

  - serialize access to the TCP connect code
  - gate access to the *socket* via the xprt_(up|down)_transmit() (and
    hence setting xprt->snd_task which is a pointer to the task that
    currently is allowed to access the socket.)

Those 2 tasks are completely orthogonal to one another, so we should
be quite free to drop xprt_lock in the second case.

I can see no other places where we're using xprt_lock to protect a
sleep/wakeup of xprt->snd_task unless you're introducing it? If so for
what purpose?

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
