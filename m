Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTA1XsI>; Tue, 28 Jan 2003 18:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTA1XsH>; Tue, 28 Jan 2003 18:48:07 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:9379 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261907AbTA1XsH>;
	Tue, 28 Jan 2003 18:48:07 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301282356.CAA30301@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
To: davem@redhat.com (David S. Miller)
Date: Wed, 29 Jan 2003 02:56:41 +0300 (MSK)
Cc: benoit-lists@fb12.de, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
In-Reply-To: <20030128.123413.51821993.davem@redhat.com> from "David S. Miller" at Jan 28, 3 12:34:13 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey, most solid report is that 2.5.43-bk1 makes bug appear.
> This is good because it sort of narrows things down.

Now I do not think so. It looks like some old beast just got manifested.

It happens when 2 short consecutive segments are lost.
Funny thing happen when retransmitting.
First, I do not see collapsing, which must be succesfull in this case.
So, the first segment is retransmitted alone, but the second is never
retransmitted, tcp even prefers to retransmit the third one. Something
is already bad, queue is broken in an interesting way, the impression is
that... that... that tcp did collapsing, but "forgot" to modify skb length.

Hey! Interesting thing has just happened, it is the first time when I found
the bug formulating a senstence while writing e-mail not while peering
to code. :-)

Shheit, look into tcp_retrans_try_collapse():

                if (skb->ip_summed != CHECKSUM_HW) {
                        memcpy(skb_put(skb, next_skb_size), next_skb->data, nex$                        skb->csum = csum_block_add(skb->csum, next_skb->csum, s$                }
 

WHERE IS skb_put and copy when skb->ip_summed==CHECKSUM_HW??!!

So, the fix is move of memcpy() line out of if clause.

Alexey
