Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbSIXF0p>; Tue, 24 Sep 2002 01:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbSIXF0p>; Tue, 24 Sep 2002 01:26:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26082 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261570AbSIXF0o>;
	Tue, 24 Sep 2002 01:26:44 -0400
Date: Tue, 24 Sep 2002 07:40:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] streq()
In-Reply-To: <20020924045313.0FBE52C075@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209240731060.8824-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Sep 2002, Rusty Russell wrote:

> Embarrassing, huh?  But I just found a bug in my code cause by "if
> (strcmp(a,b))" instead of "if (!strcmp(a,b))".

there's a few more places that tend to cause wasted time, no matter what:

 - list_add(elem, list) order of arguments. It can be mixed up easily, and
   while i know all the consequences every few months i waste a few hours
   on such a thing.

 - kmalloc(size, flags)/gfp(order, flags) argument ordering. A few months
   ago i wasted two days on such a bug - since 'size' was very small
   usually, it never showed up that the allocated buffer was short, until
   some rare load-test increased the 'size'.

we should do something about these. list_add() is hard, while we could
introduce a separate type for list heads, there are some valid uses of
non-head list_add(). But perhaps those could be separated out.

handling most of the gfp() mixups should be a bit easier, perhaps by
detecting invalid flags in the inline section, which is optimized away at
runtime in like 95% of the cases?

	Ingo

