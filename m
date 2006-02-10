Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWBJFvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWBJFvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBJFvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:51:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751134AbWBJFvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:51:24 -0500
Date: Thu, 9 Feb 2006 21:50:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209215040.0dcb36b1.akpm@osdl.org>
In-Reply-To: <43EC24B1.9010104@yahoo.com.au>
References: <20060209071832.10500.qmail@science.horizon.com>
	<20060209001850.18ca135f.akpm@osdl.org>
	<43EAFEB9.2060000@yahoo.com.au>
	<20060209004208.0ada27ef.akpm@osdl.org>
	<43EB3801.70903@yahoo.com.au>
	<20060209094815.75041932.akpm@osdl.org>
	<43EC0A44.1020302@yahoo.com.au>
	<20060209195035.5403ce95.akpm@osdl.org>
	<43EC0F3F.1000805@yahoo.com.au>
	<20060209201333.62db0e24.akpm@osdl.org>
	<43EC16D8.8030300@yahoo.com.au>
	<20060209204314.2dae2814.akpm@osdl.org>
	<43EC1BFF.1080808@yahoo.com.au>
	<20060209211356.6c3a641a.akpm@osdl.org>
	<43EC24B1.9010104@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> >>If you want to start the IO *now* without waiting on it, call msync(MS_ASYNC)
> >> If you don't want to start the IO now, that's really easy, do nothing.
> >> If you want to start the IO now and also wait for it to finish, call msync(MS_SYNC)
> > 
> > 
> > I've already explained the problems with the start-io-in-MS_ASYNC approach.
> > 
> 
> But I've explained that they only matter for people using it in stupid ways.
> fsync also poses a performance problem for programs that call it after every
> write(2).

There's absolutely nothing stupid about

	*p = <expr>
	msync(p, sizeof(*p), MS_ASYNC);

> > 
> >> Presently, the first option is unavailable.
> > 
> > 
> > We need to patch the kernel either way.  There's no point in going back to
> > either the known-problematic approach or to something half-assed.
> > 
> 
> The system call indicates to the kernel that IO submission should be started.
> The earlier the kernel does that, the better (because it is likely that an
> MS_SYNC is coming soon).
> 
> I think the current way of just moving the dirty bits is half-assed.
> 
> Is a more efficient implementation know-problematic?

It's less efficient for some things.  A lot.

> What applications did
> you observe problems with, can you remember?

Linus has some application which was doing the above.  It ran extremely
slowly, so we changed MS_ASYNC (ie: made it "more efficient"...)
