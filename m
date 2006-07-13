Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWGMO54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWGMO54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWGMO54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:57:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030217AbWGMO5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:57:55 -0400
Date: Thu, 13 Jul 2006 07:57:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: serue@us.ibm.com, hugh@veritas.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-Id: <20060713075749.982b3478.akpm@osdl.org>
In-Reply-To: <20060713133602.GH14665@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
	<20060627054612.GA15657@sergelap.austin.ibm.com>
	<Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
	<20060711194932.GA27176@sergelap.austin.ibm.com>
	<20060711171752.4993903a.akpm@osdl.org>
	<20060712032647.GA24595@sergelap.austin.ibm.com>
	<20060711204637.bba6e966.akpm@osdl.org>
	<20060712230228.GA19656@sergelap.austin.ibm.com>
	<20060713023829.c19881be.akpm@osdl.org>
	<20060713133602.GH14665@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 08:36:02 -0500
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Quoting Andrew Morton (akpm@osdl.org):
> 
> > Again: why is this so hard?  It shouldn't be.  Perhaps because loop is
> > using completions in bizarre ways where it should be using
> > wake_up_process(), wait_event(), etc.
> 
> Ah.
> 
> wait_event() actually seems like the way to go - I'll try to follow the
> example in fs/ocfs2/journal.c.

I suspect quite a lot of changes to loop.c would fall out.  For a start, in
a sufficiently-simplified implementation lo_pending would perhaps go away -
just test the NULLness of the top of the list of BIOs.

> Still I'd also like to patch kthread to correctly handle an already
> exited thread.  Would that be acceptable, or is requiring the thread not
> to exit prematurely considered desirable?

That would seem sensible, but I don't immediately see how to do it
non-racily without changing the API or by adding a `struct completion' to
the task_struct.  Because the task might be exitting-but-not-exitted, and
still using resources which the kthread_stop() caller wants to release.
