Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSGVO0U>; Mon, 22 Jul 2002 10:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSGVO0U>; Mon, 22 Jul 2002 10:26:20 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:11147 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317432AbSGVO0R>; Mon, 22 Jul 2002 10:26:17 -0400
Date: Mon, 22 Jul 2002 09:29:08 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Russell King <rmk@arm.linux.org.uk>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.25 net/core/Makefile
In-Reply-To: <20020722090704.A2052@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207220909530.28150-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Russell King wrote:

> On Mon, Jul 22, 2002 at 11:08:41AM +1000, Keith Owens wrote:
> > It is required if you ever want autoconfigure to work, that
> > distinguishes between "" (undefined) and "n" (explicitly turned off).
> > Forward planning.
> 
> Wouldn't it be better to fix the existing config tools to output "=n"
> instead of "# CONFIG_foo is not set" ?  IIRC they do the translation
> back and forth internally anyway, so it should be just a matter of
> removing some code from the tools.

The point is, what would such a change buy us? It needs going through all 
Makefiles, updating 

	ifdef CONFIG_XYZ

to

	ifneq ($(CONFIG_XYZ),n)


(or ifeq ($(CONFIG_XYZ),y) when we now it's a bool)

Actually, now this won't handle the CONFIG_XYZ unset case, which may well 
happen since a part of Config.in which would set or unset the symbols 
may not even get sourced.

So we really have to use

	ifneq ($(subst n,,$(CONFIG_XYZ),)

instead. That's ugly and doesn't have any advantage over what we have 
now, AFAICS.

Inside the Config.in scripts it's annoying that you have to check against
"n" || "" (or ! ("y" || "m") ). The reasons for that lie, for all I can
tell, in the use of sh/bash for the original Configure script. In any
case, if this behavior is considered too annoying, it should be fixed in
the config system, but there's no reason to change the Makefile/.config 
syntax, too.

(I think it may actually possible to fix it even within Configure, by just
always using <undef> instead of "n" - Configure needs to keep track of all
the encountered symbols anyway - but I didn't try. This would also
decrease the confusion, as then both the Makefiles and Config.in would
both use "y","m",<undef>.

W.r.t autoconfigure, I think that can easily be achieved using/extending 
the existing .config format.

Just have

	# CONFIG_FOO is not set
vs
	# CONFIG_FOO=n

or even

	<CONFIG_FOO not mentioned in .config>

vs the current

	# CONFIG_FOO is not set

Should be nicely compatible with all existing tools.

--Kai


