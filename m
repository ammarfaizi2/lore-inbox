Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSG3Cot>; Mon, 29 Jul 2002 22:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318192AbSG3Cot>; Mon, 29 Jul 2002 22:44:49 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:8901 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318190AbSG3Cos>; Mon, 29 Jul 2002 22:44:48 -0400
Subject: Re: [PATCH] automatic initcalls
From: Keith Adamson <keith.adamson@attbi.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, torvalds@transmeta.com
In-Reply-To: <20020729103912.A18765@nightmaster.csn.tu-chemnitz.de>
References: <20020728033359.7B2A2444C@lists.samba.org>
	<3D436A44.8080505@mandrakesoft.com> 
	<20020729103912.A18765@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-3) 
Date: 29 Jul 2002 22:49:15 -0400
Message-Id: <1027997356.9786.38.camel@h00d0700074d1.ne.client2.attbi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 04:39, Ingo Oeser wrote:
> On Sat, Jul 27, 2002 at 11:51:32PM -0400, Jeff Garzik wrote:
> > I've always preferred a system where one simply lists dependencies [as 
> > you describe above], and some program actually does the hard work of 
> > chasing down all the initcall dependency checking and ordering.
> 
> So we just need to build a directed graph, detect edges without
> existing nodes (someone changed the initcall, we depend on) and
> cycles (someone messed up the ordering) as errors, sort the
> resulting graph toplogically and dump it as a sequence.
> 
> This is no rocket science and we have two tools, which does this
> all for us (make and tsort, which create a warning for both cases).
> 
> The hard part is to CREATE all the dependencies and check and
> double check them with the maintainers.
> 

I definitely agree the easy part is the algorithm and the hard part is
creating the dependency list.  For instance, attached is a small
algorithm that does the initcall sequencing at run time.

The API is is simple, you just register your initcall with a list of
critical initcalls you need to be run before yours (not all, just the
ones you definitely need to be run first).  Then the ordering of the all
the initcalls are sequenced at run time.  This way you don't have to
worry about link ordering or code ordering of your initcalls during
make/compile/link.  All initcall ordering is done during boot.  

This really frees you from module inter-dependencies because is doesn't
mater in what order you register you initcalls.  You only need register
them with a list the critical modules that need to be initialized before
yours.

The API also provides that you can register more than one initcall for
your module with a different set of critical modules that must be run
first.

This should be relative easy to add to the kernel, as you don't have to
modify any of the existing initcalls.  You do need to remove all
existing calls to them and register them instead with the new API.

Untar and "cd init; cc *.c; ./a.out"

Four example modules register their initcalls, "foo1, foo2, foo3, foo4",
and then the main routine sequences them at run time.  

Regards, Keith



