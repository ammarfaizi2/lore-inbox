Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271089AbUJUXRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271089AbUJUXRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271100AbUJUXML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:12:11 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:4260
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S271101AbUJUXJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:09:40 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Timothy Miller <miller@techsource.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <41783B6C.2040502@techsource.com>
References: <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
	 <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de>
	 <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de>
	 <20041021195842.GA23864@nietzsche.lynx.com>
	 <20041021201443.GF32465@suse.de>
	 <20041021202422.GA24555@nietzsche.lynx.com>
	 <41783B6C.2040502@techsource.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098399697.8955.6.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 01:01:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 00:42, Timothy Miller wrote:
> Bill Huey (hui) wrote:
> > You use a semaphore to protect data, a completion isn't protecting data
> > but preserving a certain kind of wait ordering in the code. The
> > possibility of overloading the current mutex_t for PI makes for a conceptual
> > mismatch when used in this case since having a kind of priority for
> > completions is a bit odd. It's better to flat out use a completion
> > instead, IMO.
> > 
> 
> 
> Could you please define "completion" for me in this context?

A triggers B to exit and must wait until B has exited. It waits for
completion of exit.

A triggers B to execute a command and must wait until B has done so.  It
waits for completion of the command.

Mutexes are used for that, but that's not the intended functionality of
a mutex. Of course it works as long as you do no owner checks on the
mutexes.

A {
	init_MUTEX_LOCKED(m)
	trigger B
	down(m)	<----- recursion, because A owns it already
}

The completion is designed for that and should be used IMHO. Mutexe were
used for that, because the ancestors of completion, sleep_on...(), are
racy.

tglx


