Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310400AbSCLEvt>; Mon, 11 Mar 2002 23:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310392AbSCLEvn>; Mon, 11 Mar 2002 23:51:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28936 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310400AbSCLEva>; Mon, 11 Mar 2002 23:51:30 -0500
Date: Mon, 11 Mar 2002 20:40:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D8376.8010907@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203112031460.18739-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Mar 2002, Jeff Garzik wrote:
> 
> For the details of the userspace interface (for both ATA and SCSI), my 
> idea was to use standard read(2) and write(2).

I like it, but you have to realize that most, if not all, of the commands 
really are not a matter of a read or a write, but a "transaction", which 
is a pair of both (and at least in theory you could have transactions that 
are more complex than just a "command + result", ie more than just a 
write("cmd + outdata")+read("status + indata")).

I agree 100% with the notion of using read/write to do this, but I think
you need to make it very explicit that we _are_ talking about
transactions, and that the file descriptor would act as a "transaction
descriptor" when you do this. The file descriptor is the one that matches
up the write that started the transaction with the read that gets the
status of it - thus allowing multiple concurrent transactions in flight.

And the command has to have some structure, ie it needs to not just be the
low-level command, but also have the information about the "format" of the
transaction (so that the generic layer can build up the correct BIO data
structures for the result, before it actually sees the read itself).

			Linus

