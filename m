Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWH1MsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWH1MsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWH1MsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:48:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:8321 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750713AbWH1MsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:48:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=gLWfV7ItrndqViFX4cCc3GQiz/ni+EpF9zwTvjDwksFijD70Vz8aJnoNF6LZeYO3C4cljpuFwnXjZo4q8pmh7QjRHYWFRk8c3JoW0m3fjDACR60wsAu8wSrl3Th5ID/q1uFkJ5CwbS4aKjGPvcO88T41qP0iXodoArIfCC+O0p4=
Message-ID: <39e6f6c70608280548p5ba363d7o18cfd3bdb2f9e894@mail.gmail.com>
Date: Mon, 28 Aug 2006 09:48:16 -0300
From: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
To: "gerrit@erg.abdn.ac.uk" <gerrit@erg.abdn.ac.uk>
Subject: Re: [RFC][PATCH 0/3] net: a lighter UDP-Lite (RFC 3828)
Cc: davem@davemloft.net, jmorris@namei.org, alan@lxorguk.ukuu.org.uk,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, kaber@coreworks.de,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608281159.21583@strip-the-willow>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608231150.37895@strip-the-willow>
	 <200608281159.21583@strip-the-willow>
X-Google-Sender-Auth: 40b7a59a7b2549a6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, gerrit@erg.abdn.ac.uk <gerrit@erg.abdn.ac.uk> wrote:
> [NET/IPv4]: update for udp.c only, to match 2.6.18-rc4-mm3
>
> This is an update only, as the previous patch can not cope
> with recent changes to udp.c (all other files remain the same).
>
> Up-to-date, complete patches can always be taken from
> http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/files/udplite_linux.tar.gz
>
> Signed-off-by: Gerrit Renker <gerrit@erg.abdn.ac.uk>
> ---
>   udp.c |  606 ++++++++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 410 insertions(+), 196 deletions(-)
>
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 514c1e9..4ddd8e6 100644


> @@ -731,12 +801,12 @@ out:
>  }
>
>  /*
> - *     IOCTL requests applicable to the UDP protocol
> + *     IOCTL requests applicable to the UDP(-Lite) protocol
>   */

Avoid these changes to reduce patch file size, please

> -
> +
>  int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
>  {
> -       switch(cmd)
> +       switch(cmd)

Ditto


> -/*
> - *     This should be easy, if there is something there we
> - *     return it, otherwise we block.
> +/**
> + *     udp_recvmsg  -  generic UDP/-Lite receive processing
> + *
> + *     This routine is udplite-aware and works for both protocols.


> @@ -980,7 +1055,11 @@ #else
>  #endif
>  }
>
> -/* returns:
> +/**
> + *     udp_queue_rcv_skb  -  receive queue processing
> + *
> + * This routine is udplite-aware and works on both sockets.

>
>         if (up->encap_type) {
> @@ -1010,7 +1087,7 @@ static int udp_queue_rcv_skb(struct sock
>                  * If it's an encapsulateed packet, then pass it to the
>                  * IPsec xfrm input and return the response
>                  * appropriately.  Otherwise, just fall through and
> -                * pass this up the UDP socket.
> +                * pass this up the UDP/-Lite socket.
>                  */

> -               /* FALLTHROUGH -- it's a UDP Packet */
> +               /* FALLTHROUGH -- it's a UDP/-Lite Packet */
>         }

>
>  /*
> - *     All we need to do is get the socket, and then do a checksum.
> + *     All we need to do is get the socket, and then do a checksum.
>   */
> -

Huh, what was this one? trailing whitespace? Can you leave this for
another cset doing just the reformatting?

> @@ -1219,7 +1363,7 @@ static int udp_destroy_sock(struct sock
>  }
>
>  /*
> - *     Socket option code for UDP
> + *     Socket option code for UDP and UDP-Lite (shared).
>   */

>  #endif
> +
>  /**
> - *     udp_poll - wait for a UDP event.
> + *     udp_poll  -  wait for a UDP(-Lite) event.

See next comment

>   *     @file - file struct
>   *     @sock - socket
>   *     @wait - poll table
> @@ -1348,11 +1528,14 @@ #endif
>   *     then it could get return from select indicating data available
>   *     but then block when reading it. Add special case code
>   *     to work around these arguably broken applications.
> + *
> + *     The routine is udplite-aware and works for both protocols.

I guess these comments can go as well, as one can quickly realise the
functions handles UDP lite with all the "IS_UDPLITE(sk)" calls and
"is_{udp}lite" variables :-)

>   */
>  unsigned int udp_poll(struct file *file, struct socket *sock, poll_table *wait)
>  {
>         unsigned int mask = datagram_poll(file, sock, wait);
>         struct sock *sk = sock->sk;
> +       int     is_lite = IS_UDPLITE(sk);

Regards,

- Arnaldo
