Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUFFGHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUFFGHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 02:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUFFGHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 02:07:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:29376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262954AbUFFGHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 02:07:45 -0400
Date: Sat, 5 Jun 2004 23:07:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
cc: Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@ximian.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <40C2A6E4.7020103@ThinRope.net>
Message-ID: <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com> 
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> 
 <20040605205547.GD20716@devserv.devel.redhat.com>  <20040605215346.GB29525@taniwha.stupidest.org>
 <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org> <40C2A6E4.7020103@ThinRope.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Kalin KOZHUHAROV wrote:
>
> Well, not exactly sure about my reply, but let me try.
> 
> The other day I was debugging some config problems with my qmail instalation and I ended up doing:
> # strace -p 4563 -f -F
> ...
> [pid 13097] read(3, "\347\374\375TBH~\342\233\337\220\302l\220\317\237\37\25"..., 32) = 32
> [pid 13097] close(3)                    = 0
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getuid32()                  = 89
> [pid 13097] getpid()                    = 13097
> [pid 13097] time(NULL)                  = 1086497450
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097
> [pid 13097] getpid()                    = 13097

qmail is a piece of crap. The source code is completely unreadable, and it 
seems to think that "getpid()" is a good source of random data. Don't ask 
me why.

It literally does things like

	random = now() + (getpid() << 16);

and since there isn't a single comment in the whole source tree, it's
pointless to wonder why. (In case you wonder, "now()" just does a
"time(NULL)" call - whee.).

I don't understand why people bother with it. It's not like Dan Bernstein
is so charming that it makes up for the deficiencies of his programs.

But no, even despite the strange usage, this isn't a performance issue.  
qmail will call "getpid()" a few tens of times per connection because of
the wonderful quality of randomness it provides, or something.

This is another gem you find when grepping for "getpid()" in qmail, and 
apparently the source of most of them:

	if (now() - when < ((60 + (getpid() & 31)) << 6))

Don't you love it how timeouts etc seem to be based on random values that 
are calculated off the lower 5 bits of the process ID? And don't you find 
the above (totally uncommented) line just a thing of beauty and clarity?

Yeah. 

Anyway, you did find something that used more than a handful of getpid() 
calls, but no, it doesn't qualify as performance-critical, and even 
despite it's peyote-induced (or hey, some people are just crazy on their 
own) getpid() usage, it's not a reason to have a buggy glibc.

		Linus
