Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWIHXtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWIHXtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 19:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWIHXtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 19:49:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60140 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751297AbWIHXtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 19:49:14 -0400
Date: Fri, 8 Sep 2006 16:49:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] check pr_debug() arguments
Message-Id: <20060908164908.abb98076.akpm@osdl.org>
In-Reply-To: <20060908225529.9340.75338.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
	<20060908225529.9340.75338.sendpatchset@kaori.pdx.zabbo.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Sep 2006 15:55:29 -0700 (PDT)
Zach Brown <zach.brown@oracle.com> wrote:

> check pr_debug() arguments
> 
> When DEBUG isn't defined pr_debug() is defined away as an empty macro.  By
> throwing away the arguments we allow completely incorrect code to build.
> 
> Instead let's make it an empty inline which checks arguments and mark it so gcc
> can check the format specification.

Desirable.

> This results in a seemingly insignificant code size increase.  A x86-64
> allyesconfig:
> 
>    text    data     bss     dec     hex filename
> 25354768        7191098 4854720 37400586        23ab00a vmlinux.before
> 25354945        7191138 4854720 37400803        23ab0e3 vmlinux

Which would indicate that we might have expressions-with-side-effects
inside pr_debug() statements somewhere, which is risky.  I wonder where?

It looks like the version of gcc which you used is correctly discarding the
pr_debug() format string.  gcc hasn't always done that, and there's a risk
of bloatiness on older gccs.  I checked gcc-3.3.2/x86 and it does the right
thing, so...

btw, what's up with aio.c using a combination of pr_debug() and dprintk(),
and a combination of `#ifdef DEBUG' and `#if DEBUG > 1'?  Confusing.


It would be nice to have a single way of doing developer-debug in-tree.  We
have 182(!) different definitions of dprintk().  Please nobody cc me on that
discussion though ;)
