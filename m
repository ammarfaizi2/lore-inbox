Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270730AbRHPEUp>; Thu, 16 Aug 2001 00:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270731AbRHPEUg>; Thu, 16 Aug 2001 00:20:36 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:34055 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S270730AbRHPEUX>; Thu, 16 Aug 2001 00:20:23 -0400
Date: Wed, 15 Aug 2001 21:20:36 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Eric Lammerts <eric@lammerts.org>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer killing all threads
In-Reply-To: <Pine.LNX.4.33.0108132151110.31526-100000@ally.lammerts.org>
Message-ID: <Pine.LNX.4.33.0108152114520.13614-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Eric Lammerts wrote:

>
> Hello,
> I recently had the following problem: Roxen (a webserver that uses
> threads) was running out of control, eating up more and more memory.
> (btw, I'd rather run Apache but it's not my decision to make).
>
> The oom killer kicked in and started killing roxen processes.
> Apparently it didn't succeed in killing _all_ threads. So it didn't
> help at all, and the machine had to be rebooted.

this would be a bug in roxen.  for the corresponding code in apache, and
our attempt to be robust in the face of such activity take a look at the
sleep(10) in make_child().  basically apache limits how much it will spawn
each second, and if it gets any fork error the parent will cease all
activity for 10 seconds.  roxen needs code to limit its own damage, i
don't see why the kernel should do it...

> Wouldn't it be a good idea to kill all processes that have the same
> ->mm as the process that was selected to be killed? The patch below
> implements it. I've tested it and it seems to work nicely.

i think it's a good idea but not for the reason you give... it's a good
idea because a multithreaded process using userland mutexes will have an
unpredictable number of locked mutexes in each thread -- and killing a
thread could result in hangs in the remaining threads as they wait for
mutexes which will never be freed.  (threads are kind of evil ;)

hey -- is there a way to know when a task was OOM killed as opposed to
other forms of death?

-dean

