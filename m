Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTE0DKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTE0DKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:10:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23569 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262955AbTE0DKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:10:36 -0400
Date: Mon, 26 May 2003 20:23:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
In-Reply-To: <20030527030219.GI9947@vitelus.com>
Message-ID: <Pine.LNX.4.44.0305262009400.1680-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Aaron Lehmann wrote:
> 
> Well, the checker its share of those problems:
> 
> const char *gcc_includepath[] = {
>     "/usr/lib/gcc-lib/i386-redhat-linux/3.2.1/include",
>     "/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include",
>     NULL
> };

Any takers? Some Makefile magic plus some hacky thing like

	gcc -print-file-name=include

(Yeah, that's not righ either, it just happens to work. I don't know what
the proper way of making gcc expose its local paths is).

So I'm doing what works for me, and open source (in this case the OSL) 
means that you can fix it and send me patches if you want to ;)

Btw, taling about it embarrassed me so much that I just fixed the enum
confusion, so now a few less of the checker warnings are bogus. It still
misparses some assembly (notably anything that is at the top level, not
inside a function, and the kinds of asms used to rename variables).

And it doesn't handle pragmas, in particular "pragma pack" is hard to do
right (well, from a _kernel_ checking standpoint it doesn't matter, but I
do want it to actually generate a good parse tree too, which means that I
try to get things like structure member offsets etc _right_. And as I
currently just ignore - and warn about - "pragma pack", my type evaluation
doesn't get the offsets/alignments right).

But _most_ of the warnings are because of type differences. Even those are
sometimes bogus, though, so don't assume it's right. 

Oh, before I forget: it also refuses to parse some gcc constructs that I
personally don't like, like the gcc extension to make certain things
lvalues even though they really aren't (ie casts and the ?: operator).

Even though I myself have been known to use those gcc extensions, I think
they are _wrong_, since they don't actually buy you anything except for a
dubious syntactic shorthand. It's the wrong kind of language extension.

Other - more worthwhile - extensions I do actually support.

		Linus

