Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUJSGEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUJSGEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUJSGEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:04:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27606 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268008AbUJSGEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:04:37 -0400
To: jmoyer@redhat.com
Cc: Ingo Molnar <mingo@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	<20041005112752.GA21094@logos.cnet>
	<16739.61314.102521.128577@segfault.boston.redhat.com>
	<20041006120158.GA8024@logos.cnet>
	<1097119895.4339.12.camel@orbit.scot.redhat.com>
	<20041007101213.GC10234@logos.cnet>
	<1097519553.2128.115.camel@sisko.scot.redhat.com>
	<16746.55283.192591.718383@segfault.boston.redhat.com>
	<1097531370.2128.356.camel@sisko.scot.redhat.com>
	<16749.15133.627859.786023@segfault.boston.redhat.com>
	<16751.61561.156429.120130@segfault.boston.redhat.com>
	<orzn2lpyfc.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0410170715240.16806@devserv.devel.redhat.com>
	<orvfd9yw1m.fsf@livre.redhat.lsd.ic.unicamp.br>
	<16755.62608.19034.491032@segfault.boston.redhat.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 19 Oct 2004 03:04:24 -0300
In-Reply-To: <16755.62608.19034.491032@segfault.boston.redhat.com>
Message-ID: <orekjvnt07.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2004, Jeff Moyer <jmoyer@redhat.com> wrote:

> Select, pselect, and poll will always return data ready on a regular file.
> As such, I would argue that squid's behaviour is broken.  Additionally, I
> don't think it's a good idea to modify any polling mechanism to kick off
> I/O, if simply because I'm not sure how much data to request!

You could request a single block (whatever that means), and then the
subsequent non-blocking read would stand a chance of eventually making
progress.  .  Or you could request nothing, and have the actual read
start a readahead, such that next time it hopefully will have
something to get to immediately.  If the read comes in too quickly,
before the poll-initiated readahead completes, you'll probably get
them merged anyway, so it's not like it could hurt, methinks.

And then, you might arrange for select/poll to not return immediately
for these file descriptors, but rather return as soon as one of them
has some data available to read, the time-out expired, or a very short
time-out set for the case of non-blocking file descriptors select()ed
for read expired.  The latter time-out should be short enough to be
hardly distinguishable from an immediate return, and the return value
should be exactly what a POSIX-compliant application expects.

This doesn't quite fix the problem with the existing standard
interfaces, that don't quite enable anyone to do non-blocking reads
without explicit readahead advice and busy-waiting for data.  The
short time-out above should at least reduce the syscall explosion that
we get with the current behavior, but if read kicks in a readahead to
guarantee we'd eventually get out of the select/read loop without
external help to bring the data into memory, I guess we could live
without the select/poll changes.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
