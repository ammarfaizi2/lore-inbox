Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSLZVV3>; Thu, 26 Dec 2002 16:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSLZVV3>; Thu, 26 Dec 2002 16:21:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57871 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263899AbSLZVV2>; Thu, 26 Dec 2002 16:21:28 -0500
Date: Thu, 26 Dec 2002 13:23:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: manfred@colorfullife.com, <anton@samba.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 fast poll on ppc64
In-Reply-To: <200212262055.VAA28874@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0212261314001.17782-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Dec 2002, Mikael Pettersson wrote:
> 
> Technically speaking, the kernel code which uses 'entries[0]' is
> non-compliant since the proper syntax is 'entries[]', but the empty
> array size syntax isn't implemented in gcc 2.95.3.

The two things have two totally different semantics:

 - array[0] is a zero-sized array, and is a long-time gcc extension that 
   has nothing to do with the modern "flexible array". The kernel uses 
   zero-sized arrays, because flexible arrays simply aren't historically
   supported by gcc at all.

 - array[] is the standard "flexible array" thing, and has different rules 
   than array[0]. For example, sizeof() is undefined on flexible arrays, 
   but is well-defined on zero-sized ones (at zero). Also, the alignment 
   constraints are potentially quite different.

The gcc people want to make the two behave fairly similarly to ease 
implementation issues, but they are definitely not the same.

> My mistake. The old code is Ok for C99, but broken for ANSI-C.

The old code is ugly and arguably always broken, I agree 100% with making 
the usage code use "pp->entries". Whether the allocators use "sizeof" or 
"offsetof" is secondary, at worst it ends up being conservative.

		Linus

