Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269949AbUJNCOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269949AbUJNCOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 22:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269948AbUJNCOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 22:14:41 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:59400 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269950AbUJNCNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 22:13:01 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: stsp@aknet.ru (Stas Sergeev)
Subject: Re: [patch] allow write() on SOCK_PACKET sockets
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Organization: Core
In-Reply-To: <416B5085.6070907@aknet.ru>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CHv6u-0001EU-00@gondolin.me.apana.org.au>
Date: Thu, 14 Oct 2004 12:12:56 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> I claim that SOCK_RAW allows write() after bind()
> because a few days ago I changed dosemu code
> to use SOCK_RAW instead of SOCK_PACKET and write()

Well I just checked net/ipv4/raw.c and it's pretty clear that it does

		err = -EDESTADDRREQ;
		if (sk->sk_state != TCP_ESTABLISHED)
			goto out;

So you need to connect before you can write.  I'm intrigued that
you can write before connecting on a raw socket.  Could you please
write up a minimal program that I can play with?

> SOCK_PACKET. And btw, I can use read() quite
> happily even with SOCK_PACKET, so why not
> write()...

Well read() is different.  It returns all packets received on
the socket, regardless of where they came from.  So for a
connectionless socket it makes perfect sense to read() before
you've called connect().

OTOH, write() and send() needs to know where the message is going
to.  That's exactly what connect() provides.  So it makes no sense
to write()/send() before you've called connect().

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
