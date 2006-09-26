Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWIZTvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWIZTvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWIZTvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:51:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6623 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932238AbWIZTvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:51:35 -0400
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Martin Bligh <mbligh@google.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal>
	<45187146.8040302@goop.org> <20060926002551.GA18276@Krystal>
	<20060926004535.GA2978@Krystal> <45187C0E.1080601@goop.org>
	<20060926025924.GA27366@Krystal> <4518B4A0.6070509@goop.org>
	<20060926180414.GA10497@Krystal> <4519781D.9040503@goop.org>
	<20060926190849.GA2280@Krystal>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 26 Sep 2006 15:49:34 -0400
In-Reply-To: <20060926190849.GA2280@Krystal>
Message-ID: <y0mhcyue7ch.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <compudj@krystal.dyndns.org> writes:

> [...]
> > Yep, that looks reasonable.  Though you could just directly test a 
> > per-marker enable flag, rather than using "condition"...
> [...]
> I am not sure I understand your suggestion correctly.. do you mean having
> a per-marker flag that would be loaded and tested at every marker site ?

I gather that one reason for working so hard with the inline assembly
is a race condition problem with the plain STAP_MARK style of marker
disconnection:

        if (pointer) (*pointer)(args ...);

Granted, but this problem could almost certainly be dealt with simpler
than that.  How about a compxchg or other atomic-fetch of the static
pointer with a local variable?  That should solve the worry of an
(*NULL) call.

If we then become concerned with a valid pointer become obsolete (the
probe handler function wanting to unload), we might be able to use
some RCU-type deferral mechanism and/or preempt controls to ensure
that this does not happen.

- FChE
