Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTKKXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTKKXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:54:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36749 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263850AbTKKXyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:54:11 -0500
Date: Wed, 12 Nov 2003 00:53:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>,
       Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp patch..
Message-ID: <20031111235354.GB543@elf.ucw.cz>
References: <Pine.LNX.4.44.0311042243170.730-100000@localhost.localdomain> <1068059491.4179.14.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068059491.4179.14.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi. Here's the first reply I sent to Patrick.

[Sorry for long delay; cc-ing patrick and l-k so that this discussion
is archived somewhere; hope you don't mind.]

> Secondly, regarding the freezer hooks, they're the result of a long
> period of working on the problem. You see, the freezer in your tree at
> the moment isn't robust. If you try to initiate a suspend at the wrong
> time, particularly where there's heavy I/O, it will sometimes deadlock
> (particularly in journalling filesystem code if I remember correctly -
> it's been a while since I had the problem) or at least take a long time
> (try initiating a suspend during dd if=/dev/zero of=testfile bs=4096
> count=100000). Another problem is that you will be writing dirty data to
> swap. This freezer implementation overcomes those issues. It
> provides a

Well, writing dirty data to swap does not look like too bad
problem. If it simplifies things, I'm happy with dirty data in swap.

> of others. (Remember that in my version, I use activelist & inactivelist
> pages for the atomic copy of the rest of the data as well as any free
> memory, thereby overcoming the half-of-memory limitation). If
> someone

...introducing another "half-of-kernelmemory" limitation. [Did you see
people hitting half-of-memory problem in practice?].

How is it possible that copying into activelist & inactivelist helps?
If memorymanagment is working correctly then those lists should be
empty...

I know you are not freeing memory agresively.. But perhaps you have
exactly same "half-of-memory" problem as 2.6.0-test9 implementation
has?

> comes up with a better way to do this, I'll be more than happy to
> listen, as always. I've spent a long time looking at the issue though,
> and doubt that will happen. I'm sure the macros could be made to look
> nicer or perhaps written in assembly to improve speed, but I can't see

No assembly, please. Nicer macros would be welcome, through. No macros
would be best ;-).

Deadlocks... any user process stopped with sigstop should not block
anything in-kernel, right? That means that perhaps we need to be more
clever about kernel threads, but we should be able to get away without
hooks in paths such as "sys_read()". If killall -SIGSTOP can stop the
processes safely without additional hooks, we should be able to do
that, too...

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
