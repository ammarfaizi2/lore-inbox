Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSIIBbm>; Sun, 8 Sep 2002 21:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSIIBbm>; Sun, 8 Sep 2002 21:31:42 -0400
Received: from [63.209.4.196] ([63.209.4.196]:52750 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315942AbSIIBbl>; Sun, 8 Sep 2002 21:31:41 -0400
Date: Sun, 8 Sep 2002 18:36:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Altaparmakov <aia21@cantab.net>
cc: mingo@elte.hu, <linux-kernel@vger.kernel.org>
Subject: Re: pinpointed: PANIC caused by dequeue_signal() in current Linus 
 BK tree
In-Reply-To: <5.1.0.14.2.20020909001700.03fdee00@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0209081835260.1401-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Anton Altaparmakov wrote:

> Hi,
> 
> I had a look and the panic actually happens in collect_signal() in here:
> 
> static inline int collect_signal(int sig, struct sigpending *list, 
> siginfo_t *info)
> {
>          if (sigismember(&list->signal, sig)) {
>                  /* Collect the siginfo appropriate to this signal.  */
>                  struct sigqueue *q, **pp;
>                  pp = &list->head;
>                  while ((q = *pp) != NULL) {
> q becomes 0x5a5a5a5a  ^^^^^^^^^
>                          if (q->info.si_signo == sig)
> 0x5a5a5a5a is dereferenced ^^^^^^^^^^^^^^^^
>                                  goto found_it;
>                          pp = &q->next;
>                  }
> 
> Hope this helps.

0x5a5a5a5a is the slab poisoning byte, I bet somebody free's the thing, 
and Ingo and I never noticed because we didn't have slab debugging 
enabled.

Ingo, mind looking at this a bit?

		Linus

