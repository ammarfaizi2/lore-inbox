Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262910AbSJGHzZ>; Mon, 7 Oct 2002 03:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSJGHzZ>; Mon, 7 Oct 2002 03:55:25 -0400
Received: from catv-d5de80ec.bp11catv.broadband.hu ([213.222.128.236]:6410
	"EHLO balabit.hu") by vger.kernel.org with ESMTP id <S262910AbSJGHzY>;
	Mon, 7 Oct 2002 03:55:24 -0400
Date: Mon, 7 Oct 2002 10:01:01 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unix domain sockets bugfix
Message-ID: <20021007080101.GC15952@balabit.hu>
References: <20021007073532.GA15799@balabit.hu> <20021007.004800.82100313.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20021007.004800.82100313.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 12:48:00AM -0700, David S. Miller wrote:
>    From: Balazs Scheidler <bazsi@balabit.hu>
>    Date: Mon, 7 Oct 2002 09:35:32 +0200
>    
>    The returned socklen is 2, but the sockaddr.family is not touched. A fix is
>    below:
> 
> Since msg->msg_namelen is zero, msg->msg_name should not be
> interpreted in any way at all.

You would be right, if it would be zero, but it isn't:

373			res = recvfrom(closure->fd, buffer, length, 0, (struct sockaddr *) addr, (socklen_t *) addrlen);
(gdb) n
375			if (*addrlen == 2) {
(gdb) p *addrlen
$2 = 2

Checking out the code again:

static void unix_copy_addr(struct msghdr *msg, struct sock *sk)
{
        msg->msg_namelen = sizeof(short);
        if (sk->protinfo.af_unix.addr) {
                msg->msg_namelen=sk->protinfo.af_unix.addr->len;
                memcpy(msg->msg_name,
                       sk->protinfo.af_unix.addr->name,
                       sk->protinfo.af_unix.addr->len);
        }
}

namelen is explicitly set to sizeof(short) == 2.

This is 2.4.18

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1
