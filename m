Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSIBEAy>; Mon, 2 Sep 2002 00:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSIBEAy>; Mon, 2 Sep 2002 00:00:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29202 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318219AbSIBEAx>; Mon, 2 Sep 2002 00:00:53 -0400
Date: Sun, 1 Sep 2002 21:13:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, <linux-raid@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <15730.42533.481161.627180@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0209012110490.1516-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Sep 2002, Neil Brown wrote:
> 
> I'm actually a little disappointed by this change.  I was hoping that
> the ->queue might get changed to be passed a 'struct block_device *'
> instead of a 'kdev_t' so that the device driver would only have to
> interpret the device number in one place: the open.  But now that
> ->queue is called before ->open, that wouldn't help.

We may still do this. 

Right now the _only_ reason to call ->queue before open() is that open() 
is also doing things like disk change checking, which reasonably needs the 
queue because it can need to do IO in order to check the disk change 
status. The floppy in fact did exactly this.

HOWEVER, that disk change checking really should be done by the generic
layers, and it should be done after the open() anyway (and not by the
open), and I think Al is actually working on this. That will allow us to 
be a bit more flexible about the ordering.

		Linus

