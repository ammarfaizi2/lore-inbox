Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWHTSLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWHTSLH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHTSLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:11:07 -0400
Received: from 1wt.eu ([62.212.114.60]:54544 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751117AbWHTSLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:11:06 -0400
Date: Sun, 20 Aug 2006 20:10:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820181025.GN602@1wt.eu>
References: <20060820003840.GA17249@openwall.com> <20060820100706.GB6003@steel.home> <20060820153037.GA20007@openwall.com> <1156097013.4051.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156097013.4051.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 07:03:33PM +0100, Alan Cox wrote:
> Ar Sul, 2006-08-20 am 19:30 +0400, ysgrifennodd Solar Designer:
> > The problem is that there are lots of privileged userspace programs that
> > do not bother to check the return value from set*uid() calls (or
> > otherwise check that the calls succeeded) before proceeding with work
> > that is only safe to do with the *uid switched as intended.
> 
> People keep saying this but we seem short of current, commonly shipped
> examples. And quite frankly any code that doesn't check setuid returns
> is unlikely to be fit for purpose in any other way and presumably has
> never been adequately audited.

This is a beginner's bug. It is a common misconception to believe that
because your program is started as root, it will be allowed to switch
to any other uid. People do not always realize that the syscall might
fail (and not on all OSes it seems), resulting in their program still
running with all privileges. I remember having stuffed some
'setuid(getuid())' in some of my programs a long time ago, I don't see
why others would not do the same. I'm not the only dumb person on this
planet :-)

There's an interesting paper about uid transitions here :

  http://seclab.cs.ucdavis.edu/papers/Hao-Chen-papers/usenix02.pdf

Also, for examples of programs affected till recently, look at the
date on this patch (few weeks ago) :

  http://ftp.x.org/pub/X11R7.1/patches/xf86dga-1.0.1-setuid.diff

and this one now (few days ago) :

  http://www.linuxfromscratch.org/patches/downloads/xorg-server/xorg-server-1.1.0-setuid-2.patch

Scary, both X servers are affected...

Now it's not hard to find programs still working like this. Googling
"setuid(getuid())" returns several ones like this :

  http://devel.squid-cache.org/hno/setfilelimit.c

Here, someone proposing to make tcpdump drop privileges :

  http://www.mail-archive.com/tcpdump-workers@sandelman.ottawa.on.ca/msg03170.html

> Alan

So I think that while it's bad code in userland, a misunderstood kernel
semantic caught the developpers. We can at least make the kernel help them.

Regards,
Willy

