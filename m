Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWIZUK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWIZUK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWIZUK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:10:28 -0400
Received: from tomts25.bellnexxia.net ([209.226.175.188]:24198 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932267AbWIZUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:10:27 -0400
Date: Tue, 26 Sep 2006 16:05:14 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
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
Message-ID: <20060926200514.GB12532@Krystal>
References: <45187146.8040302@goop.org> <20060926002551.GA18276@Krystal> <20060926004535.GA2978@Krystal> <45187C0E.1080601@goop.org> <20060926025924.GA27366@Krystal> <4518B4A0.6070509@goop.org> <20060926180414.GA10497@Krystal> <4519781D.9040503@goop.org> <20060926190849.GA2280@Krystal> <y0mhcyue7ch.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <y0mhcyue7ch.fsf@ton.toronto.redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:57:49 up 34 days, 17:06,  4 users,  load average: 0.10, 0.21, 0.27
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Ch. Eigler (fche@redhat.com) wrote:
> Mathieu Desnoyers <compudj@krystal.dyndns.org> writes:
> 
> > [...]
> > > Yep, that looks reasonable.  Though you could just directly test a 
> > > per-marker enable flag, rather than using "condition"...
> > [...]
> > I am not sure I understand your suggestion correctly.. do you mean having
> > a per-marker flag that would be loaded and tested at every marker site ?
> 
> I gather that one reason for working so hard with the inline assembly
> is a race condition problem with the plain STAP_MARK style of marker
> disconnection:
> 
>         if (pointer) (*pointer)(args ...);
> 
> Granted, but this problem could almost certainly be dealt with simpler
> than that.  How about a compxchg or other atomic-fetch of the static
> pointer with a local variable?  That should solve the worry of an
> (*NULL) call.
> 

I don't really see how cmpxchg might be needed here.

Atomic fetch of a static variable is how I will do it in my next version for the
non optimized case :

volatile static var = 0;
if(var) {
  preempt disable
  call
  preempt_enable_no_resched
}

But, still, in the optimized case, the if(var) will depend on an immediate
value, therefore saving the memory read.


> If we then become concerned with a valid pointer become obsolete (the
> probe handler function wanting to unload), we might be able to use
> some RCU-type deferral mechanism and/or preempt controls to ensure
> that this does not happen.
> 

This is exactly why the preemption is disabled around the call. However, RCU
must always _see_ a coherent version of the structure in memory.

Calling an empty function, disabling preemption around the call and calling
synchronize_sched() before deleting the removed function looks very much like
a RCU-style protection (actually, that's what it is).

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
