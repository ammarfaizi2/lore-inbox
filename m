Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSGUQkA>; Sun, 21 Jul 2002 12:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSGUQkA>; Sun, 21 Jul 2002 12:40:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4104 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316258AbSGUQj7>; Sun, 21 Jul 2002 12:39:59 -0400
Date: Sun, 21 Jul 2002 09:43:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
In-Reply-To: <u1mug2ii.fsf@sap.com>
Message-ID: <Pine.LNX.4.44.0207210934180.3794-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Jul 2002, Christoph Rohland wrote:
>
> Yes, so everybody really using select assumes it's _at least_ X
> seconds... So where's the problem?

Have you tried to _do_ this? I doubt you have, since you think it works
well already.

The fact is, that if you're doing soft-realtime, you end up having to call
gettimeofday() a lot more than you should. Your timeouts are fundamentally
"real time" (ie they are _not_ of the type "I should show the next frame
in 0.0333 seconds" but they are really "I showed frame N at time X, so I
need to show frame N+1 at time X+0.0333").

The fact that select() and friends do not work with real time, but
offsets, and is not restartable means that you end up having to do two
gettimeofday() calls per select in these situations.

In contrast, if you could just rely on absolute time in select(), you
would be re-startable _and_ you'd not have to do the extra "what time is
it now, so that I know what timeout I need to use for the next thing"?

> Yes, and probably select is one of the calls you most of the time use
> because of portability. So IMHO a linuxism isn't worth the effort.

The fact is, the linuxism exists, and breaking it is worse than not
breaking it.

The number of users is probably small, but they do exist.

		Linus

