Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUEPESZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUEPESZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 00:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUEPESZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 00:18:25 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:59815 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S261712AbUEPESX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 00:18:23 -0400
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andi Kleen <ak@muc.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <20040515090911.GA21406@colin2.muc.de>
References: <1VLRr-38z-19@gated-at.bofh.it>
	 <m3oeorvy58.fsf@averell.firstfloor.org>
	 <1084599456.4895.103.camel@obsidian.pathscale.com>
	 <20040515090911.GA21406@colin2.muc.de>
Content-Type: text/plain
Message-Id: <1084680953.11976.27.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 15 May 2004 21:15:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-15 at 02:09, Andi Kleen wrote:

> > That's currently handled in user space, by PAPI (which sits on top of
> > perfctr).  One reason *not* to do it in the kernel is the bloat it would
> 
> That's clearly the wrong place to do it.

I can see both sides.  The perfctr driver already sanity-checks the
event selectors to make sure they're not set to anything malicious; this
is the very least it must do.

The next step up from that is allocating real performance counters
properly, but this requires quite a bit of work.  For example, you need
to know what the asymmetries in a particular CPU's counters are, so you
can tell which counter can handle the events being requested - this
varies from perfectly symmetrical (K7 and K8) through slightly odd (P3
and PM) to completely insane (P4).

After that, perhaps you start thinking about abstracting the notions of
what you're counting.  Different CPUs provide radically different ways
of counting roughly the same thing.  The event selectors for counting
instructions retired differ between AMD and P3, and between P3 and P4,
but they can all count this kind of event.  More primitive CPUs can't.

Beyond that, it is possible - and in some cases desirable - to, for
example, time-slice the real performance counters so that you could get
a somewhat representative sample of everything you wanted, assuming the
CPU could count it in the first place.  The Irix kernel does this.

Where would you draw the line?

Oh, I forgot to mention IA64 and SPARC64's incompatible performance
counter APIs :-)

> There is no way around that - there are kernel users (like the
> nmi watchdog or oprofile) and kernel users cannot be made dependent 
> on user space modules.

There's no kernel-to-user dependency.

	<b

