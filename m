Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRDTXzg>; Fri, 20 Apr 2001 19:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDTXz1>; Fri, 20 Apr 2001 19:55:27 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:23815 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132226AbRDTXx6>; Fri, 20 Apr 2001 19:53:58 -0400
Date: Sat, 21 Apr 2001 01:53:42 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Dennis <dennis@etinc.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: SMP in 2.4
In-Reply-To: <5.0.2.1.0.20010418182619.0364e1d0@mail.etinc.com>
Message-ID: <Pine.LNX.3.96.1010421013436.8002A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was referring to the infamous CLI/STI combinations that are more 
> analogous to spinlocks than anything you are talking about. spl levels are 
> clean and transparent and have been doing a very nice job in  helping to 
> avoid race conditions in real unix systems for quite some time now.

It has nothing to do with smp ;)

spl levels are actually faster, because hardware interrupt locking
routines are poorly optimized in processors.

I looked at P-6 instruction timing table and found:

PUSHF	16 upos
POPF	17 uops
CLI	9 uops
STI	17 uops

I think soft interrupt locks like this would be better (at least on i386):

cli:
	movb $0, intr_lock

sti:
	movb $1, intr_lock
	testb $1, intr_pending
	jnz somewhere_away_to_handle_defered_interrupt

save_flags:
	movb intr_lock, %al

restore_flags:
	movb %al, intr_lock
	testb %al, intr_pending
	jnz somewhere_away_to_handle_defered_interrupt

And - of course - interrupt checks intr_lock in its entry and if it is
zero, sets intr_pending and exits immediatelly.

Mikulas

