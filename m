Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSGYJxE>; Thu, 25 Jul 2002 05:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318391AbSGYJxE>; Thu, 25 Jul 2002 05:53:04 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:31501 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318389AbSGYJxB>; Thu, 25 Jul 2002 05:53:01 -0400
Date: Thu, 25 Jul 2002 11:56:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] new module interface
In-Reply-To: <20020725180831.3b0b2449.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0207251121310.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Jul 2002, Rusty Russell wrote:

> 	Firstly, I give up: what kernel is this patch against?  It's
> hard to read a patch this big which doesn't apply to any kernel I can find 8(

2.4.18. Maybe pine garbled the patch... Here is a copy of the patch:
http://www.xs4all.nl/~zippel/mod.diff

> Interesting approach.  Splitting init and start and stop and exit is
> normal, but encapsulating the usecount is different.  I made start
> and exit return void, though.

I introduced usecount() to gain more flexibility, currently one is forced
to pass the module pointer everywhere.
Allowing exit to fail simplifies the interface. Normal code doesn't has
to bother about the current state of the module, instead exit() is now the
synchronization point. This also means the unload_lock via
try_inc_mod_count is not needed anymore.

> Hmmm... you sidestepped the "rmmod -f" problem, by running module->start()
> again if module->exit() fails.  I decided against this because module
> authors have to make sure this works.

In the future it rather should work. The problem is that the current
module interface is very limited, later we can introduce a interface to
just stop a module. Right now I just emulate the old behaviour to avoid
having a module in half initailized state.

> I chose the more standard "INIT(init, start)" & "EXIT(stop, exit)" which
> makes it easier to drop the exit part if it's built-in.

I was thinking about it, but couldn't we just put these function in a
seperate section and discard them during init (maybe depending on some
hotplug switch)?

> My favorite part is including the builtin-modules.  I assume this means
> that "request_module("foo")" returns success if CONFIG_DRIVER_FOO=y now?

Not yet. The problem is the module name, e.g. ext2 is called
fs_ext2_super, it will need some kbuild changes to get the right module
name.

bye, Roman

