Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbTLIH0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 02:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbTLIH0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 02:26:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:57529 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265635AbTLIH0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 02:26:39 -0500
Date: Mon, 8 Dec 2003 23:26:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Jamie Lokier <jamie@shareable.org>, Nikita Danilov <Nikita@Namesys.COM>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
In-Reply-To: <3FD55F9D.9070203@zytor.com>
Message-ID: <Pine.LNX.4.58.0312082321470.18255@home.osdl.org>
References: <200312081646.42191.arnd@arndb.de> <3FD4B9E6.9090902@zytor.com>
 <16340.49791.585097.389128@laputa.namesys.com> <3FD4C375.2060803@zytor.com>
 <20031209025952.GA26439@mail.shareable.org> <3FD53FC6.5080103@zytor.com>
 <20031209034935.GA26987@mail.shareable.org> <3FD55F9D.9070203@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, H. Peter Anvin wrote:
>
> Sure it will:

No, Jamie was thinking of a variable that _already_ has a memory location
having its value copied around to _another_ memory location (ie a
temporary stack slot).

What your example shows is that gcc will create a stack slot for an
automatic variable if it doesn't have one already, in order to make it an
lvalue with a memory address.

So what's interesting is if gcc would take something like

	extern int variable;

	asm("..." : :"m" (variable));

and cause this to create a _new_ temporary on the stack slot, and pass the
asm the pointer to that temporary rather than the "real" address of
'variable'.

And as far as I know, it won't. Newer gcc's will _require_ memory
arguments to be lvalues (well, it will warn if they aren't), and will
always turn them into addressables of that particular lvalue.

This is actually an issue, because some asm code depends on getting the
proper address - not just the proper value. Things like locks etc care
_deeply_ about more than just the value.

		Linus
