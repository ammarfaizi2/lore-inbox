Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUCCQER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbUCCQER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:04:17 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:49325 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262497AbUCCQEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:04:10 -0500
Date: Wed, 3 Mar 2004 09:04:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040303160409.GT20227@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net> <20040302233512.GJ1225@elf.ucw.cz> <20040303152226.GS20227@smtp.west.cox.net> <20040303155106.GB12769@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303155106.GB12769@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 04:51:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > More precisely:
> > > > http://lkml.org/lkml/2004/2/11/224
> > > 
> > > Well, that just says Andrew does not care too much. I think that
> > > having both serial and ethernet support *is* good idea after all... I
> > > have few machines here, some of them do not have serial, and some of
> > > them do not have supported ethernet. It would be nice to use same
> > > kernel on all of them. Also distribution wants to have "debugging
> > > kernel", but does _not_ want to have 10 of them.
> > 
> > But unless I'm missing something, supporting eth or 8250 at all times
> > doesn't work right now anyhow, as eth if available will always take over.
> 
> Well, that can be fixed. [Probably if kgdbeth= is not passed, ethernet
> interface should not take over. So user selects which one should be
> used by either passing kgdbeth or kgdb8250. That means that 8250
> should not be initialized until user passes kgdb8250=... not sure how
> you'll like that].

At this point, I'm going to give up on killing kgdb_serial, and pass
along some comments from David Woodhouse on IRC as well (I was talking
about this issue, and the init/main.c change):
(Tartarus == me, dwmw2 == David Woodhouse)

<Tartarus> dwmw2, the problem is how do you deal with all of the
possibilities of i/o (8250, kgdboe, or other serial) and do you allow
for passing 'gdb' on the command line to result in kgdb not being dropped
into?  You can always break in later on of course
<dwmw2> parse command line early for 'gdb=' argument specifying which
i/o device to use. init kgdb core early. init each i/o device as early
as possible for that i/o device. Start the selected i/o device as soon
as it becomes available.
<dwmw2> just like console could, if we looked for console= a little bit
earlier. (forget all the earlyconsole shite, it's not necessary)
<dwmw2> Tartarrus, do the __early_setup() thing to replace __setup() for
selected args. We can use that for console= too.
<dwmw2> since 'console=' on the command line _already_ remembers its
arguments, and starts to use the offending device as soon as it gets
registered with register_console().
<Tartarus> dwmw2, __early_setup() ?
<dwmw2> See __setup("gdb=", gdb_setup_func);
<dwmw2> Replace with __early_setup(...)
<Tartarus> where is __early_setup ?
<dwmw2> before we normally parse the command line
<dwmw2> in my head

So perhaps someone can take these ideas and fix both problems... :)
(I've got some other stuff I need to work on today).

-- 
Tom Rini
http://gate.crashing.org/~trini/
