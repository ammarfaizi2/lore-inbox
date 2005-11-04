Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVKDXSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVKDXSx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVKDXSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:18:53 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:22988 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751019AbVKDXSw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:18:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FGeanZWbpf8bQCJ8U29OFfX6eZjpev63u9EIjuwc/onJERlNQPAkgbKX8Z1/qFMgpHja72xANI61pcFxJwL7CjmhOIoe2jKoqN+oC5piguOIZSkgg4lJOC1LDWi4BnLp9JXfqlQ8EKDDnU94dEzKelD+Ny4b+J+Fe3QV/JGw8Rs=
Message-ID: <29495f1d0511041518t3cd22b4eq29b32b8545df969f@mail.gmail.com>
Date: Fri, 4 Nov 2005 15:18:51 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: negative timeout can be set up by setsockopt system call
Cc: Ram Gupta <ram.gupta5@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0511041658240.13855@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436BC42B.1050804@gmail.com>
	 <Pine.LNX.4.61.0511041658240.13855@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Fri, 4 Nov 2005, Ram Gupta wrote:
>
> > I observed that the the setsockopt system call can  setup negative
> > timeout. As a matter of fact the function sock_set_timeout checks for
> > zero timeout but does not check for negative timeouts. I tested this
> > against 2.6.14  kernel but it is so in all previous release also. So I
> > am wondering if it is a bug or there is some reason for keeping it that
> > way which I am missing.
> >
> > Regards
> > Ram gupta
>
> As a parameter it takes a void pointer to the value plus a
> length of the object to which the value points. Given this,
> I don't understand "negative". The pointer can point to
> anything of a specified size so it doesn't have a sense
> of +/-.

Huh?

In Ram's specific case, I think, the call path is sys_setsockopt() ->
sock_setsockopt() -> sock_set_timeout, which has a definition of:

static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)

where optval is the same optval in sys_setsockopt():

sys_setsockopt(int fd, int level, int optname, char __user *optval, int optlen)

and is a pointer to a userspace timeval structure, in this case.
timeval's have two members, both of which are signed, so it makes
perfect sense for one of them to be (potentially) negative:

struct timeval {
        time_t          tv_sec;         /* seconds */
        suseconds_t     tv_usec;        /* microseconds */
};

(time_t --> __kernel_time_t --> long on all archs; suseconds_t -->
__kernel_suseconds_t --> int or long on all archs)

Ram, what is the expected behavior of negative values in the timeval?
And what are you seeing happen right now?

As of 2.6.14, looks like we convert any non-zero values into jiffies
and store them in sk->sk_{rcv,snd}timeo...

> If the socket call itself checked for sign it would
> severly limit what options could be adjusted. Perhaps
> the SO_SNDTIMEO/SO_RCVTIMEO might do some checking, but
> I think it's valid to set the timeout to -1, meaning it
> never times-out.

This could be, and I think is what Ram was asking about -- I've asked
for some clarification.

Thanks,
Nish
