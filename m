Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268929AbUIQRwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268929AbUIQRwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUIQRwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:52:02 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:14294 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S268919AbUIQRvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:51:45 -0400
Date: Fri, 17 Sep 2004 19:51:30 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: nproc: So?
Message-ID: <20040917175130.GA7050@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1095440131.3874.4626.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095440131.3874.4626.camel@cube>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 12:55:32 -0400, Albert Cahalan wrote:
> Roger Luethi writes:
> > I have received some constructive criticism and suggestions,
> > but I didn't see any comments on the desirability of nproc in
> > mainline. Initially meant to be a proof-of-concept, nproc has
> > become an interface that is much cleaner and faster than procfs
> > can ever hope to be (it takes some reading of procps or libgtop
> > code to appreciate the complexity that is /proc file parsing today),
> 
> You spotted the perfect hash lookup? :-)

I never claimed nproc is perfect. Solutions with comparable performance
and simplicity are conceivable, but none of them will work anything
like procfs.

> The funny varargs/vsprintf/whatever encoding is useless to me,

Actually, that's just a by-product of the design. It is what you get when
you put all the fields back to back. The only addition I made kernel-side
to make this easy to exploit was the introduction of a NOP field.

> as are the labels.

Yup. The labels are not useful for the tools you maintain.

> The nicest think about netlink is, i think, that it might make
> a practical interface for incremental update. As processes run
> or get modified, monitoring apps might get notified. I did not
> see mention of this being implemented, and I would take quite 
> some time to support it, so it's a long-term goal. (of course,
> people can always submit procps patches to support this)

Sounds like what wli and I have discussed as differential updates a few
weeks ago. I agree that would be nice, for now the goal was to suggest
something that's cleaner and faster than procfs. Extensions are easy
to add later.

> I doubt that it is good to break down the data into so many
> different items. It seems sensible to break down the data by 
> locking requirements. 

True if you consider a static set of fields that never changes. Problematic
otherwise, because as soon as you start grouping fields together, you need
an agreement between kernel and user-space on the contents of these groups.

With nproc, the kernel is free to group fields together for computation
(even the first release calculated all the fields that needed VMA walks
in one go).

> I could use an opaque per-process cookie for process identification.
> This would protect from PID reuse, and might allow for faster
> lookup. Perhaps it contains: PID, address of task_struct, and the
> system-wide or per-cpu fork count from process creation.

Agreed, that would be useful. And it would be easy to integrate with
nproc. Just add a field to return the cookie and a selector based on
cookies rather than PIDs.

> Something like the stat() syscall would be pretty decent.

You lost me there.

Roger
