Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVAKWV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVAKWV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVAKWT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:19:58 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:65519 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262672AbVAKWSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:18:08 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: utz <utz@s2y4n2c.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111212823.GX2940@waste.org>
References: <20050107221059.GA17392@infradead.org>
	 <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us>
	 <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us>
	 <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us>
	 <20050111200549.GW2940@waste.org>
	 <1105475349.4295.21.camel@krustophenia.net>
	 <20050111124707.J10567@build.pdx.osdl.net>
	 <20050111212823.GX2940@waste.org>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 23:17:47 +0100
Message-Id: <1105481867.4692.53.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 13:28 -0800, Matt Mackall wrote:
> On Tue, Jan 11, 2005 at 12:47:07PM -0800, Chris Wright wrote:
> > Guys, could we please bring this back to a useful discussion.  None of
> > you have commented on whether the rlimits for priority are useful.  As I
> > said before, I've no real problem with the module as it stands since it's
> > tiny, quite contained, and does something people need.  But I agree it'd
> > be better to find something that's workable as long term solution.
> 
> I almost like it. I don't like that it exposes the internal scheduler
> priorities directly (-tiny in fact has options to change these!). So
> perhaps some thought could be given to either stratifying it a bit
> more (>2000 for SCHED_FIFO, >1000 for SCHED_RR, then SCHED_OTHER) or
> separate limits for the different scheduling disciplines. 
> 
> Right now, you can make a good argument that SCHED_FIFO > SCHED_RR >
> SCHED_OTHER from a privilege point of view, but that could change if
> we add a pseudo-RT scheduling class of some sort. Similarly, adding a
> discipline means adding an rlimit with the split approach, so that's
> not very friendly either.
> 
> Another way:
> 
> 0-20: normal nice values (inverted)
> >20: privilege to set any RT priority
> 
> Limiting to below normal nice is a little weird and the offset to make
> everything positive is weird as well. Above 20, any RT app can starve
> SCHED_OTHER and it's less important to dole out fine-grained levels
> here as these apps must be engineered to cooperate to some degree
> anyway.

Limiting to positive nice values are needed too. At leased i need such
thing. Normal users are only allowed to increase the nice value (lower
prio). If a user job runs at nice 15 they can't renice it to 5. I get
about 3 calls a week to do this as root.

And the presentation of the usual nice values can be done in userspace.
pamlimits and ulimit already converts values (min -> s, KiB -> Bytes).

And separating the nice and RT part is useful to prevent confusion in
userspace tools and for the admin.

I patched PAM which allows the setting of nice and realtime rlimits in
limits.conf:

nice goes from 19 to -20 (internally converted to 0-39).
realtime from 0 - 99.



