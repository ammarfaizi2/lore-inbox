Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbUKVQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbUKVQzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUKVQoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:44:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:46252 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262182AbUKVQXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:23:03 -0500
Date: Mon, 22 Nov 2004 08:22:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <Pine.LNX.4.53.0411221132550.8845@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0411220812580.20993@ppc970.osdl.org>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
 <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0411211644200.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411221132550.8845@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Jan Engelhardt wrote:
>
> >BAD gcc extensions:
> 
> You don't have to use them...

We don't, generally. But they are bad even if you DON'T use them, because 
they sometimes make obvious syntax errors etc much harder to debug.

For example, the "nested function" thing makes something as simple as a 
missing end brace cause the error reporting to be totally off, when gcc 
decides that "hey, that's ok, those other function declarations are just 
nested functions in the middle of that other function". So you get 
something like

	file.c: lastline: parse error at end of input

even though the _real_ parse error could have been pinpointed exactly if 
gcc did NOT do it's totally braindamaged nested functions. IOW, the 
extension causes problems even when you don't use it.

Same goes for the "extended lvalues". They are not only insane, but they 
mean that code like

	(0,i) = 1;

actually compiles. Why is that a problem? Because some people (ie me) have 
used constructs like this in macros to make sure that the macro is 
"read-only", ie you have a situation where you don't want people to 
mis-use the macro on some architecture. So having

	int max_of_something;
	#define MAX_SOMETHING (0,max_of_something)

is actually a nice way to make sure nobody does anything like

	MAX_SOMETHING = new;

but the gcc extension means that this doesn't actually work.

(Yes, I've been bitten by this. And no, I don't see the _point_ of the
extension - does anybody actually admit to ever _using_ comma- expressions
for assignments?)

		Linus
