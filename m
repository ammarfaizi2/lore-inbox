Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbUCLXTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUCLXTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:19:23 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:1932 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263023AbUCLXTQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:19:16 -0500
Subject: Re: calling flush_scheduled_work()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Tim Hockin <thockin@hockin.org>
Cc: Tim Hockin <thockin@Sun.COM>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040312223811.GA15636@hockin.org>
References: <20040312205814.GY1333@sun.com>
	 <1079128848.3166.44.camel@lade.trondhjem.org>
	 <20040312223811.GA15636@hockin.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1079133554.3166.69.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 18:19:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 12/03/2004 klokka 17:38, skreiv Tim Hockin:
> That just divides up the problem, but doesn't solve it.  The simplest would
> be to print a badness and somehow get out of the flush.  Then anyone who is
> triggering the corner case (us, in this case) can just solve it ourselves.
> It's not pretty.

Ewww.... That's saying "I'm just going to ignore the problem and pretend
I can continue". At least the hang will tell you that there *is* a
problem and points to where it is happening.

If I understood your description of where it is happening, then in this
case, continuing is likely to lead to an Oops later when all those open
RPC up/downcall pipes find that their parent directory has disappeared
from underneath them.

> In short, it's dubious that ANYONE call flush_scheduled_work() on a
> workqueue that they don't own.

Huh? You're saying that just because work has been scheduled on some
third party thread, you should not be allowed to wait on completion of
that work? That is a clearly unreasonable statement... Imagine doing
even memory allocation in such an environment...

I agree that we need to identify and solve the deadlocking problems, but
let's not start constricting developers with completely arbitrary rules.

The *real* problem here is that mput() is being run from keventd, and is
triggering code that was assumed to be running from an ordinary process
context. Let's concentrate on fixing that...

Cheers,
  Trond
