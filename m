Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUIPDxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUIPDxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 23:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUIPDxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 23:53:14 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:63640 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267440AbUIPDxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 23:53:11 -0400
Subject: Re: get_current is __pure__, maybe __const__ even
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
In-Reply-To: <20040916023604.GH9106@holomorphy.com>
References: <1095288600.1174.5968.camel@cube>
	 <20040915231518.GB31909@devserv.devel.redhat.com>
	 <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube>
	 <20040916023604.GH9106@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095306363.3874.101.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Sep 2004 23:49:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 22:36, William Lee Irwin III wrote:
> On Wed, Sep 15, 2004 at 07:15:18PM -0400, Jakub Jelinek wrote:
> >>> current will certainly change in schedule (),
> 
> On Wed, Sep 15, 2004 at 10:10:20PM -0400, Albert Cahalan wrote:
> > Not really!
> 
> Yes it does. The interior of schedule() is C and must be compiled also.

Sure. It doesn't matter. The part that matters is
all arch-specific assembly.

Hey, the arm port already uses __const__.
Unless the arm port is broken, there's proof.

> At some point in the past, I wrote:
> >> Why would barrier() not suffice?
> 
> On Wed, Sep 15, 2004 at 10:10:20PM -0400, Albert Cahalan wrote:
> > I don't think even barrier() is needed.
> > Suppose gcc were to cache the value of
> > current over a schedule. Who cares? It'll
> > be the same after schedule() as it was
> > before.
> 
> Not over a call to schedule(). In the midst of schedule().

OK, let's look.

First, there's fork/vfork/clone. At no point does
"current" change. A process comes into existance
with a ready-made current.

Second, there's sched.c with context_switch().
That does everything via switch_to, like so:

/* Here we just switch the register state and the stack. */
switch_to(prev, next, prev);

No problem. Now I only need to show that switch_to()
is safe. Unfortunately, it's arch-specific code.
I'll look at a few examples...

x86_64:   assembly, and thus OK
i386:     assembly, and thus OK
ppc:      assembly, and thus OK
arm:      already uses __const__ :-)

To find a problem, you need to find an arch which
runs C code with current being inconsistent with
the stack or registers. That would be wild and evil.
In any case, adding __attribute__((__const__)) is
an arch-specific change. A truly evil arch running
C code with an inconsistent current can just leave
off the attribute or, better yet, stop being evil.


