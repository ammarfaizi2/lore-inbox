Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135594AbRARUpp>; Thu, 18 Jan 2001 15:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135567AbRARUpf>; Thu, 18 Jan 2001 15:45:35 -0500
Received: from chiara.elte.hu ([157.181.150.200]:34067 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135529AbRARUpZ>;
	Thu, 18 Jan 2001 15:45:25 -0500
Date: Thu, 18 Jan 2001 21:44:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <20010118212441.E28276@athlon.random>
Message-ID: <Pine.LNX.4.30.0101182135180.2034-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001, Andrea Arcangeli wrote:

> Agreed. However since TCP_CORK logic is more generic than MSG_MORE
> [...]

why? TCP_CORK is equivalent to MSG_MORE, it's just a different
representation of the same issue. TCP_CORK needs an extra syscall (in the
case of a push event - which might be rare), the MSG_MORE solution needs
an extra flag (which is merged with other flags in the send() case).

> > i believe it should rather be a new setsockopt TCP_CORK value (or a new
> > setsockopt constant), not an ioctl. Eg. a value of 2 to TCP_CORK could
> > mean 'force packet boundary now if possible, and dont touch TCP_CORK
> > state'.
>

> Doing PUSH from setsockopt(TCP_CORK) looked obviously wrong because it
> isn't setting any socket state, [...]

well, neither is clearing/setting TCP_CORK ...

> and also because the SIOCPUSH has nothing specific with TCP_CORK, as
> said it can be useful also to flush the last fragment of data pending
> in the send queue without having to wait all the unacknowledged data
> to be acknowledged from the receiver when TCP_NODELAY isn't set.

huh? in what way does the following:

{
        int val = 1;
        setsockopt(req->sock, IPPROTO_TCP, TCP_CORK,
			(char *)&val,sizeof(val));
        val = 0;
        setsockopt(req->sock, IPPROTO_TCP, TCP_CORK,
			(char *)&val,sizeof(val));
}

differ from what you posted. It does the same in my opinion. Maybe we are
not talking about the same thing?

> Changing the semantics of setsockopt(TCP_CORK, 2) would also break
> backwards compatibility with all 2.[24].x kernels out there.

[this is nitpicking. I'm quite sure all the code uses '1' as the value,
not 2.]

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
