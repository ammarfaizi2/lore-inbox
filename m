Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbUKVTW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUKVTW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbUKVTUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:20:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:26575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262375AbUKVTQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:16:33 -0500
Date: Mon, 22 Nov 2004 11:16:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <20041122183956.GA50325@gaz.sfgoth.com>
Message-ID: <Pine.LNX.4.58.0411221059420.20993@ppc970.osdl.org>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
 <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0411211644200.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411221132550.8845@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0411220812580.20993@ppc970.osdl.org> <20041122183956.GA50325@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Mitchell Blank Jr wrote:
> 
> When gcc accepts an arbitrary algebraic expression as an lvalue I'll be
> impressed :-)

Btw, the "+0" thing is something that actually might be dropped pretty 
early, and as such a compiler _might_ get it wrong just because it ended 
up optimizing the expression away. So you don't need to be all that 
impressed, certain trivial expressions might just disappear under some 
circumstances.

Side note: the _biggest_ reason why "+0" is hard to optimize away early is
actually type handling, not the expression itself. The C type rules means
that "+0" isn't actually a no-op: it implies type expansion for small
integer types etc.

So I agree that it's unlikely to be a problem in practice, but I literally 
think that the reason gcc ends up considering a comma-operator to be an 
lvalue, but not a +-operator really _is_ the type-casting issues. A comma 
doesn't do implicit type expansion.

What I find really strange is the ternary operator lvalue thing, though. A 
ternary operator _does_ do type expansion, so that extended lvalue thing 
is really quite complex for ternary ops. Try something like this:

	int test(int arg)
	{
		char c;
		int i;

		return (arg ? c : i) = 1023;
	}

and think about what a total disaster that is. Yes, gcc gets it right, but
dammit, what a total crock. The people who thought of this feature should
just be shot.

(Yes, it looks cool. Oh, well. The compiler can always simplify the 
expression "(a ? b : c) = d" into "tmp = d ; a ? b = tmp : c = tmp", but 
hey, so can the user, so what's the point? Looking at the output from 
gcc, it really looks like gcc actually handles it as a special case, 
rather than as the generic simplification. Scary. Scary. Scary.)

		Linus
