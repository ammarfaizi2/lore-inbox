Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbREMTaM>; Sun, 13 May 2001 15:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261838AbREMTaC>; Sun, 13 May 2001 15:30:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:9993 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261747AbREMT3u>; Sun, 13 May 2001 15:29:50 -0400
Date: Sun, 13 May 2001 12:29:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105131306020.5468-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105131225300.20452-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 May 2001, Rik van Riel wrote:
> 
> This means that the swapin path (and the same path for
> other pagecache pages) doesn't take the page lock and
> the page lock doesn't protect us from other people using
> the page while we have it locked.

You can test for swap cache deadness without holding the page cache lock:
if the swap count is 1, then we know that nobody else has this swap entry
in its page tables, and thus there can not be any concurrent lookups
either.

Now, it may well be that we need to make sure that there is some proper
ordering (nobody must decrement the swap count before they increment the
page count or something). I think that is the case anyway (and I _think_
that everybody that mucks with the swap count always hold the page count -
this might be a good thing to check).

So while you're right in general, there are some things we can do with
less global locking. Just holding the page lock will guarantee that at
least nobody changes the index etc from under us, so that the things we
test are at least fairly well-defined.

		Linus

