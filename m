Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbUCLXbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUCLX3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:29:32 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:62144 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S263038AbUCLX10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:27:26 -0500
Date: Fri, 12 Mar 2004 15:27:13 -0800
From: Tim Hockin <thockin@sun.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Tim Hockin <thockin@hockin.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: calling flush_scheduled_work()
Message-ID: <20040312232713.GZ1333@sun.com>
Reply-To: thockin@sun.com
References: <20040312205814.GY1333@sun.com> <1079128848.3166.44.camel@lade.trondhjem.org> <20040312223811.GA15636@hockin.org> <1079133554.3166.69.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079133554.3166.69.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 06:19:14PM -0500, Trond Myklebust wrote:
> Ewww.... That's saying "I'm just going to ignore the problem and pretend
> I can continue". At least the hang will tell you that there *is* a
> problem and points to where it is happening.

Well, it needs to be non-silent.  Whether that is a BUG() or a badness or a
panic..

> > In short, it's dubious that ANYONE call flush_scheduled_work() on a
> > workqueue that they don't own.
> 
> Huh? You're saying that just because work has been scheduled on some
> third party thread, you should not be allowed to wait on completion of
> that work? That is a clearly unreasonable statement... Imagine doing
> even memory allocation in such an environment...

Waiting for completion of your work is one thing.  But you can't know what
else has been scheduled.  In this case RPC doesn't know that our work is
calling it.  By waiting for ALL work, it is assuming (silently) that it will
never be called from a keventd.

Either that assumption is true, in which case there needs to be a BUG and a
way out, or that assumption is false.  I'd like to believe that the
assumption is false.

> The *real* problem here is that mput() is being run from keventd, and is
> triggering code that was assumed to be running from an ordinary process
> context. Let's concentrate on fixing that...

Well, we did fix it in a different way.  I just wanted to bring this up as
something that warrants at least a BUG().  But a BUG() and deadlock is
almost a panic().

So if mntput() just CAN NOT be called from keventd, that is a fine answer,
but something should be written about that.  And all the other things that
can not be called from keventd.

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
