Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVJJPOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVJJPOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 11:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVJJPOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 11:14:15 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27321 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750855AbVJJPOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 11:14:14 -0400
Date: Mon, 10 Oct 2005 11:13:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Ingo Molnar <mingo@elte.hu>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] pcmcia-shutdown-fix.patch
In-Reply-To: <20051007191712.GB22608@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0510101106380.26418@localhost.localdomain>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
 <20051002151817.GA7228@elte.hu> <5bdc1c8b0510020842p6035b4c0ibbe9aaa76789187d@mail.gmail.com>
 <5bdc1c8b0510021225y951caf3p3240a05dd2d0247c@mail.gmail.com>
 <Pine.LNX.4.58.0510061308290.973@localhost.localdomain> <20051007110914.GA30873@elte.hu>
 <20051007191712.GB22608@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Oct 2005, Russell King wrote:

> On Fri, Oct 07, 2005 at 01:09:14PM +0200, Ingo Molnar wrote:
> >
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > Ingo, here's the patch.  This should probably go upstream too since it
> > > can happen there too.  The pccardd thread has a race in it that it can
> > > shutdown in the TASK_INTERRUPTIBLE state.  Here's the fix.
> >
> > ah, certainly makes sense. Dominik, does it look good to you too? Patch
> > below is for upstream.
>
> Looks correct to me (I'm the author of this code.)  Since it's
> a bug fix, please send it upstream ASAP.
>

Just in case this was missed and hasn't been incorporated.  Here's the
patch once again:

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.14-rc3/drivers/pcmcia/cs.c
===================================================================
--- linux-2.6.14-rc3/drivers/pcmcia/cs.c.orig	2005-10-06 06:56:17.000000000 -0400
+++ linux-2.6.14-rc3/drivers/pcmcia/cs.c	2005-10-10 11:05:09.000000000 -0400
@@ -689,6 +689,9 @@
 		schedule();
 		try_to_freeze();
 	}
+	/* make sure we are running before we exit */
+	set_current_state(TASK_RUNNING);
+
 	remove_wait_queue(&skt->thread_wait, &wait);

 	/* remove from the device core */
