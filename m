Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSG2GyW>; Mon, 29 Jul 2002 02:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318069AbSG2GyW>; Mon, 29 Jul 2002 02:54:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33546 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318058AbSG2GyV>; Mon, 29 Jul 2002 02:54:21 -0400
Date: Sun, 28 Jul 2002 23:58:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Marcin Dalecki <dalecki@evision.ag>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
In-Reply-To: <20020729083409.D4445@suse.de>
Message-ID: <Pine.LNX.4.44.0207282352030.10092-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jul 2002, Jens Axboe wrote:
>
> I think Martin's was wrong in concept, mine was wrong in implementation.

I don't understand why you think the concept is wrong. Right now all users
clearly do want to free the tag on re-issue, and doing so clearly cleans
up the code and avoids duplication.

So I still don't see the advantage of your patch, even once you've fixed
the locking issue.

HOWEVER, if you really think that some future users might not want to have
the tag played with, how about making the "at_head" thing a flags field,
and letting people say so by having "INSERT_NOTAG" (and making the
existing bit be INSERT_ATHEAD).

So then the SCSI users would look like

	blk_insert_request(q, SRpnt->sr_request,
		at_head ? INSERT_ATHEAD : 0,
		SRpnt)

while your future non-tag user might do

	blk_insert_request(q, newreq,
		INSERT_ATHEAD | INSERT_NOTAG,
		channel);

_without_ having that unnecessary code duplication.

			Linus

