Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317119AbSFKOzP>; Tue, 11 Jun 2002 10:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSFKOzO>; Tue, 11 Jun 2002 10:55:14 -0400
Received: from adsl-161-92.barak.net.il ([62.90.161.92]:16907 "EHLO
	qlusters.com") by vger.kernel.org with ESMTP id <S317119AbSFKOyV>;
	Tue, 11 Jun 2002 10:54:21 -0400
Subject: Re: What dose 'general protection fault: 0000' mean?
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Wang Hui <whui@mail.ustc.edu.cn>
Cc: ganda utama <gndutm@netscape.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.31L2A.0206111533530.27147-100000@mail>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 Jun 2002 17:40:09 +0300
Message-Id: <1023806415.8140.46.camel@sake>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 10:46, Wang Hui wrote:


> As you mentioned in your mail, you suggested me to make a Netfilter module
> to realize what I want.  In fact, it is really a good choice.  But as to
> my case, I have to modify the outgoing IP packet header.  And after the
> modification, the outgoing IP packet's header will become a none-IP
> header( as defined in RFC 3095).  So I dont know if this kind of
> modified packet could still traverse the netfilter chains?  Will the
> kernel drop this 'strange header' packet (for the kernel cannot
> understand this kind of none-IP header)?  Or say, where should I put my
> modification module in the netfilter chain as to avoid this dropping??

I understand completly the problem of not being able to *continue*
traversing the netfilter path because of the sk_buff no longer
containing a valid IP packet. 

My suggestion is to use the netfilter (or even better iptables) system
to 'harvest' the packets, modify them and then do whatever needs to be
done to transmit them. 

AFAIK RFC3095 has several modes of operations and only with some of them
the end result is a non IP packet where in the others the it is an
encapsulating IP packet. When you harvest the packet using
netfilter/iptables you can re-inject those packets to the stack if it is
apropriate (the end result in an IP packet) or directly to the transmit
queue of the device (when it isn't).

Aoother advantage of my suggestion is that you don't need to *alter* the
dev struct, so you don't need to worry about the race and other
conditions that are involved with such a thing. 

It'll also enable you do neat tricks like use RFC3095 only for a
specific stream while leaving all the rest intact. Whether this actually
makes sense or not I don't know.

> To clearify my problem, I would like to draw a small picture here:
> [kernel ipv6 packet output] --> [My Module: modify the IP header to be a
> nono-IP header] --> [ put it to the device output queue to sent out]

To clarify my suggestion, I'm thinking of:

[ IP stack ] -> [Netfilter/iptables hook ] -> [Your module] if IP packet
-> [ IP stack] else -> [ device xmit queue ]

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Code mangler, senior coffee drinker and VP SIGSEGV
Qlusters ltd.

"A billion flies _can_ be wrong - I'd rather eat lamb chops than shit."
	-- Linus Torvalds on lkml




