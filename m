Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSEMBCf>; Sun, 12 May 2002 21:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSEMBCe>; Sun, 12 May 2002 21:02:34 -0400
Received: from loisexc2.loislaw.com ([12.5.234.240]:34059 "EHLO
	loisexc2.loislaw.com") by vger.kernel.org with ESMTP
	id <S315170AbSEMBCd>; Sun, 12 May 2002 21:02:33 -0400
Message-ID: <4188788C3E1BD411AA60009027E92DFD0962E251@loisexc2.loislaw.com>
From: "Rose, Billy" <wrose@loislaw.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Segfault hidden in list.h
Date: Sun, 12 May 2002 20:02:30 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not hitting it, but I came across it while writing an application server
based on TUX 2.1.0. I noticed that Ingo didn't lock a list during reads. As
long as his code traverses forward (which it does) all is well. If, however,
some module writer out there fails to lock a list for reads and traverses
said list in reverse, a failure could result. 

By logic design this assignment ordering eliminates the need for a read
lock, hence improving performance, not just data integrity.

Billy Rose 
wrose@loislaw.com

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> Sent: Sunday, May 12, 2002 7:45 PM
> To: Rose, Billy
> Subject: Re: Segfault hidden in list.h
> 
> 
> Rose, Billy wrote:
> 
> >The code inside of __list_add:
> >
> >next->prev = new;
> >new->next = next;
> >new->prev = prev;
> >pre-next = new;
> >
> >needs to be altered to:
> >
> >new->prev = prev;
> >new->next = next;
> >next->prev = new;
> >prev->next = new;
> >
> >If something is accessing the list in reverse at the time of 
> insertion and
> >"next->prev = new;" has been executed, there exists a moment 
> when new->prev
> >may contain garbage if the element had been used in another 
> list and is
> >being transposed into a new one. Even if garbage is not 
> present, and the
> >element had just been initialized (i.e. new->prev = new), a 
> false list head
> >will appear briefly (from the executing thread's point of view).
> >
> 
> It sounds like you need better locking, if you are hitting this...
> 
> 
