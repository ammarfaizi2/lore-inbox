Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135590AbREHXji>; Tue, 8 May 2001 19:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135593AbREHXja>; Tue, 8 May 2001 19:39:30 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44810 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135590AbREHXjW>; Tue, 8 May 2001 19:39:22 -0400
Date: Tue, 8 May 2001 16:38:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105081813160.9717-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0105081635530.3618-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 May 2001, Marcelo Tosatti wrote:
>
> There are two issues which I missed yesterday: we have to get a reference
> on the page, mark it clean, drop the locks and then call writepage(). If
> the writepage() fails, we'll have to set_page_dirty(page).

We can move the "mark it clean" into writepage, which would actually
simplify the error cases for shared memory writepage (no need to mark it
dirty again etc).

> I guess this is too much overhead for the common case, don't you?

You could easily be right.

On the other hand, remember that a noticeable part of the time you should
be seeing a real write too, so the CPU overhead compared to the IO might
not be prohibitive. Ie, let's assuem that 10% of the time we actually end
up doing writes, then that 10% is going to be _soo_ much more than the
extra 10 cycles 90% of the time that the cleanup may well be worth it.

Especially if the cleanup means that we can avoid doing some of the real
writes altogether, by being better able to release dead memory to the
system.

Tradeoffs..

		Linus

