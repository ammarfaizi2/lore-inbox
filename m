Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSCUGtt>; Thu, 21 Mar 2002 01:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293453AbSCUGtk>; Thu, 21 Mar 2002 01:49:40 -0500
Received: from gw.sp.op.dlr.de ([129.247.188.16]:2191 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S293457AbSCUGt1>;
	Thu, 21 Mar 2002 01:49:27 -0500
Message-ID: <3C99824B.2040307@dlr.de>
Date: Thu, 21 Mar 2002 07:48:43 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
Reply-To: Martin.Wirth@dlr.de
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.4) Gecko/20011206 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ulrich Drepper <drepper@redhat.com>, pwaechtler@loewe-komp.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16nZqJ-0004mi-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:


>2) Where this is suboptimal,

Up to know I was too focused on the wait functions, but there is
also a problem with cond_broadcast (and the mutex-protected version of 
cond_signal): since they may block (on ack or lock) this opens up 
chances for priority inversion like problems. I think to be really 
usefull cond_broacast and cond_signal should have a non-blocking 
behaviour with predictible runtime.

Just to convince you that this is a real world problem here is a 
description of one of my data-aquisition programs:

A 'producer' thread waits for the trigger of a transient recorder at 500 
Hz IRQ-rate, reads out 64k on each event into a large circular buffer,
calls cond_broadcast (every 5th IRQ) without holding a mutex and goes to 
sleep to wait for the next IRQ. (This thread is SCHED_FIFO)

Then there are three (SCHED_OTHER) 'consumer' threads which work on the 
same data doing different things of different importance (group them 
according to some hardware parameter and store them into different 
files, calculate averaged powerspectra, select pieces for an online 
scope-like display etc.)

If in this scenario the producer would have to wait in cond_broadcast 
until the least prio consumer has acknowledged (which may take a timer 
tick or longer) he would lose several IRQs each time.

So for my applications a cond_broadcast blocking for the waiters is 
simply not acceptable.

Martin

