Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269968AbSISGFC>; Thu, 19 Sep 2002 02:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269969AbSISGFC>; Thu, 19 Sep 2002 02:05:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269968AbSISGFB>; Thu, 19 Sep 2002 02:05:01 -0400
Date: Wed, 18 Sep 2002 23:10:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209190344280.3935-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209182304040.4563-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Sep 2002, Ingo Molnar wrote:
> 
> the attached patch is a significantly cleaned up version of the generic
> pidhash patch, against BK-curr.

Hmm.. I think I like it. One big improvement is just the renaming of
"struct idtag" to "struct pid", which makes it look a lot less abstract to
me. Maybe that's just me.

However:

>  	read_lock(&tasklist_lock);
> - 	for_each_process(p) {
> -		if ((tty->session > 0) && (p->session == tty->session) &&
> -		    p->leader) {
> -			send_sig(SIGHUP,p,1);
> -			send_sig(SIGCONT,p,1);
> +	if (tty->session > 0)
> +		for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid) {
> +			if (p->tty == tty)
> +				p->tty = NULL;
> +			if (!p->leader)
> +				continue;
> +			send_sig(SIGHUP, p, 1);
> +			send_sig(SIGCONT, p, 1);
>  			if (tty->pgrp > 0)
>  				p->tty_old_pgrp = tty->pgrp;
>  		}
> -		if (p->tty == tty)
> -			p->tty = NULL;
> -	}

This looks a bit wrong. In particular, the old code used to set "p->tty" 
to NULL if it matched any process, while the new code only does that for 
processes in the right session. Hmm?

Can you double-check some of these things?

		Linus

