Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317927AbSGKWbW>; Thu, 11 Jul 2002 18:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317928AbSGKWbV>; Thu, 11 Jul 2002 18:31:21 -0400
Received: from ns.suse.de ([213.95.15.193]:45576 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317927AbSGKWbS>;
	Thu, 11 Jul 2002 18:31:18 -0400
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
References: <200207112135.OAA03801@csl.Stanford.EDU.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Jul 2002 00:34:04 +0200
In-Reply-To: Dawson Engler's message of "11 Jul 2002 23:39:35 +0200"
Message-ID: <p73r8i9vqqr.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.Stanford.EDU> writes:

> [BUG]  recheck: seems unlikely, though it does seem that the path is valid.
> /u2/engler/mc/oses/linux/2.5.8/net/ipv6/tcp_ipv6.c:206:tcp_v6_get_port: ERROR:A_B:112:206:Did not reverse 'spin_lock' [COUNTER=spin_lock:112] [fit=3] [fit_fn=11] [fn_ex=2] [fn_counter=1] [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z = -2.25170500701057]
> 		rover = tcp_port_rover;
> 		do {	rover++;
> 			if ((rover < low) || (rover > high))
> 				rover = low;
> 			head = &tcp_bhash[tcp_bhashfn(rover)];
> Start --->
> 			spin_lock(&head->lock);
> 

           } while (--remaining > 0);
                tcp_port_rover = rover;
                spin_unlock(&tcp_portalloc_lock);

                /* Exhausted local port range during search? */
                ret = 1;
                if (remaining <= 0)
                        goto fail;


the goto can only hit when the lock hasn't been taken, so not unlocking it
is correct. It just rechecks the loop end condition, but your tool probably
doesn't know that. The wonders of structured programming :-)


-Andi
