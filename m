Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269958AbUJNDnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbUJNDnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 23:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269956AbUJNDnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 23:43:24 -0400
Received: from mail.aknet.ru ([217.67.122.194]:11 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S269955AbUJNDnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 23:43:09 -0400
Message-ID: <416DF644.2070906@aknet.ru>
Date: Thu, 14 Oct 2004 07:45:08 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [patch] allow write() on SOCK_PACKET sockets
References: <E1CHv6u-0001EU-00@gondolin.me.apana.org.au>
In-Reply-To: <E1CHv6u-0001EU-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Herbert Xu wrote:
Stas Sergeev <stsp@aknet.ru> wrote:
>> I claim that SOCK_RAW allows write() after bind()
>> because a few days ago I changed dosemu code
>> to use SOCK_RAW instead of SOCK_PACKET and write()
> Well I just checked net/ipv4/raw.c and it's pretty clear that it does
I think you are looking at a wrong place.
You are looking into IP raw sockets code.
Packet sockets are really the different
layer. Please have a look into
net/packet/af_packet.c instead.

> So you need to connect before you can write.
Packet sockets, actually, do not even have
connect:
.connect = sock_no_connect

> I'm intrigued that
> you can write before connecting on a raw socket.
Not an IP raw socket, but the raw packet
socket. So yes, I can. And that looks very
natural to me, not a hack or something.

> Could you please
> write up a minimal program that I can play with?
I can but I am a bit surprised that dosemu
is not a sufficient test-case for *you* :)
But I don't seem to be able to send any
mail to you:

<herbert@gondor.apana.org.au>: host arnor.apana.org.au[203.14.152.115] said:
    550 mail from 217.67.122.194 rejected: administrative prohibition (in reply
    to RCPT TO command)

> Well read() is different.
Yes, not a good argument on my side, sorry.

> OTOH, write() and send() needs to know where the message is going
> to.
That's exactly where the packet sockets are
different. Here's the whole point. Have a
look into a "struct sockaddr_pkt":

              struct sockaddr_pkt
              {
                  unsigned short  spkt_family;
                  unsigned char   spkt_device[14];
                  unsigned short  spkt_protocol;
              };

Not too much about a destination here.
For the packet sockets you only need to
know via which eth device you want to send
it, and nothing more. And this is what I
specify to bind() anyway, so I dont want
to duplicate that info all the time.
You say it is counter-intuitive.
I'll agree with this only if you point me
another convinient way to bind to the
particular eth device and send/receive via
that device without always specifying its
name/number. That's what SOCK_RAW allows,
but not SOCK_PACKET.

My patch is probably dead anyway though.
SOCK_PACKET is mentioned to be deprecated
in man, so perhaps noone will apply any
patches on it... Just wanted to point out
that there is a bug/inconsistency in it.

