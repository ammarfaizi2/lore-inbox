Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289749AbSA2Qc6>; Tue, 29 Jan 2002 11:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289756AbSA2Qcm>; Tue, 29 Jan 2002 11:32:42 -0500
Received: from zarjazz.demon.co.uk ([194.222.135.25]:49536 "EHLO
	zarjazz.demon.co.uk") by vger.kernel.org with ESMTP
	id <S289749AbSA2Qc1>; Tue, 29 Jan 2002 11:32:27 -0500
Message-ID: <006f01c1a8e2$83734750$0201010a@frodo>
From: "Vincent Sweeney" <v.sweeney@barrysworld.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Rik van Riel" <riel@conectiva.com.br>,
        "Andrew Morton" <akpm@zip.com.au>
In-Reply-To: <Pine.LNX.4.33L.0201281739190.32617-100000@imladris.surriel.com>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
Date: Tue, 29 Jan 2002 16:32:15 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Rik van Riel" <riel@conectiva.com.br>
To: "Vincent Sweeney" <v.sweeney@barrysworld.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
Sent: Monday, January 28, 2002 7:40 PM
Subject: Re: PROBLEM: high system usage / poor SMP network performance


> On Mon, 28 Jan 2002, Vincent Sweeney wrote:
>
> > > >     CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
> > > >     CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle
> > >
> > > The important bit here is     ^^^^^^^^ that one. Something is causing
> > > horrendous lock contention it appears.
> >
> > I've switched a server over to the default eepro100 driver as supplied
> > in 2.4.17 (compiled as a module). This is tonights snapshot with about
> > 10% higher user count than above (2200 connections per ircd)
>
> Hummm ... poll() / select() ?  ;)
>
> > I will try the profiling tomorrow
>
> readprofile | sort -n | tail -20
>
> kind regards,
>
> Rik

Right then, here is the results from today so far (snapshot taken with 2000
users per ircd). Kernel profiling enabled with the eepro100 driver compiled
statically.

---
> readprofile -r ; sleep 60; readprofile | sort -n | tail -30

    11 tcp_rcv_established                        0.0055
    12 do_softirq                                 0.0536
    12 nf_hook_slow                               0.0291
    13 __free_pages_ok                            0.0256
    13 kmalloc                                    0.0378
    13 rmqueue                                    0.0301
    13 tcp_ack                                    0.0159
    14 __kfree_skb                                0.0455
    14 tcp_v4_rcv                                 0.0084
    15 __ip_conntrack_find                        0.0441
    16 handle_IRQ_event                           0.1290
    16 tcp_packet                                 0.0351
    17 speedo_rx                                  0.0227
    17 speedo_start_xmit                          0.0346
    18 ip_route_input                             0.0484
    23 speedo_interrupt                           0.0301
    30 ipt_do_table                               0.0284
    30 tcp_sendmsg                                0.0065
   116 __pollwait                                 0.7838
   140 poll_freewait                              1.7500
   170 sys_poll                                   0.1897
   269 do_pollfd                                  1.4944
   462 remove_wait_queue                         12.8333
   474 add_wait_queue                             9.1154
   782 fput                                       3.3707
  1216 default_idle                              23.3846
  1334 fget                                      16.6750
  1347 sock_poll                                 33.6750
  2408 tcp_poll                                   6.9195
  9366 total                                      0.0094

> top

  4:30pm  up  2:57,  2 users,  load average: 0.76, 0.85, 0.82
36 processes: 33 sleeping, 3 running, 0 zombie, 0 stopped
CPU0 states: 21.4% user, 68.1% system,  0.0% nice,  9.3% idle
CPU1 states: 23.4% user, 67.1% system,  0.0% nice,  8.3% idle
Mem:   382916K av,  191276K used,  191640K free,       0K shrd,    1444K
buff
Swap:  379416K av,       0K used,  379416K free                   23188K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  613 ircd      16   0 67140  65M   660 R    89.6 17.5 102:00 ircd
  607 ircd      16   0 64868  63M   656 S    88.7 16.9  98:50 ircd

---

So with my little knowledge of what this means I would say this is purely
down to poll(), but surely even with 4000 connections to the box that
shouldn't stretch a dual P3-800 box as much as it does?

Vince.


