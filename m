Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbTLZLCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 06:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbTLZLCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 06:02:11 -0500
Received: from science.horizon.com ([192.35.100.1]:23092 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S265168AbTLZLCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 06:02:07 -0500
Date: 26 Dec 2003 11:02:06 -0000
Message-ID: <20031226110206.28382.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: GCC 3.4 Heads-up
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Similarly, what the _hell_ does the gcc extension
> 
> 	int a;
> 
> 	(char)a += b;
> 
> really mean? The whole extension is just braindamaged,

It means a = (int)((char)a + b).
(Modulo the fact that the value of the expression is the sum of type
char and not the final value of type int.)

Applied to integer types, it *is* pretty brain damaged.  But applied to
pointer types, it makes a lot more sense.

This is because "a += b" in C is actually "a += b * sizeof(*a)", and
sometimes you want a different *a.

In particular, 1 is a popular value.

Consider the common case of a structure which has a bunch of variable-sized
blocks with a standard header:

struct foo {
	unsigned type, size;
	...
} a;

Then you *do* have to write
	a = (struct foo *)((char *)a + a->size);

and I might argue that

	(char *)a += a->size;

is definitely cleaner.

Or consider the case when the structure doesn't have an explicit size
and you have a big case statement for parsing it:

switch (a->type) {
	case BAR:
		process_bar_chunk(((struct bar *)a)++);
		break;
	case BAZ:
		process_baz_chunk(((struct baz *)a)++);
		break;
	...
};

Isn't that code a bit nicer looking?  I put the redundant parens
in to remind people that I didn't mean to write "(struct bar *)(a++)"
(which also has its legitimate uses).


Necessary, no.  But not "brain damaged", either.
It's well-defined and has legitimate uses.
