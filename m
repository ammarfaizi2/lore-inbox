Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269457AbSIRWzK>; Wed, 18 Sep 2002 18:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269466AbSIRWzK>; Wed, 18 Sep 2002 18:55:10 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:44818 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S269457AbSIRWzJ>; Wed, 18 Sep 2002 18:55:09 -0400
Date: Thu, 19 Sep 2002 00:59:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7
In-Reply-To: <20020918021714.E43A92C132@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209182313360.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 18 Sep 2002, Rusty Russell wrote:

> 	I've rewritten my in-kernel module loader: this version breaks
> much less existing code.  Basically, we go to a model of
> externally-controlled module refcounts with possibility of failure
> (ie. try_inc_mod_count, now called try_module_get()).

You add a lot of complexity in an attempt to solve a quite simple problem.
I agree that the module load mechanism could be simplified, but why do you
want to do it in the kernel? Some general module management in userspace
is needed anyway and all you save is a single call to the kernel.
Most of the module related changes are rather cosmetic. You still have to
spread try_module_get() calls all over the kernel, one has to call it
before calling a function which might sleep, this means we will add it
everywhere just to be save. What makes it worse is that it's not generally
usable, a per object reference count can also be used for module
management, but the module count can't be used for object management. This
means for modules with more dynamic interfaces, they have to do twice as
much work.
I can only refer to my own patch again, which has most of the basic things
needed to sanely get out of this mess:
1. Allow module exit to fail. This gives modules far more control over
module management and the generic module code can be simplified.
2. The new module layout simplifies module loading, much more than
relocating isn't necessary, but keeps backward compability as long as
necessary. This means new modules can be loaded with old modutils and
modules using the old interface can be kept working for a while.

bye, Roman


